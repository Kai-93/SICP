(define (smallestDivisor n) (findDivisor n 2))

(define (findDivisor n testDivisor)
    (cond ((> (square testDivisor) n)
            n)
          ((divides? n testDivisor) 
            testDivisor)
          (else 
            (findDivisor n (+ testDivisor 1)))))

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder a b) 0))

(smallestDivisor 199)
(smallestDivisor 1999)
(smallestDivisor 19999)

