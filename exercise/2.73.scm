(load "2.56.scm")
(load "complex_number.scm")

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

; 复写
(define (deriv exp var)
      (cond ((number? exp) 0)
            ((variable? exp) (if (same-variable? exp var) 1 0))
            (else
              ((get 'deriv (operator exp))
               (operands exp)
               var))))

; 加法的安装包
(define (install-sum-package)
    (define (addend s) (car s))
    (define (augend s) (cadr s))
    (define (make-sum x y)
        (cond ((=number? x 0) y)
              ((=number? y 0) x)
              ((and (number? x) (number? y)) (+ x y))
              (else (attach-tag '+ (list '+ x y)))))

    (put 'addend '+ addend)
    (put 'augend '+ augend)
    (put 'make-sum '+ make-sum)
    (put 'deriv '+
        (lambda (exp var)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var))))
    'done)

(install-sum-package)

(define (make-sum x y) ((get 'make-sum '+) x y))

(define (addend sum) ((get 'addend '+) (contents sum)))

(define (augend sum) ((get 'augend '+) (contents sum)))

(deriv '(+ x 3) 'x)

; 加法的安装包
(define (install-product-package)
    (define (multiplier p) (car p))
    (define (multiplicand p) (cadr p))
    (define (make-product m1 m2)
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (attach-tag '* (list '* m1 m2)))))

    (put 'multiplier '* multiplier)
    (put 'multiplicand '* multiplicand)
    (put 'make-product '* make-product)
    (put 'deriv '*
        (lambda (exp var)
            (make-sum (make-product (multiplier exp)
                                      (deriv (multiplicand exp) var))
                      (make-product (deriv (multiplier exp) var)
                                    (multiplicand exp)))))
    'done)

(install-product-package)

(define (make-product x y) ((get 'make-product '*) x y))

(define (multiplier product) ((get 'multiplier '*) (contents product)))

(define (multiplicand product) ((get 'multiplicand '*) (contents product)))

(deriv '(* x y) 'x)
