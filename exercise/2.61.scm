
; (define (adjoin-set x set)
;   (if (element-of-set? x set)
;       set
;       (cons x set)))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        (else (let ((current-item (car set))
                    (remainder-set (cdr set)))
                   (cond ((= x current-item) set)
                         ((< x current-item) (cons x set))
                         (else (cons current-item (adjoin-set x remainder-set))))))))

(adjoin-set 1 '())    

(adjoin-set 1 (list 2 3 4))  

(adjoin-set 3 (list 1 2 3))  

(adjoin-set 3 (list 1 2 4 5)) 
