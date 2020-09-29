(define (make-vect x y) (cons x y))

(define (xcor-vect v) (car v))

(define (ycor-vect v) (cdr v))


(define (add-vect v1 v2)
  (make-vect 
    (+ (xcor-vect v1) (xcor-vect v2))
    (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect 
    (- (xcor-vect v1) (xcor-vect v2))
    (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v factor)
  (make-vect 
    (*  (xcor-vect v) factor)
    (* (ycor-vect v) factor)))


(add-vect (make-vect 1 1) (make-vect 2 2))

; (sub-vect (make-vect 1 1) (make-vect 2 2))

; (scale-vect (make-vect 3 3) 2)

