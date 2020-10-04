(load "2.68.scm")
(load "2.69.scm")

(define tree (generate-huffman-tree '((A 1) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(define msg-1 '(Get a job)) ; 3
(define encode-msg1 (encode msg-1 tree))
(display encode-msg1)
(length encode-msg1)

(define msg-2 '(Sha na na na na na na na na)) ; 9
(define encode-msg2 (encode msg-2 tree))
(display encode-msg2)
(length encode-msg2)

(define msg-3 '(Wah yip yip yip yip yip yip yip yip yip)) ; 10
(define encode-msg3 (encode msg-3 tree))
(display encode-msg3)
(length encode-msg3)

(define msg-4 '(Sha boom)) ; 2
(define encode-msg4 (encode msg-4 tree))
(display encode-msg4)
(length encode-msg4)

; variable-length code: 14*2 + 12*2 + 23 + 9 = 84
; fixed-length code: 3 * (3*2 + 9*2 + 10 + 2) = 108
