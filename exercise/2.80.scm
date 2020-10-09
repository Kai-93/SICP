(load "number_generic_arithmetic_package.scm")
(load "number_complex_number_package.scm")
(load "number_rational_number_package.scm")
(load "number_scheme_number_package.scm")

; scheme 数值
(=zero? (make-scheme-number 0))
(=zero? (make-scheme-number 10))

; 有理数
(=zero? (make-rational 0 2))
(=zero? (make-rational 1 2))

; 复数
(=zero? (make-complex-from-real-imag 0 0))
(=zero? (make-complex-from-real-imag 0 2))
(=zero? (make-complex-from-real-imag 1 0))
(=zero? (make-complex-from-mag-ang 0 0))
(=zero? (make-complex-from-mag-ang 0 2))
(=zero? (make-complex-from-mag-ang 1 0))
