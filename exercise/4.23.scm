
; Analyze-sequence procedure in the text.
(define (analyze-sequence exps)
        (define (sequentially proc1 proc2)
                (lambda (env) (proc1 env) (proc2 env)))
        ; 
        (define (loop first-proc rest-procs)
                (if (null? rest-procs) first-proc
                    (loop (sequentially first-proc (car rest-procs)) ; 返回一个 lambda
                          (cdr rest-procs))))
        ; 执行逻辑
        (let ((procs (map analyze exps)))
              (if (null? procs) (error "Empty sequence - ANALYZE"))
              (loop (car procs) (cdr procs))))  

; Alyssa's analyze-sequence procedure
(define (analyze-sequence exps)
        (define (execute-sequence procs env)
                (cond ((null? (cdr procs)) ((car procs) env))
                      (else ((car procs) env) (execute-sequence (cdr procs) env))))
        (let ((procs (map analyze exps)))
              (if (null? procs) (error "Empty sequence - ANALYZE"))
              (lambda (env) (execute-sequence procs env))))


; 若 exps 中有四个子表达式
; 正文中的代码将会返回如下结构
; analyze 时返回如下结构, 以及是展开的结构
(lambda (env) 
        ((lambda (env)
                 ((lambda (env) 
                          (p1 env)
                          (p2 env)) env)
                 (p3 env)
        ) env)
        (p4 env))   

; Alyssa 的 procedure 将会给出如下结构
; analyze 时返回如下结构, 运行时在进一步展开
(lambda (env) 
        (execute-sequence (p1 p2 p3 p4) env))
