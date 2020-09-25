; linear recursion 
(define (sum term a next b)
  (if (> a b)
          0
       (+ (term a)
          (sum term (next a) next b))))

; (define (cube x) (* x x x))

; (define (increase a) (+ a 1))

; (define (sum-cubes a b) 
;         (sum cube a increase b))

; (sum-cubes 1 10)

; (define (integral f a b dx)
;   (define (add-dx x) (+ dx x))
;   (define (term a) (+ a (/ dx 2)))
;   (* 
;     ; (sum f (+ a (/ dx 2.0)) add-dx b)
;     (sum f (+ a (/ dx 2.0)) add-dx b)
;     dx)
; )

; (integral cube 0 1 0.01)
