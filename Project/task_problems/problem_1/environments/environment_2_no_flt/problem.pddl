;; problem file: problem_2.pddl
(define (problem default)
  (:domain default)
  (:objects l1_4 l2_0 l0_6 l1_3 l1_2 l3_2 l2_2 l3_0 l0_3 l0_5 l4_4 l1_1 l2_3 l0_7 l0_4 l1_0 l0_2 l3_3 l2_4 l1_5 l0_0 l3_1 l2_1 l3_4 l2_5 - location agent_0 - agent supply_3 supply_14 supply_9 supply_0 supply_11 supply_1 supply_8 supply_7 supply_12 supply_6 supply_4 supply_2 supply_13 supply_10 supply_5 - supply box_6 box_0 box_4 box_5 box_1 box_7 box_2 box_9 box_8 box_3 - box workstation_2 workstation_0 workstation_1 - workstation warehouse_0 - warehouse gear circuit bolt tool valve - supply_type )
  (:init (adjacent l1_4 l2_4) (empty box_3) (at supply_14 l3_3) (adjacent l2_1 l2_2) (adjacent l3_1 l3_0) (adjacent l0_5 l1_5) (is supply_1 valve) (at supply_0 l3_3) (adjacent l0_3 l1_3) (adjacent l2_0 l2_1) (at box_4 l3_3) (available box_5) (adjacent l2_2 l2_1) (at box_0 l3_3) (adjacent l2_5 l1_5) (loaded_to supply_10 workstation_1) (available box_8) (at workstation_0 l0_0) (adjacent l3_3 l3_4) (is supply_12 circuit) (at box_9 l3_3) (at supply_11 l3_3) (at workstation_2 l3_0) (adjacent l2_4 l2_5) (adjacent l1_3 l0_3) (loaded_to supply_13 workstation_1) (adjacent l1_2 l0_2) (is supply_2 valve) (adjacent l2_4 l3_4) (is supply_6 tool) (adjacent l0_7 l0_6) (adjacent l1_5 l2_5) (empty box_9) (adjacent l2_5 l2_4) (is supply_13 circuit) (at supply_12 l3_3) (adjacent l2_4 l2_3) (adjacent l3_3 l2_3) (adjacent l0_3 l0_4) (is supply_7 tool) (adjacent l1_0 l2_0) (adjacent l1_3 l2_3) (adjacent l2_3 l2_2) (available box_1) (adjacent l3_3 l3_2) (at supply_10 l3_3) (is supply_14 circuit) (empty box_7) (adjacent l0_2 l0_3) (empty box_6) (available box_0) (adjacent l1_1 l1_2) (empty box_2) (at box_6 l3_3) (adjacent l1_2 l1_1) (adjacent l0_4 l0_5) (empty box_0) (is supply_11 gear) (available box_9) (adjacent l0_4 l0_3) (at supply_6 l3_3) (adjacent l1_1 l1_0) (adjacent l3_1 l2_1) (adjacent l3_2 l3_1) (at box_1 l3_3) (adjacent l2_0 l3_0) (at box_5 l3_3) (is supply_5 bolt) (adjacent l2_4 l1_4) (is supply_8 tool) (at supply_9 l3_3) (empty box_5) (is supply_9 gear) (adjacent l0_3 l0_2) (loaded_to supply_3 workstation_2) (is supply_0 valve) (adjacent l0_5 l0_6) (adjacent l1_3 l1_4) (adjacent l2_1 l3_1) (adjacent l3_2 l3_3) (available box_2) (adjacent l2_3 l1_3) (adjacent l3_4 l3_3) (empty box_8) (available box_4) (at supply_4 l3_3) (at supply_13 l3_3) (adjacent l2_3 l3_3) (adjacent l4_4 l3_4) (adjacent l1_4 l1_5) (adjacent l1_5 l1_4) (adjacent l1_1 l2_1) (adjacent l0_4 l1_4) (adjacent l0_6 l0_7) (at supply_5 l3_3) (adjacent l2_2 l2_3) (free_arms agent_0) (adjacent l3_4 l2_4) (adjacent l3_2 l2_2) (adjacent l2_3 l2_4) (adjacent l1_3 l1_2) (adjacent l2_2 l1_2) (empty box_4) (adjacent l0_2 l1_2) (adjacent l1_0 l1_1) (at workstation_1 l0_2) (adjacent l1_2 l1_3) (adjacent l0_5 l0_4) (adjacent l3_0 l2_0) (adjacent l0_0 l1_0) (empty box_1) (adjacent l2_2 l3_2) (adjacent l1_4 l0_4) (is supply_4 bolt) (loaded_to supply_14 workstation_0) (at box_8 l3_3) (at supply_1 l3_3) (adjacent l2_1 l1_1) (available box_6) (adjacent l1_4 l1_3) (is supply_3 bolt) (available box_7) (at box_2 l3_3) (adjacent l2_0 l1_0) (at supply_2 l3_3) (at supply_8 l3_3) (at agent_0 l3_3) (adjacent l2_1 l2_0) (at box_7 l3_3) (adjacent l1_0 l0_0) (is supply_10 gear) (adjacent l1_2 l2_2) (loaded_to supply_11 workstation_0) (adjacent l3_4 l4_4) (at box_3 l3_3) (at supply_7 l3_3) (adjacent l3_1 l3_2) (available box_3) (adjacent l0_6 l0_5) (adjacent l1_5 l0_5) (at warehouse_0 l3_3) (adjacent l3_0 l3_1) (at supply_3 l3_3) (loaded_to supply_5 workstation_0))
  (:goal (and (has workstation_2 tool) (has workstation_2 circuit) (has workstation_0 valve) (has workstation_1 tool) (has workstation_2 valve) (has workstation_0 tool) (has workstation_2 gear) (has workstation_1 valve) (has workstation_1 bolt)))
)