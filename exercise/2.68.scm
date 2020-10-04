(load "2.67.scm")

(define (symbol-in-tree? symbol tree)
  (cond ((null? tree) #f)
        ((leaf? tree) (eq? symbol (symbol-leaf tree)))
        (else (or (symbol-in-tree? symbol (left-branch tree))
                  (symbol-in-tree? symbol (right-branch tree))))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((symbol-in-tree? symbol (left-branch tree))
          (cons 0 (encode-symbol symbol (left-branch tree))))
        ((symbol-in-tree? symbol (right-branch tree))
          (cons 1 (encode-symbol symbol (right-branch tree))))
        (else
          (error "This symbol not in tree: " symbol))))

(define (encode message tree)
     (if (null? message) '()
         (append (encode-symbol (car message) tree)
                 (encode (cdr message) tree))))


; (encode message sample-tree)
