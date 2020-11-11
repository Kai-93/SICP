
; (let* ((x 3)
;       (y (+ x 2))
;       (z (+ x y 5)))
;       (* x z))
; 
; return 39

; 是否是 let 表达式
(define (let*? exp) (tagged-list? exp 'let*))

(define (get-variables-and-values-of-let* exp)
        (cadr exp))
(define (get-body-of-let* exp)
        (cddr exp))
(define (expand-clauses variables-and-values body)
        (if (null? variables-and-values) body
            (make-let (list (car variables-and-values))
                      (expand-clauses (car variables-and-values)
                                      body)))
; 下一个let嵌套在上一个let中
(define (let*->nested-lets exp)
        (expand-clauses (get-variables-and-values-of-let* exp)
                        (get-body-of-let* exp)))
