(load "stream.scm")

;     n: 1 2 3 4  5
; value: 1 2 6 24 120
(define factorials 
        (cons-stream 1 (mul-streams (stream-cdr integers)
                                    factorials)))



(stream-ref factorials 0)
(stream-ref factorials 1)
(stream-ref factorials 2)
(stream-ref factorials 3)
(stream-ref factorials 4)
