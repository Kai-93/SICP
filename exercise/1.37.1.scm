(define (continued-fraction-recursion n d k)
    (define (iter i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i) (+ (d i) (iter (+ i 1))))
        )
    )
    (iter 1)
)
      
(define (golden-ratio k)
    (+ 1
       (continued-fraction-recursion (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))

(golden-ratio 1)
(golden-ratio 10)
(golden-ratio 11)
