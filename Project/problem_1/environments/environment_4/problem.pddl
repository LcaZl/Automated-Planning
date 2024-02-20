;; problem file: problem_4.pddl
(define (problem default)
  (:domain default)
  (:objects l1_2 l1_3 l1_4 l2_0 l2_1 l2_2 l2_3 l2_4 l3_0 l4_0 - location
agent_0 - agent
obj_valve_0 obj_valve_1 - valve
obj_bolt_0 obj_bolt_1 - bolt
obj_tool_0 obj_tool_1 - tool
box_0 box_1 - box
workstation_0 - workstation
warehouse_0 - warehouse
)
  (:init (adjacent l2_2 l2_1) (has warehouse_0 box_1) (adjacent l2_4 l1_4) (adjacent l2_0 l2_1) (has warehouse_0 obj_bolt_1) (adjacent l2_3 l2_2) (adjacent l2_4 l2_3) (adjacent l1_3 l2_3) (adjacent l1_3 l1_4) (has workstation_0 obj_tool_1) (adjacent l2_1 l2_2) (adjacent l1_4 l2_4) (adjacent l2_1 l2_0) (adjacent l2_3 l2_4) (at agent_0 l2_1) (at workstation_0 l3_0) (= (num_objects_at workstation_0 valve) 1) (at obj_tool_0 l2_1) (adjacent l2_0 l3_0) (has warehouse_0 box_0) (adjacent l2_2 l1_2) (adjacent l2_2 l2_3) (at box_0 l2_1) (empty box_1) (adjacent l1_4 l1_3) (adjacent l1_3 l1_2) (at obj_bolt_1 l2_1) (adjacent l3_0 l2_0) (has warehouse_0 obj_tool_0) (= (num_objects_at workstation_0 tool) 1) (at warehouse_0 l2_1) (has warehouse_0 obj_valve_0) (has workstation_0 obj_valve_1) (adjacent l4_0 l3_0) (adjacent l2_3 l1_3) (at box_1 l2_1) (= (num_objects_at workstation_0 bolt) 0) (adjacent l1_2 l2_2) (has warehouse_0 obj_bolt_0) (adjacent l3_0 l4_0) (empty box_0) (at obj_bolt_0 l2_1) (adjacent l1_2 l1_3) (at obj_valve_0 l2_1) (at obj_tool_1 l3_0) (at obj_valve_1 l3_0))
  (:goal ((and (= (num_objects_at workstation_0 bolt) 0) (= (num_objects_at workstation_0 valve) 2) (= (num_objects_at workstation_0 tool) 1))))
)