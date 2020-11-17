
(define (unless condition usual-value exceptional-value)
        (if condition exceptional-value usual-value))

(define (factorial n)
        (unless (= n 1)
                (* n (factorial (- n 1)))
                1))

; applicative-order
; (factorial 5) => (factorial 4) ... (factorial -100) ... 
; 因为调用 unless 的时候, 作为参数的 (factorial (- n 1)) 将会一直被求值

; normal-order
; (factorial (- n 1)) 在需要求值时求值, 结果是正常的
