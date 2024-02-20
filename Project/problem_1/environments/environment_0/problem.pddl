;; problem file: problem_0.pddl
(define (problem default)
  (:domain default)
  (:objects l1_1 l2_0 l2_1 l2_2 l3_0 l3_1 l3_2 l4_0 l4_1 l4_2 - location
agent_0 - agent
obj_valve_0 obj_valve_1 - valve
obj_bolt_0 obj_bolt_1 - bolt
obj_tool_0 obj_tool_1 - tool
box_0 box_1 - box
workstation_0 - workstation
warehouse_0 - warehouse
)
  (:init (adjacent l3_0 l3_1) (has warehouse_0 box_0) (adjacent l3_1 l2_1) (at obj_tool_0 l2_2) (adjacent l2_1 l3_1) (at workstation_0 l2_2) (adjacent l2_1 l2_0) (adjacent l3_1 l3_2) (adjacent l4_2 l3_2) (empty box_0) (has workstation_0 obj_bolt_1) (at box_0 l2_1) (adjacent l2_1 l1_1) (has workstation_0 obj_valve_0) (adjacent l4_2 l4_1) (adjacent l2_2 l2_1) (adjacent l4_1 l3_1) (adjacent l3_2 l3_1) (adjacent l4_0 l4_1) (at box_1 l2_1) (at obj_tool_1 l2_2) (has warehouse_0 box_1) (has workstation_0 obj_tool_0) (adjacent l4_0 l3_0) (adjacent l1_1 l2_1) (= (num_objects_at workstation_0 bolt) 1) (at agent_0 l2_1) (has warehouse_0 obj_bolt_0) (= (num_objects_at workstation_0 tool) 2) (adjacent l2_0 l3_0) (at obj_valve_0 l2_2) (has workstation_0 obj_tool_1) (adjacent l3_1 l4_1) (adjacent l2_0 l2_1) (= (num_objects_at workstation_0 valve) 2) (adjacent l3_2 l2_2) (adjacent l3_1 l3_0) (adjacent l3_0 l4_0) (at warehouse_0 l2_1) (adjacent l3_0 l2_0) (adjacent l2_2 l3_2) (adjacent l2_1 l2_2) (adjacent l4_1 l4_0) (at obj_bolt_0 l2_1) (at obj_bolt_1 l2_2) (has workstation_0 obj_valve_1) (empty box_1) (at obj_valve_1 l2_2) (adjacent l4_1 l4_2) (adjacent l3_2 l4_2))
  (:goal ((and (= (num_objects_at workstation_0 valve) 2) (= (num_objects_at workstation_0 tool) 2) (= (num_objects_at workstation_0 bolt) 2))))
)