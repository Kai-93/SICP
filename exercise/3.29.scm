(load "digital_circuit_simulator.scm")

(define (or-gate a1 a2 a3)
  (let ((x (make-wire))
        (y (make-wire))
        (z (make-wire)))
        (inverter a1 x)
        (inverter a2 y)
        (and-gate x y z)
        (inverter z a3))
  'ok)


(define input-1 (make-wire))              ; 定义三条线路

;Value: input-1

(define input-2 (make-wire))

;Value: input-2

(define output (make-wire))

;Value: output

(or-gate input-1 input-2 output)          ; 连接线路到 or-gate 上

;Value: ok

(propagate)                               ; 执行模拟

;Value: done

(get-signal output)                       ; 因为两条输入线路的值都是默认的 0 ，所以 output 的信号为 (logical-or 0 0) 等于 0

;Value: 0

(set-signal! input-1 1)                   ; 将其中一条输入线路的值设置为 1

;Value: done

(propagate)                               ; 重新执行模拟

;Value: done

(get-signal output)                       ; 这次两条输入线路的值分别是 1 和 0 ，所以 output 的信号为 (logical-or 1 0) 等于 1

;Value: 1
