; code from in class and out of class
(define (average L)
        (define (avg-iter sum L num)
                (if (null? L) (/ sum num)
                    (avg-iter (+ sum (car L)) (cdr L) (+ num 1))))
        (avg-iter 0 L 0))
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
(define (reject f L) (if (null? L) L
                         (if (f (car L)) (reject f (cdr L))
                             (cons (car L) (reject f (cdr L))))))

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

; find n such that m^n = q (assume m, n, and q are integers)
(define (log-iter m q guess) (if (= (power m guess) q) guess
                                 (log-iter m q (+ guess 1))))
(define (log m q) (if (or (= q 0) (= m 0) (= m 1)) 0 ; error
                      (log-iter m q 0)))

; Pascal's triangle
(define (pascal row col)
        (if (or (= col 0) (= col row)) 1
            (+ (pascal (- row 1) (- col 1)) (pascal (- row 1) col))))
; find combination n choose k using Pascal's triangle
(define (comb1 n k) (if (> k n) 0 (pascal n k)))
; find a factorial
(define (factorial n)
        (define (iter product counter)
                (if (> counter n) product
                    (iter (* product counter) (+ counter 1))))
        (iter 1 1))
; find combination n choose k using factorials
(define (comb2 n k) (if (> k n) 0 
                        (/ (factorial n) 
                           (* (factorial k) 
                              (factorial (- n k)))))) 

; insertion sort a list
(define (insertion_sort L) (define (insert_into L val) (cond ((null? L) (list val))
                                                             ((< val (car L)) (cons val L))
                                                             (#t (cons (car L) (insert_into (cdr L) val)))))
                           (define (insertion_helper sorted unsorted) (if (null? unsorted) sorted
                                                                          (insertion_helper (insert_into sorted (car unsorted)) (cdr unsorted))))
         (insertion_helper '() L))

; selection sort
; index_min is the smallest number between index_unsorted and index_current
; index_current is the next number to be examined
; index_unsorted is the first number that isn't necessarily in order
(define (selection_sort L) (define (selection_helper l index_min index_current index_unsorted)
                                   (if (or (>= index_unsorted (- (length l) 1)) (< (length l) 2)) l ; sorted or trivial
                                       (if (= index_current (length l)) ; finished this pass
                                           (selection_helper (append (sublist l 0 index_unsorted) ; move the min to the front
                                                                     (list (list-ref l index_min))
                                                                     (sublist l index_unsorted index_min)
                                                                     (sublist l (+ index_min 1) (length l)))
                                                             (+ index_unsorted 1)
                                                             (+ index_unsorted 2)
                                                             (+ index_unsorted 1))
                                           (if (< (list-ref l index_current) (list-ref l index_min))
                                               (selection_helper l index_current (+ index_current 1) index_unsorted)
                                               (selection_helper l index_min (+ index_current 1) index_unsorted)))))
                           (selection_helper L 0 1 0))

; quick sort taken from http://rosettacode.org/wiki/Quick_Sort#Scheme
(define (split-by l p k)
        (let loop ((low '()) (high '()) (l l))
        (cond ((null? l) (k low high))
              ((p (car l)) (loop low (cons (car l) high) (cdr l)))
              (else (loop (cons (car l) low) high (cdr l))))))
 
(define (quicksort l gt?)
        (if (null? l) '()
            (split-by (cdr l) 
                      (lambda (x) (gt? x (car l)))
                      (lambda (low high)
                              (append (quicksort low gt?)
                                      (list (car l))
                                      (quicksort high gt?))))))

; seach a Binary Search Tree for a value
(define (member? x T) (cond ((null? T) #f)
                            ((eqv? x (car T)) #t)
                            ((< x (car T)) (member? x (left T)))
                            (else (member? x (right T)))))

; insert a value into a Binary Search Tree (assume no duplicates)
(define (insert x T) (cond ((null? T) (list x))
                           ((< x (car T)) (list (car T) (insert x (left T)) (right T)))
                           (#t (list (car T) (left T) (insert x (right T))))))

; remove a value from a Binary Search Tree
(define (remove x T) (cond ((null? T) T)
                           ((eqv? x (car T)) '())
                           ((< x (car T)) (list (car T) (remove x (left T)) (right T)))
                           (else (list (car T) (left T) (remove x (right T))))))

; apply each function in the first list to the corresponding element in the second list
; assume (= (length list_fns) (length list_vals))
(define (applyeach list_fns list_vals) 
        (define (applyeach_helper list_fns list_vals list_ret)
                (if (null? list_fns) list_ret
                    (applyeach_helper (cdr list_fns) (cdr list_vals) (append list_ret (list ((car list_fns) (car list_vals)))))))
        (applyeach_helper list_fns list_vals '()))

; return #t iff all values in L satisfy the predicate P
(define (forall P L) (null? (reject P L)))

; return #t iff some value in L satisfies P
(define (exists P L) (not (null? (filter P L))))

; take the inner product of two lists using two binary operators
; assume the lists are the same length
(define (inner_product1 L1 L2 f g) (if (null? (cdr L1)) (g (car L1) (car L2))
                                      (f (g (car L1) (car L2))
                                         (inner_product1 (cdr L1) (cdr L2) f g))))
