(load "utils.scm")
(load "2.2.scm")

(define (print-perimeter-and-area rectangle)
    (newline)
    (display "perimeter: ")
    (display (get-perimeter rectangle))
    (newline)
    (display "area: ")
    (display (get-area rectangle)))


(define (get-perimeter rectangle)
    (let (
            (width (get-width-of-rectangle rectangle))
            (height (get-height-of-rectangle rectangle))
        )
        (* (+ width height) 2)))

(define (get-area rectangle)
    (* (get-width-of-rectangle rectangle)
       (get-height-of-rectangle rectangle)))

(define (make-rectangle left-top-point right-bottom-point)
    (cons left-top-point right-bottom-point))

(define (get-left-top-point-of-rectangle rectangle)
    (car rectangle))

(define (get-right-bottom-point-of-rectangle rectangle)
    (cdr rectangle))

(define (get-width-of-rectangle rectangle)
    (let (
            (x2 (x-point (get-left-top-point-of-rectangle rectangle)))
            (x1 (x-point (get-right-bottom-point-of-rectangle rectangle)))
         )
        (abs (- x2 x1))))

(define (get-height-of-rectangle rectangle)
    (let (
            (y2 (y-point (get-left-top-point-of-rectangle rectangle)))
            (y1 (y-point (get-right-bottom-point-of-rectangle rectangle)))
         )
        (abs (- y2 y1))))

(define start (make-point 0 2))
(define end (make-point 3 0))

(define rect (make-rectangle start end))

(get-area rect)
(get-perimeter rect)
