; 不动点计算
(define (fixed-point f first-guess)

  (define tolerance 0.00001)

  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (display-info guess step)
    (display "Step: ")
    (display step)
    (display ", ")
    
    (display "Guess: ")
    (display guess)
    (newline))

  (define (try guess step)
    (display-info guess step)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next (+ step 1)))))

  (try first-guess 1))

(define golden-ratio
  (fixed-point (lambda (x)
                (+ 1 (/ 1 x)))
                1.0))

(golden-ratio)
