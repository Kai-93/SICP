; 书中的 demo
; (define (eval exp env)
;      (cond ((self-evaluating? exp) exp)
;            ((variable? exp) (lookup-variable-value exp env))
;            ((quoted? exp) (text-of-quotation exp))
;            ((assignment? exp) (eval-assignment exp env))
;            ((definition? exp) (eval-definition exp env))
;            ((if? exp) (eval-if exp env))
;            ((lambda? exp)
;             (make-procedure (lambda-parameters exp)
;                             (lambda-body exp)
;                             env))
;            ((begin? exp)
;             (eval-sequence (begin-actions exp) env))
;            ((cond? exp) (eval (cond->if exp) env))
;            ((application? exp)
;             (apply (eval (operator exp) env)
;                    (list-of-values (operands exp) env)))
;            (else
;             (error "Unknown expression type - EVAL" exp))))

; 把 procedure application 放到 assignment 前
(define (eval exp env)
        (cond ((self-evaluating? exp) exp)
              ((variable? exp) (lookup-variable-value exp env))
              ((quoted? exp) (text-of-quotation exp))
              ; 修改之后的代码
              ((application? exp)
                  (apply (eval (operator exp) env)
                         (list-of-values (operands exp) env)))
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
              ((application? exp)
                (apply (eval (operator exp) env)
                      (list-of-values (operands exp) env)))
              (else
                (error "Unknown expression type - EVAL" exp))))

(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (list-of-values exps env)
        (if (no-operands? exps) '()
            (cons (eval (first-operand exps) env)
                  (list-of-values (rest-operands exps) env))))


; 在 eval 下面代码时
; 将先判断 (application? '(define x 3)) => (pair? '(define x 3)), 其值为 #t
; 而后 (eval (operator exp) env) => (eval (car exp) env) => (eval define env) 
; 将 define 作为 procedure application 执行, x 3 成为了参数

(define x 3)
