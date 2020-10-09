; scheme 数值
(define (install-scheme-number-package)
     (define (tag x)
       (attach-tag 'scheme-number x))
     (put 'add '(scheme-number scheme-number)
          (lambda (x y) (tag (+ x y))))
     (put 'sub '(scheme-number scheme-number)
          (lambda (x y) (tag (- x y))))
     (put 'mul '(scheme-number scheme-number)
          (lambda (x y) (tag (* x y))))
     (put 'div '(scheme-number scheme-number)
          (lambda (x y) (tag (/ x y))))
     (put 'make 'scheme-number
          (lambda (x) (tag x)))
     (put 'equ? '(scheme-number scheme-number)
          (lambda (x y) (= x y)))
  'done)

(install-scheme-number-package)

(define (make-scheme-number n) ((get 'make 'scheme-number) n))

; 复数
; (equ? (make-complex-from-real-imag 1 2)
;             (make-complex-from-real-imag 1 2))
; (equ? (make-complex-from-real-imag 1 2)
;             (make-complex-from-real-imag 10086 10086))
; (equ? (make-complex-from-mag-ang 1 2)
;             (make-complex-from-mag-ang 1 2))
; (equ? (make-complex-from-mag-ang 1 2)
;             (make-complex-from-mag-ang 10086 10086))
