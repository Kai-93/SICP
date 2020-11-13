(define (letrec? exp)
  (tagged-list exp 'letrec))
(define (letrec-bindings exp)
  (cadr exp))
(define (letrec-binding-vars exp)
  (map car (letrec-bindings exp)))
(define (letrec-binding-vals exp)
  (map cadr (letrec-bindings exp)))
(define (letrec-body exp)
  (cddr exp))

(define (make-unassigned-bindings vars)
  (map (lambda (var) (cons var '*unassigned*)) vars))

(define (make-set-clauses vars vals)
  (map (lambda (var val) (list 'set! var val)) vars vals))


(define (letrec->let exp)
  (let ((vars (letrec-binding-vars exp))
        (vals (letrec-binding-vals exp)))
    (make-let (make-unassigned-bindings vars)
              (append (make-set-clauses vars vals)
                      (letrec-body exp)))))
