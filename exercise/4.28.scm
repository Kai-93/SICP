 (define (g x) (+ x 1)) 

 (define (f g x) (g x)) 

 ; g 是一个 procedure
 ; 在 f 中 g 先是一个 parameter, 此时由于 lazy evaluation 且未遇到 primitiva operator, g 并不会被 evaluate
 ; 当执行 (g x) 时, g 将被视为 procedure, 而被 apply, 但其还是 thunk, 所以报错
