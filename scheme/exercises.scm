; code from in class and out of class
(define (avg-iter sum L num)
        (if (null? L) (/ sum num)
            (avg-iter (+ sum (car L)) (cdr L) (+ num 1))))
(define (average L) (avg-iter 0 L 0))
(define (square x) (* x x))
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
; apply a list of functions to a value
(define (applyall list_fns val) (if (null? list_fns) list_fns (cons ((car list_fns) val) (applyall (cdr list_fns) val))))
; merge sort
(define (mergesort L) (if (or (null? L) (null? (cdr L))) L
                          (merge (map mergesort (split L '() '())))))
(define (split L L1 L2) (if (null? L) (list L1 L2)
                            (if (null? (cdr L)) (list (cons (car L) L1) L2)
                                (split (cddr L) (cons (car L) L1) (cons (cadr L) L2)))))
(define (merge L) (let ((L1 (car L)) (L2 (cadr L)))
                       (cond ((null? L1) L2)
                             ((null? L2) L1)
                             ((< (car L1) (car L2)) (cons (car L1) (merge (list (cdr L1) L2))))
                             (#t (cons (car L2) (merge (list L1 (cdr L2))))))))
; find m^n, n >= 0 (for integers)
(define (power m n) (cond ((= n 0) 1)
                          ((= n 1) m)
                          (#t (* m (power m (- n 1))))))
