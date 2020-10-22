(load "queue.scm")

; 定义延迟
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

; 与或非逻辑
(define (logical-and x y)
  (if (and (= x 1) (= y 1)) 1
      0))
(define (logical-not x)
  (cond ((= x 0) 1)
        ((= x 1) 0)
        (else (error "Invalid signal" x))))
(define (logical-or x y)
    (if (or (= x 1) (= y 1)) 1
        0))

; 反门/非门
(define (inverter input output)
    (define (invert-input)
        (let ((new-value (logical-not (get-signal input))))
              ; 将任务加至 agenda 中
              (after-delay inverter-delay
                           (lambda () (set-signal! output new-value)))))
    (add-action! input invert-input)
    'ok)
; 与门
(define (and-gate a1 a2 output)
    (define (and-action-procedure)
        (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
              ; 将任务加至 agenda 中
              (after-delay and-gate-delay
                           (lambda () (set-signal! output new-value)))))
    (add-action! a1 and-action-procedure)
    (add-action! a2 and-action-procedure)
    'ok)
; 或门, 注册修改事件
; 调用时, 创建 action-procedure, 其作用是根据输入来输入
; 并将其加入到输入 wire 的 action-procedures 中
; 当输入 wire 的是修改时, 会将方法放入 agenda 中, 延迟调用
(define (or-gate input-1 input-2 output)
    (define (or-action-procedure)
        (let ((new-value (logical-or (get-signal input-1) (get-signal input-2))))
              ; 将任务加至 agenda 中
              (after-delay or-gate-delay 
                           (lambda () (set-signal! output new-value)))))
    ; 将 action 加入到 wire(input-1) 中 action-procedures 中, 并执行
    (add-action! input-1 or-action-procedure)
    ; 将 action 加入到 wire(input-2) 中 action-procedures 中, 并执行
    (add-action! input-2 or-action-procedure)
    'ok)

; 创建 wire
(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
        ; 设置 wire 的 signal-value, 并执行 action-procedures 中的 每一个 procedure
        (define (set-my-signal! new-value)
                (if (not (= signal-value new-value))
                         (begin (set! signal-value new-value)
                                (call-each action-procedures))
                    'done))
        ; 将 procedure 加入 action-procedures 中, 并执行
        (define (accept-action-procedure! proc)
                (set! action-procedures (cons proc action-procedures))
                (proc))

        (define (dispatch m)
                (cond ((eq? m 'get-signal) signal-value)
                      ((eq? m 'set-signal!) set-my-signal!)
                      ((eq? m 'add-action!) accept-action-procedure!)
                      (else (error "Unknown operation - WIRE" m))))
        dispatch))

(define (get-signal wire) (wire 'get-signal))

(define (set-signal! wire new-value) ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure) ((wire 'add-action!) action-procedure))

; 执行 procedures 中的每一个 procedure
(define (call-each procedures)
     (if (null? procedures) 'done 
         (begin ((car procedures))
                (call-each (cdr procedures)))))


(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time) (set-car! agenda time))
; 返回 agenda 的 segments
(define (segments agenda) (cdr agenda))
; 创建 segment 
(define (make-time-segment time queue) (cons time queue))
; 返回 segment 的 time
(define (segment-time s) (car s))
; 返回 segment 中的 procedures
(define (segment-queue s) (cdr s))
; 设置 agenda 的 segments
(define (set-segments! agenda segments) (set-cdr! agenda segments))
; 返回 the-agenda 的第一个 segment
(define (first-segment agenda) (car (segments agenda)))
; 返回 the-agenda 中除第一个 segment
(define (rest-segments agenda) (cdr (segments agenda)))
(define (empty-agenda? agenda) (null? (segments agenda)))

; 将 time 对应的 action 加入到 agenda 中
(define (add-to-agenda! time action agenda)
        ; 若要加入的 time 是否比 segments 中的 time 都要早
        (define (belongs-before? segments)
                (or (null? segments)
                    (< time (segment-time (car segments)))))
        ; 创建新的 segment
        (define (make-new-time-segment time action)
                (let ((q (make-queue))) ; 新建 queue
                      (insert-queue! q action) ; 将 action 插入 queue 中
                      (make-time-segment time q))) ; 创建 segment
        ; 将 time&action 插入到 segments 中 
        (define (add-to-segments! segments)
                ; 若要加入的 time 与 segments 中第一个 segment 的 time 相等
                (if (= (segment-time (car segments)) time)
                    ; 将 action 插入到 segments 中第一个 segment 的 procedures 中的第一个
                    (insert-queue! (segment-queue (car segments)) action)
                    ; 若要加入的 time 与 segments 中第一个 segment 的 time 不相等
                    ; 获取余下的 segments
                    (let ((rest (cdr segments)))
                          ; 若要加入的 time 比余下的 segments 中的 time 都要早
                          (if (belongs-before? rest)
                                  ; 创建新的 segment, 并将其插入到余下的 segments 的头部
                                  (set-cdr! segments
                                            (cons (make-new-time-segment time action) (cdr segments)))
                              ; 若要加入的 time 比余下的 segments 中的 time 都要迟, 则继续遍历
                              (add-to-segments! rest)))))
        ; 获取 agenda 的 segments
        (let ((segments (segments agenda)))
              ; 若要加入的 time 比 segments 中的 time 都要早
              (if (belongs-before? segments)
                      ; 设置 agenda 的 segments
                      (set-segments! agenda
                          ; 创建新的 segment, 并将其插入到 segments 的头部
                          (cons (make-new-time-segment time action) segments))
                  ; 若不是最早的, 将 time&action 插入到 segments 中
                  (add-to-segments! segments))))

; 移除一个时间片段中的 procedures 中的第一个 procedure
 (define (remove-first-agenda-item! agenda)
      (let ((q (segment-queue (first-segment agenda))))
            (delete-queue! q) ; 删除 q 中的第一个元素
            (if (empty-queue? q) ; 若 q 为空, 则移除该时间片段
                (set-segments! agenda (rest-segments agenda)))))

; 取出 the-agenda 中的第一个 segment
; 并将 the-agenda 第一个对象(用于保存时间)设置为 第一个 segment 的 segment-time
; 并返回第一个 segment 的 第一个procedure
(define (first-agenda-item agenda)
        (if (empty-agenda? agenda)
            (error "Agenda is empty - FIRST-AGENDA-ITEM")
            ; 获取 the-agenda 中第一个 segment 
            (let ((first-seg (first-segment agenda)))
                  ; 设置 the-agenda 的第一个对象(最近执行时间)为 segment的时间
                  (set-current-time! agenda (segment-time first-seg))
                  ; 返回 segment 中 procedures 中的第一个 procedure
                  (front-queue (segment-queue first-seg)))))

(define the-agenda (make-agenda))

; 处理 the-agenda
; 每次取 the-agenda 的第一个 segment 中的第一个 procedure 处理并移除, 继续执行下一个
(define (propagate)
        (if (empty-agenda? the-agenda) 'done
            ; 获取 the-agenda 中第一个 segment 中的 第一个 procedure
            (let ((first-item (first-agenda-item the-agenda)))
                  ; 执行第一个 segment 中的 第一个 procedure
                  (first-item)
                  ; 移除第一个 segment 中的 第一个 procedure
                  (remove-first-agenda-item! the-agenda)
                  ; 继续执行
                  (propagate))))

; 将 action 加入到 agenda 中
; time = delay + current-time
; delay(每个操作都有相应的延迟) + current-time(保存在agenda的第一个对象中, 意为上一次执行的时间)
(define (after-delay delay action)
        (add-to-agenda! (+ delay (current-time the-agenda))
                        action
                        the-agenda))

; 将监听加入到 wire 的 action-procedures 中
(define (probe name wire)
    (add-action! wire
                (lambda ()
                  (newline)
                  (display name)
                  (display " ")
                  (display (current-time the-agenda))
                  (display "  New-value = ")
                  (display (get-signal wire)))))

; 半加器
(define (half-adder a b s c)
        (let ((d (make-wire)) (e (make-wire)))
              (or-gate a b d)
              (and-gate a b c)
              (inverter c e)
              (and-gate d e s)
              'ok))
; 全加器
(define (full-adder a b c-in sum c-out)
        (let ((s (make-wire))
              (c1 (make-wire))
              (c2 (make-wire)))
              (half-adder b c-in s c1)
              (half-adder a s sum c2)
              (or-gate c1 c2 c-out)
              'ok))
