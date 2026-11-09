#lang scheme

(map (lambda (x) (* x x)) '(3 1 5))                 ; (9 1 25)
(map (lambda (x) (* 4 x)) '(3 1 5))                 ; (12 4 20)
(map (lambda (x) (* 2 x)) '(3 1 5))                 ; (6 2 10)
(define (multiply-by y) (lambda (x) (* x y)))       ; a procedure with param y, that returns a proecedure that returns the product of x and y
(define times-4 (multiply-by 4))                    ; ties identifier `times-4` to a procedure that returns the product of x and 4
(define times-2 (multiply-by 2))                    ; ties identifier `times-4` to a procedure that returns the product of x and 2
times-4
(times-4 10)                                        ; 40
(times-2 10)                                        ; 20
(map times-4 '(3 1 5))                              ; (12 4 20)

(define (filter predicate L)
  (cond
    ((null? L) '())
    ((predicate (car L)) (cons (car L) (filter predicate (cdr L))))
    (else (filter predicate (cdr L)))))

(define (is-positive? x) (> x 0))                   
(filter is-positive? '(4 0 -2 5 6 -1 -3))           ; (4 5 6)
(define (even-length? s) (even? (string-length s))) 
(filter even-length? '("abc" "de" "fghi" "j" ""))   ; ("de" "fghi" "")

(filter even? '(5 6 -1 -3 -4))                      ; (6 -4)

(define (reduce f init L)
  (if (null? L)
      init
      (f (car L) (reduce f init (cdr L)))))

(define (add x y) (+ x y))                          

(reduce add 0 '())                                  ; 0

(reduce add 0 '(4 7 2 1))                           ; 14

(reduce + 0 '(4 7 2 1))                             ; 14

(string-append "ab" "cde")                          ; "abcde"
(reduce string-append "" '("abc" "de" "fghi" "j"))  ; "abcdefghij"

(define (demo . args) (display args) (newline))     ; args is a list of all arguments
(demo)                                              ; ()
(demo 1 2 3)                                        ; (1 2 3)

; creates a list of integers from starting at a, ending at b
(define (range a b)
  (if (> a b)
      '()
      (cons a (range (+ a 1) b))))

(define (square x) (* x x))                             

; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
; (1 3 5 7 9 11 13 15 17 19)
; (1 9 25 49 81 121 169 225 289 361)
; 1330
(reduce + 0 (map square (filter odd? (range 1 20))))
