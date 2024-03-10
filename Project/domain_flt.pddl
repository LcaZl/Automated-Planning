(define (domain default)
  (:requirements :strips :typing :action-costs)  ; Domain capabilities.
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
  )
  ;; Action definitions
  (:action move
    :parameters (?a - agent ?from ?to - location)
    :precondition (and 
      (adjacent ?from ?to)  ; The agent must move between adjacent locations.
      (at ?a ?from)  ; The agent must be at the starting location.
    )
    :effect (and 
      (at ?a ?to)  ; The agent is now at the destination location.
      (not (at ?a ?from))  ; The agent is no longer at the starting location.
      (increase (total-cost) 1)  ; Increase the total cost due to movement.
    )
  )

  (:action load_box
    :parameters (?a - agent ?c - carrier ?b - box ?l - location)
    :precondition (and 
      (at ?b ?l)  ; The box must be at the agent's location.
      (at ?a ?l)  ; The agent must be at the location.
      (attached ?c ?a)  ; The carrier must be attached to the agent.
      (free_arms ?a)  ; The agent must have free arms.
      (available ?b)  ; The box must be available.
      (< (carrier-load ?c) (carrier-capacity ?c))  ; The carrier must have available capacity.
    )
    :effect (and 
      (on ?c ?b)  ; The box is now on the carrier.
      (not (at ?b ?l))  ; The box is no longer at the location.
      (not (available ?b))  ; The box is no longer available to be carried by an agent.
      (increase (carrier-load ?c) 1)  ; Increase the load on this specific carrier.
    )
  )

  (:action leave_box
    :parameters (?a - agent ?c - carrier ?b - box ?l - location ?wh - warehouse)
    :precondition (and 
      (at ?a ?l)  ; The agent must be at the location.
      (at ?wh ?l)  ; The warehouse must be at the location.
      (attached ?c ?a)  ; The carrier must be attached to the agent.
      (on ?c ?b)  ; The box must be on the carrier.
      (free_arms ?a)  ; The agent must have free arms.
    )
    :effect (and 
      (not (on ?c ?b))  ; The box is no longer on the carrier.
      (at ?b ?l)  ; The box is now at the location.
      (available ?b)  ; The box is now available to be carried by an agent.
      (decrease (carrier-load ?c) 1)  ; Decrease the load on this specific carrier.
    )
  )

  (:action fill_box
    :parameters (?a - agent ?b - box ?c - carrier ?s - supply ?l - location)
    :precondition (and 
      (at ?a ?l)  ; The agent must be at the location.
      (at ?s ?l)  ; The supply must be at the location.
      (empty ?b)  ; The box must be empty.
      (on ?c ?b)  ; The box must be on the carrier.
      (attached ?c ?a)  ; The carrier must be attached to the agent.
    )
    :effect (and 
      (not (empty ?b))  ; The box is no longer empty.
      (contains ?b ?s)  ; The box now contains the supply.
      (not (at ?s ?l))  ; The supply is no longer at the location.
    )
  )
  
  (:action deliver_supply_to_workstation
    :parameters (?a - agent ?ws - workstation ?b - box ?s - supply ?l - location ?t - supply_type ?c - carrier)
    :precondition (and 
      (at ?a ?l)  ; The agent must be at the workstation's location.
      (at ?ws ?l)  ; The workstation must be at the location.
      (contains ?b ?s)  ; The box must contain the supply.
      (on ?c ?b)  ; The box must be on the carrier.
      (is ?s ?t)  ; The supply must be of the required supply_type.
      (attached ?c ?a)  ; The carrier must be attached to the agent.
    )
    :effect (and 
      (loaded_to ?s ?ws)  ; The supply is now loaded to the workstation.
      (not (contains ?b ?s))  ; The box no longer contains the supply.
      (empty ?b)  ; The box is now empty.
      (has ?ws ?t)  ; The workstation now has the required supply supply_type.
    )
  )
)
