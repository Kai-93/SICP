(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

; 判断 queue 是否是空的
(define (empty-queue? queue) (null? (front-ptr queue)))

; 创建 queue
; queue 中保存 头部元素的指针 和 尾部元素的指针
; 头部和尾部元素都是 pair, 其中 car 是当前元素的值, cdr指向 下一个值(pair)
(define (make-queue) (cons '() '()))

; 返回 queue 中的第一个元素
 (define (front-queue queue)
     (if (empty-queue? queue) (error "FRONT called with an empty queue" queue)
         (car (front-ptr queue))))

; 将 item 插入到 queue 的尾部
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
              (set-front-ptr! queue new-pair)
              (set-rear-ptr! queue new-pair)
              queue)
          (else (set-cdr! (rear-ptr queue) new-pair)
  (set-rear-ptr! queue new-pair)
  queue))))

; 删除 queue 中的第一个元素
(define (delete-queue! queue)
      (cond ((empty-queue? queue) (error "DELETE! called with an empty queue" queue))
            (else (set-front-ptr! queue (cdr (front-ptr queue)))
                  queue)))

; 打印 queue 中的所有元素
(define (print-queue queue) (car queue))

