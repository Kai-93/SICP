(load "stream.scm")

; Define a procedure partial-sums that takes as argument a stream S 
; returns the stream whose elements are S0, S0+S1,S0+S1+S2,....
(define (partial-sums stream)
        (cons-stream (stream-car stream)
                     ; 下一个值
                     (stream-map + 
                                 ; S1+S2+...Sn-1
                                 (partial-sums stream)
                                 ; Sn
                                 (stream-cdr stream))))
 


(define n (partial-sums integers))

; 1 3 6 10 15 21 28 36 45 55
(stream-ref n 0)
(stream-ref n 1)
(stream-ref n 2)
(stream-ref n 3)
(stream-ref n 4)
