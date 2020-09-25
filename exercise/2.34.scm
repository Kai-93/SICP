(load "utils.scm")

(define (horner-eval x coefficient-sequence)
  (accumulate 
    (lambda ; operation 的传参数1是当前值, 传参数2是后续累计值
      (this-coeff higher-terms) 
      (+ this-coeff (* x higher-terms)))
    0 
    coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))
