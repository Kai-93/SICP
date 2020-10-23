(load "constraint.scm")
(define (squarer a b) (multiplier a a b))


(define a (make-connector))          
(define b (make-connector))
(squarer a b)

; (set-value! a 10 'user)

; (get-value b)

(set-value! b 100 'user)

; 错误原因是 处理b的设置时, 两个a都没有值, 故没有输出
; multiplier 只有当两个 connector 有值时, 才会计算输出第三个 connector 的值
(get-value a)
