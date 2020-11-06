(load "stream.scm")

(define (show x) 
              (display x)
              x)

(define _x (stream-enumerate-interval 0 10))

(define x (stream-map show _x))

(stream-ref x 5)

(stream-ref x 7)                                            
