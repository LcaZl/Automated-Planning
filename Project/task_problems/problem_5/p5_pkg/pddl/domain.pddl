(define (domain default)
  (:requirements :strips :durative-actions :typing :negative-preconditions)  ; Domain capabilities.
  (:types
    agent workstation warehouse box supply - locatable  ; Object supply_types.
    location supply_type carrier - object
    capacity - object

  )
  (:predicates
    (adjacent ?l1 ?l2 - location)       ; Two locations are adjacent.
    (at ?o - locatable ?l - location)  ; An object is at a specific location.
    (empty ?b - box)   ; A box is empty.
    (free_arms ?a - agent) ; An agent has free arms (not carrying a box).
    (available ?b - box) ; A box is available to be carried.
    (contains ?b - box ?s - supply) ; A box contains a specific supply.
    (is ?s - supply ?t -  supply_type) ; A supply is of a specific supply_type.
    (has ?ws - workstation ?t - supply_type) ; A workstation requires a supply of a specific supply_type.
    (loaded_to ?s - supply ?ws - workstation) ; A supply has been loaded onto a workstation.
    (attached ?c - carrier ?a - agent) ; A carrier is attached to an agent.
    (on ?c - carrier ?b - box) ; A box is on a carrier.
      ;; capacity
    (carrier_capacity ?c - carrier ?cap - capacity)
    (predecessor ?cap0 - capacity ?cap1 - capacity)
  )
  ;; Action definitions
  (:durative-action move
    :parameters (?a - agent ?from ?to - location)
    :duration (= ?duration 1)
    :condition (and 
      (at start (at ?a ?from))  ; The agent must be at the starting location.
      (over all (adjacent ?from ?to))  ; The agent must move between adjacent locations.
    )
    :effect (and 
      (at start (not (at ?a ?from)))  ; The agent is no longer at the starting location.
      (at end (at ?a ?to))  ; The agent is now at the destination location.
    )
  )

  (:durative-action load_box
    :parameters (?a - agent ?c - carrier ?b - box ?l - location ?c0 - capacity ?c1 - capacity)
    :duration (= ?duration 2)
    :condition (and 
      (at start (at ?b ?l))  ; The box must be at the agent's location.
      (at start (carrier_capacity ?c ?c1))
      (at start (free_arms ?a))
      (at start (available ?b))  ; The box must be available.
      (over all (at ?a ?l))  ; The agent must be at the location.
      (over all (attached ?c ?a))  ; The carrier must be attached to the agent.
      (over all (predecessor ?c0 ?c1))
    )
    :effect (and 
      (at start (not (at ?b ?l)))  ; The box is no longer at the location.
      (at start (not (free_arms ?a)))  ; The agent must have free arms.
      (at start (not (available ?b)))  ; The box is no longer available to be carried by an agent.
      (at start (carrier_capacity ?c ?c0))
      (at start (not (carrier_capacity ?c ?c1)))  
      (at end (on ?c ?b))  ; The box is now on the carrier.
      (at end (free_arms ?a))
    )
  )

  (:durative-action leave_box
    :parameters (?a - agent ?c - carrier ?b - box ?l - location ?wh - warehouse ?c0 - capacity ?c1 - capacity)
    :duration (= ?duration 2)
    :condition (and 
      (at start (carrier_capacity ?c ?c0))
      (at start (on ?c ?b))  ; The box must be on the carrier.
      (at start (free_arms ?a))  ; The agent must have free arms.
      (over all (predecessor ?c0 ?c1))
      (over all (at ?a ?l))  ; The agent must be at the location.
      (over all (at ?wh ?l))  ; The warehouse must be at the location.
      (over all (attached ?c ?a))  ; The carrier must be attached to the agent.
    )
    :effect (and 
      (at start (not (on ?c ?b)))  ; The box is no longer on the carrier.
      (at start (not (free_arms ?a)))
      (at end (at ?b ?l)) ; The box is now at the location.
      (at end (available ?b))  ; The box is now available to be carried by an agent.
      (at end (carrier_capacity ?c ?c1))
      (at end (not (carrier_capacity ?c ?c0)))    
      (at end (free_arms ?a))
    )
  )

  (:durative-action fill_box
    :parameters (?a - agent ?b - box ?c - carrier ?s - supply ?l - location)
    :duration (= ?duration 2)
    :condition (and 
      (at start (free_arms ?a))  ; The agent must have free arms.
      (at start (at ?s ?l))  ; The supply must be at the location.
      (at start (empty ?b))  ; The box must be empty.
      (over all (at ?a ?l))  ; The agent must be at the location.
      (over all (on ?c ?b))  ; The box must be on the carrier.
      (over all (attached ?c ?a))  ; The carrier must be attached to the agent.
    )
    :effect (and 
      (at start (not (empty ?b)))  ; The box is no longer empty.
      (at start (not (at ?s ?l)))  ; The supply is no longer at the location.
      (at start (not (free_arms ?a)))
      (at end (free_arms ?a))
      (at end (contains ?b ?s))  ; The box now contains the supply.
    )
  )
  
  (:durative-action deliver_supply_to_workstation
    :parameters (?a - agent ?ws - workstation ?b - box ?s - supply ?l - location ?t - supply_type ?c - carrier)
    :duration (= ?duration 2)
    :condition (and 
      (at start (contains ?b ?s))  ; The box must contain the supply.
      (at start (free_arms ?a))  ; The agent must have free arms.
      (over all (on ?c ?b) ) ; The box must be on the carrier.
      (over all (is ?s ?t))  ; The supply must be of the required supply_type.
      (over all (at ?a ?l))  ; The agent must be at the workstation's location.
      (over all (at ?ws ?l))  ; The workstation must be at the location.
      (over all (attached ?c ?a))  ; The carrier must be attached to the agent.
    )
    :effect (and 
      (at start (not (free_arms ?a)))
      (at start (not (contains ?b ?s)) ) ; The box no longer contains the supply.
      (at end (loaded_to ?s ?ws))  ; The supply is now loaded to the workstation.
      (at end (empty ?b) ) ; The box is now empty.
      (at end (has ?ws ?t) ) ; The workstation now has the required supply supply_type.
      (at end (free_arms ?a))
    )
  )
)
