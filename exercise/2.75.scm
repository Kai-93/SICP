 (define (make-from-mag-ang r a)
     (define (dispatch op)
       (cond ((eq? op 'magnitude) r)
             ((eq? op 'angle) r)
             ((eq? op 'real-part) (* r (cos a)))
             ((eq? op 'imag-part) (* r (sin a)))
             (else (error "Unknown op - MAKE-FROM-MAG-ANG" op))))
     dispatch)


(define c (make-from-mag-ang 3 4)) ;Value: c

(c 'real-part) ;Value: -1.960930862590836

(c 'imag-part) ;Value: -2.2704074859237844

(c 'magnitude) ;Value: 3

(c 'angle) ;Value: 4
