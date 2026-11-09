(define a 10)
a ; 10
(quote a)               ; 'a (the symbol a)
(+ 1 a)                 ; 11
(+ 1 2)                 ; 3
(quote (+ 1 2))         ; '(+ 1 2) || the symbol (+ 1 2) || the list (+ 1 2)
; (quote (+ 1 a)) ; error: can't add a number with a symbol
(quote 1)               ; 1 quoting numbers evaulate as numbers
(+ 1 (quote 1))         ; 2

a                       ; 10 - not modified
'a                      ; a (symbol)
(+ 1 a)                 ; 11
'(+ 1 a)                ; (+ 1 a)
(list 1 2 a)            ; (1 2 10)
'(1 2 a)                ; (1 2 a)
(define L '(a 2))       
L                       ; (a 2)
(car L)                 ; a

(length '((1 . 2) 3 (4 5)))         ; 3

(list '(1 3) '(2) '() '(3 0))       ; ((1 3) (2) () (3 0))
(append '(1 3) '(2) '() '(3 0))     ; (1 3 2 3 0)

(define (len L)
  (if (null? L)
      0
      (+ 1 (len (cdr L)))))

(len '((1 . 2) 3 (4 5)))            ; 3

(len '((1 . 2) 3 (4 5)))            ; 3
(+ 1 (len '(3 (4 5))))              ; 3
(+ 1 (+ 1 (len '((4 5)))))          ; 3
(+ 1 (+ 1 (+ 1 (len '()))))         ; 3
(+ 1 (+ 1 (+ 1 0)))                 ; 3
(+ 1 (+ 1 1))                       ; 3
(+ 1 2)                             ; 3
3                                   ; 3

(define (len-tr L)
  (len-tr-helper L 0))

(define (len-tr-helper L a)
  (if (null? L)
      a
      (len-tr-helper (cdr L) (+ 1 a))))

(len-tr '((1 . 2) 3 (4 5)))                 ; 3
(len-tr-helper '((1 . 2) 3 (4 5)) 0)        ; 3
(len-tr-helper '(3 (4 5)) 1)                ; 3
(len-tr-helper '((4 5)) 2)                  ; 3
(len-tr-helper '() 3)                       ; 3
3                                           ; 3

; Recurses down L1 until it's empty, then returns L2; on the way back,
; each call conses its (car L1) onto the front of the result.
(define (app L1 L2)
  (if (null? L1)
      L2
      (cons (car L1) (app (cdr L1) L2))))

(app '(1 2 3) '(4 5))
(cons 1 (app '(2 3) '(4 5)))
(cons 1 (cons 2 (app '(3) '(4 5))))
(cons 1 (cons 2 (cons 3 (app '() '(4 5)))))
(cons 1 (cons 2 (cons 3 '(4 5))))
(cons 1 (cons 2 '(3 4 5)))
(cons 1 '(2 3 4 5))
'(1 2 3 4 5)