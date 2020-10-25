(load "constraint.scm")

(define (c+ x y)
        (let ((sum (make-connector)))
              (adder x y sum) 
              sum))
(define (c- sum x)
        (let ((diff (make-connector)))
              (adder x diff sum) 
              diff))
(define (c* x y)
        (let ((product (make-connector)))
              (multiplier x y product)
              product))
(define (c/ dividend divisor)
        (let ((reminder (make-connector)))
              (multiplier divisor reminder dividend) 
              reminder))
(define (cv num)
        (let ((connector-constant (make-connector)))
              (constant num connector-constant)
              connector-constant))


(define (celsius-fahrenheit-converter x)
        (c+ (c* (c/ (cv 9) (cv 5))
                x) 
            (cv 32)))


(define C (make-connector))

(define F (celsius-fahrenheit-converter C))


(probe "Celsius temp" C)

(probe "Fahrenheit temp" F)

(set-value! C 25 'user)

(forget-value! C 'user)

(set-value! F 212 'user)

