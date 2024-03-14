(define (domain default)
  (:requirements :strips :typing)
  (:types
    agent - locatable 
    workstation - locatable
    warehouse - locatable 
    box - locatable
    supply - locatable
    location - object
    supply_type - object
    carrier - object
    capacity - object
  )
  (:predicates
    (adjacent ?l1 ?l2 - location) ; Adjacency relation between locations
    (at ?o - locatable ?l - location)  ; Locatable positioning
    (empty ?b - box)   ; Box is empty and can contain a supply
    (box_carried_by ?b - box ?a - agent) ; Relation between a box and the agent whose transporting it.
    (contains ?b - box ?s - supply) ; relation between a box and the supply inside it.
    (is ?s - supply ?t - supply_type) ; Relation between a supply and its category.
    (has ?ws - workstation ?t - supply_type) ; Used for goals. Indicates that a workstation ha a single supply of the specified type. Doesn't matter which specific supply.
    (loaded_to ?s - supply ?ws - workstation) ; Indicates that a specific supply object is owned by a workstation
    (unloaded_box ?b - box ?ws - workstation) ; Indicates that a box with a supply inside is delivered to a workstation. But the supply remain inside the box.
    
    (attached ?c - carrier ?a - agent) ; Relation between carrier and the agent
    (on ?c - carrier ?b - box) ; Indicate that a box is on a carrier
    (carrier_capacity ?c - carrier ?cap - capacity) ; Manage capacity
    (predecessor ?cap0 - capacity ?cap1 - capacity) ; Manage capacity
  )
  
  ;; Actions
  (:action move
    :parameters (?a - agent ?from ?to - location)
    :precondition (and 
      (adjacent ?from ?to)
      (at ?a ?from)
    )
    :effect (and 
      (at ?a ?to)
      (not (at ?a ?from))
    )
  )
  
  (:action take_box
    :parameters (?a - agent ?b - box ?c - carrier ?l - location ?c0 ?c1 - capacity)
    :precondition (and 
      (at ?a ?l) 
      (at ?b ?l)

      (attached ?c ?a)  ; The carrier must be attached to the agent.
      (predecessor ?c0 ?c1)
      (carrier_capacity ?c ?c1)
    )
    :effect (and 
      (not (at ?b ?l))  ; Box ?b is no longer at ?l location.
      (box_carried_by ?b ?a)  ; Box ?b is now carried by agent ?a.

      (carrier_capacity ?c ?c0)
      (not (carrier_capacity ?c ?c1))  
      (on ?c ?b)
    )
  )
  
  (:action fill_box
    :parameters (?a - agent ?b - box ?s - supply ?l - location)
    :precondition (and 
      (at ?a ?l)
      (at ?s ?l)
      (empty ?b)
      (box_carried_by ?b ?a)
    )
    :effect (and 
      (not (empty ?b))
      (contains ?b ?s) 
      (not (at ?s ?l))
    )
  )

  (:action deliver_box
    :parameters (?a - agent ?b - box ?c - carrier ?ws - workstation ?l - location ?c0 ?c1 - capacity)
    :precondition (and 
      (box_carried_by ?b ?a)  ; Box ?b must be carried by agent ?a. Thus on carrier.
      (at ?a ?l) 
      (at ?ws ?l)

      (attached ?c ?a) 
      (predecessor ?c0 ?c1)
      (carrier_capacity ?c ?c0)
    )
    :effect (and 
      (not (box_carried_by ?b ?a))
      (unloaded_box ?b ?ws)

      (not (on ?c ?b))
      (carrier_capacity ?c ?c1)
      (not (carrier_capacity ?c ?c0))    
    )
  )
    
  (:action deliver_supply
    :parameters (?a - agent ?ws - workstation ?t - supply_type ?s - supply ?b - box ?l - location )
    :precondition (and 
      (at ?a ?l)
      (at ?ws ?l)
      (is ?s ?t)
      (unloaded_box ?b ?ws)
      (contains ?b ?s)
    )
    :effect (and 
      (loaded_to ?s ?ws)
      (not (contains ?b ?s))
      (not (unloaded_box ?b ?ws))
      (empty ?b)
      (at ?b ?l)
      (has ?ws ?t)
    )
  )
)
