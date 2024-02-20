;; problem file: problem_8.pddl
(define (problem default)
  (:domain default)
  (:objects l0_4 l1_3 l1_4 l2_3 l2_4 l3_3 l3_4 l4_2 l4_3 l4_4 - location agent_0 - agent obj_valve_0 obj_valve_1 - valve obj_bolt_0 obj_bolt_1 - bolt obj_tool_0 obj_tool_1 - tool box_0 box_1 - box workstation_0 - workstation warehouse_0 - warehouse )
  (:init (adjacent l3_3 l3_4) (= (num_objects_at workstation_0 tool) 0) (adjacent l2_4 l1_4) (at obj_bolt_1 l4_3) (adjacent l3_4 l3_3) (adjacent l3_4 l2_4) (adjacent l2_4 l2_3) (adjacent l1_3 l2_3) (at box_1 l4_3) (adjacent l1_3 l1_4) (adjacent l2_4 l3_4) (at obj_tool_0 l4_3) (adjacent l1_4 l2_4) (at workstation_0 l1_3) (adjacent l1_4 l0_4) (adjacent l2_3 l2_4) (at obj_bolt_0 l4_3) (at obj_valve_0 l4_3) (adjacent l4_4 l3_4) (adjacent l3_3 l4_3) (at box_0 l4_3) (adjacent l4_2 l4_3) (at obj_valve_1 l4_3) (adjacent l2_3 l3_3) (adjacent l0_4 l1_4) (at agent_0 l4_3) (empty box_1) (adjacent l1_4 l1_3) (adjacent l4_3 l4_4) (at warehouse_0 l4_3) (adjacent l4_3 l3_3) (adjacent l4_4 l4_3) (adjacent l2_3 l1_3) (adjacent l3_3 l2_3) (adjacent l3_4 l4_4) (= (num_objects_at workstation_0 valve) 0) (= (num_objects_at workstation_0 bolt) 0) (adjacent l4_3 l4_2) (empty box_0) (at obj_tool_1 l4_3))
  (:goal (and (= (num_objects_at workstation_0 bolt) 0) (= (num_objects_at workstation_0 valve) 0) (= (num_objects_at workstation_0 tool) 0)))
)