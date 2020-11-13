(let ((a 1))
      (define (f x)
              (define b (+ a x)) ; set 时需求值, 这里的 a 是 *unassigned*
              (define a 5)
              (+ a b))
      (f 10))
