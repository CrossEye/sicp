(require-extension test)

; 1.1.1 REPL fun
; --------------
(test "1.1.1 interpreter result" 10 10)
(test "1.1.1 interpreter result" 12 (+ 5 3 4))
(test "1.1.1 interpreter result" 8 (- 9 1))
(test "1.1.1 interpreter result" 3 (/ 6 2))
(test "1.1.1 interpreter result" 6 (+ (* 2 4) (- 4 6)))


; Ex 1.1
; ------
(test "Ex 1.1 ... 10 => 10" 10 10)
(test "Ex 1.1 ... (+ 5 3 4) => 12" 12 (+ 5 3 4))
(test "Ex 1.1 ... (- 9 1) => 8" 8 (- 9 1))
(test "Ex 1.1 ... (/ 6 2) => 3" 3 (/ 6 2))
(test "Ex 1.1 ... (+ (* 2 4) (- 4 6)) => 6" 6 (+ (* 2 4) (- 4 6)))
(define a 3)  ; return is unspecified
(define b (+ a 1))  ; return is unspecified
(test "Ex 1.1 ... (define a 3)" 1 1)
(test "Ex 1.1 ... (define b (+ a 1))" 1 1)
(test "Ex 1.1 ... (+ a b (* a b)) => 19" 19 (+ a b (* a b)))
(test "Ex 1.1 ... (= a b) => #f" #f (= a b))
(test "Ex 1.1 ... (if (and (> b a) (< b (* a b))) b a) => 4" 4 (if (and (> b a) (< b (* a b))) b a))
(test "Ex 1.1 ... (cond ((= a 4) 6) ((= b 4) (+ 6 7 a)) (else 25)) => 16" 16 (cond ((= a 4) 6) ((= b 4) (+ 6 7 a)) (else 25)))
(test "Ex 1.1 ... (+ 2 (if (> b a) b a)) => 6" 6 (+ 2 (if (> b a) b a)))
(test "Ex 1.1 ... (* (cond ((> a b) a) ((< a b) b) (else -1)) (+ a 1)) => 16" 16 (* (cond ((> a b) a) ((< a b) b) (else -1)) (+ a 1)))


; Ex 1.2
; ------
(test "Ex 1.2 ... (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7))) => -37/150" (/ (- 37) 150) (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7))))


; Ex 1.3
; ------
(define (square x) (* x x))

(define (sum-squares a b)
  (+ (square a) (square b))
)

(define (square-top-two a b c)
  (cond 
        ((and (<= a b) (<= a c)) (sum-squares b c))
        ((and (<= b a) (<= b c)) (sum-squares a c))
        (else                    (sum-squares a b))
  )
)

(test "Ex 1.3 ... (square-top-two 1 2 3) => 13" 13 (square-top-two 1 2 3))
(test "Ex 1.3 ... (square-top-two 3 1 4) => 25" 25 (square-top-two 3 1 4))
(test "Ex 1.3 ... (square-top-two 5 3 1) => 34" 34 (square-top-two 5 3 1))



; Ex 1.4
; ------
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Description: dynamically chooses the operation to apply to a and b, based on whether b is
; positive or not, addition or subtraction, respectively.  This effectively adds the
; absolute value of b to a.

(test "Ex 1.4 ... (a-plus-abs-b 3 5) => 8" 8 (a-plus-abs-b 3 5))
(test "Ex 1.4 ... (a-plus-abs-b 3 -5) => 8" 8 (a-plus-abs-b 3 -5))


; Ex 1.5
; ------
;(define (p) (p))     ; (A)
;
;(define (test x y)   ; (B)
;  (if (= x 0)
;      0
;      y))

; Applicative order
; -----------------
; (test 0 (p))
; => (test 0 (p))       ; (B)
; => (if (= 0 0) 0 (p)) ; (A)
; => 0                  ; `if`

; Normal order
; ------------
; (test 0 (p))
; => (if (= 0 0) 0 (p)) ; (B)
; => (if (= 0 0) 0 (p)) ; (A) (substituting (p) in for (p) )
; => (if (= 0 0) 0 (p)) ; (A) (substituting (p) in for (p) )
; => (if (= 0 0) 0 (p)) ; (A) (substituting (p) in for (p) )
; ...


; Ex 1.6
; ------

;(define (new-if predicate then-clause else-clause)
;  (cond (predicate then-clause)
;        (else else-clause)))

;(define (sqrt-iter guess x)
;  (new-if (good-enough? guess x)
;          guess
;          (sqrt-iter (improve guess x)
;                     x)))

;(define (sqrt x)
;  (sqrt-iter 1.0 x))

;(sqrt 10) => infinite regress (presumably out-of-memory) as all the parameters
;             to `new-if`, including the recursive call to sqrt-iter have to be
;             parsed before sqrt-iter itself can return.

