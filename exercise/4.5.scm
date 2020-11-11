; <test> => <recipient>
; <test> 其值若为 true, 其值将传递给 <recipient> 进行求值

; (assoc 'b '((a 1) (b 2)) 的结果是 (b 2)
; (cadr (b 2)) 的结果是 2
(cond ((assoc 'b '((a 1) (b 2))) => cadr)
      (else false))

; 本体要求修改 cond 的处理逻辑, 时期支持上述格式的 cond

; 修改如下思路如下
; 1/判断
(define (is-additional-clause-of-cond? clause) (eq? (cadr clause) '=>))
; 2/获取 predicate
(define (get-predicate-of-additional-clause-of-cond clause) (car clause))
; 3/获取 clause 的 action
(define (get-action-of-additional-clause-of-cond clause) (caddr clause))
; 4/组成,执行 cond

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
                      ; 判断是否是新的形式
                      (if (is-additional-clause-of-cond? first)
                              (let ((parameter (apply (get-predicate-of-additional-clause-of-cond first))))
                                    (make-if ((parameter)
                                             (apply ((get-action-of-additional-clause-of-cond first) parameter))
                                             (expand-clauses rest))))
                          ; 派生 cond 的 clauses
                          (make-if (cond-predicate first)
                                  (sequence->exp (cond-actions first))
                                  (expand-clauses rest)))))))

