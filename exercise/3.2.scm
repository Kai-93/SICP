(define (make-monitored f)
  (let ((count 0))
       (lambda (input)
               (cond ((eq? 'how-many-calls? input) count)
                     ((eq? 'reset-count input) (begin (set! count 0)
                                                      count))
                     (else (begin (set! count (+ count 1))
                                  (f input)))))))

(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)

(s 'reset-count)

(s 'how-many-calls?)
