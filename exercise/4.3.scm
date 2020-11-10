; 示意
(define (eval exp env)
     (cond ((self-evaluating? exp) 
              ((get (exp-type exp)) (exp-body exp) env))
           ...
           (else (error "Unknown expression type - EVAL" exp))))

; 示意
(define (install-exp-type)
    (put '(exp-type)
        (lambda (exp env)
            (lookup-variable-value exp env)))
    ...
)
