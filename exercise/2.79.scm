(load "number_generic_arithmetic_package.scm")
(load "number_complex_number_package.scm")
(load "number_rational_number_package.scm")
(load "number_scheme_number_package.scm")

; scheme 数值
(equ? (make-scheme-number 10) (make-scheme-number 10))
(equ? (make-scheme-number 10) (make-scheme-number 1008611))

; 有理数
(equ? (make-rational 1 2) (make-rational 1 2))
(equ? (make-rational 1 2) (make-rational 10086 10086))

; 复数
(equ? (make-complex-from-real-imag 1 2)
            (make-complex-from-real-imag 1 2))
(equ? (make-complex-from-real-imag 1 2)
            (make-complex-from-real-imag 10086 10086))
(equ? (make-complex-from-mag-ang 1 2)
            (make-complex-from-mag-ang 1 2))
(equ? (make-complex-from-mag-ang 1 2)
            (make-complex-from-mag-ang 10086 10086))
