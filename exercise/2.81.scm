
(load "table.scm")
(load "number_generic_arithmetic_package.scm")
(load "number_complex_number_package.scm")
(load "number_rational_number_package.scm")
(load "number_scheme_number_package.scm")


(define coercion-table (make-table))

(define get-coercion (coercion-table 'lookup-proc))

(define put-coercion (coercion-table 'insert-proc!))

(define (scheme-number->scheme-number n) n)

(define (complex->complex z) z)

(put-coercion 'scheme-number 'scheme-number scheme-number->scheme-number)

(put-coercion 'complex 'complex complex->complex)

(exp (make-scheme-number 1) (make-scheme-number 2))
