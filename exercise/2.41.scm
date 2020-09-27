(load "utils.scm")
(load "2.40.scm")

(define (unique-triples n)
  (flatmap
    (lambda (i) 
      (map 
        (lambda (pair) (cons i pair)) 
        (unique-pairs (- i 1))))
    (enumerate-interval 1 n)))

(define (sum-of-triple-equal-to? sum triple) (= sum (accumulate + 0 triple)))

(define (remove-triples-item-not-equal-to sum triples)
  (filter (lambda (triple) (sum-of-triple-equal-to? sum triple)) triples))

(remove-triples-item-not-equal-to 10 (unique-triples 13))

