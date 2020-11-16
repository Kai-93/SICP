; 执行 exps 中所有操作数
(define (list-of-values exps env)
        (if (no-operands? exps) '()
                  ; 从 exps 中取出第一个被操作数, 并执行
            (cons (eval (first-operand exps) env) 
                  ; 继续执行后续操作
                  (list-of-values (rest-operands exps) env))))


; 执行 exps 中所有表达式
(define (eval-sequence exps env)
           ; 若 exps 中只有一个表达式, 则执行
     (cond ((last-exp? exps) (eval (first-exp exps) env))
           ; 继续执行 exps 中的第一个表达式, 并继续执行后续表达式
           (else (eval (first-exp exps) env)
                 (eval-sequence (rest-exps exps) env))))


; 处理赋值操作
 (define (eval-assignment exp env)
         (set-variable-value! (assignment-variable exp)
                              (eval (assignment-value exp) env)
                              env)
          'ok)


; 处理定义操作
 (define (eval-definition exp env)
         (define-variable! (definition-variable exp)
                          (eval (definition-value exp) env)
                          env)
          'ok)


; 判断是否是 self-evaluating?
; 即判断是否是 number or string
(define (self-evaluating? exp)
        (cond ((number? exp) true)
              ((string? exp) true)
              (else false)))


; 判断是否是变量
(define (variable? exp) (symbol? exp))


; 判断是否是以引号开头, 被引号的表达式
(define (quoted? exp) (tagged-list? exp 'quote))


; 是被引号的表达式的前提下, 获取引号内的内容
(define (text-of-quotation exp) (cadr exp))


; identifies lists beginning with a designated symbol
; 识别列表第一个元素是否与 tag 相等
(define (tagged-list? exp tag)
        (if (pair? exp) (eq? (car exp) tag)
            #f))


; 判断是否是赋值操作
(define (assignment? exp) (tagged-list? exp 'set!))
; 获取赋值的变量名
(define (assignment-variable exp) (cadr exp))
; 获取需要赋值的值
(define (assignment-value exp) (caddr exp))


; 判断是否是定义操作
(define (definition? exp) (tagged-list? exp 'define))
; 获取定义的变量
(define (definition-variable exp)
        (if (symbol? (cadr exp)) (cadr exp)
            (caadr exp)))
; 获取需要定义的值
(define (definition-value exp)
        (if (symbol? (cadr exp)) (caddr exp)
            (make-lambda (cdadr exp)   ; formalparameters
                         (cddr exp)))) ; body


; 判断是否是 lambda 表达式
(define (lambda? exp) (tagged-list? exp 'lambda))
; 获取 lambda 表达式的参数
(define (lambda-parameters exp) (cadr exp))
; 获取 lambda 表达式的函数体
(define (lambda-body exp) (cddr exp))
; 派生新的 lambda 表达式
 (define (make-lambda parameters body)
         (cons 'lambda (cons parameters body)))


; 判断是否是 if 的表达式
(define (if? exp) (tagged-list? exp 'if))
; 获取 if 表达式的 predicate 
(define (if-predicate exp) (cadr exp))
; 获取 if 表达式的 consequent 
(define (if-consequent exp) (caddr exp))
; 获取 if 表达式的 alternative  
(define (if-alternative exp)
        (if (not (null? (cdddr exp))) (cadddr exp)
            #f))
; 派生新的 if 表达式
(define (make-if predicate consequent alternative)
        (list 'if predicate consequent alternative))
; 求值 if 表达式
(define (eval-if exp env)
        (if (true? (eval (if-predicate exp) env))
            (eval (if-consequent exp) env)
            (eval (if-alternative exp) env)))


; 是否是 begin 表达式
(define (begin? exp) (tagged-list? exp 'begin))
; 获取 begin 表达式中的 子表达式
(define (begin-actions exp) (cdr exp))
; 判断 sequence 中是否只包含一个表达式了
(define (last-exp? seq) (null? (cdr seq)))
; 获取 sequence 中第一个表达式
(define (first-exp seq) (car seq))
; 获取除去第一个表达式之外的剩余表达式
(define (rest-exps seq) (cdr seq))
; 将 sequence 转换成表达式
(define (sequence->exp seq)
        (cond ((null? seq) seq) ((last-exp? seq) (first-exp seq))
              (else (make-begin seq))))
; 派生新的 begin 表达式
(define (make-begin seq) (cons 'begin seq))


; 判断是否是 application(应用)
(define (application? exp) (pair? exp))
; 获取表达式的操作符号(计算符号)
(define (operator exp) (car exp))
; 获取表达式的操作数
(define (operands exp) (cdr exp))
; 操作数是否为空
(define (no-operands? ops) (null? ops))
; 获取第一个操作数
(define (first-operand ops) (car ops))
; 获取出第一个操作数外的余下的操作数
(define (rest-operands ops) (cdr ops))


; 判断是否是 cond 表达式
(define (cond? exp) (tagged-list? exp 'cond))
; 获取 cond 的细则
(define (cond-clauses exp) (cdr exp))
; 判读是否是 cond 表达式的 else 表达式
(define (cond-else-clause? clause)
        (eq? (cond-predicate clause) 'else))
; 获取 cond 表达式的 predicate
(define (cond-predicate clause) (car clause))
; 获取 cond 中某种情况的 action
(define (cond-actions clause) (cdr clause))
; 将派生 cond
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
; 处理 cond 的细则
(define (expand-clauses clauses)
        (if (null? clauses) 'false ; no else clause 
            (let ((first (car clauses)) ; 第一个条款
                  (rest (cdr clauses))) ; 余下的条款
                  (if (cond-else-clause? first) ; 若是 else 表达式
                            (if (null? rest) ; 若 rest 为空
                                    (sequence->exp (cond-actions first)) ; 执行 sequence 中的表达式
                                (error "ELSE clause isn’t last - COND->IF" clauses))
                      ; 派生 cond 的 clauses
                      (make-if (cond-predicate first)
                               (sequence->exp (cond-actions first))
                               (expand-clauses rest))))))


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
           ((application? exp)
                (apply (eval (operator exp) env)
                      (list-of-values (operands exp) env)))
           (else (error "Unknown expression type - EVAL" exp))))

; 解析表达式, 没有求值逻辑
; 进行语法分析, 返回 procedure
(define (analyze exp)
        (cond ((self-evaluating? exp)
               (analyze-self-evaluating exp))
               ((quoted? exp) (analyze-quoted exp))
               ((variable? exp) (analyze-variable exp))
               ((assignment? exp) (analyze-assignment exp))
               ((definition? exp) (analyze-definition exp))
               ((if? exp) (analyze-if exp))
               ((lambda? exp) (analyze-lambda exp))
               ((begin? exp) (analyze-sequence
                              (begin-actions exp)))
               ((cond? exp) (analyze (cond->if exp)))
               ((application? exp) (analyze-application exp))
               (else (error "Unknown expression type - ANALYZE" exp))))



; apply 的实现
(define (apply procedure arguments)
        (cond ((primitive-procedure? procedure)
                    (apply-primitive-procedure procedure arguments))
              ((compound-procedure? procedure)
                    (eval-sequence (procedure-body procedure)
                                   (extend-environment (procedure-parameters procedure)
                                                       arguments
                                                       (procedure-environment procedure))))
              (else (error "Unknown procedure type - APPLY" procedure))))
