(define (subsets s)
  (if (null? s) (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (subsets (car s)))))

(subsets (list 1 2 3))
