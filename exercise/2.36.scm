(load "utils.scm")

(define (car-n seqs) (map car seqs))
(define (cdr-n seqs) (map cdr seqs))

(define (accumulate-n op init seqs)
  (if (null? (car seqs)) '()
      (cons 
        ; 抽取 各子序列 的 第n个元素 组成 新序列
        (accumulate op init (car-n seqs)) 
        ; 计算各序列后面的元素
        (accumulate-n op init (cdr-n seqs))
      )
  )
) 

(accumulate-n + 0 (list (list 1 2 3)
                        (list 4 5 6)
                        (list 7 8 9)
                        (list 10 11 12)))
