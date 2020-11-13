(define (run-forever)
        (run-forever))

(define (try p)
        (if (halts? p p) (run-forever)
            'halted'))

(try try)    

; 1. 假设 (try try) 不停止 => (halts? p p) 为 true => 结果 (try try) 停止
; 假设 和 结果矛盾

; 2. 假设 (try try) 停止 => (halts? p p) 为 false => 结果 (try try) 不停止
; 假设 和 结果矛盾
