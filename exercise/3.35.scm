(load "constraint.scm")

(define (squarer a b)
        (define (process-new-value)
                (if (has-value? b) (if (< (get-value b) 0) (error "Square less than 0 - SQUARER" (get-value b))
                                       (set-value! a (sqrt (get-value b)) me))
                    (if (has-value? a)
                            (set-value! b (square (get-value a)) me)
                        (error "Neither a nor b has a value - SQUARER"))))

        (define (process-forget-value) 
                (forget-value! a me)
                (forget-value! b me)
                (process-new-value))

        (define (me request)
                (cond ((eq? request 'I-have-a-value) (process-new-value))
                      ((eq? request 'I-lost-my-value) (process-forget-value))
                      (else (error "Unknown request - ADDER" request))))
        (connect a me)
        (connect b me)
        me)


(define a (make-connector))

;Value: a

(define b (make-connector))

;Value: b

(probe "a" a)

;Value 11: #[compound-procedure 11 me]

(probe "b" b)

;Value 12: #[compound-procedure 12 me]

(squarer a b)

;Value 13: #[compound-procedure 13 me]

(set-value! a 3 'user)

;Value: done

(forget-value! a 'user)

;Value: done

(set-value! b 16 'user)

;Value: done
