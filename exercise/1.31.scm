(load "utils.scm")

(define (product-recursion term a next b)
  (if (> a b)
          1
       (* (term a)
          (product-recursion term (next a) next b))))


(define (product-iteration term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a))))) 
  (iter a 1))

; (define (term x) x)

; (product-recursion term 1 increase 10)
; (product-iteration term 1 increase 10)

; (define (factorial x) (product-recursion term 1 increase x))

; (factorial 10)

(define (pi n)
  (define (term n)
    (if (even? n)
      (/ (+ n 2) (+ n 1))
      (/ (+ n 1) (+ n 2))))
  (* (exact->inexact (product-iteration term 1 increase n)) 4)
)

(pi 100000)
