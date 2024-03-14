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
  (:durative-action move
    :parameters (?a - agent ?from ?to - location)
    :duration (= ?duration 3)
    :condition (and 
      (at start (at ?a ?from))
      (over all (adjacent ?from ?to))
    )
    :effect (and 
      (at start (not (at ?a ?from)))
      (at end (at ?a ?to)) 
    )
  )
  
  (:durative-action take_box
    :parameters (?a - agent ?b - box ?c - carrier ?l - location ?c0 ?c1 - capacity)
    :duration (= ?duration 1)
    :condition (and 
      (at start (at ?b ?l)) 
      (at start (at ?a ?l))
      (at start (carrier_capacity ?c ?c1))
      (over all (attached ?c ?a))
      (over all (predecessor ?c0 ?c1))
    )
    :effect (and 
      (at start (not (at ?b ?l)))
      (at start (carrier_capacity ?c ?c0))
      (at start (not (carrier_capacity ?c ?c1)))
      (at end (on ?c ?b))
      (at end (box_carried_by ?b ?a))
    )
  )
  
  (:durative-action fill_box
    :parameters (?a - agent ?b - box ?s - supply ?l - location)
    :duration (= ?duration 2)
    :condition (and 
      (at start (at ?s ?l)) 
      (at start (at ?a ?l))
      (at start (empty ?b)) 
      (over all (box_carried_by ?b ?a))
    )
    :effect (and 
      (at start (not (empty ?b)))
      (at start (not (at ?s ?l)))
      (at end (contains ?b ?s))
    )
  )

  (:durative-action deliver_box
    :parameters (?a - agent ?b - box ?c - carrier ?ws - workstation ?l - location ?c0 ?c1 - capacity)
    :duration (= ?duration 1)
    :condition (and 
      (at start (box_carried_by ?b ?a))
      (at start (on ?c ?b))
      (at start (carrier_capacity ?c ?c0))
      (over all (predecessor ?c0 ?c1))
      (over all (at ?a ?l))
      (over all (at ?ws ?l))
      (over all (attached ?c ?a))
    )
    :effect (and 

      (at start (carrier_capacity ?c ?c1))
      (at start (not (carrier_capacity ?c ?c0)))

      (at end (not (box_carried_by ?b ?a)))
      (at end (not (on ?c ?b)))
      (at end (unloaded_box ?b ?ws))
       
    )
  )
    
  (:durative-action deliver_supply
    :parameters (?a - agent ?ws - workstation ?t - supply_type ?s - supply ?b - box ?l - location )
    :duration (= ?duration 2)
    :condition (and 
      (over all (at ?a ?l))
      (over all (at ?ws ?l))
      (over all (is ?s ?t)) 
      (at start (unloaded_box ?b ?ws))
      (at start (contains ?b ?s))
    )
    :effect (and 
      (at start (not (contains ?b ?s)))
      (at start (at ?b ?l))
      (at start (not (unloaded_box ?b ?ws)))
      (at start (empty ?b))
      (at end (has ?ws ?t))
      (at end (loaded_to ?s ?ws))
    )
  )
)
