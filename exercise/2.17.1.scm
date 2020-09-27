; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list

(load "utils.scm")

(define (list-ref items n)
      (if (= n 0)
          (car items)
          (list-ref (cdr items) (- n 1))))

(define (last-pair target)
  (list (list-ref target (- (length target) 1))))

(last-pair (list 23 72 149 34))
