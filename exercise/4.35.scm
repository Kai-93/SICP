; returns an integer between two given bounds
(define (an-integer-between low high)
        (require (<= low high))
        (amb low (an-integer-between (+ low 1) high)))

(an-integer-between 1 3)
