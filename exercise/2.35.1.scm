(load "utils.scm")

; 实现参考
; (define (count-leaves x)
;   (cond ((null? x) 0)
;         ((not (pair? x)) 1)
;         (else (+ (count-leaves (car x))
;                  (count-leaves (cdr x))))))

;;; 28-fringe.scm
(define (fringe tree)
    (cond ((null? tree)                         ; 空树
            '())
          ((not (pair? tree))                   ; 叶子
            (list tree))
          (else
            (append (fringe (car tree))         ; 累积左子树所有元素
                    (fringe (cadr tree))))))    ; 累积右子树所有元素

(define (count-leaves tree)
  (accumulate
    (lambda (x y) (+ 1 y)) ; op 的传参数1是当前值, 传参数2是后续累计值
    0
    (fringe tree)))


(count-leaves (list (list 1 2) (list 3 4)))

(count-leaves (list (list 1 (list 2 3)) (list (list 4 5) (list 6 7))))
