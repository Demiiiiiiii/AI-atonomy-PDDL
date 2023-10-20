;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p4-UpdsideDown)
  (:domain UpdsideDown)
  (:objects
           ;add objects and their types
    cell-1 cell-2 cell- cell-3 cell-4 cell-5 cell-6 cell-7 - cells
    red green blue - colour
    k1 k2 k3 - keys
    m1 - matches
  )
  (:init
    (cells cell-1)
    (cells cell-2)
    (cells cell-3)
    (cells cell-4)
    (cells cell-5)
    (cells cell-6)
    (cells cell-7)
    (color red)
    (color blue)
    (color green)
    (keys k1)
    (keys k2)
    (keys k3)
    (matches m1)
    ;Initial Hero Location
    (at-hero cell-1)
    (visited cell-1)
    ;He starts with a free arm
    (empty-hand)
    ;Initial location of the keys
    (at-key k1 cell-1)
    (at-key k2 cell-3)
    (at-key k3 cell-5)
    ;Initial location of the matches
    ;(at-match m1 cell-4)
    ;Initial location of Monsters
    ;(at-monster cell-5)
    ;Initial lcocation of open gates
    (at-gate cell-2)
    (gate-red cell-2 red)
    (at-gate cell-4)
    (gate-green cell-4 green)
    (at-gate cell-6)
    (gate-blue cell-6 blue)
    ; ;Key uses
    (key-infinite-uses k1)
    (key-two-use k2)
    (key-one-use k3)
    ;Key Colours
    (key-red k1)
    (key-green k2)
    (key-blue k3)
    ;Graph Connectivity
    (connected cell-1 cell-2)
    (connected cell-2 cell-1)
    (connected cell-2 cell-3)
    (connected cell-3 cell-2)
    (connected cell-3 cell-4)
    (connected cell-4 cell-3)
    (connected cell-4 cell-5)
    (connected cell-5 cell-4)
    (connected cell-5 cell-6)
    (connected cell-6 cell-5)
    (connected cell-6 cell-7)
    (connected cell-7 cell-6)
    
    
  )
  (:goal (and
           ;Hero's Goal Location
                (at-hero cell-7)
                
                ;All gates are closed
                (closed cell-2)
                (closed cell-6)
                (closed cell-4)
            
  ))
  
)
