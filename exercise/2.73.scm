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

(define (install-exponentiation-package)
    (define (base exp) (car exp))
    (define (exponent exp) (cadr exp))
    (define (make-exponentiation base n)
        (cond ((= n 0) 0)
              ((= n 1) base)
              (else (attach-tag '** (list '** base n)))))

    (put 'base '** base)
    (put 'exponent '** exponent)
    (put 'make-exponentiation '** make-exponentiation)

    (put 'deriv '**
         (lambda (exp var)
            (let ((n (exponent exp)) (u (base exp)))
                 (make-product n (make-product (make-exponentiation u (- n 1))
                                               (deriv u var))))))

'done)

(install-exponentiation-package)

(define (make-exponentiation base n)
    ((get 'make-exponentiation '**) base n))

(define (base exp)
    ((get 'base '**) (contents exp)))

(define (exponent exp)
    ((get 'exponent '**) (contents exp)))

(deriv '(** x 3) 'x)
