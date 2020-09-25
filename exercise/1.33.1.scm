(load "utils.scm")
(load "1.32.scm")
(load "1.33.scm")

(define (sum-prime a b)
  (filtered-accumulate-iteration combiner-sum 0 return-self a increase b prime?))

(sum-prime 1 10)
