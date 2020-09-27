(load "utils.scm")

 (define (flatmap proc seq)
      (accumulate append '() (map proc seq)))

(define (enumerate-interval i j)
  (if (> i j) '()
      (cons i (enumerate-interval (+ i 1) j))))

(define (unique-pairs n) 
  (flatmap 
      (lambda (i)
        (map 
          (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
      (enumerate-interval 1 n)))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum (filter prime-sum? (unique-pairs n))))

 (prime-sum-pairs 6)
