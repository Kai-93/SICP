(load "constraint.scm")

(define (averager a b c)
        (let ((connector-sum (make-connector))
              (connector-constant (make-connector)))
              (adder a b connector-sum)
              (multiplier c connector-constant connector-sum)
              (constant 2 connector-constant)))

(define a (make-connector))           ; 设置连接器

;Value: a

(define b (make-connector))

;Value: b

(define c (make-connector))

;Value: c

(probe "a" a)                         ; 监视连接器

;Value 11: #[compound-procedure 11 me]

(probe "b" b)

;Value 12: #[compound-procedure 12 me]

(probe "c" c)

;Value 13: #[compound-procedure 13 me]

(averager a b c)                      ; 进行约束

;Value: ok

(set-value! a 10 'user)

;Value: done

(set-value! b 2 'user)

;Value: done

(get-value c)

;Value: 6
