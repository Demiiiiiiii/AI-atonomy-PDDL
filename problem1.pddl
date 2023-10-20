;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p1-UpdsideDown)
  (:domain UpdsideDown)
  (:objects
    cell-1 cell-2 cell- cell-3 cell-4 cell-5 cell-6 cell-7 cell-8 cell-9 cell-10 cell-11 - cells
    red green blue - colour
    m1 - matches
    k1 k2 k3 - keys

  )
  (:init
    (cells cell-1)
    (cells cell-2)
    (cells cell-3)
    (cells cell-4)
    (cells cell-5)
    (cells cell-6)
    (cells cell-7)
    (cells cell-8)
    (cells cell-9)
    (cells cell-10)
    (cells cell-11)
    (color red)
    (color blue)
    (color green)
    (matches m1)
    (keys k1)
    (keys k2)
    (keys k3)
    ;Initial Hero Location
    (at-hero cell-1)
    (visited cell-1)
    ;She starts with a free arm
    (empty-hand)
    ;Initial location of the keys
    (at-key k1 cell-2)
    (at-key k2 cell-8)
    (at-key k3 cell-10)
    ;Initial location of the matches
    (at-match m1 cell-4)
    ;Initial location of Monsters
    (at-monster cell-3)
    ;Initial lcocation of open gates
    (at-gate cell-5)
    (gate-red cell-5 red)
    (at-gate cell-6)
    (gate-green cell-6 green)
    (at-gate cell-9)
    (gate-green cell-9 green)
    (at-gate cell-7)
    (gate-blue cell-7 blue)
    ; ;Key uses
    (key-infinite-uses k1)
    (key-two-use k2)
    (key-one-use k3)
    ;Key Colours
    (key-blue k3)
    (key-green k2)
    (key-red k1)
    ;Graph Connectivity
    (connected cell-1 cell-2)
    (connected cell-2 cell-3)
    (connected cell-3 cell-4)
    (connected cell-3 cell-11)
    (connected cell-2 cell-5)
    (connected cell-5 cell-6)
    (connected cell-3 cell-6)
    (connected cell-6 cell-7)
    (connected cell-4 cell-7)
    (connected cell-5 cell-8)
    (connected cell-8 cell-9)
    (connected cell-6 cell-9)
    (connected cell-9 cell-10)
    (connected cell-7 cell-10)
    (connected cell-2 cell-1)
    (connected cell-3 cell-2)
    (connected cell-4 cell-3)
    (connected cell-11 cell-3)
    (connected cell-5 cell-2)
    (connected cell-6 cell-5)
    (connected cell-6 cell-3)
    (connected cell-7 cell-6)
    (connected cell-7 cell-4)
    (connected cell-8 cell-5)
    (connected cell-9 cell-8)
    (connected cell-9 cell-6)
    (connected cell-10 cell-9)
    (connected cell-10 cell-7)
    
  )
  (:goal (and
                ;Hero's Goal Location
                (at-hero cell-11)
                ;All gates are closed
                (closed cell-5)
                (closed cell-6)
                (closed cell-7)
                (closed cell-9)

  ))
  
)