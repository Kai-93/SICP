(define (make-accumulator initial)
  (lambda (amount)
          (begin (set! initial (+ initial amount))
                 initial)))

(define acc1 (make-accumulator 5))
(define acc2 (make-accumulator 5))

(acc1 1)
(acc2 2)

(acc1 1)
(acc2 2)
