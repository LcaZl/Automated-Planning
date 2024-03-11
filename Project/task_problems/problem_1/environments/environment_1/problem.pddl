;; problem file: problem_1.pddl
(define (problem default)
  (:domain default)
  (:objects l5_1 l5_6 l4_2 l5_5 l1_3 l1_2 l4_6 l4_5 l1_5 l6_4 l4_1 l2_6 l6_3 l5_4 l3_3 l2_5 l6_0 l1_1 l3_5 l6_1 l2_1 l6_2 l1_6 l6_6 l1_0 l1_4 l2_0 l3_1 l3_0 l3_6 l4_0 l4_3 l4_4 l5_2 l5_3 l3_2 l3_4 l5_0 l6_5 l2_2 - location agent_0 - agent supply_1 supply_8 supply_0 supply_6 supply_3 supply_22 supply_11 supply_23 supply_12 supply_14 supply_10 supply_4 supply_19 supply_24 supply_21 supply_20 supply_2 supply_13 supply_7 supply_18 supply_5 supply_17 supply_15 supply_9 supply_16 - supply box_0 - box workstation_2 workstation_0 workstation_3 workstation_4 workstation_1 - workstation warehouse_0 - warehouse bolt valve circuit tool gear - supply_type )
  (:init (adjacent l3_4 l4_4) (adjacent l6_4 l5_4) (adjacent l3_1 l2_1) (at supply_19 l1_0) (adjacent l4_6 l3_6) (adjacent l4_4 l4_5) (adjacent l6_1 l6_0) (adjacent l3_5 l2_5) (adjacent l2_1 l2_0) (at supply_1 l1_0) (adjacent l3_1 l3_2) (adjacent l6_3 l6_4) (is supply_11 tool) (adjacent l2_5 l2_6) (adjacent l1_1 l1_0) (at supply_4 l1_0) (at supply_17 l1_0) (is supply_18 gear) (is supply_20 circuit) (adjacent l3_5 l3_4) (adjacent l6_4 l6_3) (adjacent l3_0 l2_0) (at agent_0 l1_0) (adjacent l4_2 l5_2) (empty box_0) (adjacent l5_1 l5_2) (adjacent l3_0 l4_0) (adjacent l5_5 l4_5) (at supply_15 l1_0) (at supply_10 l1_0) (adjacent l1_0 l2_0) (adjacent l5_0 l5_1) (is supply_6 bolt) (is supply_22 circuit) (is supply_0 valve) (adjacent l4_1 l3_1) (adjacent l4_5 l4_4) (is supply_17 gear) (adjacent l3_4 l3_3) (adjacent l2_2 l1_2) (adjacent l3_2 l4_2) (adjacent l3_2 l2_2) (adjacent l2_5 l1_5) (adjacent l1_5 l1_6) (adjacent l2_1 l1_1) (at supply_16 l1_0) (adjacent l1_2 l1_1) (adjacent l2_6 l3_6) (adjacent l4_3 l4_4) (adjacent l4_5 l3_5) (at workstation_0 l1_5) (at supply_20 l1_0) (at supply_24 l1_0) (adjacent l5_1 l4_1) (adjacent l4_5 l5_5) (adjacent l6_5 l6_4) (adjacent l5_5 l6_5) (adjacent l2_6 l1_6) (at supply_12 l1_0) (adjacent l4_3 l4_2) (adjacent l3_3 l3_2) (adjacent l3_2 l3_3) (adjacent l5_3 l4_3) (is supply_23 circuit) (at supply_5 l1_0) (adjacent l5_6 l4_6) (adjacent l3_3 l4_3) (adjacent l2_1 l3_1) (adjacent l6_2 l6_1) (adjacent l1_2 l1_3) (adjacent l5_3 l6_3) (is supply_10 tool) (adjacent l6_3 l6_2) (is supply_21 circuit) (at workstation_4 l2_6) (adjacent l4_2 l4_1) (adjacent l4_4 l3_4) (adjacent l4_5 l4_6) (adjacent l4_3 l3_3) (adjacent l5_1 l6_1) (is supply_2 valve) (is supply_24 circuit) (is supply_13 tool) (is supply_19 gear) (is supply_7 bolt) (adjacent l4_1 l4_2) (adjacent l5_4 l5_3) (adjacent l6_3 l5_3) (adjacent l2_0 l1_0) (is supply_4 valve) (adjacent l5_4 l5_5) (adjacent l5_5 l5_6) (at supply_18 l1_0) (adjacent l5_2 l5_1) (at supply_2 l1_0) (adjacent l6_2 l5_2) (adjacent l5_2 l5_3) (at workstation_1 l3_5) (adjacent l3_2 l3_1) (adjacent l5_3 l5_4) (adjacent l6_4 l6_5) (adjacent l2_1 l2_2) (is supply_9 bolt) (at supply_11 l1_0) (is supply_1 valve) (adjacent l6_0 l6_1) (at supply_7 l1_0) (adjacent l6_2 l6_3) (adjacent l4_1 l5_1) (adjacent l3_0 l3_1) (adjacent l4_0 l4_1) (is supply_15 gear) (adjacent l2_5 l3_5) (adjacent l1_4 l1_3) (adjacent l1_3 l1_2) (adjacent l3_6 l3_5) (adjacent l5_0 l6_0) (adjacent l1_0 l1_1) (adjacent l4_4 l4_3) (adjacent l3_5 l3_6) (at workstation_2 l4_5) (at supply_13 l1_0) (adjacent l4_2 l4_3) (adjacent l6_6 l5_6) (adjacent l3_6 l2_6) (adjacent l6_5 l6_6) (adjacent l4_3 l5_3) (at box_0 l1_0) (adjacent l5_1 l5_0) (is supply_14 tool) (adjacent l5_0 l4_0) (adjacent l1_5 l1_4) (adjacent l1_6 l2_6) (at workstation_3 l2_2) (at supply_0 l1_0) (adjacent l3_4 l3_5) (adjacent l4_6 l5_6) (adjacent l6_0 l5_0) (adjacent l6_1 l6_2) (is supply_16 gear) (at supply_6 l1_0) (at supply_9 l1_0) (adjacent l2_0 l3_0) (adjacent l2_0 l2_1) (adjacent l3_1 l4_1) (adjacent l4_4 l5_4) (adjacent l2_6 l2_5) (adjacent l1_2 l2_2) (adjacent l4_1 l4_0) (adjacent l5_3 l5_2) (adjacent l5_2 l6_2) (adjacent l5_4 l6_4) (adjacent l2_2 l2_1) (adjacent l5_4 l4_4) (adjacent l1_1 l1_2) (at supply_21 l1_0) (adjacent l6_5 l5_5) (is supply_8 bolt) (at warehouse_0 l1_0) (at supply_14 l1_0) (adjacent l3_5 l4_5) (adjacent l3_1 l3_0) (adjacent l2_2 l3_2) (adjacent l3_3 l3_4) (adjacent l4_2 l3_2) (adjacent l6_1 l5_1) (at supply_22 l1_0) (loaded_to supply_17 workstation_2) (free_arms agent_0) (at supply_8 l1_0) (adjacent l4_0 l5_0) (adjacent l1_3 l1_4) (adjacent l6_6 l6_5) (adjacent l5_6 l6_6) (adjacent l1_1 l2_1) (loaded_to supply_24 workstation_0) (adjacent l5_2 l4_2) (adjacent l3_6 l4_6) (adjacent l1_6 l1_5) (adjacent l1_5 l2_5) (adjacent l5_5 l5_4) (adjacent l4_6 l4_5) (is supply_5 bolt) (is supply_3 valve) (adjacent l5_6 l5_5) (at supply_23 l1_0) (is supply_12 tool) (adjacent l1_4 l1_5) (at supply_3 l1_0) (adjacent l4_0 l3_0))
  (:goal (and (has workstation_0 valve) (has workstation_0 bolt) (has workstation_3 valve) (has workstation_4 tool) (has workstation_1 tool) (has workstation_1 bolt) (has workstation_3 bolt) (has workstation_4 gear) (has workstation_1 gear) (has workstation_4 valve) (has workstation_2 circuit) (has workstation_2 tool) (has workstation_1 circuit) (has workstation_1 valve) (has workstation_4 circuit) (has workstation_3 tool) (has workstation_0 gear) (has workstation_3 gear) (has workstation_4 bolt)))
)