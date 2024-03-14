from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'supply_types', 'boxes', 'workstations', 'warehouses'])
configurations = {
'config_0' : EnvironmentConfig(
    X=7, 
    Y=7, 
    active_cells=20, 
    agents=1, 
    boxes=10, 
    workstations=3, 
    warehouses=1,
    supply_types=['valve', 'bolt','tool']),

'config_1' : EnvironmentConfig(
    X=7, 
    Y=7, 
    active_cells=30, 
    agents=1, 
    boxes=10, 
    workstations=4, 
    warehouses=1,
    supply_types=['valve', 'bolt', 'tool','circuit']),

'config_2' : EnvironmentConfig(
    X=7, 
    Y=7, 
    active_cells=40, 
    agents=1, 
    boxes=10, 
    workstations=5, 
    warehouses=1,
    supply_types=['valve', 'bolt', 'tool','circuit','gear'])
}