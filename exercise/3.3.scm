(define (make-account initial origin-password)
        (define (deposit amount)
                      (begin (set! initial (+ initial amount))
                            initial))
        (define (withdraw amount)
                (if (> initial amount)
                    (begin (set! initial (- initial amount))
                        initial)
                    (display "Insufficient funds")))
        (define (dispatch input-password mode)
                (cond ((eq? input-password origin-password) 
                        (cond ((eq? mode 'deposit) deposit)
                          ((eq? mode 'withdraw) withdraw)
                          (else (display "No such action"))))
                      (else (display "Incorrect password"))))
        dispatch)

(define peter-acc (make-account 100 'secret-password))

((peter-acc 'secret-password 'withdraw) 40)

((peter-acc 'secret-password 'deposit) 40)

; ((peter-acc 'some-other-password 'deposit) 50) 
