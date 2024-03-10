from collections import namedtuple
EnvironmentConfig = namedtuple('EnvironmentConfig', ['X', 'Y', 'active_cells', 'agents',
                                                     'supply_types', 'boxes', 'workstations', 'warehouses','carrier_capacity'])
# Configuration 1
configurations = {
'config_1' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=1, 
                                         boxes=10, 
                                         workstations=1, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool'], 
                                         carrier_capacity = 3),

# Configuration 2
'config_2' : EnvironmentConfig(X=5, 
                                         Y=5, 
                                         active_cells=25, 
                                         agents=2, 
                                         boxes=10, 
                                         workstations=2, 
                                         warehouses=1,
                                         supply_types=['valve', 'bolt', 'tool'],
                                         carrier_capacity = 4),

}