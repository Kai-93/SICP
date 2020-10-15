(load "3.3.scm")

(define (make-joint account origin-password other-password)
        (lambda (input-password mode) 
                (cond ((eq? input-password other-password)
                        (account origin-password mode))
                      (else (display "Incorrect other-password")))))   

(define paul-acc (make-joint peter-acc 'secret-password 'rosebud))

((paul-acc 'rosebud 'deposit) 50)
