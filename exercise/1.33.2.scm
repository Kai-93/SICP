(load "utils.scm")
(load "1.32.scm")
(load "1.33.scm")

(define (product-prime n)
  (define (valid? x) (= (gcd x n) 1))
  (filtered-accumulate-iteration combiner-product 1 return-self 1 increase n valid?))

(product-prime 10)

