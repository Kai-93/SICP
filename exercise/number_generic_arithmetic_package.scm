; 操作表
(define *op-table* (make-hash-table))

; 举例 op = 'add, type = '(complex complex), 表示是两个复数相加
; put 即将 op + type 对应的 procedure 存入 table 中
; get 即将 op + type 对应的 procedure 从 table 取出

(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))

(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

; 获取 table 中保存的所有的 key
(define (all_keys)
  (hash-table/key-list *op-table*))

; 带标志数据的辅助函数
(define (attach-tag type-tag contents)
  (if (number? contents) contents
    (cons type-tag contents)))

; 获取 tag
(define (type-tags datum)
        ; 数字直接返回 type
        (cond ((number? datum) 'scheme-number)
              ; 若是 pair, 使用 car 返回
              ((pair? datum) (car datum))
              (else (error "Bad tagged datum -- TYPE-TAG " datum))))

; 获取 content
(define (contents datum)
  (cond ((number? datum) datum)
    ((pair? datum) (cdr datum))
    (else (error "Bad tagged datum -- TYPE-TAG " datum))))

; 通过 op args 定位 hash-table 中的方法
; (define (apply-generic op . args)
;   (let ((type-tags (map type-tags args)))
;     (let ((proc (get op type-tags)))
;       (if proc
;         (apply proc (map contents args))
;         (error "No method for thest types -- APPLY-GENERIC" (list op type-tags))))))

; 
(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                          (let ((t1->t2 (get-coercion type1 type2))
                                (t2->t1 (get-coercion type2 type1)))
                                (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                                      (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                                      (else (error "No method for these types" (list op type-tags))))))
                    (error "No method for these types" (list op type-tags)))))))


; 加减乘除
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
; 判断两个数值是否相等
(define (equ? x y) (apply-generic 'equ? x y))
; 是否等于0
(define (=zero? x) (apply-generic '=zero? x))
; x的y次方
(define (exp x y) (apply-generic 'exp x y))
