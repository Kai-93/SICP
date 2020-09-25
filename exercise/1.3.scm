(define (square x) (* x x))
(define (squares x y) (+ (square x) (square y)))

(define (getValue a b c)
  (
    if (> a b) 
    (
      if (> b c)
        (squares a b)
        (squares a c)
    )
    (
      if (> a c)
        (squares b a)
        (squares b c)
    )
  )
)

(getValue 10 2 3) 
