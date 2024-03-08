from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'content_type', 'boxes', 'workstations', 'warehouses','carrier_capacity'])
# Configuration 1
configurations = {
'config_1' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=2, 
                                         boxes=10, 
                                         workstations=2, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool'], 
                                         carrier_capacity = 3),

# Configuration 2
'config_2' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=3, 
                                         boxes=10, 
                                         workstations=3, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool','gear'],
                                         carrier_capacity = 5),

# Configuration 3
'config_3' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=4, 
                                         boxes=10, 
                                         workstations=4, 
                                         warehouses=1,
                                         content_type=['valve', 'bolt', 'tool', 'gear', 'circuit'],
                                         carrier_capacity = 7),
}