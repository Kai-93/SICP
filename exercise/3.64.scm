(load "stream.scm")

(define (stream-limit stream tolerance)
        (let ((current (stream-car stream))
              (next (stream-car (stream-cdr stream))))
          (if (< (abs (- next current)) tolerance) next
              (stream-limit (stream-cdr stream) tolerance))))

(define (sqrt x tolerance)
        (stream-limit (sqrt-stream x) tolerance))

(sqrt 9 0.0001)
