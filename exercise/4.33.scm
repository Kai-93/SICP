; 判断是否是以引号开头, 被引号的表达式
(define (quoted? exp) (tagged-list? exp 'quote))

 (define (eval exp env) 
     (if (quoted? exp) (quote->lazy-list exp env) 
         ...)) 


(define (text-of-quotation exp) (cadr exp))

(define (quote->lazy-list exp)
        (define (iter text)
          (if (null? text) (list 'quote '())
              (list 'cons (list 'quote (car text))
                          (iter (cdr text)))))

        (let ((text (text-of-quotation exp))
              (if (quoted? text) (iter text)
                  text)))
