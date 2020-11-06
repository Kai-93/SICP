(load "stream.scm")

(define sum 0)

(define (accum x)
        (set! sum (+ x sum))
        sum)

(display sum)

(define x (stream-enumerate-interval 1 20))

; x
; n = 1 2 3 4 5 6 ... 20

(define seq (stream-map accum x))

; seq
; (0+1) (1+2) (3+3) ... (sum+20)=210
; sum = (1+n)*n/2
; item(n) = (1+n)*n/2

; 只求值了第一个元素, 故 sum = 1
(display sum)

(define y (stream-filter even? seq))

; y
; 6 10 28 36 66 78 120 136 190 210

; 只求值了第一个元素, 故 sum = 6
(display sum)

(define z (stream-filter  (lambda (x) (= (remainder x 5) 0))
                           seq))

; 只求值了第一个元素, 故 sum = 10
(display sum)

; 136
(stream-ref y 0)
