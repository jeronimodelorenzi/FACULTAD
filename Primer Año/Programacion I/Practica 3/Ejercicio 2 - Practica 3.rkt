;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 2 - Practica 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado es el paso del tiempo que hace que el circulo vaya cambiando su tamaño.

(define ESCENA (empty-scene 300 300)) ;corresponde a una escena vacia de 300 x 300.

;muestra-circulo: Number -> Image
;Dado un estado, nos devuelve la imagen correspondiente a mostrar por el programa.

(define (mostrar-circulo tamaño)
  (place-image (circle tamaño "solid" "blue") 150 150 ESCENA))

;decrecimiento : Number -> Number
;Dado un numero, devuelve el predecesor de un numero positivo.
;(check-expect (decrecimiento 100) 99)
;(check-expect (decrecimiento 0) 100)
;(check-expect (decrecimiento -1) "Inserte un numero positivo")


(define (decrecimiento n)
  (if (>= n 0)
      (if (= 0 n) 100 (- n 1))
      "Inserte un numero positivo"))

;crecimiento : Number -> Number
;Dado un numero, devuelve el sucesor de un numero positivo.
;(check-expect (crecimiento 1) 2)
;(check-expect (crecimiento 100) 0)
;(check-expect (crecimiento -1) "Inserte un numero positivo")

(define (crecimiento n)
  (if (>= n 0)
      (if (= 100 n) 0 (+ n 1))
      "Inserte un numero positivo"))

(define ESTADO-INICIAL-DECRECIMIENTO 100)
(define ESTADO-INICIAL-CRECIMIENTO 0)

(big-bang ESTADO-INICIAL-CRECIMIENTO
 [to-draw mostrar-circulo]
  [on-tick crecimiento])