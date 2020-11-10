; 在 a) 的基础上, 修改代码以实现在识别大多数表达式之前识别 procedure application
; b) 中说明在调用 procedure application 时, 将新增 call 关键字
; 故用词关键字来实现该逻辑

; 源代码
(define (application? exp) (pair? exp))
; 修改后
(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
