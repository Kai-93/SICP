(load "utils.scm")

(define (combiner-sum current-term accumulation-of-preceding-terms)
  (+ current-term accumulation-of-preceding-terms))

(define (combiner-product current-term accumulation-of-preceding-terms)
  (* current-term accumulation-of-preceding-terms))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (next a) next b))))

(define (sum a b)
  (accumulate combiner-sum 0 return-self a increase b))

(define (product a b)
  (accumulate combiner-product 1 return-self a increase b))

(sum 1 5)
(product 1 5)
