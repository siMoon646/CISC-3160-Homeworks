; Another HOP

(define (wr x)
    (display x)
    (newline))

(define compose (lambda (f g) (lambda (x) (f (g x)))))

(define square (lambda (x) (* x x)))
(define inc (lambda (x) (+ x 1)))
(define inc-after-square (compose inc square))
(wr (inc-after-square 5)     ) ; 26
(wr ((compose square inc) 5) ) ; 36

; List Mutation
; a)
(define y (list 'a 'b))
(define x (list y y))

; b)
(wr x)
; output: ((a b) (a b))

; c)
(wr y)
; output: (a b)

; d) 
(set-cdr! (cdr x) (cdr (car x)))
(wr x)
; output: ((a b) (a b) b)

; Stacks
(define (make-stack)
    '())

(define (empty-stack? s) 
    (if (null? s)
        #t
        #f))
    
(define (push-stack s elt)
    (cons elt s))

(define (top-stack s)
    (if (empty-stack? s)
        (error "top-stack: stack is empty")
        (car s)))

(define (pop-stack s)
    (if (empty-stack? s)
        (error "pop-stack: stack is empty")
        (cdr s)))

; Mutating Stacks:
(define (make-mstack)
    (cons 'mstack '()))

(define (mstack? s)
    (and (pair? s) (eq? (car s) 'mstack)))

(define (empty-mstack? s)
    (if (mstack? s)
        (null? (cdr s))
        (error "empty_mstack?: mstack not provided")))

(define (push-mstack! s elt)
    (if (mstack? s)
        (begin
            (set-cdr! s (cons elt (cdr s)))
            s)
        (error "push-mstack! : mstack not provided")))

(define (top-mstack s)
    (if (mstack? s)
        (if(empty-mstack? s)
            (error "top-mstack : mstack is empty")
            (car (cdr s)))
        (error "top-mstack : mstack not provided")))

(define (pop-mstack! s)
    (if (mstack? s)
        (if (empty-mstack? s)
            (error "pop-mstack! : mstack is empty")
            (begin
                (set-cdr! s (cdr (cdr s)))
                s))
        (error "pop-mstack! : mstack not provided")))

; Environment Models:
; 1:

(define x 1)
(define y 2)
(define z 3)
(define (foo x)
  (define y 50)
  (list x y z))

(list x y z) ; (1 2 3)
(foo 40) ; (40 50 3)
(set! x 5) 
(list x y z) ; (5 2 3)
(foo 45) ; (45 50 3)

; 2:
(define bar
  (let ((result 'uninitialized))
    (lambda (x)
      (set! result
            (if (eq? result 'uninitialized)
                x
                (max result x)))
      result)))

(bar 4)  ; 4
(bar 50) ; 50
(bar 2)  ; 50

; Global:  bar -> procedure (params: x, body: set!/result), env = E1
; E1 (created once by let, encloses: Global):
;   result = uninitialized  -> 4 -> 50
; E2 (bar 4),  encloses E1:  x = 4   ; sets E1.result to 4
; E3 (bar 50), encloses E1:  x = 50  ; sets E1.result to (max 4 50) = 50
; E4 (bar 2),  encloses E1:  x = 2   ; sets E1.result to (max 50 2) = 50

; 3: 
(define make-accumulator
  (lambda ()
    (let ((count 0))
      (lambda (increment)
        (set! count (+ count increment))
        count))))

(define a (make-accumulator))
(a 3) ; 3
(a 2) ; 5
(define b (make-accumulator))
(b 2) ; 2
(a 1) ; 6

; Global: 
; make-accumulator -> ...
; a -> accumulator procedure object
; b -> accumulator procedure object

; E1 ()