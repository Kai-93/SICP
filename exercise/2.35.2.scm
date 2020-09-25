(load "utils.scm")

; 实现参考
; (define (count-leaves x)
;   (cond ((null? x) 0)
;         ((not (pair? x)) 1)
;         (else (+ (count-leaves (car x))
;                  (count-leaves (cdr x))))))

(define (count-leaves tree)
  (accumulate
    + ; op 的传参数1是当前值, 传参数2是后续累计值
    0
    (map 
      (lambda (item) 
        (if (pair? item)
            (count-leaves item)
            1))
      tree) ; return sequence
  )
)

(count-leaves (list (list 1 2) (list 3 4)))

(count-leaves (list (list 1 (list 2 3)) (list (list 4 5) (list 6 7))))
