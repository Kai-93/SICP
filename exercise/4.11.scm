; 举例
; 旧的结构: ((variable1, variable2), (value1, value2))
; 新的结构: ((variable1, value1), (variable2,value2))
(define (make-frame vars vals)
        (if (or (null? vars) (null? vals)) '()
            (cons (cons (car vars) (cdr vars))
                  (make-frame (cdr vars) (cdr vars)))))
