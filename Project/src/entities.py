class Agent:

    def __init__(self, id, position):
        self.id = id 
        self.position = position

    def __str__(self):
        return f'[{self.id}, {self.position}]'
    
    # Ensures consistent representation in print and debug outputs
    __repr__ = __str__


class Warehouse:

    def __init__(self, id, position):
        self.id = id 
        self.position = position

    def __str__(self):
        return f'[{self.id}, {self.position}]'
    
    # Ensures consistent representation in print and debug outputs
    __repr__ = __str__


class Workstation:

    def __init__(self, id, position, types):
        self.id = id
        self.position = position
        self.own_supplies = set()  # Supplies currently owned by the workstation
        self.needed_supplies = set()  # Supplies needed by the workstation for tasks

    def __str__(self):
        return f'[{self.id}, {self.position}, O:{self.own_supplies}, N:{self.needed_supplies}]'
    
    # Ensures consistent representation in print and debug outputs
    __repr__ = __str__


class Supply:

    def __init__(self, id, position, type, stored_by):
        self.id = id
        self.position = position
        self.type = type  # Type of the supply
        self.stored_by = stored_by  # Identifier of the warehouse/workstation storing the supply

    def update_location(self, position, stored_by):
        """
        Updates the location and storage information for the supply.
        Used when a supply is owned by a workstation, during final goal generation.

        """
        self.position = position
        self.stored_by = stored_by

    def __str__(self):
        return f'[{self.id}, {self.position}, {self.type}]'
    
    __repr__ = __str__


class Box:

    def __init__(self, id, position, initial_wh_id):
        self.id = id
        self.position = position
        self.stored_by = initial_wh_id  # Identifier of the warehouse initially storing the box

    def __str__(self):
        return f'[{self.id}, {self.position}]'
    
    __repr__ = __str__


class Carrier:

    def __init__(self, id, agent, capacity):
        self.id = id 
        self.attached_to = agent  # The agent to which the carrier is attached
        self.capacity = capacity  # Maximum capacity of the carrier
        self.load = 0  # Initial load of the carrier

    def __str__(self):
        return f'[{self.id}, {self.capacity}, {self.attached_to.id}]'
    
    __repr__ = __str__