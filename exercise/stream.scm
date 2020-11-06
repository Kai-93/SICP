; 以下是模拟实现
; ; 缓存计算结果
; (define (memo-proc proc)
;   (let ((already-run? false)(result false))
;         (lambda ()
;                 (if (not already-run?) 
;                         (begin (set! result (proc))
;                                (set! already-run? true)
;                                result)
;                     result))))

; (define (force delayed-object) (delayed-object))

; (define (delay proc) (memo-proc (lambda () proc)))

; ; 核心
; (define (cons-stream x y) (cons x (delay y)))

; (define (stream-car stream) (car stream))

; ; cdr 时才计算延迟的表达式
; (define (stream-cdr stream) (force (cdr stream)))


(define (stream-null? stream) (equal? stream the-empty-stream))

; 获取 stream 中第 n+1 的元素
(define (stream-ref stream n)
        (if (= n 0) (stream-car stream)
            (stream-ref (stream-cdr stream) (- n 1))))

; 3.50时添加 
; 用于多个 stream 的 map 处理
(define (stream-map proc . arguements) ; . arguements 将后续所有参数赋值给 arguements
  (if (stream-null? (car arguements)) the-empty-stream
      (cons-stream (apply proc (map stream-car arguements)) ; 将所以 stream 的第一个元素取出来, 交由 proc 执行, 并组成新 stream
                   (apply stream-map (cons proc (map stream-cdr arguements))))))
                  ; (stream-map proc (map stream-cdr arguements))))) ; 这里不能写成这样

; 以 stream 中的每个元素为参数, 执行 proc
 (define (stream-for-each proc stream)
      (if (stream-null? stream) 'done
          (begin (proc (stream-car stream))
                 (stream-for-each proc (stream-cdr stream)))))

; 展示 stream 中的每个元素
(define (display-stream stream) (stream-for-each display-line stream))

; 换行展示 x
 (define (display-line x)
         (newline)
         (display x))

; stream 的过滤器, 将符合 predicate 的新元素组成 stream 返回
(define (stream-filter predicate stream)
        (cond ((stream-null? stream) the-empty-stream)
              ((predicate (stream-car stream)) (cons-stream (stream-car stream) 
                                                            (stream-filter predicate (stream-cdr stream))))
              (else (stream-filter predicate 
                                   (stream-cdr stream)))))

; 生成从 low 到 high 的stream
(define (stream-enumerate-interval low high)
      (if (> low high) the-empty-stream
          (cons-stream low (stream-enumerate-interval (+ low 1) high))))

; 整数无穷流, 从 n 开始
(define (integers-starting-from n)
        (cons-stream n (integers-starting-from (+ n 1))))

; 正整数
(define integers (integers-starting-from 1))

; 两个 stream 中的元素逐个相乘
(define (mul-streams stream-1 stream-2)
        ; 方法一
        (stream-map * stream-1 stream-2))
        ; 方法二
        ; (cons-stream (* (stream-car stream-1) (stream-car stream-2))
        ;              (mul-streams (stream-cdr stream-1) (stream-cdr stream-2))))
