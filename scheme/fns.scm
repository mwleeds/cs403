; an iterative fibonacci function
(define (fib-iter last current count n)
              (if (= count n) current
                  (fib-iter current (+ last current) (+ 1 count) n)))
(define (fib x) (if (= x 0) 0 (fib-iter 0 1 1 x)))
; exercise 1.11 - recursive
(define (f1 n) (if (< n 3) n
                  (+ (f1 (- n 1)) (* 2 (f1 (- n 2))) (* 3 (f1 (- n 3))))))
; exercise 1.11 - iterative
(define (f-iter three_back two_back one_back current n)
        (if (= current n) (+ one_back (* 2 two_back) (* 3 three_back))
            (f-iter two_back one_back (+ one_back (* 2 two_back) (* 3 three_back)) (+ current 1) n)))
(define (f2 n) (if (< n 3) n (f-iter 0 1 2 3 n)))
