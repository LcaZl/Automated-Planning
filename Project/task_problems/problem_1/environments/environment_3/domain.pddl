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
  )
  (:predicates
    
    (adjacent ?l1 ?l2 - location) ; Adjacency relation between locations
    (at ?o - locatable ?l - location)  ; Locatable positioning
    (empty ?b - box)   ; Box is empty and can contain a supply
    (free_arms ?a - agent) ; Indicates that agent has free arms (not carrying a box), thus can take one.
    (box_carried_by ?b - box ?a - agent) ; Relation between a box and the agent whose transporting it.
    (contains ?b - box ?s - supply) ; relation between a box and the supply inside it.
    (is ?s - supply ?t - supply_type) ; Relation between a supply and its category.
    (has ?ws - workstation ?t - supply_type) ; Used for goals. Indicates that a workstation ha a single supply of the specified type. Doesn't matter which specific supply.
    (loaded_to ?s - supply ?ws - workstation) ; Indicates that a specific supply object is owned by a workstation
    (unloaded_box ?b - box ?ws - workstation) ; Indicates that a box with a supply inside is delivered to a workstation. But the supply remain inside the box.
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
    :parameters (?a - agent ?b - box ?l - location)
    :precondition (and 
      (at ?a ?l)
      (at ?b ?l)
      (free_arms ?a) ; Only one box a time
    )
    :effect (and 
      (not (free_arms ?a)) ; Only one box a time
      (not (at ?b ?l))
      (box_carried_by ?b ?a)
    )
  )
  

  (:action fill_box
    :parameters (?a - agent ?b - box ?s - supply ?l - location)
    :precondition (and 
      (at ?a ?l)
      (at ?s ?l)
      (empty ?b)
      (box_carried_by ?b ?a) ; Agent must own a box to fill it with a supply
    )
    :effect (and 
      (not (empty ?b))
      (contains ?b ?s)
      (not (at ?s ?l))
    )
  )

  
  (:action deliver_box
    :parameters (?a - agent ?b - box ?s - supply ?ws - workstation ?l - location)
    :precondition (and 
      (box_carried_by ?b ?a)
      (at ?a ?l)
      (at ?ws ?l)
      (contains ?b ?s) ; agents cannot deliver empty boxes.
    )
    :effect (and 
      (free_arms ?a) ; Only one box a time
      (not (box_carried_by ?b ?a)) 
      (unloaded_box ?b ?ws) ; box is waiting to be emptied at workstation location
    )
  )
    
  (:action deliver_supply
    :parameters (?a - agent ?ws - workstation ?t - supply_type ?s - supply ?b - box ?l - location )
    :precondition (and 
      ; Agent can carry or not a box while delivering a supply
      (at ?a ?l)
      (at ?ws ?l)
      (is ?s ?t)
      (unloaded_box ?b ?ws) ; in KB only after deliver_box
      (contains ?b ?s)
    )
    :effect (and 
      (not (unloaded_box ?b ?ws))
      (loaded_to ?s ?ws)  ; Specific supply object no more available in environment. Loaded into workstation.
      ; Box emptied at workstation location
      (not (contains ?b ?s))
      (at ?b ?l)
      (empty ?b)
      ; Goal satisfied
      (has ?ws ?t)  ; Workstation now has a supply of the needed type
    )
  )
)
