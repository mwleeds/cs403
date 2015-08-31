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
; mapping functions to lists
(define (map f L) (if (null? L) L
                      (cons (f (car L)) (map f (cdr L)))))
; fold lists by applying binary operators
(define (foldr f id L) (if (null? L) id
                           (f (car L) (foldr f id (cdr L)))))
(define (foldl f id L) (if (null? L) id
                           (foldl f (f (car L) id) (cdr L))))
; filter lists using predicates
(define (even? x) (= (modulo x 2) 0))
(define (odd? x) (not (even? x)))
(define (filter f L) (if (null? L) L
                         (if (f (car L)) (cons (car L) (filter f (cdr L)))
                             (filter f (cdr L)))))
; tree traversal
; nodes are (value (left_subtree) (right_subtree))
(define (left T) (cadr T))
(define (right T) (caddr T))
(define (inorder T) (if (null? T) T
                        (append (append (inorder (left T)) (list (car T)))
                                (inorder (right T)))))
(define (preorder T) (if (null? T) T
                         (append (append (list (car T)) (preorder (left T)))
                                 (preorder (right T)))))
(define (postorder T) (if (null? T) T
                          (append (append (postorder (left T)) (postorder (right T)))
                                  (list (car T)))))
