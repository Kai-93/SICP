
; scheme 实现的格式
(map + '(1 2) '(3 4))

; metacircular evaluator 的格式
('map '(procedure +) '(1 2) '(3 4))

; 故解析会有问题
