from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'supply_types', 'boxes', 'workstations', 'warehouses'])
configurations = {
'config_1' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=1, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool']),

# Configuration 2
'config_2' : EnvironmentConfig(X=6, 
                                         Y=6, 
                                         active_cells=30, 
                                         agents=1, 
                                         boxes=20, 
                                         workstations=2, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool','gear']),

# Configuration 3
'config_3' : EnvironmentConfig(X=7, 
                                         Y=7, 
                                         active_cells=40, 
                                         agents=1, 
                                         boxes=1, 
                                         workstations=5, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool', 'gear', 'circuit'])
}