((lambda (n)
         ((lambda (fact) (fact fact n))
                  (lambda (ft k)
                          (if (= 1 k) 1
                              (* k (ft ft (- k 1)))))))
  10)
