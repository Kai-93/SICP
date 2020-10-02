(define (element-of-set? x set)
      (cond ((null? set) false)
            ((equal? x (car set)) true)
            (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
     (cond ((null? set1) set2)
           ((element-of-set? (car set1) set2) (union-set (cdr set1) set2))
           (else (union-set (cdr set1) (cons (car set1) set2)))))

(union-set '(1 2 3) '(3 4 5 6))

(union-set '() '(1 2 3))
