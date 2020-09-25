(define (even? n) (= (remainder n 2) 0))

(define (odd? n) (not (= (remainder n 2) 0)))

(define (increase x) (+ x 1))

(define (average a b) (/ (+ a b) 2))

(define (return-self x) x)

(define (smallestDivisor n) (findDivisor n 2))

(define (findDivisor n testDivisor)
    (cond ((> (square testDivisor) n)
            n)
          ((divides? n testDivisor) 
            testDivisor)
          (else 
            (findDivisor n (+ testDivisor 1)))))

(define (square x) (* x x))

(define (divides? a b) (= (remainder a b) 0))

(define (prime? n) (= (smallestDivisor n) n))

(define (gcd a b)
      (if (= b 0)
          a
          (gcd b (remainder a b))))


(define (accumulate op initial sequence)
     (if  (null? sequence) ; 为null返回初始值
            initial 
          (op ; 使用 操作符 处理 当前值 和 后续累计值
            (car sequence)
            (accumulate op initial (cdr sequence)))))
