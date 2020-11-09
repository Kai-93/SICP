; 文中的 demo
(define (list-of-values exps env)
        (if (no-operands? exps) '()
            (cons (eval (first-operand exps) env)
                  (list-of-values (rest-operands exps) env))))

; from left to right
(define (list-of-values exps env)
        (if (no-operands? exps) '()
            (let ((first (eval (first-operand exps) env)))
                  (cons first (list-of-values (rest-operands exps) env))))

; from right to left
(define (list-of-values exps env)
        (if (no-operands? exps) '()
            (let ((rest (list-of-values (rest-operands exps) env)))
                  (cons (eval (first-operand exps) env) rest)))
