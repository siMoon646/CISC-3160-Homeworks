; helper for printing
(define (wr x) 
    (write x)
    (newline))
    
(define L1 '(10))
(define L2 '(5 9 2))

; 1
(define (last L)
    (if (null? (cdr L))
        (car L)
        (last (cdr L))))

; 2
(define (get-at L i)
    (if (= i 0)
        (car L)
        (get-at (cdr L) (- i 1))))

; 3
(define (take n L)
    (if (= n 0)
        '()
        (cons (car L) (take (- n 1) (cdr L)))))

; 4
(define (drop n L)
    (cond 
        ((null? (cdr L)) '())
        ((= n 0) (cons (car L) (drop 0 (cdr L))))
        (else (drop (- n 1) (cdr L)))))

; 5
(define (repeat x n)
    (if (= n 0)
        '()
        (cons x (repeat x (- n 1)))))

; 6
(define (zip L1 L2)
    (if (or (null? L1) (null? L2))
        '()
        (cons (cons (car L1) (car L2)) (zip (cdr L1) (cdr L2)))))

;7
(define (alternate L1 L2)
    (if (null? L1)
        L2
        (cons (car L1) (alternate L2 (cdr L1))))) ; L1 and L2 swap places

;8
(define (contains? e L)
    (if (null? (cdr L))
        #f 
        (or (= (car L) e) (contains? e (cdr L)))))

;9
(define (remove-first e L)
    (cond
        ((null? L) #f)
        ((= e (car L)) (cdr L)) ; this base case will be hit on the first occurrence of e
        (else (cons (car L)(remove-first e (cdr L))))))

;10
(define (remove-all e L)
    (cond
    ((null? L) '())
    ((= e (car L)) (remove-all e (cdr L)))
    (else (cons (car L) (remove-all e (cdr L))))))


; higher-order functions:
; A higher-order function takes another function as an argument (or returns one).
; Scheme treats procedures as first-class values, so they can be passed around like data.

;1
(define (any? predicate L)
    (if (null? L)
        #f
        (or (predicate (car L)) (any? predicate (cdr L)))))

;2
(define (all? predicate L)
  (cond
    ((null? L) #t)
    ((not (predicate (car L))) #f)
    (else (all? predicate (cdr L)))))

;3
(define (take-while predicate L)
  (cond
    ((null? L) '()) ; if the list is empty, the predicate can't be satisfied
    ((predicate (car L)) (cons (car L) (take-while predicate (cdr L)))) ; predicate is satisfeid -> cons it to the list
    (else '()))) ; predicate is not satisfied, return the empty list -> don't care about other elements after the element that failed predicate
        
;4
(define (drop-while predicate L) 
    (cond
        ((null? L) '()) ; if the list is empty, the inverse predicate can't be satisfied
        ((predicate (car L)) (drop-while predicate (cdr L)))
        (else L)))

; using

; returns a list consisting of only elements that pass a test
(define (filter predicate L)
    (cond
        ((null? L) '())
        ((predicate (car L)) (cons (car L) (filter predicate (cdr L))))
        (else (filter predicate (cdr L)))))

; returns a value based on applying a procedure over a list
(define (reduce procedure init L)
    (if (null? L)
        init
        (procedure (car L) (reduce procedure init (cdr L)))))

;1
(define L '((1 2 3) (4) (5 6) (7 8)))
(map car L) ; (1 4 5 7)
(map cdr L) ; ((2 3) () (6) (8))

(define L3 '((1 2 3) () (4 5) (6 7 8 9) (10 11 12) (13)))

;2
(define (odd-length? L)
    (if (odd? (length L)) 
        #t 
        #f))

(define (func L)
    (let* ( (oddLists (filter odd-length? L)) ; '( (1 2 3) () (10 11 12) (13) )
            (firstElts(map car oddLists)))    ; '( 1 10 13 )
            (reduce + 0 firstElts)))          ; 24

(wr (func L3)) ; 24

;4
(define (abs-val x)
    (if (positive? x)
    x
    (- x)))

(define (sum-abs-list L)
    (reduce + 0 (map abs-val L)))

(define L4 '(-1 1 -2 2 -3 3))

;5
(define (count-positives L)
    (let* ( (positives (filter positive? L))            ; positives holds only positive numbers of L
            (ones      (map (lambda (x) 1) positives))) ; turns each element in positives into 1
        (reduce + 0 ones)))                             ; sums the ones list
