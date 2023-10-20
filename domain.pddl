(define (domain UpdsideDown)

    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
     :disjunctive-preconditions)

    (:types
        matches keys 
        cells
        colour
    )

    (:predicates
        (matches ?m)
        (keys ?k)
        (cells ?r)
        (color ?c)
        
        ;Indicates the number of uses left in a key
        (key-infinite-uses ?k - keys)
        (key-two-use ?k - keys)        
        (key-one-use ?k - keys)        
        (key-used-up ?k - keys)

        ;The color of the key match with the gate color
        (match)

        ;color of the key
        (key-green ?k - keys)
        (key-blue ?k - keys)
        (key-red ?k - keys)

        ;Whether two romms are connected
        (connected ?x ?y - cells)

        ;Whether key/match/monster/here/gate is in the room r
        (at-key ?k - keys?r - cells)        
        (at-match ?m - matches ?r - cells)
        (at-monster ?r - cells)
        (at-hero ?r -cells)
        (at-gate ?r -cells)

        ;Whether the room is visited
        (visited ?r - cells)
        
        ;Whether gate is closed
        (closed ?r - cells)

        ;Whether the hand of hero is empty
        (empty-hand)
        ;Whether hold key/match
        (hold-match ?m - matches)
        (hold-key ?k - keys)

        ;the color of the gate
        (gate-blue ?r - cells ?c - colour)
        (gate-green ?r - cells ?c - colour)
        (gate-red ?r - cells ?c - colour)

        ;Whether match is on fire
        (fire)
        

        
       
        
    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no monster in current loc and destination, and 
    ;    - destination is not invigilated
    ;Effects move the hero, and the original cell becomes invigilated.
    (:action move
        :parameters (?from ?to - cells)
        :precondition (and
            (at-hero ?from)
            (visited ?from)
            (connected ?from ?to)
            (not
                (at-monster ?from)
            )
            (not
                (at-monster ?to)
            )
            (not
                (visited ?to)
            )                       
        )
        :effect (and
            (at-hero ?to)
            (not
                (at-hero ?from)
            )
            (visited ?to)                             
        )
    )
    
    ;this action is executed if
    ;    - the hero is in a location with a monster in it
    ;    - cells are connected
    ;    - fire is on
    ;    - destination is not invigilated
    ;    Effects: fire is not on and destination is invigilated
    (:action move-out-of-monster
        :parameters (?from ?to - cells)
        :precondition (and
            (at-hero ?from)
            (at-monster ?from)
            (connected ?from ?to) 
            (fire)
            (not
                (visited ?to)    
            ) 
            (visited ?from)           
        )
        :effect (and
            (visited ?to)
            (at-hero ?to)
            (at-monster ?from)
            (not 
                (fire)
            ) 
                            
        )
    )

    ;When this action is executed if
    ;   -the hero leaves a location without a monster
    ;    - cells are connected, 
    ;   -gets into a location with a monster 
    ;   -the hero holds a match
    ;    - destination is not invigilated
    ;Effects: 
    ;   -hero moves to the ceil with monster
    ;   -match is striked with fire
    ;   - location is invigilated
    (:action move-into-monster
        :parameters (?from ?to - cells ?m - matches)
        :precondition (and
            (at-hero ?from)
            (visited ?from)
            (connected ?from ?to)
            (not 
                (at-monster ?from)
            )
            (at-monster ?to) 
            (hold-match ?m)
            (not
                (visited ?to)
            )               
        ) 
            
        :effect (and
            (at-hero ?to)
            (at-monster ?to)
            (not 
                (at-hero ?from)    
            )
            (visited ?to)
             
        )
            
    )
    
    ;Hero's picks a key if 
    ;   - he's in the same location with key
    ;   - he is empty-hand
    ;Effects: he holds key and key is not in the room
    (:action pick-key
        :parameters (?loc - cells ?k - keys)
        :precondition (and
            (at-hero ?loc)
            (at-key ?k ?loc)
            (empty-hand) 
                            
        )
        :effect (and
            (hold-key ?k)
            (not 
                (at-key ?k ?loc)
                
            )
            (not(empty-hand))
                            
        )
    )

    ;Hero's picks a match if 
    ;   - he's in the same location with match
    ;   - he is empty-hand
    ;Effects: he holds match and match is not in the room
    (:action pick-match
        :parameters (?loc - cells ?m - matches)
        :precondition (and
            (at-hero ?loc)
            (at-match ?m ?loc)
            (empty-hand) 
                            
                      )
        :effect (and
            (hold-match ?m)
            (not (at-match ?m ?loc))
            (not(empty-hand))                
                )
    )
    
   ;Hero's drops his key if
    ;   - he's hold the key
    ;   - he is not empty-hand
    ;Effects: he empty hand and key is in the room
    (:action drop-key
        :parameters (?loc - cells ?k - keys)
        :precondition (and
            (at-hero ?loc) 
            (hold-key ?k)
            (not
                (empty-hand)
    
            )
            (not(at-key ?k ?loc))                            
         )
        :effect (and
            (at-hero ?loc)
            (empty-hand)
            (at-key ?k ?loc)
            (not(hold-key ?k))                
        )
    )

    ;Hero's drops his match if
    ;   - he's hold the match
    ;   - he is not empty-hand
    ;Effects: he empty hand and match is in the room
    (:action drop-match
        :parameters (?loc - cells ?m - matches)
        :precondition (and 
            (at-hero ?loc)
            (hold-match ?m)
            (not
                (empty-hand)
            
            )
            (not(at-match ?m ?loc))   
        )
        :effect (and
            (at-hero ?loc)
            (empty-hand)
            (at-match ?m ?loc)
                 
                )
    )
    
    ;Hero's disarm the trap with his hand if
    ; -he hold the key
    ; the location and destination are connected
    ; -the destination room has gate
    ; the color of key is the same as the gate
    ; the counter of key is bigger than 0
    ; the gate is not closed
    ;Effects: gate is closed and decreases the counter of the key
    (:action close-gate
        :parameters (?from ?to - cells ?k - keys ?c - colour)
        :precondition (and
            (hold-key ?k)
            (not(empty-hand))
            (connected ?from ?to)
            (at-gate ?to)
            (at-hero ?from) 
            (not
                (key-used-up ?k)
            )
            (not
                (closed ?to)
            )
            (or
                (and(key-blue ?k)(gate-blue ?to ?c))
                (and(key-green ?k)(gate-green ?to ?c))
                (and(key-red ?k)(gate-red ?to ?c))
            )
            
            
        )
        :effect (and

                    ;When a key has two uses, then it becomes a single use
                    (when (key-two-use ?k) (key-one-use ?k))
                    ;When a key has a single use, it becomes used-up
                    (when (key-one-use ?k) (key-used-up ?k))  
                    (closed ?to)     
                )
    )

    ;Hero strikes her match if
    ; -he hold the match
    ; Effect: the match is on fire
    (:action strike-match
        :parameters (?m - matches)
        :precondition (and
            (hold-match ?m) 
            (not(fire))
                            
        )
        :effect (and 
            (fire)
                           
        )
    )
    
)