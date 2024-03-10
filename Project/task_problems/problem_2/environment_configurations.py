from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'supply_types', 'boxes', 'workstations', 'warehouses','carrier_capacity'])
configurations = {
'config_1' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=1, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool'],
                                         carrier_capacity = 2),

# Configuration 2
'config_2' : EnvironmentConfig(X=6, 
                                         Y=6, 
                                         active_cells=30, 
                                         agents=2, 
                                         boxes=20, 
                                         workstations=2, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool','gear'],
                                         carrier_capacity = 3),

# Configuration 3
'config_3' : EnvironmentConfig(X=7, 
                                         Y=7, 
                                         active_cells=40, 
                                         agents=3, 
                                         boxes=30, 
                                         workstations=3, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool', 'gear', 'circuit'],
                                         carrier_capacity = 4)
}