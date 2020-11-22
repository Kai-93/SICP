(define (for-each proc items)
        (if (null? items) 'done
        (begin (proc (car items))
               (for-each proc (cdr items)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

; Cy's procedure
(define (eval-sequence exps env)
        (cond ((last-exp? exps) (eval (first-exp exps) env))
              (else (actual-value (first-exp exps) env)
                    (eval-sequence (rest-exps exps) env))))


; procedure in the text
; 执行 exps 中所有表达式
(define (eval-sequence exps env)
        ; 若 exps 中只有一个表达式, 则执行
        (cond ((last-exp? exps) (eval (first-exp exps) env))
              ; 继续执行 exps 中的第一个表达式, 并继续执行后续表达式
              (else (eval (first-exp exps) env)
                    (eval-sequence (rest-exps exps) env))))



; b)
(define (p1 x)
        (set! x (cons x '(2)))
        x)

(define (p2 x)
        (define (p e) e x)
        (p (set! x (cons x '(2)))))
; Cy's procedure: (1 (2))
; procedure in the text: (1 (2))
(p1 1) 

; Cy's procedure: (1 (2))
; procedure in the text: (1 (2))
(p2 1)
