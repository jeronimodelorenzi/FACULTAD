;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Practica 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;1)
;---Diseño de datos---
;Representamos la cordenadas y la distancia mediante numeros
;---Signatura y declaracion de proposito
;distancia-origen : Number Number -> Number
;La funcion distancia-origen recibe la suma de dos puntos y saca su raiz cuadrada
;---Ejemplos---
;(check-expect (distancia-origen 3 4) 5)
;(check-expect (distancia-origen 3 4) 5)
;---Definicion de la funcion---
(define (distancia-origen x y)
  (sqrt(+ (sqr x)(sqr y))))
;---Evaluar el codigo en los ejemplos---
(check-within (distancia-origen 2 3) 3.60 0.1)
(check-expect (distancia-origen 3 4) 5)

;2)

;---Diseño de datos---
;Representamos las coordenadas y las distancias mediante numeros
;---Signatura y declaracion de proposito---
; distancia-puntos : Number Number Number Number -> Number
;La funcion distancia-puntos recibe cuatro numeros, hace la diferencia,
;eleva el resultado al cuadrado y saca su raiz cuadrada.
;---Ejemplos---
;(check-expect (distancia-puntos 10 6 12 9) 5)
;(check-within (distancia-puntos 4 5 2 3) #i1.41 0.1)
;---Definicion de la funcion---
(define (distancia-puntos x1 x2 y1 y2)
  (sqrt (+ (sqr (- x1 x2))(sqr (- y1 y2)))))
;---Evaluar el codigo en los ejemplos---
(check-expect (distancia-puntos 10 6 12 9) 5)
(check-within (distancia-puntos 4 5 2 3) 1.41 0.1)

;3)

;---Diseño de datos---
;Representamos la longitud de las aristas mediante numeros
;---Signatura y declaracion de proposito---
;area-cubo : Number -> Number
;La funcion area-cubo recibe un numero, obtiene el cuadrado y lo multiplica por 6
;---Ejemplos---
;(check-expect (area-cubo 4) 96)
;(check-expect (area-cubo 10) 600)
;---Definicion de la funcion---
(define (area-cubo x) (* 6 (sqr x)))
;---Evaluar el codigo en los ejemplos---
(check-expect (area-cubo 4) 96)
(check-expect (area-cubo 10) 600)

;4)

;---Diseño de datos---
;Representamos la longitud de las aristas mediante numeros
;---Signatura y declaracion de proposito---
;vol-cubo : Number -> Number
;La funcion vol-cubo recibe un numero y lo eleva al cubo
;---Ejemplos---
;(check-expect (vol-cubo 4) 64)
;(check-expect (vol-cubo 2) 8)
;---Definicion de la funcion---
(define (vol-cubo x) (expt x 3))
;---Evaluar el codigo en los ejemplos---
(check-expect (vol-cubo 4) 64)
(check-expect (vol-cubo 2) 8)

;5)

;---Diseño de datos---
;Representamos la cadena con una String
;---Signatura y declaracion de proposito---
;string-insert : String Number -> String
;La funcion recibe una cadena de caracteres y un numero, 
;concatena la primer parte del segmento del string determinado por el numero,
;con un guion medio y con la segunda parte del segmento del string.
;---Ejemplos---
;(check-expect (string-insert "Hola" 2) "Ho-la")
;(check-expect (string-insert "Jeronimo" 4) Jero-nimo)
;---Definicion de la funcion---
(define (string-insert x i) (string-append (substring x 0 i)"-" (substring x i)))
;---Evaluar el codigo en los ejemplos---
(check-expect (string-insert "Hola" 2) "Ho-la")
(check-expect (string-insert "Jeronimo" 4) "Jero-nimo")

;6)

;---Diseño de datos---
;Representamos una cadena no vacia con un String
;---Signatura y declaracion de proposito---
;string-last : String -> String
;La funcion recibe una cadena no vacia la cual se le saca el ultimo caracter
;y devuelve la cadena
;---Ejemplos---
;(check-expect (string-last "Hola") "Hol")
;(check-expect (string-last "Jeronimo") "Jeronim")
;---Definicion de la funcion---
(define (string-last x) (substring x 0 (- (string-length x) 1)))
;---Evaluar el codigo en los ejemplos---
(check-expect (string-last "Hola") "Hol")
(check-expect (string-last "Jeronimo") "Jeronim")