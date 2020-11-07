(load "stream.scm")

;     n: 0 1 2 3 4
; value: 0 1 1 2 3 
(define fibs 
        (cons-stream 0 (cons-stream 1 (add-streams fibs
                                                   (stream-cdr fibs)))))

(stream-ref fibs 0)
(stream-ref fibs 1)
(stream-ref fibs 2)
(stream-ref fibs 3)
(stream-ref fibs 4)

; O(n)

; (delay <exp>) simply as (lambda () <exp>)
; without using the optimization provided by the memo-proc procedure
; O(n^2)
