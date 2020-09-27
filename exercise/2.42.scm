(load "utils.scm")
(load "2.40.scm")
; 坐标说明, 在list是的下标为x, 其值为y


; 将新的坐标加入坐标集中
(define (adjoin-position y replaced-queens) 
  (cons y replaced-queens))


; 返回空的坐标集
(define empty-board '())


; 某个坐标是否安全
(define (is-safe? new-x new-y current-x current-y)
  (not 
    (or 
      (= current-y new-y)
      (= (abs (- current-y new-y)) (abs (- current-x new-x))))))


; 递归判断坐标是否安全
(define (item-safe? new-x new-y current-x rest-positions)
 (if (null? rest-positions) #t
   (let ((current-y (car rest-positions)))
    (if (is-safe? new-x new-y current-x current-y)
        (item-safe? new-x new-y (+ current-x 1) (cdr rest-positions))
      #f))))


; 新坐标在坐标集中是否安全
(define (safe? new-y positions)
  (item-safe? (+ (length positions) 1) new-y 1 positions))


; 返回n*n格棋盘上放置n个皇后的所有方法
(define (queens board-size)
  (define (queen-cols k)
    (if 
      (= k 0)
      '()
      (filter
        (lambda (item) (not (null? item)))
        (flatmap
          ; 返回规格是K的所有组合的坐标集
          (lambda (rest-of-queens)
            (map
              ; 将新坐标加入坐标集中
              (lambda (new-row)
                (if (safe? new-row rest-of-queens)
                  (adjoin-position new-row rest-of-queens)
                  '()))
              ; (list 1 board-size)
              (enumerate-interval 1 board-size)))
        ; k-1规格棋盘的揭发
        (queen-cols (- k 1))))))
  (queen-cols board-size))

(define board-size 8)

(define (queen-cols k)
  (if 
    (= k 0) (list '())
    (filter
      (lambda (item) (not (null? item)))
      (flatmap
        (lambda (rest-of-queens)
          (map
            (lambda (new-row) 
              (if (safe? new-row rest-of-queens)
                (adjoin-position new-row rest-of-queens)
                '()))
            (enumerate-interval 1 board-size)))
        (queen-cols (- k 1))
      )
    )
  )
)

;  (flatmap
;   (lambda (rest-of-queens)
;     (map
;       (lambda (new-row) 
;         (if (safe? new-row rest-of-queens)
;           (adjoin-position new-row rest-of-queens)
;           '()))
;       (enumerate-interval 1 board-size)))
;   (list '())
; )

(for-each
  (lambda (pos)
    (begin
      (display pos)
      (newline)))
  (queen-cols 7))


