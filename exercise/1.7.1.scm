
(define (square a) (* a a))

(define (average a b) (/ (+ a b) 2))

(define (goodEnough? guess x) (<= (abs (- (square guess)  x)) 0.001))

(define (newGoodEnough? oldGuess newGuess) (< (abs (- newGuess oldGuess)) 0.001))

; new-if 是函数, 故作为参数的函数会一直执行, 直至爆栈
(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(define (improve guess x) (average guess (/ x  guess)))

(define (sqrtIter guess x) 
  (
    if (newGoodEnough? guess (improve guess  x)) 
      (improve guess  x)
      (sqrtIter (improve guess  x)  x)
  )
)

(define (sqrt x) (sqrtIter 1.0 x))

(sqrt 100000000000000000000)


