(load "3.17.scm")

(define (has-circle? x)
  (if (pair? x)
    (if (seen? x)
      #t
      (begin
        (set! already-seen (cons x already-seen))
        (or (has-circle? (car x))
            (has-circle? (cdr x)))))
    #f))

; never return at all.
(define circle (cons 1 2))
(set-cdr! circle circle)
(has-circle? circle)

