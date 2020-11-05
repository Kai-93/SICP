(load "stream.scm")

(define a (stream-enumerate-interval 1 4))
(define b (stream-enumerate-interval 2 5))
(define c (stream-enumerate-interval 3 6))

(define z (stream-map + a b c))

(display-stream a)
(display-stream b)
(display-stream c)

(display-stream z)
