
(load "utils.scm")
(load "1.35.scm")

(define (average-damp f)
    (lambda (x)
        (average x 
                 (f x))))

(define formula 
    (lambda (x)
        (/ (log 1000) 
           (log x))))

(define get-solution (fixed-point formula 1.1))

(get-solution)

(fixed-point (average-damp formula) 1.1)



