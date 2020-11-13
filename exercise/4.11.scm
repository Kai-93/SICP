; 举例
; 旧的结构: ((variable1, variable2), (value1, value2))
; 新的结构: ((variable1, value1), (variable2,value2))
; 意为文中的实现只是实例, 还有别的实现方式
; 比如, bindings的结构可以如题所示
(define (make-frame vars vals)
        (if (or (null? vars) (null? vals)) '()
            (cons (cons (car vars) (cdr vars))
                  (make-frame (cdr vars) (cdr vars)))))
