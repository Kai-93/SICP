; Define a procedure last-pair that returns the list that contains only the last element of a given (nonempty) list

(define (reverse-list-iter source result)
  (cond ((null? source) result)
        ((not (pair? source)) source)
        (else 
          (reverse-list-iter 
            (cdr source)
            (cons
              (reverse-list-iter  (car source) ()) ; car source 并不一定是 pair , 所以需要line 5代码的判断
              result)))))

(define (reverse-list source)
  (reverse-list-iter source ()))

(reverse-list (list (list 1 (list 2 3)) (list 4 (list 5 6))))
