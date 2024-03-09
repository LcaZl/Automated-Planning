from src.environment_generator import *
from src.functions import *
import shutil

class Environment_toPDDL:
    
    def __init__(self, env : Environment_generator, baseline_path, domain_type = 'no_flt', lang = 'pddl', verbose = True):
        
        self.baseline_path = baseline_path
        self.problem_id = env.problem_id
        self.domain_type = domain_type
        self.environment = env
        self.lang = lang

        self.id = str(self.generate_id())
        self.path = f'{baseline_path}/environments/environment_{self.id}'
        self.environment = env
        self.init = set()
        self.goals = set()
        if self.lang == 'hddl':
            self.goal_ordering = set()
        self.pddl_objects = {
            'location' : set(),
            'agent' : set(),
            'supply' : set(),
            'box' : set(),
            'workstation' : set(),
            'warehouse' : set(),
            'carrier':set(),
            'supply_type': set(env.supply_types),
            'capacity' : set()
        }
        self.convert_area()
        self.convert_agents()
        self.convert_warehouses()
        self.convert_workstations()
        self.convert_boxes()
        self.convert_supplies()

        if (self.problem_id != 'P1'):

            if self.domain_type == 'no_flt':
                self.convert_capacities()
                self.convert_carriers()

            elif self.domain_type == 'flt':
                self.convert_carriers_flt()
                self.init.add(f'= (total-cost) 0')

        self.generate_goal()
        self.problem_init = ' '.join([ f'({fact})' for fact in self.init])
        self.problem_objects = ''
        for type, objects in self.pddl_objects.items():
            if len(objects) > 0:
                self.problem_objects += ' '.join(objects) + f' - {type} '
        self.problem_goal = 'and ' + ' '.join([f'({goal})' for goal in self.goals])


        self.generate_problem()
        self.save_problem()

        if self.environment.problem_id == 'P5':
            self.generate_commands_for_ros2()
            
        if verbose: self.toString()

    def generate_commands_for_ros2(self):
        self.commands = []

        for type, ids in self.pddl_objects.items():
            for id in ids:
                self.commands.append(f'set instance {id} {type}')

        for fact in self.init:
            self.commands.append(f'set predicate ({fact})')

        self.problem_goal = 'and ' + ' '.join([f'({goal})' for goal in self.goals])
        self.commands.append(f'set goal ({self.problem_goal})')

        self.pddl_problem = '\n'.join(self.commands)

        os.makedirs(self.path, exist_ok=True)

        commands_file_path = os.path.join(self.path, f'commands')

        with open(commands_file_path, 'w') as file:
            file.write(self.pddl_problem)
        print(f" - Ros2 commands saved at: {commands_file_path}")


    def convert_area(self):
        for x in range(self.environment.matrix.shape[0]):
            for y in range(self.environment.matrix.shape[1]):
                 if (self.environment.matrix[x][y] != 0):
                    
                    self.pddl_objects['location'].add(f'l{x}_{y}')
                    #self.init.add(f'free_from_agent l{x}_{y}')
                    adjacent_positions = [Position(x - 1, y), Position(x + 1, y), Position(x, y - 1), Position(x, y + 1)]
                    for p in adjacent_positions:

                        if 0 <= p.x < self.environment.X and 0 <= p.y < self.environment.Y and self.environment.matrix[p] != 0:
                            self.init.add(f'adjacent l{x}_{y} l{p.x}_{p.y}')
                            self.init.add(f'adjacent l{p.x}_{p.y} l{x}_{y}')

    def convert_agents(self):                 
        for agent in self.environment.agents.values():
            self.pddl_objects['agent'].add(agent.id)
            self.init.add(f'at {agent.id} l{agent.position.x}_{agent.position.y}')
            self.init.add(f'free_arms {agent.id}')
            #self.init.remove(f'free_from_agent l{agent.position.x}_{agent.position.y}')

    def convert_warehouses(self):
        for wh in self.environment.warehouses.values():
            self.pddl_objects['warehouse'].add(wh.id)
            self.init.add(f'at {wh.id} l{wh.position.x}_{wh.position.y}')

    def generate_goal(self):
            i = 0

            for ws in self.environment.workstations.values():
                state = self.environment.workstations_state[ws.id]
                for supply in state['needs']:   

                    if self.lang == 'pddl':
                        self.goals.add(f'has {ws.id} {supply.type}')

                    elif self.lang == 'hddl':
                        self.goals.add(f'task{i} (t-deliver_supply ' + self.environment.agents[f'agent_{int(i%self.environment.agent_count)}'].id + f' {ws.id} {supply.type})')
                        if i != 0: self.goal_ordering.add(f'task{i-1} < task{i}')
                        i += 1


    def convert_workstations(self): 
        for ws in self.environment.workstations.values():
             self.pddl_objects['workstation'].add(ws.id)            
             self.init.add(f'at {ws.id} l{ws.position.x}_{ws.position.y}')
            
             state = self.environment.workstations_state[ws.id]
             for supply in state['own']:
                #self.init.add(f'has {ws.id} {supply.type}')
                self.init.add(f'loaded_to {supply.id} {ws.id}')

    def convert_boxes(self):                      
        for box in self.environment.boxes.values():
            self.pddl_objects['box'].add(box.id)
            self.init.add(f'at {box.id} l{box.position.x}_{box.position.y}')
            self.init.add(f'empty {box.id}')
            self.init.add(f'available {box.id}')

    def convert_supplies(self):   
        for _, supply in self.environment.supplies.items():
            self.pddl_objects['supply'].add(supply.id)
            if not supply.stored_by.startswith('workstation'):
                self.init.add(f'at {supply.id} l{supply.position.x}_{supply.position.y}')
            self.init.add(f'is {supply.id} {supply.type}')
            
    def convert_capacities(self):

        for i in range(0, self.environment.max_carriers_capacity + 1):
            self.pddl_objects['capacity'].add(f'capacity_{i}')
            if i > 0:
                self.init.add(f'predecessor capacity_{i-1} capacity_{i}')
                
    def convert_carriers(self):

        for _, carrier in self.environment.carriers.items():
            self.pddl_objects['carrier'].add(carrier.id)
            self.init.add(f'attached {carrier.id} {carrier.attached_to.id}')
            self.init.add(f'carrier_capacity {carrier.id} capacity_{carrier.capacity}')

    def convert_carriers_flt(self):
            
        total_carriers_capacity = 0
        for _, carrier in self.environment.carriers.items():
            total_carriers_capacity += carrier.capacity
            self.pddl_objects['carrier'].add(carrier.id)
            self.init.add(f'attached {carrier.id} {carrier.attached_to.id}')
            self.init.add(f'= (carrier-capacity {carrier.id}) {carrier.capacity}')
            self.init.add(f'= (carrier-load {carrier.id}) {carrier.load}')
            
        #self.init.add(f'= (total-carrier-capacity) {total_carriers_capacity}')
        #self.init.add(f'= (total-carrier-load) 0')
 
    def generate_problem(self):


        if self.lang == 'pddl':
            if self.problem_id != 'P1' and self.domain_type == 'flt':

                self.pddl_problem = (';; problem file: problem_' + self.id + '.pddl\n' +
                        '(define (problem default)\n' +
                        '  (:domain default)\n' +
                        '  (:objects ' + self.problem_objects + ')\n' +
                        '  (:init ' + self.problem_init + ')\n' +
                        '  (:goal (' + self.problem_goal + '))\n' +
                        '  (:metric maximize (- (/ (total-carrier-load) (total-carrier-capacity)) (total-cost)))\n)')
            
            elif self.problem_id == 'P4':

                self.pddl_problem = (';; problem file: problem_' + self.id + '.pddl\n' +
                        '(define (problem default)\n' +
                        '  (:domain default)\n' +
                        '  (:objects ' + self.problem_objects + ')\n' +
                        '  (:init ' + self.problem_init + ')\n' +
                        '  (:goal (' + self.problem_goal + '))\n' +
                        '  (:metric minimize (total-time))\n)')  
            else:

                self.pddl_problem = (';; problem file: problem_' + self.id + '.pddl\n' +
                        '(define (problem default)\n' +
                        '  (:domain default)\n' +
                        '  (:objects ' + self.problem_objects + ')\n' +
                        '  (:init ' + self.problem_init + ')\n' +
                        '  (:goal (' + self.problem_goal + '))\n)')
                
        elif self.lang == 'hddl':
            self.goal_ordering = 'and ' + ' '.join([f'({order})' for order in self.goal_ordering])
            self.pddl_problem = (';; problem file: problem_' + self.id + '.pddl\n' +
                    '(define (problem default)\n' +
                    '  (:domain default)\n' +
                    '  (:objects ' + self.problem_objects + ')\n' +
                    '  (:htn\n' +
                    '     :parameters ()\n' +
                    '     :subtasks (' + self.problem_goal + ')\n' +
                    '     :ordering (' + self.goal_ordering + ')\n' +
                    '  )\n' +
                    '  (:init ' + self.problem_init + ')\n)')

        
    def generate_id(self):
        max_index = -1 
        environments_path = self.baseline_path + '/environments/'

        for item in os.listdir(environments_path):
            full_path = os.path.join(environments_path, item)
            if os.path.isdir(full_path) and item.startswith("environment_"):
                index = int(item.split('_')[1])
                max_index = max(max_index, index)
        return str(max_index + 1)

    
    def save_problem(self):
        domain_name = f'domain.{self.lang}' if self.domain_type == 'no_flt' else f'domain_flt.{self.lang}'
        ext = 'pddl' if self.lang == 'pddl' else 'hddl'
        os.makedirs(self.path, exist_ok=True)

        problem_file_path = os.path.join(self.path, f'problem.{ext}')

        with open(problem_file_path, 'w') as file:
            file.write(self.pddl_problem)
        print(f" - PDDL problem saved at: {problem_file_path}")

        domain_file_path = os.path.join(self.baseline_path, domain_name)
        new_domain_file_path = os.path.join(self.path, f'domain.{ext}')

        shutil.copyfile(domain_file_path, new_domain_file_path)
        print(f" - Domain file copied to: {new_domain_file_path}")


    def toString(self):
        print('PDDL:')

        print(f' - PDDL objects:')
        for (key, objs) in self.pddl_objects.items():
            print(f' -- {key}:', objs)

        print(' - PDDL goals:')
        for fact in self.goals:
            print(f' -- {fact}')