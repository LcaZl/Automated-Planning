;; problem file: problem_2.pddl
(define (problem default)
  (:domain default)
  (:objects l0_3 l0_4 l1_1 l1_2 l1_3 l1_4 l2_2 l2_3 l2_4 l3_4 - location
agent_0 - agent
obj_valve_0 obj_valve_1 - valve
obj_bolt_0 obj_bolt_1 - bolt
obj_tool_0 obj_tool_1 - tool
box_0 box_1 - box
workstation_0 - workstation
warehouse_0 - warehouse
)
  (:init (has warehouse_0 box_0) (at obj_valve_0 l1_4) (at obj_tool_0 l2_2) (adjacent l1_1 l1_2) (adjacent l1_2 l1_3) (empty box_0) (adjacent l2_3 l2_4) (adjacent l1_4 l0_4) (adjacent l0_3 l0_4) (has workstation_0 obj_valve_0) (adjacent l0_4 l0_3) (at obj_valve_1 l1_4) (at box_0 l2_2) (at obj_tool_1 l2_2) (at agent_0 l2_2) (adjacent l1_4 l1_3) (has warehouse_0 box_1) (has workstation_0 obj_valve_1) (adjacent l2_2 l1_2) (= (num_objects_at workstation_0 tool) 0) (adjacent l1_3 l2_3) (adjacent l1_3 l1_4) (adjacent l0_3 l1_3) (adjacent l2_3 l2_2) (at obj_bolt_1 l1_4) (has warehouse_0 obj_tool_1) (at warehouse_0 l2_2) (adjacent l1_3 l0_3) (adjacent l2_4 l2_3) (adjacent l1_3 l1_2) (adjacent l1_2 l1_1) (= (num_objects_at workstation_0 valve) 2) (adjacent l3_4 l2_4) (at obj_bolt_0 l1_4) (has warehouse_0 obj_tool_0) (adjacent l2_2 l2_3) (adjacent l2_3 l1_3) (at box_1 l2_2) (adjacent l2_4 l3_4) (at workstation_0 l1_4) (has workstation_0 obj_bolt_0) (adjacent l1_2 l2_2) (adjacent l2_4 l1_4) (empty box_1) (adjacent l1_4 l2_4) (adjacent l0_4 l1_4) (= (num_objects_at workstation_0 bolt) 2) (has workstation_0 obj_bolt_1))
  (:goal ((and (= (num_objects_at workstation_0 valve) 2) (= (num_objects_at workstation_0 tool) 1) (= (num_objects_at workstation_0 bolt) 2))))
)