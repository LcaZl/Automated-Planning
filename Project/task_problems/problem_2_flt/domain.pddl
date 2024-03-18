(define (domain default)
  (:requirements :strips :typing :action-costs)  ; Specifies the requirements: STRIPS, ADL, and typing.
  (:types
    agent workstation warehouse box supply - locatable  ; Object supply_types.
    location supply_type carrier - object
  )  
  (:functions
    (total-cost) - number  ; Tracks the total cost of actions taken.
    (carrier-capacity ?c - carrier) - number  ; Capacity of a specific carrier.
    (carrier-load ?c - carrier) - number  ; Current load of a specific carrier.
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
  )
  
  ;; Actions
  (:action move
    :parameters (?a - agent ?from ?to - location)
    :precondition (and 
      (adjacent ?from ?to)  ; Requires ?from to be adjacent to ?to.
      (at ?a ?from)  ; Agent ?a must be at the ?from location.
    )
    :effect (and 
      (at ?a ?to)  ; Agent ?a is now at ?to location.
      (not (at ?a ?from))  ; Agent ?a is no longer at ?from location.
      (increase (total-cost) 1)
    )
  )
  
  (:action take_box
    :parameters (?a - agent ?b - box ?c - carrier ?l - location)
    :precondition (and 
      (at ?a ?l)  ; Agent ?a must be at ?l location.
      (at ?b ?l)  ; Box ?b must be at ?l location.
      (attached ?c ?a)  ; The carrier must be attached to the agent.
      (< (carrier-load ?c) (carrier-capacity ?c))
    )
    :effect (and 
      (not (at ?b ?l))  ; Box ?b is no longer at ?l location.
      (box_carried_by ?b ?a)  ; Box ?b is now carried by agent ?a.
      (on ?c ?b)
      (increase (carrier-load ?c) 1)
    )
  )
  
  (:action fill_box
    :parameters (?a - agent ?b - box ?s - supply ?l - location)
    :precondition (and 
      (at ?a ?l)  ; Agent ?a must be at ?l location.
      (at ?s ?l)  ; Supply ?s must be at ?l location.
      (empty ?b)  ; Box ?b must be empty.
      (box_carried_by ?b ?a)
    )
    :effect (and 
      (not (empty ?b))  ; Box ?b is no longer empty.
      (contains ?b ?s)  ; Box ?b now contains supply ?s.
      (not (at ?s ?l))  ; Supply ?s is no longer at ?l location.
    )
  )

  (:action deliver_box
    :parameters (?a - agent ?b - box ?c - carrier ?ws - workstation ?l - location)
    :precondition (and 
      (box_carried_by ?b ?a)  ; Box ?b must be carried by agent ?a.
      (at ?a ?l)  ; Agent ?a must be at ?l location.
      (at ?ws ?l)
      (attached ?c ?a)  ; The carrier must be attached to the agent.
      (on ?c ?b)  ; The box must be on the carrier.
    )
    :effect (and 
      (not (box_carried_by ?b ?a))  ; Box ?b is no longer carried by agent ?a.
      (not (on ?c ?b))
      (unloaded_box ?b ?ws)
      (decrease (carrier-load ?c) 1)
    )
  )
    
  (:action deliver_supply
    :parameters (?a - agent ?ws - workstation ?t - supply_type ?s - supply ?b - box ?l - location )
    :precondition (and 
      (at ?a ?l)  ; Agent ?a must be at ?l location.
      (at ?ws ?l)  ; Workstation ?ws must be at ?l location.
      (is ?s ?t)  ; Supply ?s must be of supply_type ?t.
      (unloaded_box ?b ?ws)
      (contains ?b ?s)  ; Box ?b must contain supply ?s.
    )
    :effect (and 
      (loaded_to ?s ?ws)  ; Supply ?s is now loaded to workstation ?ws.
      (not (contains ?b ?s))  ; Box ?b no longer contains supply ?s.
      (not (unloaded_box ?b ?ws))
      (empty ?b)  ; Box ?b is now empty.
      (at ?b ?l)
      (has ?ws ?t)  ; Workstation ?ws now has a supply of supply_type ?t.
    )
  )
)
