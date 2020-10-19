(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
        (define (empty-queue?) (null? front-ptr))
        (define (insert-queue! item) 
                (if (empty-queue?) (let ((init (list item)))
                                        (set! front-ptr init)
                                        (set! rear-ptr init)
                                        front-ptr)
                    (let ((new-item (list item)))
                         ((set-cdr! rear-ptr new-item)
                          front-ptr)))
        (define (delete-queue!) 
                (if (empty-queue?) '()
                    (else (set! front-ptr (cdr front-ptr))
                          front-ptr)))
        (define (dispatch m)
                (cond ((eq? m 'insert-queue!) insert-queue!)
                      ((eq? m 'delete-queue!) (delete-queue!))
                      ((eq? m 'empty-queue?) (empty-queue?))
                      (else (error "Unknow operation -- DISPATCH" m))))
        dispatch))

; 创建队列
(define q (make-queue))

(q 'insert-queue!)

; 插入
((q 'insert-queue!) 'a)
;Value 11: (a)

((q 'insert-queue!) 'b)
;Value 11: (a b)


; 删除
(q 'delete-queue!)                        

;Value 12: (b)

(q 'delete-queue!)

;Value: ()

; 空队列
(q 'empty-queue?)                         

;Value: #t

((q 'insert-queue!) 'not-empty-now)

;Value 14: (not-empty-now)

(q 'empty-queue?)

;Value: #f
