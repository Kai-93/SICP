(define (next-step l)
  (if (pair? l) (cdr l)
      '()))

(define (has-circle? l)
  (define (iter x y)
    (cond ((not (pair? x)) #f)
          ((not (pair? y)) #f)
          ((eq? x y) #t)
          (else (iter (next-step x)
                      (next-step (next-step x))))))
  (iter l (next-step l)))

; make up of 3 pairs, return 4
(define p3 (cons 1 2))
(define p2 (cons 1 p3))
(define p1 (cons p2 p3))
(has-circle? p1)

; make up of 3 pairs, return 7
(define p3 (cons 1 2))
(define p2 (cons p3 p3))
(define p1 (cons p2 p2))

(has-circle? p1)

; never return at all.
(define circle (cons 1 2))
(set-cdr! circle circle)
(has-circle? circle)
