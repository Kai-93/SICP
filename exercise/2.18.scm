; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list

(define (reverse-list-iter source result)
  (cond 
        (
          (null? source) result
        )
        (
          else 
          (reverse-list-iter (cdr source) (cons (car source) result))
        )
  )
)

(define (reverse-list source)
  (reverse-list-iter source ()))

(reverse-list (list 23 72 149 34))
