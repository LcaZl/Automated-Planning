from src.environment_generator import *
from src.functions import *
import shutil

class Environment_toPDDL:
    """
    Convert and Environment_generator instance into a PDDL problem.

    """
    def __init__(self, env: Environment_generator, baseline_path, domain_type='no_flt', lang='pddl', verbose=True):
        self.baseline_path = baseline_path  # Path to save generated PDDL/HDDL files
        self.problem_id = env.problem_id  # ID of the problem instance
        self.domain_type = domain_type  # Type of domain ('no_flt' for non-fluent, 'flt' for fluent)
        self.environment = env  # Environment object containing the scenario details
        self.lang = lang  # Language of the problem ('pddl' or 'hddl')

        # Unique ID for the environment instance
        self.id = str(self.generate_id())  
        # Full path to save the environment instance
        self.path = f'{baseline_path}/environments/environment_{self.id}'
        self.init = set()  # Initial facts
        self.goals = []  # Goal conditions
        # For HDDL language, maintain goal ordering
        if self.lang == 'hddl':
            self.goal_ordering = set()
        # Dictionary to hold different PDDL objects and their types
        self.pddl_objects = {
            'location': set(),
            'agent': set(),
            'supply': set(),
            'box': set(),
            'workstation': set(),
            'warehouse': set(),
            'carrier': set(),
            'supply_type': set(env.supply_types),  # Initialize supply types labels from environment
            'capacity': set()
        }
        # Convert different components of the environment to PDDL format
        self.convert_area()
        self.convert_agents()
        self.convert_warehouses()
        self.convert_workstations()
        self.convert_boxes()
        self.convert_supplies()

        if self.problem_id != 'P1':
            if self.domain_type == 'no_flt':
                self.convert_capacities()
                self.convert_carriers()
            elif self.domain_type == 'flt':
                self.convert_carriers_flt()
                # For fluent domains, initialize total-cost
                self.init.add(f'= (total-cost) 0')

        self.generate_goal()

        # Generate and save the problem file
        self.generate_problem()
        self.save_problem()

        # For Problem 5, generate ROS2 command instructions
        if self.environment.problem_id == 'P5':
            self.generate_commands_for_ros2()
            
        if verbose: self.toString()


    def generate_commands_for_ros2(self):

        # Prepares ROS2 commands for problem setup.
        self.commands = []

        # Create instance commands for all objects.
        for type, ids in self.pddl_objects.items():
            for id in ids:
                self.commands.append(f'set instance {id} {type}')

        # Create predicate commands for initial facts.
        for fact in self.init:
            self.commands.append(f'set predicate ({fact})')

        # Define the problem goal and append it to commands.
        self.problem_goal = 'and ' + ' '.join([f'({goal})' for goal in self.goals])
        self.commands.append(f'set goal ({self.problem_goal})')

        # Write commands to a file for execution in ROS2.
        os.makedirs(self.path, exist_ok=True)
        commands_file_path = os.path.join(self.path, f'commands')
        with open(commands_file_path, 'w') as file:
            file.write(self.pddl_problem)
        print(f" - Ros2 commands saved at: {commands_file_path}")

    def generate_goal(self):
        # Defines goal conditions based on workstation needs.

        i = 0
        for ws in self.environment.workstations.values():
            state = self.environment.workstations_state[ws.id]
            for supply in state['needs']:
                if self.lang == 'pddl':
                    self.goals.append(f'has {ws.id} {supply.type}')
                elif self.lang == 'hddl':
                    self.goals.append(f'task{i} (t-deliver_supply ' + self.environment.agents[f'agent_{int(i%self.environment.agent_count)}'].id + f' {ws.id} {supply.type})')
                    if i != 0: self.goal_ordering.add(f'task{i-1} < task{i}')
                    i += 1


    def convert_area(self):
        # Converts grid cells to locations and defines adjacency for active cells.
        for x in range(self.environment.matrix.shape[0]):
            for y in range(self.environment.matrix.shape[1]):
                if (self.environment.matrix[x][y] != 0):
                    self.pddl_objects['location'].add(f'l{x}_{y}')
                    adjacent_positions = [Position(x - 1, y), Position(x + 1, y), Position(x, y - 1), Position(x, y + 1)]
                    for p in adjacent_positions:
                        if 0 <= p.x < self.environment.X and 0 <= p.y < self.environment.Y and self.environment.matrix[p] != 0:
                            self.init.add(f'adjacent l{x}_{y} l{p.x}_{p.y}')

    def convert_agents(self): 
        # Initializes agents' positions and states.               
        for agent in self.environment.agents.values():
            self.pddl_objects['agent'].add(agent.id)
            self.init.add(f'at {agent.id} l{agent.position.x}_{agent.position.y}')
            if self.environment.problem_id == 'P1':
                self.init.add(f'free_arms {agent.id}')

    def convert_warehouses(self):
        # Initializes warehouses' positions.
        for wh in self.environment.warehouses.values():
            self.pddl_objects['warehouse'].add(wh.id)
            self.init.add(f'at {wh.id} l{wh.position.x}_{wh.position.y}')

    def convert_workstations(self): 
        # Initializes workstations' positions and supplies they initially own.
        for ws in self.environment.workstations.values():
            self.pddl_objects['workstation'].add(ws.id)            
            self.init.add(f'at {ws.id} l{ws.position.x}_{ws.position.y}')
            # Add supplies loaded to each workstation.
            state = self.environment.workstations_state[ws.id]
            for supply in state['own']:
                self.init.add(f'loaded_to {supply.id} {ws.id}')

    def convert_boxes(self):                      
        # Initializes boxes' positions and states.
        for box in self.environment.boxes.values():
            self.pddl_objects['box'].add(box.id)
            self.init.add(f'at {box.id} l{box.position.x}_{box.position.y}')
            self.init.add(f'empty {box.id}')

    def convert_supplies(self):   
        # Initializes supplies' positions and types.
        for _, supply in self.environment.supplies.items():
            self.pddl_objects['supply'].add(supply.id)
            # Position only if not initially at a workstation.
            if not supply.stored_by.startswith('workstation'):
                self.init.add(f'at {supply.id} l{supply.position.x}_{supply.position.y}')
            # Define the type of each supply.
            self.init.add(f'is {supply.id} {supply.type}')
                
    def convert_capacities(self):
        # Defines capacities and their predecessor relationship for modeling carrier capacity.
        for i in range(0, self.environment.max_carriers_capacity + 1):
            self.pddl_objects['capacity'].add(f'capacity_{i}')
            if i > 0:
                self.init.add(f'predecessor capacity_{i-1} capacity_{i}')
                    
    def convert_carriers(self):
        # Initializes carriers' capacities and attachments to agents.
        for _, carrier in self.environment.carriers.items():
            self.pddl_objects['carrier'].add(carrier.id)
            # Link carrier to its agent and set its capacity.
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
             
    def generate_problem(self):
        # Formats and prepares the PDDL problem file content.
        self.problem_init = ' '.join([f'({fact})' for fact in self.init])
        self.problem_objects = ''
        for type, objects in self.pddl_objects.items():
            if len(objects) > 0:
                self.problem_objects += ' '.join(objects) + f' - {type} '
                
        # Format goal conditions for the problem file
        self.problem_goal = 'and ' + ' '.join([f'({goal})' for goal in self.goals])

        if self.lang == 'pddl':
            if self.problem_id != 'P1' and self.domain_type == 'flt':

                metric = f'minimize (total-cost)'
                
                self.pddl_problem = (';; problem file: problem_' + self.id + '.pddl\n' +
                        '(define (problem default)\n' +
                        '  (:domain default)\n' +
                        '  (:objects ' + self.problem_objects + ')\n' +
                        '  (:init ' + self.problem_init + ')\n' +
                        '  (:goal (' + self.problem_goal + '))\n' +
                        '  (:metric ' + metric + ')\n)')
            
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
        # Generates a unique ID for the problem by inspecting existing environment directories.
        max_index = -1
        environments_path = self.baseline_path + '/environments/'

        for item in os.listdir(environments_path):
            full_path = os.path.join(environments_path, item)
            if os.path.isdir(full_path) and item.startswith("environment_"):
                index = int(item.split('_')[1])
                max_index = max(max_index, index)
        return str(max_index + 1)

    def save_problem(self):
        # Saves the generated problem and copies the domain file to the new environment directory.
        domain_name = f'domain.{self.lang}'
        ext = 'pddl' if self.lang == 'pddl' else 'hddl'
        os.makedirs(self.path, exist_ok=True)

        # Write the problem file.
        problem_file_path = os.path.join(self.path, f'problem.{ext}')
        with open(problem_file_path, 'w') as file:
            file.write(self.pddl_problem)
        print(f" - PDDL problem saved at: {problem_file_path}")

        # Copy the domain file to the new environment directory.
        domain_file_path = os.path.join(self.baseline_path, domain_name)
        new_domain_file_path = os.path.join(self.path, f'domain.{ext}')
        shutil.copyfile(domain_file_path, new_domain_file_path)
        print(f" - Domain file copied to: {new_domain_file_path}")

    def toString(self):
        # Prints a summary of the generated PDDL problem.
        print('PDDL:')
        print(f' - PDDL objects:')
        for (key, objs) in self.pddl_objects.items():
            print(f' -- {key}:', objs)
        print(' - PDDL goals:')
        for i, fact in enumerate(self.goals):
            print(f' {i} -- {fact}')