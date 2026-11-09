#lang scheme

; recurses down L1 until it is empty and returns L2, then on the way back
; conses each element of L1 onto the front of the result
(define (app L1 L2)
  (if (null? L1)
      L2
      (cons (car L1) (app (cdr L1) L2))))

(app '(1 2 3) '(4 5)) ; (1 2 3 4 5)

(reverse '(1 2 5 4)) ; 4 5 2 1

(define (rev L)
  (if (null? L)                                 ; check if the list is empty
      '()                                       ; return empty list if list is empty
      (append (rev (cdr L)) (list (car L)))))   ; append the first elt of L to the back of the list returned by rev.

(rev '(1 2 4 3)) ; (3 4 2 1)

(define (rev-tr L)
  (rev-tr-helper L '()))

(define (rev-tr-helper L A)
  (if (null? L)                                   
      A                                           ; return the accumulator's value if L is empty 
      (rev-tr-helper (cdr L) (cons (car L) A)))) 

(rev-tr '(1 2 3 4))

(define (list-integers a b)
  (if (> a b)
      '()
      (cons a (list-integers (+ a 1) b))))

(list-integers 5 7)
(list-integers 9 9)
(list-integers 9 8)

(list-integers 5 7)

(map (lambda (x) (* 2 x)) '(5 3 10))              ; (10 6 20)

(define (inc x) (+ x 1))

(map inc '(5 3 10))                               ; 6 4 11

(map number->string '(5 3 10))                    ; ("5" "3" "10")

(define (my-map f L)
  (if (null? L)
      '()
      (cons (f (car L)) (my-map f (cdr L)))))

(my-map inc '(7 13 10)) ; (8 14 11)

(define L '(10 5 7))            
(map (lambda (x) (+ x 1)) L)  ; (11 6 8)
(map (lambda (x) (+ x 5)) L)  ; (15 10 12)

(define (plus y)
  (lambda (x) (+ x y)))

(plus 100)                    ; #<procedure>
((plus 100) 3)                ; 103
(define plus100 (plus 100))
plus100                       ; #<procedure>
(plus100 3)                   ; 103
(map (plus 1) L)              ; (11 6 8)
(map (plus 5) L)              ; (15 10 12)
