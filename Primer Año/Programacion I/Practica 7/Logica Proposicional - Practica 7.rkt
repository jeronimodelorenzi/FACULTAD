;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Logica Proposicional - Practica 7|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;implica : Boolean Boolean -> Boolean
;Dado dos valores booleanos, devuelve el valor booleano correspondiente
;a la tabla de verdad del implica.

(check-expect (implica #f #f) #t)
(check-expect (implica #f #t) #t)
(check-expect (implica #t #f) #f)
(check-expect (implica #t #t) #t)

(define (implica p q)
  (cond [(and (boolean=? p #t) (boolean=? q #f)) #f]
        [else #t]))

;equivalente : Boolean Boolean -> Boolean
;Dado dos valores booleanos, devuelve el valor booleano correspondiente
;a la tabla de verdad del equivalente.

(check-expect (equivalente #f #f) #t)
(check-expect (equivalente #f #t) #f)
(check-expect (equivalente #t #f) #f)
(check-expect (equivalente #t #t) #t)

(define (equivalente p q)
  (cond [(not(boolean=? p q)) #f]
        [else #t]))

(define (valuaciones n)
  (cond [(zero? n) (list empty)]
        [else (append (map (lambda (val) (cons #false val)) (valuaciones (- n 1)))
                      (map (lambda (val) (cons #true val)) (valuaciones (- n 1))))]))

(define (cant-elementos l)
  (cond [(empty? l) 0]
        [(cons? l) (+ 1 (cant-elementos (rest l)))]))

; A : List(Boolean) -> Boolean
(define
  (A l)
  (cond [(not(= (cant-elementos l) 3)) (error "La cantidad de variables especificada es mayor que las utilizadas en la fórmula.")]
  [else (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)])
  (equivalente (and (implica p1 p3)
                    (implica p2 p3))
               (implica (or p1 p2)
                        p3)))]))

; B : List(Boolean) -> Boolean

(define
  (B l)
  (cond [(not(= (cant-elementos l) 3)) (error "La cantidad de variables especificada es mayor que las utilizadas en la fórmula.")]
  [else (let ([p1 (first l)]
        [p2 (second l)]
        [p3 (third l)])
  (equivalente (implica (and p1 p2) p3)
               (and (implica p1 p3)(implica p2 p3))))]))

; C : List(Boolean) -> Boolean


(define
  (C l)
  (cond [(not(= (cant-elementos l) 2)) (error "La cantidad de variables especificada es mayor que las utilizadas en la fórmula.")]
        [else
  (let ([p1 (first l)]
        [p2 (second l)])
  (equivalente (or (not p1) (not p2)) (and p1 p2)))]))

(A (list #f #f #f))
(B (list #t #t #t))
(C (list #f #t))

(define (evaluar P n)
  (map P (valuaciones n)))

(check-expect (tautologia? A 3) #t)
(check-expect (tautologia? B 3) #f)
(check-expect (tautologia? C 2) #f)

(define (todos-verdaderos l)
  (cond [(empty? l) #t]
        [(cons? l) (and (first l)(todos-verdaderos (rest l)))]))

(define (tautologia? P n)
  (todos-verdaderos (evaluar P n)))

(define (todos-falsos l)
  (cond [(empty? l) #t]
        [(cons? l) (and (not(first l)) (todos-falsos (rest l)))]))

(check-expect (contradiccion? A 3) #f)
(check-expect (contradiccion? B 3) #f)
(check-expect (contradiccion? C 2) #t)

(define (contradiccion? P n)
  (todos-falsos (evaluar P n)))

(define (uno-verdadero l)
  (cond [(empty? l) #f]
        [(cons? l) (if (boolean=? (first l) #t)
                       #t
                       (uno-verdadero (rest l)))]))

(check-expect (satisfactible? A 3) #t)
(check-expect (satisfactible? B 3) #t)
(check-expect (satisfactible? C 2) #f)

(define (satisfactible? P n)
  (uno-verdadero (evaluar P n)))