(load "utils.scm")

;;; 33-map.scm
; (define (map p sequence)
;     (if (null? sequence)
;         '()
;         (cons (p (car sequence))
;               (map p (cdr sequence)))))

(define (map p sequence)
  (accumulate
    ; x是当前值, y是后续累计值
    (lambda (x y) (cons (p x) y))
    ()
    sequence))

(map square (list 1 2 3))


;;; 33-append.scm
; (define (append list1 list2)
;     (if (null? list1)
;         list2
;         (cons (car list1)
;               (append (cdr list1) list2))))

(define (append seq1 seq2) 
  (accumulate
    cons ; cons的传参数1是当前值, 传参数2是后续累计值
      seq2; 初始值
      seq1; 序列
  )
)

(append (list 1 2 3) (list 4 5 6))

(length (list 1 2 3))

