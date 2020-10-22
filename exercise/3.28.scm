(load "digital_simulator.scm")

(define input-1 (make-wire))              ; 创建三条线路

;Value: input-1

(define input-2 (make-wire))

;Value: input-2

(define output (make-wire))

;Value: output

(or-gate input-1 input-2 output)          ; 将线路连接到 or-gate

;Value: ok

(propagate)                               ; 执行模拟

;Value: done

(get-signal output)                       ; 因为线路的默认信号值为 0 ，所以 output 线路的值为 (logical-or 0 0) 等于 0

;Value: 0

(set-signal! input-1 1)                   ; 将其中一条输入线路的信号值设置为 1

;Value: done

(propagate)                               ; 再次执行模拟

;Value: done

(get-signal output)
