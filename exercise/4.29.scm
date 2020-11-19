
(define (square x) (* x x))
 
(define count 0)

(define (id x)
        (set! count (+ count 1))
        x)

;;; L-Eval input:
(square (id 10)) ; (squre 10), count = 1
;;; L-Eval value: 
100

;;; L-Eval input:
count
;;; L-Eval value: 
1
