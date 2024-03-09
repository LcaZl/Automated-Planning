from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'content_type', 'boxes', 'workstations', 'warehouses'])
configurations = {
'config_1' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=1, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool']),

# Configuration 2
'config_2' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=2, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool','gear']),

# Configuration 3
'config_3' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=3, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool', 'gear', 'circuit']),
'config_4' : EnvironmentConfig(X=10, 
                                         Y=10, 
                                         active_cells=50, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=10, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool', 'gear', 'circuit','metal'])
}