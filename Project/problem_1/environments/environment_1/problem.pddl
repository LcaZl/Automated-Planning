;; problem file: problem_1.pddl
(define (problem default)
  (:domain default)
  (:objects l2_1 l2_2 l2_3 l3_1 l3_2 l3_3 l3_4 l4_2 l4_3 l4_4 - location
agent_0 - agent
obj_valve_0 obj_valve_1 - valve
obj_bolt_0 obj_bolt_1 - bolt
obj_tool_0 obj_tool_1 - tool
box_0 box_1 - box
workstation_0 - workstation
warehouse_0 - warehouse
)
  (:init (has warehouse_0 box_0) (adjacent l3_1 l2_1) (adjacent l4_4 l4_3) (adjacent l2_1 l3_1) (adjacent l3_2 l3_3) (adjacent l3_1 l3_2) (at box_1 l3_4) (adjacent l4_2 l3_2) (empty box_0) (adjacent l3_3 l3_2) (has workstation_0 obj_bolt_1) (at obj_valve_0 l3_4) (adjacent l3_3 l3_4) (adjacent l2_2 l2_1) (adjacent l3_2 l3_1) (at obj_tool_1 l3_4) (adjacent l2_3 l3_3) (at agent_0 l3_4) (has warehouse_0 obj_valve_0) (at obj_bolt_0 l4_3) (has warehouse_0 box_1) (adjacent l3_4 l4_4) (adjacent l4_3 l4_4) (adjacent l3_3 l4_3) (has workstation_0 obj_valve_1) (adjacent l3_3 l2_3) (= (num_objects_at workstation_0 tool) 0) (at obj_bolt_1 l4_3) (adjacent l4_2 l4_3) (adjacent l3_4 l3_3) (adjacent l2_3 l2_2) (adjacent l4_4 l3_4) (adjacent l4_3 l3_3) (has warehouse_0 obj_tool_1) (adjacent l4_3 l4_2) (at warehouse_0 l3_4) (has warehouse_0 obj_tool_0) (adjacent l3_2 l2_2) (adjacent l2_2 l2_3) (at workstation_0 l4_3) (adjacent l2_2 l3_2) (adjacent l2_1 l2_2) (at obj_valve_1 l4_3) (at obj_tool_0 l3_4) (= (num_objects_at workstation_0 valve) 1) (has workstation_0 obj_bolt_0) (at box_0 l3_4) (empty box_1) (= (num_objects_at workstation_0 bolt) 2) (adjacent l3_2 l4_2))
  (:goal ((and (= (num_objects_at workstation_0 valve) 1) (= (num_objects_at workstation_0 tool) 1) (= (num_objects_at workstation_0 bolt) 2))))
)