(define (domain default)
    (:requirements :strips :typing :negative-preconditions :numeric-fluents)
    (:types
        location tile agent box workstation warehouse
        bolt valve tool - supply  ; bolt, valve, and tool are subtypes of supply
        supply                    ; supply is defined as a higher-level type
    )
    (:functions
        (num_objects_at ?e - workstation ?s - supply)
    )
    (:predicates
        ; Positioning
        (adjacent ?l1 ?l2 - location)       ; location ?l1 is adjacent to ?l2
        (at ?e - (either agent supply box workstation warehouse) ?l - location)  ; entity ?e is at location ?l
        (free_from_agent ?l - location)  ; location ?l is free
        ; Box interaction
        (empty ?b - box)      ; box ?b is empty
        (contains ?b - box ?s - supply)  ; box ?b contains supply ?s
        (holding ?e - agent ?s - (either supply box))
        (supplied_with ?ws - workstation ?s - supply)
    )

    ;; moves an agent between two adjacent locations
    (:action move
        :parameters (?a - agent ?from ?to - location)
        :precondition (and 
            (adjacent ?from ?to) 
            (at ?a ?from) 
            (free_from_agent ?to)
        )
        :effect (and 
            (at ?a ?to) 
            (free_from_agent ?from) 
            (not (free_from_agent ?to)) 
            (not (at ?a ?from))
            ; If the agent is holding a box, the box is implicitly moved with the agent
            ; and there's no need to update the box or its contents' locations explicitly
        )
    )


    (:action pick_up_box
        :parameters (?a - agent ?b - box ?l - location)
        :precondition (and (at ?a ?l) (at ?b ?l) (forall (?b - box) (not (holding ?a ?b))))
        :effect (and (holding ?a ?b) (not (at ?b ?l)))
    )
    
    (:action fill_box
        :parameters (?a - agent ?b - box ?s - supply ?l - location)
        :precondition (and (empty ?b) (at ?a ?l) (at ?b ?l) (at ?s ?l) (not (holding ?a ?b)))
        :effect (and (not (empty ?b)) (contains ?b ?s) (not (at ?s ?l))) 
    )

    (:action leave_box_at_workstation
        :parameters (?a - agent ?b - box ?ws - workstation ?l - location)
        :precondition (and
            (at ?a ?l)        ; Agent is at the location
            (holding ?a ?b)   ; Agent is holding the box
            (at ?ws ?l)       ; Workstation is at the location
        )
        :effect (and
            (not (holding ?a ?b))   ; Agent is no longer holding the box
            (at ?b ?l)              ; Box is now at the workstation's location
            ; Keep the box's content as it is for now
        )
    )

    (:action process_box_contents_at_workstation
        :parameters (?b - box ?s - supply ?ws - workstation ?l - location)
        :precondition (and
            (at ?b ?l)         ; Box is at the workstation's location
            (at ?ws ?l)        ; Workstation is at the location
            (contains ?b ?s)   ; Box contains the supply
        )
        :effect (and
            (not (contains ?b ?s))  ; Box no longer contains the supply
            (supplied_with ?ws ?s)  ; Workstation is marked as supplied with the supply
            (empty ?b)              ; Box is now empty
            (increase (num_objects_at ?ws ?s) 1)  ; Increase the count of the supply type at the workstation
            ; Optionally, remove the supply from the location if you're tracking supplies individually
        )
    )

)
