
; eval-and
(define (eval-and exp env) 
        (if (null? exp) #t ; (and ) 返回 true
            ; 判断 第一个表达式, 若为 false, 则返回, 若为 true, 则继续判断后面的
            (and (eval (car exp) env)
                 (eval-and exp env)))) 

; eval-or
(define (eval-or exp env)
        (if (null? exp) #f ; (or ) 返回 false
            ; 判断 第一个表达式, 若为 true, 则返回, 若为 falsse, 则继续判断后面的
            (or (eval (car exp) env)
                (eval-or exp env))))



; derived expression, 派生表达式的意思是, 在实现方法的过程中使用了语法转换, 使用了其他的方法
; 以下是以派生的形式实现的
(define (eval-and exp env) 
        (if (null? exp) #t ; (and ) 返回 true
            ; 判断 第一个表达式, 若为 false, 则返回, 若为 true, 则继续判断后面的
            (make-if (eval (car exp) env)
                     #f
                     (eval-and exp env))))

(define (eval-or exp env)
        (if (null? exp) #f ; (or ) 返回 false
            ; 判断 第一个表达式, 若为 true, 则返回, 若为 falsse, 则继续判断后面的
            (make-if (eval (car exp) env)
                     #t
                     (eval-or exp env))))

