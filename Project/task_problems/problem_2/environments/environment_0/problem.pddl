;; problem file: problem_3.pddl
(define (problem default)
  (:domain default)
  (:objects l6_0 l5_2 l4_6 l4_5 l4_4 l5_0 l6_5 l6_1 l3_5 l6_2 l6_3 l5_6 l5_3 l4_3 l3_6 l5_1 l6_6 l6_4 l5_4 l5_5 - location agent_1 agent_0 - agent supply_3 supply_0 supply_2 supply_4 supply_5 supply_1 - supply box_6 box_9 box_2 box_8 box_5 box_7 box_0 box_1 box_4 box_3 - box workstation_0 workstation_1 - workstation warehouse_0 - warehouse carrier_0 carrier_1 - carrier tool bolt valve - supply_type capacity_0 capacity_1 capacity_2 - capacity )
  (:init (adjacent l5_4 l6_4) (at supply_0 l6_6) (adjacent l4_6 l5_6) (adjacent l6_3 l5_3) (adjacent l4_3 l4_4) (at agent_0 l6_6) (predecessor capacity_0 capacity_1) (adjacent l6_5 l5_5) (adjacent l6_3 l6_4) (is supply_4 tool) (adjacent l6_6 l6_5) (at box_0 l6_6) (attached carrier_0 agent_0) (at supply_4 l6_6) (at box_4 l6_6) (adjacent l6_5 l6_4) (adjacent l4_5 l4_4) (at supply_2 l6_6) (adjacent l5_4 l4_4) (adjacent l5_5 l5_4) (at box_1 l6_6) (adjacent l5_0 l6_0) (empty box_9) (adjacent l5_5 l6_5) (adjacent l5_2 l5_3) (adjacent l5_0 l5_1) (adjacent l5_6 l5_5) (at box_5 l6_6) (adjacent l6_2 l6_1) (adjacent l5_2 l5_1) (empty box_2) (adjacent l6_0 l5_0) (adjacent l4_6 l4_5) (is supply_0 valve) (adjacent l6_2 l6_3) (adjacent l6_5 l6_6) (adjacent l6_1 l6_0) (adjacent l3_5 l4_5) (adjacent l6_1 l5_1) (adjacent l6_2 l5_2) (at agent_1 l6_6) (empty box_3) (empty box_1) (adjacent l6_4 l5_4) (empty box_0) (adjacent l5_6 l6_6) (adjacent l4_4 l4_5) (at warehouse_0 l6_6) (adjacent l5_1 l5_0) (adjacent l5_2 l6_2) (adjacent l4_5 l4_6) (at box_8 l6_6) (is supply_1 valve) (adjacent l4_6 l3_6) (at workstation_0 l6_1) (adjacent l5_3 l6_3) (at box_2 l6_6) (adjacent l5_1 l6_1) (adjacent l5_6 l4_6) (adjacent l4_3 l5_3) (adjacent l6_1 l6_2) (carrier_capacity carrier_0 capacity_2) (adjacent l5_3 l5_4) (predecessor capacity_1 capacity_2) (empty box_7) (at box_6 l6_6) (adjacent l6_4 l6_5) (empty box_6) (adjacent l3_6 l4_6) (is supply_3 bolt) (at workstation_1 l5_5) (at box_3 l6_6) (is supply_5 tool) (adjacent l6_3 l6_2) (adjacent l6_0 l6_1) (empty box_4) (adjacent l3_6 l3_5) (at supply_3 l6_6) (at supply_1 l6_6) (adjacent l5_3 l5_2) (attached carrier_1 agent_1) (adjacent l4_4 l5_4) (is supply_2 bolt) (at box_7 l6_6) (adjacent l4_5 l5_5) (adjacent l4_5 l3_5) (adjacent l6_6 l5_6) (carrier_capacity carrier_1 capacity_2) (adjacent l5_4 l5_5) (at box_9 l6_6) (at supply_5 l6_6) (empty box_5) (adjacent l5_4 l5_3) (adjacent l5_5 l5_6) (adjacent l3_5 l3_6) (adjacent l5_1 l5_2) (adjacent l5_5 l4_5) (empty box_8) (adjacent l5_3 l4_3) (adjacent l4_4 l4_3) (adjacent l6_4 l6_3))
  (:goal (and (has workstation_1 valve) (has workstation_0 bolt) (has workstation_0 tool) (has workstation_1 bolt) (has workstation_1 tool)))
)