(load "2.38.scm")

(define (reverse-right sequence)
  (fold-right 
    ; x为当前值, y为后续累计值
    (lambda (x y) (append y (list)))
    '()
    sequence))

(define (reverse-left sequence)
  (fold-left
    (lambda (x y) (cons y x))
    '()
    sequence))

(reverse-right (list 1 2 3 4))

(reverse-left (list 1 2 3 4))

