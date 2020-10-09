; 操作表
(define *op-table* (make-hash-table))

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

(define (all_keys)
  (hash-table/key-list *op-table*))

; 带标志数据的辅助函数
(define (attach-tag type-tag contents)
  (if (number? contents) contents
    (cons type-tag contents)))

; 获取 tag
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
    ((pair? datum) (car datum))
    (else (error "Bad tagged datum -- TYPE-TAG " datum))))

; 获取 content
(define (contents datum)
  (cond ((number? datum) datum)
    ((pair? datum) (cdr datum))
    (else (error "Bad tagged datum -- TYPE-TAG " datum))))

; 通过 op args 定位 hash-table 中的方法
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (error "No method for thest types -- APPLY-GENERIC" (list op type-tags))))))

; 判断两个数值是否相等
(define (equ? x y) (apply-generic 'equ? x y))
; 是否等于0
(define (=zero? x) (apply-generic '=zero? x))
