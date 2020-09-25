; (h/3) * (y0 +4*y1 +2*y2 +4*y3 +2*y4 +...+2*yn−2 +4*yn−1 + yn) 
; h=(b−a)/n
; n为偶数时, yk = f(a+kh)


(load "1.29.before.scm")
; (load "1.30.scm")

(define (even? n) (= (remainder n 2) 0))

(define (simpson f a b n)

    (define h (/ (- b a) n))

    (define (y k) (f (+ a (* k h))))

    (define (factor k)
        (cond ((or (= k 0) (= k n)) 1)
              ((even? k) 2)
              (else 4)))
              
    (define (next k) (+ k 1))

    (define (item k) (* (factor k) (y k)))

    (if (not (even? n))
      (error "n can't be odd")
      (* (/ h 3) 
        (sum item (exact->inexact 0) next n))))

(define (cube x) (* x x x))

(trace-entry sum)

(simpson cube 0 1 100)


