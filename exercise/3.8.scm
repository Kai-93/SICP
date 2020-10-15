
(define f
    (lambda (first-value)
        (set! f (lambda (second-value) 0))
        first-value))

(+ (f 0) (f 1))
