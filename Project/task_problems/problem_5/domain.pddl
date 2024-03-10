(define (domain default)
  (:requirements :strips :typing :durative-actions)  ; Specifies the requirements: STRIPS, ADL, and typing.
  (:types
    agent workstation warehouse box supply - locatable  ; Object supply_types.
    location supply_type carrier - object
    capacity - object
  )
  (:predicates
    (adjacent ?l1 ?l2 - location)       ; Indicates that ?l1 is adjacent to ?l2.
    (at ?o - locatable ?l - location)  ; Indicates that object ?o is at location ?l.
    (empty ?b - box)   ; Indicates that ?b, a box, is empty.
    (box_carried_by ?b - box ?a - agent) ; Indicates that ?b, a box, is being carried by ?a, an agent.
    (contains ?b - box ?s - supply) ; Indicates that ?b, a box, contains ?s, a supply.
    (is ?s - supply ?t - supply_type) ; Indicates the supply_type ?t of a supply ?s.
    (has ?ws - workstation ?t - supply_type) ; Indicates that workstation ?ws requires a supply of supply_type ?t.
    (loaded_to ?s - supply ?ws - workstation) ; Indicates that supply ?s has been loaded to workstation ?ws.
    (unloaded_box ?b - box ?ws - workstation)
    (attached ?c - carrier ?a - agent) ; A carrier is attached to an agent.
    (on ?c - carrier ?b - box) ; A box is on a carrier.
      ;; capacity
    (carrier_capacity ?c - carrier ?cap - capacity)
    (predecessor ?cap0 - capacity ?cap1 - capacity)
  )
  
  ;; Actions
  (:durative-action move
    :parameters (?a - agent ?from ?to - location)
    :duration (= ?duration 3)
    :condition (and 
      (at start (at ?a ?from))  ; The agent must be at the starting location.
      (over all (adjacent ?from ?to))  ; The agent must move between adjacent locations.
    )
    :effect (and 
      (at start (not (at ?a ?from)))  ; The agent is no longer at the starting location.
      (at end (at ?a ?to))  ; The agent is now at the destination location.
    )
  )
  
  (:durative-action take_box
    :parameters (?a - agent ?b - box ?c - carrier ?l - location ?c0 ?c1 - capacity)
    :duration (= ?duration 1)
    :condition (and 
      (at start (at ?b ?l))  ; Box ?b must be at ?l location.
      (at start (at ?a ?l))  ; Agent ?a must be at ?l location.
      (at start (carrier_capacity ?c ?c1))
      (over all (attached ?c ?a))  ; The carrier must be attached to the agent.
      (over all (predecessor ?c0 ?c1))
    )
    :effect (and 
      (at start (not (at ?b ?l)))  ; Box ?b is no longer at ?l location.
      (at start (carrier_capacity ?c ?c0))
      (at start (not (carrier_capacity ?c ?c1)))
      (at end (on ?c ?b))
      (at end (box_carried_by ?b ?a))  ; Box ?b is now carried by agent ?a.
    )
  )
  
  (:durative-action fill_box
    :parameters (?a - agent ?b - box ?s - supply ?l - location)
    :duration (= ?duration 2)
    :condition (and 
      (at start (at ?s ?l))  ; Supply ?s must be at ?l location.
      (at start (at ?a ?l))  ; Agent ?a must be at ?l location.
      (at start (empty ?b))  ; Box ?b must be empty.
      (over all (box_carried_by ?b ?a))
    )
    :effect (and 
      (at start (not (empty ?b))) ; Box ?b is no longer empty.
      (at start (not (at ?s ?l)))  ; Supply ?s is no longer at ?l location.
      (at end (contains ?b ?s))  ; Box ?b now contains supply ?s.
    )
  )

  (:durative-action deliver_box
    :parameters (?a - agent ?b - box ?c - carrier ?ws - workstation ?l - location ?c0 ?c1 - capacity)
    :duration (= ?duration 1)
    :condition (and 
      (at start (box_carried_by ?b ?a))  ; Box ?b must be carried by agent ?a.
      (at start (on ?c ?b))  ; The box must be on the carrier.
      (at start (carrier_capacity ?c ?c0))
      (over all (predecessor ?c0 ?c1))
      (over all (at ?a ?l))  ; Agent ?a must be at ?l location.
      (over all (at ?ws ?l))
      (over all (attached ?c ?a))  ; The carrier must be attached to the agent.
    )
    :effect (and 

      (at start (carrier_capacity ?c ?c1))
      (at start (not (carrier_capacity ?c ?c0)))

      (at end (not (box_carried_by ?b ?a)))  ; Box ?b is no longer carried by agent ?a.
      (at end (not (on ?c ?b)))
      (at end (unloaded_box ?b ?ws))
       
    )
  )
    
  (:durative-action deliver_supply
    :parameters (?a - agent ?ws - workstation ?t - supply_type ?s - supply ?b - box ?l - location )
    :duration (= ?duration 2)
    :condition (and 
      (over all (at ?a ?l))  ; Agent ?a must be at ?l location.
      (over all (at ?ws ?l))  ; Workstation ?ws must be at ?l location.
      (over all (is ?s ?t))  ; Supply ?s must be of supply_type ?t.
      (at start (unloaded_box ?b ?ws))
      (at start (contains ?b ?s))  ; Box ?b must contain supply ?s.
    )
    :effect (and 
      (at start (not (contains ?b ?s)))  ; Box ?b no longer contains supply ?s.
      (at start (at ?b ?l))
      (at start (not (unloaded_box ?b ?ws)))
      (at end (empty ?b))  ; Box ?b is now empty.
      (at end (has ?ws ?t))  ; Workstation ?ws now has a supply of supply_type ?t.
      (at end (loaded_to ?s ?ws))  ; Supply ?s is now loaded to workstation ?ws.
    )
  )
)
