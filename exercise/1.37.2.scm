(define (continued-fraction-iteration n d k)
    (define (iter result i)
        (if (= i 1)
            result
            (iter (/ (n i) (+ (d i) result)) (- i 1))
        )
    )
    (iter 1 k)
)
      
(define (golden-ratio k)
    (+ 1
       (continued-fraction-iteration (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))

(golden-ratio 1)
(golden-ratio 10)
(golden-ratio 11)
