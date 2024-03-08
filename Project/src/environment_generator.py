from src.functions import *

class Agent:
    
    def __init__(self, id, position):
        self.id = id
        self.position = position

    def __str__(self):
        return f'[{self.id}, {self.position}]'
    
    __repr__ = __str__

class Warehouse:
    
    def __init__(self, id, position):
        self.id = id
        self.position = position
        
    def __str__(self):
        return f'[{self.id}, {self.position}]'
    
    __repr__ = __str__

class Workstation:
    
    def __init__(self, id, position, types):
        self.id = id
        self.position = position
        self.own_supplies = set()
        self.needed_supplies = set()
        
    def __str__(self):
        return f'[{self.id}, {self.position}, O:{self.own_supplies}, N:{self.needed_supplies}]'
    
    __repr__ = __str__

    
class Supply:

    def __init__(self, id, position, type, stored_by):
        self.id = id
        self.position = position 
        self.type = type
        self.stored_by = stored_by
        
    def __str__(self):
        return f'[{self.id}, {self.position}, {self.type}]'
    
    __repr__ = __str__
    
    def update_location(self, position, stored_by):
        self.position = position
        self.stored_by = stored_by
    
class Box:
    
    def __init__(self, id, position, initial_wh_id):
        self.id = id
        self.position = position
        self.stored_by = initial_wh_id

    def __str__(self):
        return f'[{self.id}, {self.position}]'
    
    __repr__ = __str__

class Carrier:

    def __init__(self, id, agent, capacity):
        self.id = id
        self.attached_to = agent
        self.capacity = capacity
        self.load = 0

    def __str__(self):
        return f'[{self.id}, {self.capacity}, {self.attached_to.id}]'
    
    __repr__ = __str__

class Environment_generator:
    
    def __init__(self, configuration, problem_id = 'P1', verbose = True):
            
        self.configuration = configuration # Parameters
        self.problem_id = problem_id
        self.X = configuration.X # Environment matrix width
        self.Y = configuration.Y # environment matrix height
        self.active_cells = configuration.active_cells # Active cells (max XxY)
        self.agent_count = configuration.agents # # of available robots
        self.warehouses_count = configuration.warehouses # # of available warehouses
        self.workstation_count = configuration.workstations # # of available workstations

        # Content type and quantity available (1 for each workstation for each type)
        self.content = [(type, self.workstation_count) for type in configuration.content_type]
        self.box_count = configuration.boxes # # of available box

        # Internale environment rapresentation
        self.matrix = np.zeros((self.X, self.Y), dtype=int) # Matrix XxY
        self.supply_types = configuration.content_type # Supply types available (sstring)
        self.supply_type_count = len(self.content) # # of supply types
        self.warehouse_positions = [] # Warehouses positions (there no workstations can be placed)
        self.agent_positions = [] # Initial agent/s position
        
        if self.problem_id != 'P1':
            self.max_carriers_capacity = self.configuration.carrier_capacity
            self.carriers = {}

        # Internal rapresentation of each environment entity
        self.agents = {} 
        self.warehouses = {}
        self.workstations = {}
        self.supplies = {}
        self.boxes = {}
        
        # Randomly initialize the number of available locations (accordingly to active_cells)
        self.create_environment_active_area()

        # Generate all environment entities
        self.generate_warehouses()
        self.generate_agents()
        self.generate_content()
        self.generate_boxex()
        self.generate_workstations()
        if self.problem_id != 'P1':
            self.generate_carriers()

        # Randomly define the needed and owned supplies for the workstations
        self.random_goal()

        # Used for pddl goal generation
        self.workstations_state = {id : None for id in self.workstations.keys()}
        for ws in self.workstations.values():
            self.workstations_state[ws.id] = {'own': ws.own_supplies, 'needs': ws.needed_supplies}
                
        if verbose: self.toString() # print environment info

    def random_goal(self):

        supplies_per_type = { type : [supply for supply in self.supplies.values() if supply.type == type] for type in self.supply_types }

        for ws in self.workstations.values():
            for type in self.supply_types:

                need = random.randint(0,100)
                if need > 40:
                    ws.needed_supplies.add(supplies_per_type[type].pop())
                else:
                    own = random.randint(0,100)
                    if own >= 70:
                        ws.own_supplies.add(supplies_per_type[type].pop())
                               
    def create_environment_active_area(self):
            # Sceglie un punto di partenza casuale e imposta la cella a 1
            current_position = Position(random.randint(0, self.X - 1), random.randint(0, self.Y - 1))
            self.matrix[current_position.x, current_position.y] = 1
            steps_taken = 1

            while steps_taken < self.active_cells:
                # Definisce i possibili movimenti: su, giù, sinistra, destra
                movements = [(0, 1), (0, -1), (1, 0), (-1, 0)]
                random.shuffle(movements)

                for dx, dy in movements:
                    next_position = Position(current_position.x + dx, current_position.y + dy)

                    if next_position != current_position and 0 <= next_position[0] < self.X and 0 <= next_position[1] < self.Y and self.matrix[next_position] == 0:
                        self.matrix[next_position] = 1
                        current_position = next_position
                        steps_taken += 1
                        break
                    else:
                        # Se tutte le direzioni sono bloccate, trova un nuovo punto di partenza tra quelli già impostati a 1
                        ones = np.argwhere(self.matrix == 1)
                        random_index = random.randint(0, len(ones) - 1)
                        current_position = Position(ones[random_index][0], ones[random_index][1])
            
    def generate_agents(self):
        for i in range(self.agent_count):
            
            pos = random.choice(self.agent_positions)# Initialize agent at a random warehouse - ?
            agent = Agent(f'agent_{i}', pos)
            self.agents[f'agent_{i}'] = agent
            
    def generate_warehouses(self):
        for i in range(self.warehouses_count): 
            
            pos = select_random_one_position(self.matrix, self.warehouse_positions)
            wh = Warehouse(f'warehouse_{i}', pos)
            self.warehouses[f'warehouse_{i}'] = wh
            
            self.warehouse_positions.append(pos)
            self.agent_positions.append(pos)
            self.matrix[pos] = 2

    def generate_workstations(self):
        
        for i in range(self.workstation_count):
            
            pos = select_random_one_position(self.matrix, self.warehouse_positions)
            ws = Workstation(f'workstation_{i}', pos, self.supply_types)
            
            self.workstations[f'workstation_{i}'] = ws

            # Matrix set
            if (self.matrix[pos] % 3 == 0): self.matrix[pos] += 3
            else: self.matrix[pos] = 3

    def generate_content(self):
        
        i = 0
        for (type, qty) in self.content:

            for _ in range(qty):
                wh = random.choice(list(self.warehouses.values()))
                supply = Supply(f'supply_{i}', wh.position, type, wh.id)
                self.supplies[f'supply_{i}'] = supply
                i += 1

    def generate_boxex(self):

        for i in range(self.box_count):
            wh = random.choice(list(self.warehouses.values()))
            box = Box(f'box_{i}', wh.position, wh.id)
            self.boxes[f'box_{i}'] = box
           
    def generate_carriers(self):

        for i, agent in enumerate(self.agents.values()):
            id = f'carrier_{i}'
            capacity = random.randint(3, self.max_carriers_capacity)
            carrier = Carrier(id, agent, capacity)
            self.carriers[id] = carrier
    
    def toString(self):
        print('Environment info:')
        print(f' - Environment size: {self.X}x{self.Y}\n - Active area: {self.active_cells} ({(self.active_cells / (self.X * self.Y))*100}%)')
        print(f' - Warehouses: {self.warehouses_count}')
        print(f' - Agents: {self.agent_count}')
        print(f' - Workstations: {self.workstation_count}')
        print(f' - Content types: {self.supply_type_count}')
        print(f' - Content total quantity: {self.supplies}')
        print(f' - Boxes available: {len(self.boxes)}')
        if self.problem_id != 'P1': print(f' - Carriers: {self.carriers}')
        print('Examples:')
        print(f' - Warehouse encoded:', list(self.warehouses.values()))
        print(f' - Agent encoded:', list(self.agents.values()))
        print(f' - Workstation encoded:', list(self.workstations.values()))
        print(f' - Content encoded:', list(self.supplies.items()))
        print(f' - Box encoded:', list(self.boxes.values())[0])
        if self.problem_id != 'P1': print(f' - Carriers encoded:', list(self.carriers.values())[0])

        print('Workstation goal & state:')
        for ws_id, state in self.workstations_state.items():
            print(f' - {ws_id}:\n -- Supplies owned',state['own'],'\n -- Supplies needed ',state['needs'])
        print_colored_matrix_seaborn(self.matrix, 'Environment')
    
