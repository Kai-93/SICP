(define (f1 n) 
  (if(< n 3)
      n
      (+ (f1 (- n 1))
        (* 2 (f1 (- n 2)))
        (* 3 (f1 (- n 3))))))

(f1 4)

(define (f2 n) 
  (f2-iter 2 1 0 0 n))

(define (f2-iter a b c i n)
  (if (= i n)
    c
    (f2-iter (+ a (* 2 b) (* 3 c)) 
              a 
              b 
              (+ i 1) 
              n)))

(f2 4)
