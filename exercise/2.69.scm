(load "2.67.scm")

;带权重元素的集合
(define (adjoin-set x set)
  (cond
    ((null? set) (list x))
    ((< (weight x) (weight (car set))) (cons x set))
    (else (cons (car set) (adjoin-set x (cdr set))))))

; transform (symbol weight) to ('leaf symbol weight)
(define (make-leaf-set pairs)
  (if (null? pairs) '()
      (let ((pair (car pairs)))
            ; add new pair to pairs
            (adjoin-set (make-leaf (car pair) ; symbol
                                   (cadr pair)) ; weight
                        (make-leaf-set (cdr pairs))))))


; (define (successive-merge pairs)
;   (cond ((= 0 (length pairs)) '())
;         ((= 1 (length pairs)) (car pairs))
;         (else (make-code-tree (car pairs) (successive-merge (cdr pairs))))))


(define (successive-merge pairs)
  (cond ((= 0 (length pairs)) '())
        ((= 1 (length pairs)) (car pairs))
        (else (let ((new-subtree (make-code-tree (car pairs) (cadr pairs))) ; 将前两个组成一个平衡树
                    (remainder-pairs (cddr pairs))) ; 除去前两个之后的 pairs
                   ; 新树 与 剩下的 pairs 排序成新的有序的 pairs
                   (successive-merge (adjoin-set new-subtree remainder-pairs))))))


(define (generate-huffman-tree pairs)
        (successive-merge (make-leaf-set pairs)))

(define pairs '((A 1) (B 1) (C 1) (D 1)))

(generate-huffman-tree pairs)


