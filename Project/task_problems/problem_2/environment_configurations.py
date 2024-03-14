from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'supply_types', 'boxes', 'workstations', 'warehouses','carrier_capacity'])
configurations = {
'config_0' : EnvironmentConfig(
    X=7, 
    Y=7, 
    active_cells=20, 
    agents=2, 
    boxes=4, 
    workstations=1, 
    warehouses=1,
    supply_types=['valve', 'bolt','tool'],
    carrier_capacity=2),

'config_1' : EnvironmentConfig(
    X=7, 
    Y=7, 
    active_cells=30, 
    agents=3, 
    boxes=6, 
    workstations=2, 
    warehouses=1,
    supply_types=['valve', 'bolt', 'tool','circuit'],
    carrier_capacity=3),

'config_2' : EnvironmentConfig(
    X=7, 
    Y=7, 
    active_cells=40, 
    agents=4, 
    boxes=16, 
    workstations=3, 
    warehouses=1,
    supply_types=['valve', 'bolt', 'tool','circuit'],
    carrier_capacity=4)
}