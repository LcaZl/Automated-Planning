;; problem file: problem_1.pddl
(define (problem default)
  (:domain default)
  (:objects l0_2 l4_1 l4_3 l3_2 l4_0 l2_1 l3_0 l4_2 l3_1 l1_3 l4_4 l2_4 l0_1 l3_3 l1_4 l0_3 l2_3 l2_2 l3_4 l1_1 l1_0 l1_2 l0_0 l0_4 l2_0 - location agent_0 - agent supply_7 supply_6 supply_2 supply_1 supply_4 supply_0 supply_3 supply_5 - supply box_3 box_8 box_5 box_6 box_4 box_2 box_7 box_0 box_9 box_1 - box workstation_0 workstation_1 - workstation warehouse_0 - warehouse bolt tool valve gear - supply_type )
  (:init (adjacent l1_0 l2_0) (empty box_9) (empty box_8) (adjacent l3_2 l2_2) (adjacent l1_1 l1_0) (available box_6) (at supply_0 l4_0) (available box_9) (free_arms agent_0) (is supply_4 tool) (empty box_6) (is supply_7 gear) (adjacent l4_3 l4_2) (adjacent l3_2 l4_2) (adjacent l2_1 l3_1) (is supply_2 bolt) (adjacent l2_1 l2_0) (adjacent l1_1 l2_1) (adjacent l0_0 l1_0) (adjacent l4_0 l4_1) (adjacent l4_1 l3_1) (is supply_6 gear) (adjacent l4_0 l3_0) (at supply_4 l4_0) (adjacent l2_3 l3_3) (adjacent l1_3 l2_3) (empty box_7) (adjacent l3_2 l3_3) (at warehouse_0 l4_0) (at box_9 l4_0) (adjacent l0_4 l1_4) (adjacent l0_1 l0_2) (is supply_1 valve) (adjacent l2_4 l3_4) (is supply_5 tool) (at box_1 l4_0) (empty box_5) (adjacent l2_4 l2_3) (adjacent l0_3 l0_4) (adjacent l3_3 l2_3) (adjacent l1_2 l1_3) (adjacent l4_4 l4_3) (available box_7) (adjacent l1_2 l1_1) (adjacent l3_4 l2_4) (at box_2 l4_0) (adjacent l3_1 l4_1) (adjacent l3_4 l3_3) (adjacent l1_2 l2_2) (adjacent l1_4 l0_4) (adjacent l4_4 l3_4) (is supply_3 bolt) (adjacent l1_2 l0_2) (empty box_0) (adjacent l3_1 l3_2) (at box_7 l4_0) (adjacent l4_2 l4_1) (adjacent l3_4 l4_4) (at box_4 l4_0) (at box_6 l4_0) (available box_2) (adjacent l4_1 l4_0) (available box_1) (adjacent l3_0 l2_0) (adjacent l2_1 l1_1) (adjacent l1_3 l1_2) (adjacent l3_3 l3_4) (adjacent l2_2 l2_3) (adjacent l4_3 l4_4) (adjacent l0_0 l0_1) (adjacent l1_3 l0_3) (adjacent l3_3 l4_3) (adjacent l3_1 l2_1) (adjacent l2_3 l2_4) (adjacent l1_3 l1_4) (available box_4) (adjacent l4_3 l3_3) (at supply_1 l4_0) (available box_5) (adjacent l0_2 l0_3) (adjacent l0_4 l0_3) (at workstation_0 l4_3) (empty box_3) (adjacent l4_2 l3_2) (adjacent l3_0 l3_1) (at supply_6 l4_0) (adjacent l2_1 l2_2) (is supply_0 valve) (adjacent l4_1 l4_2) (at supply_3 l4_0) (at supply_7 l4_0) (adjacent l2_2 l3_2) (adjacent l2_0 l3_0) (adjacent l1_4 l1_3) (empty box_1) (adjacent l2_2 l2_1) (adjacent l0_3 l1_3) (at box_8 l4_0) (at box_5 l4_0) (adjacent l2_4 l1_4) (empty box_4) (adjacent l0_2 l0_1) (adjacent l3_3 l3_2) (adjacent l2_2 l1_2) (adjacent l3_1 l3_0) (adjacent l0_1 l0_0) (available box_3) (at box_0 l4_0) (adjacent l1_0 l0_0) (adjacent l1_4 l2_4) (adjacent l1_0 l1_1) (at workstation_1 l2_4) (available box_8) (adjacent l2_0 l2_1) (available box_0) (empty box_2) (adjacent l1_1 l1_2) (adjacent l2_3 l2_2) (adjacent l0_3 l0_2) (adjacent l3_2 l3_1) (adjacent l0_1 l1_1) (adjacent l1_1 l0_1) (at agent_0 l4_0) (adjacent l2_3 l1_3) (adjacent l3_0 l4_0) (at box_3 l4_0) (adjacent l2_0 l1_0) (adjacent l0_2 l1_2) (adjacent l4_2 l4_3) (at supply_2 l4_0) (at supply_5 l4_0))
  (:goal (and (has workstation_1 tool) (has workstation_1 bolt) (has workstation_0 gear) (has workstation_1 gear) (has workstation_0 tool) (has workstation_1 valve) (has workstation_0 valve)))
)