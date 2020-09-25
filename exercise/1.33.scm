(load "utils.scm")
(load "1.32.scm")

; 递归
(define (filtered-accumulate-recursion combiner null-value term a next b filter?)
  (if (> a b)
    null-value
    (if (filter? a) 
      (combiner 
        (term a)
        (filtered-accumulate-recursion
                combiner 
                null-value 
                term (next a) 
                next 
                b 
                filter?))
        (filtered-accumulate-recursion
                combiner 
                null-value 
                term (next a) 
                next 
                b 
                filter?))))

; 迭代
(define (filtered-accumulate-iteration combiner null-value term a next b filter?)
  (define (iter acc i)
    (if (> i b)
      acc
      (if (filter? i)
        (iter (combiner acc (term i)) (next i))
        (iter acc (next i)))))
      
  (iter null-value a))

