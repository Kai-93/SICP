(define (equal? v1 v2)
  (cond 
    ((and (symbol? v1) (symbol? v2))
      (eq? v1 v2))
    ((and (list? v1) (list? v2))
      (equal-list? v1 v2))
    (else 
      (error "Wrong type input x and y -- EQUAL?" v1 v2))))

(define (equal-list? v1 v2)
  (cond 
    ((and (null? v1) (null? v2)) 
      #t)
    ((or (null? v1) (null? v2))
      #f)
    ((equal? (car v1) (car v2))
      (equal? (cdr v1) (cdr v2)))
    (else
      #f)))

(equal? '(this is a list) '(this is a list))

(equal? '(this (is a) list) '(this (is a) list))
