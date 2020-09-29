(define frame1 (list 1 2 3))

; (car frame1)
; (cadr frame1)
; (caddr frame1)

(define (origin-of-frame1 f)
    (car f))

(define (edge1-of-frame1 f)
    (cadr f))

(define (edge2-of-frame1 f)
    (caddr f))
  
(origin-of-frame1 frame1)
(edge1-of-frame1 frame1)
(edge2-of-frame1 frame1)


(define frame2 (cons 1 (cons 2 3)))

; (car frame2)
; (cadr frame2)
; (cddr frame2)

(define (origin-of-frame2 f)
    (car f))

(define (edge1-of-frame2 f)
    (cadr f))

(define (edge2-of-frame2 f)
    (cddr f))


(origin-of-frame2 frame2)
(edge1-of-frame2 frame2)
(edge2-of-frame2 frame2)
