; code from SICP (Structure and Interpretation of Computer Programs)
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
; exercise 1.12
(define (pascal row col)
        (if (or (= col 0) (= col row)) 1
            (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col))))
; exponentiation (n^m)
(define (expt n m) (if (= m 0) 1 (* n (expt n (- m 1)))))
(define (expt n m) (expt-iter n m 1))
(define (expt-iter n m p) (if (= m 0) p (expt-iter n (- m 1) (* n p))))
(define (fast-expt n m) (cond ((= m 0) 1)
                              ((even? m) (square (fast-expt n (/ m 2))))
                              (else (* n (fast-expt n (- m 1))))))
; exercise 1.16
(define (expt-iter-log b n)
        (define (iter a b n)
                (if (= n 0) a
                    (if (even? n) (iter a (* b b) (/ n 2))
                        (iter (* a b) b (- n 1)))))
        (iter 1 b n))
; exercise 1.17
(define (mult-log a b) (if (= b 0) 0
                           (if (even? b) (mult-log (* a 2) (/ b 2))
                               (+ a (mult-log a (- b 1))))))
