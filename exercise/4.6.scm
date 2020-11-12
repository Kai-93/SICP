
; (let ((〈var1〉 〈exp1〉) ... (〈varn〉 〈expn〉))
; 〈body〉)
; 上面等同于下面
; ((lambda (〈var1〉 ... 〈varn〉) 〈body〉)
;   〈exp1〉
;    ...
;   〈expn〉)


; 是否是 let 表达式
(define (let? exp) (tagged-list? exp 'let))
; 获取 let 表达式中的变量名
(define (get-variables-of-let-exp exp)
        (let ((pairs cadr exp))
             (map car pairs)))
; 获取 let 表达式中的变量名对应的表达式
(define (get-values-of-let-exp exp)
        (let ((pairs cadr exp))
             (map cadr pairs)))
; 获取 let 表达式中的函数体
(define (get-body-of-let-exp exp) (cddr exp))

; 派生新的 let 表达式, 
(define (let->combination exp) 
        ((make-lambda (get-variables-of-let-exp exp)
                      (get-body-of-let-exp exp))
        (get-values-of-let-exp exp)))

(define (make-let variables-and-values body)
        (list 'let variables-and-values body))

; eval 的实现
(define (eval exp env)
     (cond ((self-evaluating? exp) exp)
           ((variable? exp) (lookup-variable-value exp env))
           ((quoted? exp) (text-of-quotation exp))
           ((assignment? exp) (eval-assignment exp env))
           ((definition? exp) (eval-definition exp env))
           ((if? exp) (eval-if exp env))
           ((lambda? exp)
                (make-procedure (lambda-parameters exp)
                                (lambda-body exp)
                                env))
           ((begin? exp)
                (eval-sequence (begin-actions exp) env))
           ((cond? exp) (eval (cond->if exp) env))
           ((let? exp) (eval (let->combination exp) env))
           ((application? exp)
                (apply (eval (operator exp) env)
                      (list-of-values (operands exp) env)))
           (else (error "Unknown expression type - EVAL" exp))))
