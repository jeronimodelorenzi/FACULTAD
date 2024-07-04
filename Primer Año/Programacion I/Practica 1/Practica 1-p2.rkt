;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Practica 1-p2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;CONDICIONALES MULTIPLES

;1)

(define (sgn2 x) (cond [(< x 0) -1]
                   [(= x 0) 0]
                   [(> x 0) 1]))

;2)

;a)
(define (b-tamaño? x y) (cond [(= x y) "Cuadrada"]
                              [(> x y) "Angosta"]
                              [(< x y) "Ancha"]
                              ))

;b)
(define (trianguloError a1 a2 a3) (cond [(= (+ a1 a2 a3) 180) "Triangulo"]
                                        [(> (+ a1 a2 a3) 180) "No es triangulo"]
                                        ))

;c)
(define PC 60)
(define PL 8)
(define descL 0.15)
(define descC 0.1)
(define descT 0.18)
(define topL 5)
(define topC 4)
(define topT 10)

(define (cantidad c l) (cond [(>= (+ c l) topT) (- (+ (* PL l)(* PC c)) (*(+ (* PC c)(* PL l)) descT))]
                             [(and (>= l topL) (>= c topC)) (+ (- (* l PL) (* l PL descL)) (- (* c PC) (* c PC descC)))]
                             [(and (< c topC) (>= l topL)) (+ (- (* l PL) (* l PL descL)) (* PC c))]
                             [else (+ (* PL l) (* PC c))]
                             
))

;d)
(define (pitagorica? a b c) (cond [(= (sqr a) (+ (sqr b) (sqr c))) #t]
                                  [(= (sqr b) (+ (sqr a) (sqr c))) #t]
                                  [(= (sqr c) (+ (sqr a) (sqr b))) #t]
                                  [else (string-append "Los numeros " (number->string a)", " (number->string b) " y " (number->string c) " no son terna pitagorica")]
                                  ))

;4)

(define (tamaño? x y) (cond [(> x (* 2 y)) "Muy angosta"]
                            [(> x y) "Angosta"]
                            [(<(* 2 x) y) "Muy ancha"]
                            [(< x y) "Ancha"]
                            [(= x y) "Cuadrada"]))

;5)

(define (clasificar t) (cond [(< t 0) "Muy frío (MF)"]
[(and (> t 0) (<= t 15)) "Frío (F)"]
[(and (> t 15) (< t 25)) "Agradable (A)"]
[(> t 25) "Caluroso (C)"]))

;6)

(define (sgn3 x)
  (cond [(number? x) (sgn2 x)]
        [(string? x) (sgn2 (string->number x))]
        [(boolean? x) (sgn2 (boolean->number x))]
        ))

;recibe un booleano, retorna un number
;(check-expect (boolean->number #f) 0)
; Bool -> Number
(define (boolean->number x) (if x 1 0))

;7)

(define (sgn4 x)
  (cond [(number? x) (sgn2 x)]
        [(string? x) (sgn2 (string->number x))]
        [(boolean? x) (sgn2 (boolean->number x))]
        [(image? x) (sgn2 (image->number x))]
        ))

;recibe una imagen, retorna un number
;(check-expect (image->number (empty-scene 20 21)) 1)
; Image -> Number
(define (image->number x) (cond [(=  (image-width x) (image-height x)) 0]
                              [(> (image-width x) (image-height x)) -1]
                              [(< (image-width x) (image-height x)) 1]
                              ))

;8)

(define (sgn5 x)
  (cond [(number? x) (sgn2 x)]
        [(string? x) (sgn2 (string->number x))]
        [(boolean? x) (sgn2 (boolean->number x))]
        [(image? x) (sgn2 (image->number x))]
        [else "Clase no soportada por la función."]
        ))

;9)

(define (sgn6 x)
  (cond [(number? x) (sgn2 x)]
        [(number-string? x) (sgn2 (string->number x))]
        [(string? x) "La cadena no se puede convertir a un número"]
        [(boolean? x) (sgn2 (boolean->number x))]
        [(image? x) (sgn2 (image->number x))]
        ))

(define (number-string? x) (and (string? x) (number? (string->number x))))

 ( define  ( f  x )
    ( cond  [ ( <  x  0 )      "B" ]
                 [ ( >  x  100 )   "B"]
                 [ ( >=  x  0 )      "A"]       
                 [ ( <=  x  100 )  "A"]  ))