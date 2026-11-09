(define (wr x)
    (display x) (newline))

(define (rev lst)
    (if (null? lst)
        '()
        (append (rev (cdr lst)) (list (car lst)))))

; trace:
; (rev '(a b c d e))
; (append (rev '(b c d e)) (list 'a))
; (append (append (rev '(c d e)) (list 'b)) (list 'a))
; (append (append (append (rev '(d e)) (list 'c)) (list 'b)) (list 'a))
; (append (append (append (append (rev '(e)) (list 'd)) (list 'c)) (list 'b)) (list 'a))
; (append (append (append (append (append (rev '()) (list 'e)) (list 'd)) (list 'c)) (list 'b)) (list 'a))
; (append (append (append (append (append '() (list 'e)) (list 'd)) (list 'c)) (list 'b)) (list 'a))
; (append (append (append (append '(e) (list 'd)) (list 'c)) (list 'b)) (list 'a))
; (append (append (append '(e d) (list 'c)) (list 'b)) (list 'a))
; (append (append '(e d c) (list 'b)) (list 'a))
; (append '(e d c b) (list 'a))
; '(e d c b a)

; tail recursive variant:
(define (rev-tr lst)
    (rev-tr-helper lst '()))

(define (rev-tr-helper lst acc)
    (if (null? lst)
        acc
        (rev-tr-helper (cdr lst) (cons (car lst) acc))))

;trace
; (rev-tr '(a b c d e))
; (rev-tr-helper '(a b c d e) '())
; (rev-tr-helper '(b c d e) (cons a '()))
; (rev-tr-helper '(c d e) (cons b '(a)))
; (rev-tr-helper '(d e) (cons c '(b a)))
; (rev-tr-helper '(e) (cons d '(c b a)))
; (rev-tr-helper '() (cons e '(d c b a)))
; '(e d c b a)

; question 2: 
(define (fact n) ; assume non-negative n
  (if (zero? n)
      1
      (* n (fact (- n 1)))))

; a:
; (fact 5)
; (* 5 (fact 4))
; (* 5 (* 4 (fact 3)))
; (* 5 (* 4 (* 3 (fact 2))))
; (* 5 (* 4 (* 3 (* 2 (fact 1)))))
; (* 5 (* 4 (* 3 (* 2 (* 1 (fact 0))))))
; (* 5 (* 4 (* 3 (* 2 (* 1 1)))))
; (* 5 (* 4 (* 3 (* 2 1))))
; (* 5 (* 4 (* 3 2)))
; (* 5 (* 4 6))
; (* 5 24)
; 120

; b:
; O(n) time and O(n) space

; c: 
(define (fact-tr n)
    (fact-tr-helper n 1))

(define (fact-tr-helper n prod)
    (if (zero? n)
        prod
        (fact-tr-helper (- n 1) (* n prod))))

; (fact-tr 5)
; (fact-tr-helper 5 1)
; (fact-tr-helper 4 5)
; (fact-tr-helper 3 20)
; (fact-tr-helper 2 60)
; (fact-tr-helper 1 120)
; (fact-tr-helper 0 120)
; 120

; list procedures:

; assuming nonempty L:
(define (last L) 
    (if (null? (cdr L))
        (car L)
        (last (cdr L))))

; assuming that 0 <= i < (length L)
(define (get-at L i)
    (if (= i 0)
        (car L)
        (get-at (cdr L) (- i 1))))

; assuming 0 <= n <= (length L)
(define (take n L)
    (if (= n 0)
        '()
        (cons (car L) (take (- n 1) (cdr L)))))

; assuming 0 <= n <= (length L)
(define (drop n L) 
    (if (= n 0)
        L
        (drop (- n 1) (cdr L))))

; 
(define (repeat x n)
    (if (= n 0)
        '()
        (cons x (repeat x (- n 1)))))

;
(define (zip L1 L2)
    (cond
        ((or (null? L1) (null? L2)) '())
        (else (cons (cons (car L1) (car L2)) (zip (cdr L1) (cdr L2))))))

;
(define (alternate L1 L2)
    (cond
        ((and (null? L1) (null? L2)) '())
        ((null? L1) (cons (car L2) (alternate L1 (cdr L2))))
        ((null? L2) (cons (car L1) (alternate (cdr L1) L2)))
        (else (cons (car L1) (cons (car L2) (alternate (cdr L1) (cdr L2)))))))

; (cons 0 (cons 1 (alternate '(0 0 0) '(1))))
; (cons 0 (cons 1 (cons (0 (cons 1 (alternate '(0 0) '()'))))))
; (cons 0 (cons 1 (cons (0 (cons 1 (cons 0 (alternate '(0) '())))))))
; (cons 0 (cons 1 (cons (0 (cons 1 (cons 0 (cons 0 (alternate '() '()))))))))
; (cons 0 (cons 1 (cons (0 (cons 1 (cons 0 (cons 0 '())))))))
; (cons 0 (cons 1 (cons (0 (cons 1 (cons 0 '(0)))))))
; (cons 0 (cons 1 (cons (0 (cons 1 '(0 0))))))
; (cons 0 (cons 1 (cons (0 '(1 0 0)))))
; (cons 0 (cons 1 '(0 1 0 0)))
; (cons 0 '(1 0 1 0 0))
; (0 1 0 1 0 0)

; Assuming e is a number and that all elements of L are numbers
(define (contains? e L)
    (if (null? L)
        #f
        (or (= e (car L)) (contains? e (cdr L)))))

; Assuming that e is a number and that all element of L are numbers.
(define (remove-first e L)
    (if (null? L)
        '()
        (if (= e (car L))
            (cdr L)
            (cons (car L) (remove-first e (cdr L))))))
            
; Assuming that e is a number and that all element of L are numbers.
(define (remove-all e L)
    (if (null? L)
        '()
        (if (= e (car L))
            (remove-all e (cdr L))
            (cons (car L) (remove-all e (cdr L))))))

;
(define (any? predicate L)
    (if (null? L)
        #f
        (or (predicate (car L)) (any? predicate (cdr L)))))

;
(define (all? predicate L)
    (if (null? L)
        #t
        (and (predicate (car L)) (all? predicate (cdr L)))))

;
(define (take-while predicate L) 
    (if (null? L)
        '()
        (if (predicate (car L))
            (cons (car L) (take-while predicate (cdr L)))
            '())))

;
(define (drop-while predicate L)
    (if (null? L)
        '()
        (if (predicate (car L))
            (drop-while predicate (cdr L))
            L)))

; using
; 1) 
(define L '((1 2 3) (4) (5 6) (7 8)))
(wr (map car L)) ; (1 4 5 7)
(wr (map cdr L)) ; ((2 3) () (6) (8))

; 2)
(define L '((1 2 3) () (4 5) (6 7 8 9) (10 11 12) (13)))
(define oddLengthLists (filter (lambda (x) (odd? (length x))) L))   ; ((1 2 3) (10 11 12) (13))
(define firstEltLists (map car oddLengthLists))                     ; (1 10 13)
(define sumOfFirstEltInOddLists (reduce + 0 firstEltLists))         ; (24)

(wr sumOfFirstEltInOddLists)

; 3)
(define listOfNums '(5 4 3 2 1))
(define product (reduce * 1 listOfNums))

(wr product)

; 4) 
(define (abs-val x)
    (if (< x 0)
        (- x)
        x))

(define listOfNums2 '(5 -2 -1))                                     ; (5 -2 -1)
(define abs-listOfNums2 (map abs-val listOfNums2))                  ; (5 2 1)
(define sum-abs-listOfNums2 (reduce + 0 abs-listOfNums2))           ; 8

(wr sum-abs-listOfNums2)

; 5)
(define listOfNums3 '(1 0 9 -21 -1 6 -5))                                           ; (1 0 9 -21 -1 6 -5)
(define positive-listOfNums3 (filter positive? listOfNums3))                        ; (1 9 6)
(define mapToOnes-positives-listOfNums3 (map (lambda (x) 1) positive-listOfNums3))  ; (1 1 1)
(define countedPositives (reduce + 0 mapToOnes-positives-listOfNums3))              ; 3

(wr countedPositives)

; compose: returns h where (h x) = (f (g x))
(define (compose f g)
    (lambda (x) (f (g x))))

(define (square x) (* x x))
(define (increment x) (+ 1 x))
(define increment-then-square (compose square increment)) ; the inner function is the last mentioned.

(define y '(a b))       ; (a b)
(define x (list y y))   ; ((a b) (a b))
(set-cdr! (cdr x) (cdr (car x))) ; x is now ; ((a b) (a b) b)
(wr x)

; non-mutating O(n) stack
(define make-stack '())

(define (empty-stack? s)
    (null? s))

(define (push-stack s elt)
    (cons elt s))

(define (top-stack s)
    (if (empty-stack? s)
        (error "stack empty")
        (car s))
    )
    
(define (pop-stack s)
    (if (empty-stack? s)
        (error "stack empty")
        (cdr s)))

; Mutating-stack O(1) stack
(define (make-mstack) (cons 'mstack '()))
(define (mstack? s)
    (if (and (pair? s) (eq? 'mstack (car s)))))

(define (emtpy-mstack? s)
    (null? (car s)))

(define (push-mstack! s elt)
    (if (mstack? s)
        (set-cdr! s (cons elt (cdr s))))    
        (error "not mstack"))

(define (top-mstack! s)
    (cond
        ((not (mstack? s)) (error "not mstack"))
        ((empty-mstack? s) (error "empty mstack"))
        (else (car (cdr x)))))

(define (pop-mstack! s)
    (cond
        ((not (mstack? s)) (error "not mstack"))
        ((empty-mstack? s) (error "empty mstack"))
        (else (set-cdr! s (cddr s)))))
