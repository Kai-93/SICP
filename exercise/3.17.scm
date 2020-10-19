(define nil '())
(define already-seen '())

(define (seen? x)
  (define (iter already-seen)
    (if (null? already-seen)
      #f
      (or (eq? x (car already-seen))
          (iter (cdr already-seen)))))
  (iter already-seen))

(define (count-pairs x)
  (if (not (pair? x))
    0
    (if (seen? x) 
      0
      (begin
        (set! already-seen (cons x already-seen))
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))))

; make up of 3 pairs, return 4
(define p3 (cons 1 2))
(define p2 (cons 1 p3))
(define p1 (cons p2 p3))
(count-pairs p1)

; make up of 3 pairs, return 7
(define p3 (cons 1 2))
(define p2 (cons p3 p3))
(define p1 (cons p2 p2))

(count-pairs p1)

; never return at all.
(define circle (cons 1 2))
(set-cdr! circle circle)
(count-pairs circle)




; ; make up of 3 pairs, return 4
; (define p3 (cons 1 2))
; (define p2 (cons 1 p3))
; (define p1 (cons p2 p3))
; (has-circle? p1)

; ; make up of 3 pairs, return 7
; (define p3 (cons 1 2))
; (define p2 (cons p3 p3))
; (define p1 (cons p2 p2))

; (has-circle? p1)

; ; never return at all.
; (define circle (cons 1 2))
; (set-cdr! circle circle)
; (has-circle? circle)

