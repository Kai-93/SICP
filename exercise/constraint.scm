; 加法 constraint
(define (adder a1 a2 sum)
        (define (process-new-value)
                (cond ((and (has-value? a1) (has-value? a2))
                            (set-value! sum
                                        (+ (get-value a1) (get-value a2))
                                        me))
                      ((and (has-value? a1) (has-value? sum))
                            (set-value! a2
                                        (- (get-value sum) (get-value a1))
                                        me))
                      ((and (has-value? a2) (has-value? sum))
                            (set-value! a1
                                        (- (get-value sum) (get-value a2))
                                        me))))
        (define (process-forget-value)
                (forget-value! sum me)
                (forget-value! a1 me)
                (forget-value! a2 me)
                (process-new-value))

        (define (me request)
                (cond ((eq? request 'I-have-a-value) (process-new-value))
                      ((eq? request 'I-lost-my-value) (process-forget-value))
                      (else (error "Unknown request - ADDER" request))))
        (connect a1 me)
        (connect a2 me)
        (connect sum me)
        me)

; 乘法 constraint
(define (multiplier m1 m2 product)
        (define (process-new-value)
                (cond ((or (and (has-value? m1) (= (get-value m1) 0))
                           (and (has-value? m2) (= (get-value m2) 0)))
                                (set-value! product 0 me))
                      ((and (has-value? m1) (has-value? m2))
                            (set-value! product
                                        (* (get-value m1) (get-value m2))
                                        me))
                      ((and (has-value? product) (has-value? m1))
                            (set-value! m2
                                        (/ (get-value product) (get-value m1))
                                        me))
                      ((and (has-value? product) (has-value? m2))
                            (set-value! m1
                                        (/ (get-value product) (get-value m2))
                                        me))))

        (define (process-forget-value)
                (forget-value! product me)
                (forget-value! m1 me)
                (forget-value! m2 me)
                (process-new-value))

        (define (me request)
                (cond ((eq? request 'I-have-a-value) (process-new-value))
                      ((eq? request 'I-lost-my-value) (process-forget-value))
                      (else (error "Unknown request - MULTIPLIER" request))))

        (connect m1 me)
        (connect m2 me)
        (connect product me)
        me)

; 常量 constraint
(define (constant value connector)
        (define (me request) (error "Unknown request - CONSTANT" request))
        (connect connector me)
        (set-value! connector value me)
        me)

; 创建 connector
(define (make-connector)
        (let ((value false) (informant false) (constraints '()))
              ; 设置 值 和 信息源(设置者)
              (define (set-my-value newval setter)
                      (cond ((not (has-value? me))
                              (set! value newval)
                              (set! informant setter)
                              ; 通知相连的 constraint
                              (for-each-except setter inform-about-value constraints))
                            ((not (= value newval)) (error "Contradiction" (list value newval)))
                            (else 'ignored)))
              ; 置空 connector 的值和信息源
              (define (forget-my-value retractor)
                      (if (eq? retractor informant)
                               (begin (set! informant false)
                                      (for-each-except retractor inform-about-no-value constraints))
                          'ignored))
              ; 连接新的 constraint
              (define (connect new-constraint)
                      (if (not (memq new-constraint constraints))
                          (set! constraints (cons new-constraint constraints)))
                      (if (has-value? me) (inform-about-value new-constraint))
                      'done)
              ; 代表 connector 的 me
              (define (me request)
                      (cond ((eq? request 'has-value?) (if informant true false))
                      ((eq? request 'value) value)
                      ((eq? request 'set-value!) set-my-value)
                      ((eq? request 'forget) forget-my-value)
                      ((eq? request 'connect) connect)
                      (else (error "Unknown operation - CONNECTOR" request))))
        me))

; 通知(procedure)所有 list 中的所有 constraint, 除了exception
(define (for-each-except exception procedure list)
      (define (loop items)
              (cond ((null? items) 'done)
                    ((eq? (car items) exception) (loop (cdr items)))
                    (else (procedure (car items))
                          (loop (cdr items)))))
      (loop list))

; 监听 connector
(define (probe name connector)
        (define (print-probe value)
                (newline)
                (display "Probe: ")
                (display name)
                (display " = ")
                (display value))
        (define (process-new-value) (print-probe (get-value connector)))
        (define (process-forget-value) (print-probe "?"))
        (define (me request)
                (cond ((eq? request 'I-have-a-value) (process-new-value))
                      ((eq? request 'I-lost-my-value) (process-forget-value))
                      (else (error "Unknown request - PROBE" request))))
        (connect connector me)
        me)

; 通知值有了
(define (inform-about-value constraint) (constraint 'I-have-a-value))
; 通知值没了
(define (inform-about-no-value constraint) (constraint 'I-lost-my-value))
; 判断 connector 是否有值
(define (has-value? connector) (connector 'has-value?))
; 获取 connector 的值
(define (get-value connector) (connector 'value))
; 设置 connector 的值和信息源
(define (set-value! connector new-value informant) ((connector 'set-value!) new-value informant))
; 置空 connector 的值和信息源
(define (forget-value! connector retractor) ((connector 'forget) retractor))
; 连接 connector 和新的 constraint
(define (connect connector new-constraint) ((connector 'connect) new-constraint))
