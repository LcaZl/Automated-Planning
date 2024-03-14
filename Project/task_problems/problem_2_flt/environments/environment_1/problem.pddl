;; problem file: problem_1.pddl
(define (problem default)
  (:domain default)
  (:objects l4_4 l4_6 l6_1 l6_0 l6_2 l6_6 l2_1 l4_0 l5_5 l5_3 l6_4 l3_6 l5_0 l2_6 l4_2 l4_1 l2_2 l5_2 l5_6 l2_4 l2_5 l4_5 l2_3 l5_4 l3_5 l6_5 l6_3 l5_1 l4_3 l3_4 - location agent_1 agent_2 agent_0 - agent supply_7 supply_4 supply_2 supply_3 supply_5 supply_0 supply_1 supply_6 - supply box_1 box_2 box_4 box_5 box_3 box_0 - box workstation_0 workstation_1 - workstation warehouse_0 - warehouse carrier_0 carrier_2 carrier_1 - carrier tool circuit bolt valve - supply_type capacity_0 capacity_3 capacity_2 capacity_1 - capacity )
  (:init (= (carrier-load carrier_0) 0) (= (carrier-load carrier_1) 0) (= (carrier-load carrier_2) 0) (= (total-cost) 0) (adjacent l6_6 l6_5) (adjacent l4_5 l4_6) (adjacent l5_2 l5_3) (adjacent l3_4 l4_4) (adjacent l4_2 l4_1) (adjacent l5_1 l5_0) (adjacent l5_0 l4_0) (adjacent l4_4 l4_3) (empty box_3) (adjacent l2_2 l2_3) (at warehouse_0 l6_1) (adjacent l6_2 l6_1) (adjacent l6_4 l5_4) (is supply_0 valve) (at box_1 l6_1) (empty box_0) (adjacent l4_3 l4_4) (adjacent l6_4 l6_5) (adjacent l5_1 l6_1) (adjacent l2_5 l2_6) (adjacent l4_5 l3_5) (adjacent l6_5 l5_5) (adjacent l5_3 l6_3) (at workstation_1 l4_6) (adjacent l5_4 l5_5) (adjacent l4_2 l4_3) (at workstation_0 l5_2) (adjacent l4_1 l4_2) (adjacent l4_2 l5_2) (adjacent l6_2 l6_3) (adjacent l4_1 l5_1) (at agent_2 l6_1) (adjacent l5_3 l5_2) (adjacent l4_4 l5_4) (adjacent l5_2 l5_1) (adjacent l2_4 l2_5) (= (carrier-capacity carrier_2) 3) (adjacent l5_5 l5_4) (adjacent l3_6 l2_6) (adjacent l5_1 l4_1) (= (carrier-capacity carrier_1) 3) (adjacent l5_4 l6_4) (adjacent l6_4 l6_3) (is supply_6 circuit) (is supply_2 bolt) (at box_3 l6_1) (adjacent l4_3 l5_3) (empty box_1) (adjacent l5_2 l6_2) (adjacent l2_6 l2_5) (is supply_7 circuit) (adjacent l6_3 l5_3) (adjacent l3_5 l4_5) (at supply_4 l6_1) (adjacent l3_4 l3_5) (adjacent l4_6 l3_6) (attached carrier_2 agent_2) (adjacent l5_6 l5_5) (= (carrier-capacity carrier_0) 3) (adjacent l5_1 l5_2) (adjacent l6_1 l6_2) (adjacent l5_4 l4_4) (at supply_1 l6_1) (at supply_2 l6_1) (adjacent l2_3 l2_2) (attached carrier_0 agent_0) (at box_2 l6_1) (adjacent l2_4 l2_3) (adjacent l4_5 l5_5) (adjacent l5_6 l4_6) (at supply_7 l6_1) (adjacent l5_5 l5_6) (adjacent l2_6 l3_6) (adjacent l5_5 l4_5) (adjacent l4_3 l4_2) (adjacent l4_1 l4_0) (adjacent l4_0 l4_1) (adjacent l6_1 l6_0) (at supply_0 l6_1) (adjacent l6_2 l5_2) (adjacent l5_3 l4_3) (at box_5 l6_1) (adjacent l5_2 l4_2) (adjacent l6_0 l6_1) (adjacent l6_3 l6_4) (adjacent l4_6 l4_5) (at box_4 l6_1) (is supply_5 tool) (adjacent l4_6 l5_6) (adjacent l3_6 l4_6) (adjacent l5_6 l6_6) (adjacent l4_5 l4_4) (is supply_4 tool) (adjacent l6_5 l6_6) (attached carrier_1 agent_1) (adjacent l6_1 l5_1) (adjacent l2_5 l3_5) (adjacent l2_1 l2_2) (empty box_4) (adjacent l3_4 l2_4) (adjacent l5_3 l5_4) (adjacent l2_5 l2_4) (adjacent l4_4 l3_4) (at supply_5 l6_1) (adjacent l2_3 l2_4) (empty box_5) (adjacent l5_4 l5_3) (adjacent l5_0 l6_0) (adjacent l5_0 l5_1) (adjacent l4_0 l5_0) (adjacent l5_5 l6_5) (adjacent l6_5 l6_4) (at box_0 l6_1) (is supply_3 bolt) (empty box_2) (adjacent l2_4 l3_4) (at agent_1 l6_1) (adjacent l2_2 l2_1) (adjacent l6_6 l5_6) (adjacent l3_5 l2_5) (adjacent l6_0 l5_0) (adjacent l3_5 l3_6) (adjacent l3_5 l3_4) (at agent_0 l6_1) (at supply_3 l6_1) (adjacent l3_6 l3_5) (at supply_6 l6_1) (is supply_1 valve) (adjacent l4_4 l4_5) (adjacent l6_3 l6_2))
  (:goal (and (has workstation_1 valve) (has workstation_1 bolt) (has workstation_0 valve) (has workstation_0 tool) (has workstation_0 circuit) (has workstation_1 tool) (has workstation_1 circuit) (has workstation_0 bolt)))
  (:metric minimize (total-cost))

  
  )