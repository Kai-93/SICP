; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list

(define (last-pair source)
  (cond 
        (
          (null? source) (error "list empty -- LAST-PAIR")
        )
        (
          (null? (cdr source)) source
        )
        (
          else (last-pair (cdr source))
        )
  )
)

(last-pair (list 23 72 149 34))
