;; problem file: problem_5.pddl
(define (problem default)
  (:domain default)
  (:objects l4_4 l4_6 l5_1 l6_1 l6_0 l6_2 l6_6 l1_6 l2_1 l3_0 l5_5 l5_3 l6_4 l1_4 l3_6 l1_5 l5_0 l2_6 l0_5 l4_2 l4_1 l0_6 l2_2 l5_2 l2_0 l5_6 l2_4 l2_5 l3_2 l4_5 l2_3 l3_3 l5_4 l3_5 l6_5 l6_3 l3_1 l0_4 l4_3 l3_4 - location agent_3 agent_1 agent_2 agent_0 - agent supply_7 supply_4 supply_2 supply_3 supply_5 supply_8 supply_11 supply_9 supply_0 supply_1 supply_10 supply_6 - supply box_1 box_2 box_4 box_9 box_12 box_7 box_5 box_10 box_6 box_3 box_13 box_11 box_14 box_15 box_8 box_0 - box workstation_0 workstation_2 workstation_1 - workstation warehouse_0 - warehouse carrier_0 carrier_3 carrier_2 carrier_1 - carrier tool circuit bolt valve - supply_type capacity_0 capacity_2 capacity_1 capacity_3 capacity_4 - capacity )
  (:init (= (total-cost) 0) (= (carrier-load carrier_0) 0) (= (carrier-load carrier_1) 0) (= (carrier-load carrier_2) 0) (= (carrier-load carrier_3) 0) (adjacent l3_2 l3_3) (adjacent l6_6 l6_5) (adjacent l4_5 l4_6) (at agent_3 l3_2) (adjacent l5_2 l5_3) (adjacent l3_4 l4_4) (adjacent l4_2 l4_1) (adjacent l5_1 l5_0) (adjacent l4_4 l4_3) (adjacent l3_3 l3_4) (empty box_3) (at supply_9 l3_2) (at box_8 l3_2) (adjacent l2_2 l2_3) (adjacent l4_4 l4_5) (adjacent l6_4 l5_4) (adjacent l6_2 l6_1) (at supply_0 l3_2) (is supply_0 valve) (= (carrier-capacity carrier_0) 4) (adjacent l3_3 l3_2) (empty box_7) (empty box_0) (at box_12 l3_2) (adjacent l0_4 l0_5) (adjacent l2_1 l3_1) (adjacent l3_2 l4_2) (empty box_12) (adjacent l1_4 l2_4) (adjacent l4_3 l4_4) (adjacent l6_4 l6_5) (adjacent l5_1 l6_1) (adjacent l2_5 l2_6) (adjacent l4_5 l3_5) (adjacent l1_5 l0_5) (at box_1 l3_2) (at box_0 l3_2) (at supply_5 l3_2) (adjacent l6_5 l5_5) (empty box_13) (adjacent l5_3 l6_3) (adjacent l5_4 l5_5) (at workstation_2 l6_4) (adjacent l3_0 l2_0) (adjacent l4_2 l4_3) (at supply_1 l3_2) (adjacent l4_1 l4_2) (at supply_7 l3_2) (adjacent l4_2 l5_2) (adjacent l1_6 l1_5) (adjacent l6_2 l6_3) (at box_3 l3_2) (at box_6 l3_2) (adjacent l0_5 l0_6) (adjacent l4_1 l5_1) (adjacent l5_3 l5_2) (adjacent l4_4 l5_4) (adjacent l5_2 l5_1) (at supply_6 l3_2) (adjacent l2_4 l2_5) (at supply_10 l3_2) (adjacent l5_5 l5_4) (at box_15 l3_2) (adjacent l3_6 l2_6) (adjacent l4_1 l3_1) (adjacent l0_4 l1_4) (adjacent l5_1 l4_1) (at box_7 l3_2) (at box_13 l3_2) (is supply_10 circuit) (adjacent l2_4 l1_4) (adjacent l2_1 l2_0) (adjacent l5_4 l6_4) (adjacent l6_4 l6_3) (is supply_8 tool) (adjacent l3_0 l3_1) (adjacent l2_6 l1_6) (adjacent l4_3 l5_3) (empty box_14) (empty box_1) (adjacent l5_2 l6_2) (adjacent l2_6 l2_5) (adjacent l6_3 l5_3) (adjacent l0_5 l0_4) (adjacent l3_5 l4_5) (adjacent l3_2 l2_2) (adjacent l3_4 l3_5) (adjacent l3_1 l2_1) (adjacent l4_6 l3_6) (at supply_8 l3_2) (adjacent l2_3 l3_3) (attached carrier_2 agent_2) (adjacent l5_6 l5_5) (adjacent l5_1 l5_2) (adjacent l2_2 l3_2) (adjacent l6_1 l6_2) (at box_11 l3_2) (adjacent l5_4 l4_4) (at box_14 l3_2) (adjacent l2_3 l2_2) (attached carrier_0 agent_0) (adjacent l3_3 l4_3) (at box_4 l3_2) (loaded_to supply_1 workstation_1) (at warehouse_0 l3_2) (adjacent l3_1 l3_0) (adjacent l2_4 l2_3) (adjacent l4_5 l5_5) (adjacent l5_6 l4_6) (empty box_11) (empty box_15) (empty box_6) (adjacent l1_4 l1_5) (adjacent l5_5 l5_6) (adjacent l2_6 l3_6) (adjacent l5_5 l4_5) (at supply_3 l3_2) (adjacent l4_3 l4_2) (adjacent l1_6 l0_6) (adjacent l0_5 l1_5) (at workstation_1 l6_0) (is supply_2 valve) (at supply_4 l3_2) (at workstation_0 l4_2) (adjacent l6_1 l6_0) (adjacent l1_5 l1_6) (adjacent l6_2 l5_2) (is supply_7 tool) (adjacent l5_3 l4_3) (is supply_5 bolt) (at supply_11 l3_2) (adjacent l5_2 l4_2) (adjacent l6_0 l6_1) (adjacent l6_3 l6_4) (adjacent l4_6 l4_5) (at box_5 l3_2) (adjacent l3_4 l3_3) (adjacent l4_6 l5_6) (adjacent l3_6 l4_6) (adjacent l3_1 l4_1) (at agent_0 l3_2) (empty box_9) (adjacent l5_6 l6_6) (adjacent l3_3 l2_3) (adjacent l4_5 l4_4) (is supply_6 tool) (adjacent l6_5 l6_6) (= (carrier-capacity carrier_1) 4) (attached carrier_1 agent_1) (adjacent l6_1 l5_1) (at box_2 l3_2) (adjacent l2_5 l3_5) (adjacent l0_6 l0_5) (adjacent l2_5 l1_5) (adjacent l2_1 l2_2) (empty box_4) (adjacent l3_4 l2_4) (adjacent l5_3 l5_4) (adjacent l1_5 l1_4) (adjacent l0_6 l1_6) (adjacent l2_5 l2_4) (adjacent l4_4 l3_4) (adjacent l2_3 l2_4) (empty box_5) (adjacent l5_4 l5_3) (at box_10 l3_2) (adjacent l2_0 l3_0) (= (carrier-capacity carrier_2) 4) (adjacent l5_0 l6_0) (adjacent l5_0 l5_1) (at agent_1 l3_2) (adjacent l5_5 l6_5) (empty box_8) (adjacent l6_5 l6_4) (adjacent l3_2 l3_1) (at agent_2 l3_2) (= (carrier-capacity carrier_3) 4) (is supply_3 bolt) (adjacent l1_6 l2_6) (empty box_2) (adjacent l2_4 l3_4) (attached carrier_3 agent_3) (adjacent l2_2 l2_1) (adjacent l6_6 l5_6) (adjacent l3_5 l2_5) (adjacent l6_0 l5_0) (at supply_2 l3_2) (adjacent l3_5 l3_6) (is supply_9 circuit) (adjacent l3_5 l3_4) (is supply_4 bolt) (adjacent l2_0 l2_1) (adjacent l1_5 l2_5) (adjacent l4_2 l3_2) (adjacent l3_6 l3_5) (adjacent l1_4 l0_4) (is supply_1 valve) (at box_9 l3_2) (is supply_11 circuit) (adjacent l3_1 l3_2) (adjacent l4_3 l3_3) (adjacent l6_3 l6_2) (empty box_10))
  (:goal (and (has workstation_1 bolt) (has workstation_2 tool) (has workstation_0 valve) (has workstation_0 tool) (has workstation_2 bolt) (has workstation_0 circuit) (has workstation_2 valve) (has workstation_1 tool) (has workstation_1 circuit) (has workstation_0 bolt)))
  (:metric minimize (total-cost))  
)