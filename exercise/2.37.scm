(load "utils.scm")
(load "2.36.scm")
(load "2.27.scm")


(define m (list (list 1 2 3 4)
                (list 4 5 6 6)
                (list 6 7 8 9)))

(define v (list 1 2 3 4))


; 两个向量的乘积之和
(define (dot-product v w) 
  (accumulate + 0 (map * v w)))


; 矩阵与向量的乘积
(define (matrix-*-vector m v) (map (lambda (col) (dot-product col v)) m))

(matrix-*-vector m v)


; 矩阵变换
(define (transpose mat) (accumulate-n cons '() mat))

(transpose m)

(define (vectoer-product v m) 
  (map (lambda (col) (dot-product v col)) m))

(vectoer-product v v)

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (col) (vectoer-product col cols)) m)))

(matrix-*-matrix m (transpose m))
