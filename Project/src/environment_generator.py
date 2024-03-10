from src.functions import *
from src.entities import *

class Environment_generator:
    def __init__(self, configuration, problem_id='P1', verbose=True):
        """
        Initialize environment with configuration and problem details.

        """
        self.configuration = configuration
        self.problem_id = problem_id
        self.X = configuration.X  # Matrix width
        self.Y = configuration.Y  # Matrix height
        self.active_cells = configuration.active_cells  # Number of active cells
        self.agent_count = configuration.agents  # Number of agents
        self.warehouses_count = configuration.warehouses  # Number of warehouses
        self.workstation_count = configuration.workstations  # Number of workstations

        # Setup for content type and initial box count.
        self.content = [(type, self.workstation_count) for type in configuration.supply_types]
        self.box_count = configuration.boxes

        # Initialize environment matrix and supply types.
        self.matrix = np.zeros((self.X, self.Y), dtype=int)  # Environment matrix
        self.supply_types = configuration.supply_types
        self.supply_type_count = len(self.content)

        # Initialize positions and internal representations.
        self.warehouse_positions = []  # To store warehouse positions
        self.agent_positions = []  # To store initial agent positions
        if self.problem_id != 'P1':
            # For other problems, set max carriers' capacity and initialize carriers.
            self.max_carriers_capacity = self.configuration.carrier_capacity
            self.carriers = {}

        self.agents = {}
        self.warehouses = {}
        self.workstations = {}
        self.supplies = {}
        self.boxes = {}

        # Define the active area of the environment based on active_cells.
        self.create_environment_active_area()

        # Generate entities within the environment.
        self.generate_warehouses()
        self.generate_agents()
        self.generate_supplies()
        self.generate_boxex()
        self.generate_workstations()
        if self.problem_id != 'P1':
            self.generate_carriers()

        # Assign random goals and supplies to workstations.
        self.random_goal()
        if verbose: self.toString()  # Optionally print environment details.


    def random_goal(self):
        """
        Assigns random goals for each workstation regarding the supplies they need or own.
        Supplies are assigned based on random thresholds to simulate variability in needs and ownership.
        """
        # Prepare a dictionary mapping each supply type to available supplies of that type.
        supplies_per_type = {type: [supply for supply in self.supplies.values() if supply.type == type] for type in self.supply_types}

        for ws in self.workstations.values():
            for type in self.supply_types:
                need = random.randint(0, 100)  # Randomly decide if a workstation needs a supply
                own = random.randint(0, 100)  # Randomly decide if a workstation already owns a supply

                if need > 20:
                    ws.needed_supplies.add(supplies_per_type[type].pop())
                elif own >= 60:
                    ws.own_supplies.add(supplies_per_type[type].pop())

        self.workstations_state = {id: {'own': ws.own_supplies, 'needs': ws.needed_supplies} for id, ws in self.workstations.items()}

    def create_environment_active_area(self):
        """
        Generates an active area within the environment matrix by randomly walking and marking cells,
        ensuring the number of active cells matches the configuration.
        """
        # Start at a random position
        current_position = Position(random.randint(0, self.X - 1), random.randint(0, self.Y - 1))
        self.matrix[current_position.x, current_position.y] = 1  # Mark the starting cell as active
        steps_taken = 1  # Initialize steps counter

        while steps_taken < self.active_cells:
            # Define possible movements (up, down, left, right)
            movements = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            for dx, dy in movements:
                next_position = Position(current_position.x + dx, current_position.y + dy)

                # Check if next_position is valid and not yet active
                if 0 <= next_position[0] < self.X and 0 <= next_position[1] < self.Y and self.matrix[next_position] == 0:
                    self.matrix[next_position] = 1  # Mark the cell as active
                    current_position = next_position  # Update current position
                    steps_taken += 1  # Increment steps counter
                    break
            else:
                # If no valid move is found, choose a new current position from the active ones
                ones = np.argwhere(self.matrix == 1)
                random_index = random.randint(0, len(ones) - 1)
                current_position = Position(ones[random_index][0], ones[random_index][1])
    def generate_warehouses(self):
        """
        Generates warehouses_count number of warehouses at unique positions.
        
        """
        for i in range(self.warehouses_count):
            pos = select_random_one_position(self.matrix, self.warehouse_positions)  # Avoids overlap with existing warehouses
            wh = Warehouse(f'warehouse_{i}', pos)
            self.warehouses[f'warehouse_{i}'] = wh
            self.warehouse_positions.append(pos)  # Updates warehouse positions
            self.agent_positions.append(pos)  # Agents can start at warehouse positions
            self.matrix[pos] = 2  # Marks the position in the matrix

    def generate_agents(self):
        """
        Create agent_count number of agents, each initialized at a random position selected from agent_positions.
        
        """
        for i in range(self.agent_count):
            pos = random.choice(self.agent_positions)  # Selects a random starting position
            agent = Agent(f'agent_{i}', pos)
            self.agents[f'agent_{i}'] = agent  # Store the agent

    def generate_supplies(self):
        """
        Distributes the specified types and quantities of supplies to warehouses.
        
        """
        i = 0
        for (type, qty) in self.content:
            for _ in range(qty):
                wh = random.choice(list(self.warehouses.values()))  # Selects a warehouse
                supply = Supply(f'supply_{i}', wh.position, type, wh.id)
                self.supplies[f'supply_{i}'] = supply
                i += 1

    def generate_boxex(self):
        """
        Places boxes in warehouses
        
        """
        for i in range(self.box_count):
            wh = random.choice(list(self.warehouses.values()))  # Selects a warehouse
            box = Box(f'box_{i}', wh.position, wh.id)
            self.boxes[f'box_{i}'] = box

    def generate_workstations(self):
        """
        Creates workstation_count number of workstations, ensuring their positions don't clash with warehouses.

        """
        for i in range(self.workstation_count):
            pos = select_random_one_position(self.matrix, self.warehouse_positions)  # Excludes warehouse positions
            ws = Workstation(f'workstation_{i}', pos, self.supply_types)
            self.workstations[f'workstation_{i}'] = ws
            # Mark the position in the matrix
            if self.matrix[pos] % 3 == 0:
                self.matrix[pos] += 3
            else:
                self.matrix[pos] = 3

    def generate_carriers(self):
        """
        Generates carriers and assigns them to agents with random capacities.

        """
        for i, agent in enumerate(self.agents.values()):
            id = f'carrier_{i}'
            capacity = random.randint(2, self.max_carriers_capacity)  # Random capacity within allowed range
            carrier = Carrier(id, agent, capacity)
            self.carriers[id] = carrier

    def toString(self):
        """
        Prints information about the environment
        """
        print('Environment info:')
        active_area_percentage = (self.active_cells / (self.X * self.Y)) * 100
        print(f' - Environment size: {self.X}x{self.Y}\n - Active area: {self.active_cells} ({active_area_percentage}%)')
        print(f' - Warehouses: {self.warehouses_count}\n - Agents: {self.agent_count}\n - Workstations: {self.workstation_count}')
        print(f' - Supply types: {self.supply_type_count}\n - Supplies: {len(self.supplies)}\n - Boxes available: {len(self.boxes)}')
        if self.problem_id != 'P1': print(f' - Carriers: {len(self.carriers)}')
        print('Examples:')
        print(f' - Warehouse encoded:', list(self.warehouses.values())[0] if self.warehouses else 'None')
        print(f' - Agent encoded:', list(self.agents.values())[0] if self.agents else 'None')
        print(f' - Workstation encoded:', list(self.workstations.values())[0] if self.workstations else 'None')
        print(f' - Supplies encoded:', list(self.supplies.items())[0] if self.supplies else 'None')
        print(f' - Box encoded:', list(self.boxes.values())[0] if self.boxes else 'None')
        if self.problem_id != 'P1': print(f' - Carriers encoded:', list(self.carriers.values())[0] if self.carriers else 'None')
        print('Workstation goal & state:')
        for ws_id, state in self.workstations_state.items():
            print(f' - {ws_id}:\n -- Supplies owned {state["own"]}\n -- Supplies needed {state["needs"]}')
        print_colored_matrix_seaborn(self.matrix, 'Environment')
