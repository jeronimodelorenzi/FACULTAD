;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 11- Practica 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;---Definicion de la funcion---

;promedio : Number Number Number -> Number
;Representamos los tres valores de la terna autopromediable con Number.
;La funcion promedio recibe tres numero. Iguala el primer numero
;con la media suma entre el segundo y el tercero, asi calculando el promedio.
;-Ejemplos-
;(check-expect (promedio 5 7 3) #t)
;(check-expect (promedio 6 7 7) #f)

(define (promedio a b c)
  (= a (/ (+ b c) 2)))

;autopromediable : Number Number Number -> Number
;Representamos los tres valos de la terna con Number
;La funcion autopromediable recibe tres numeros, verifica si el primero es
;promedio de los otros dos. Si es una terna autopromediable, hace el producto
;de los tres numeros, en caso contrario los suma.
;-Ejemplos-
;(check-expect (autopromediable 5 7 3) 105)
;(check-expect (autopromediable 6 7 7) 20)

(define (autopromediable a b c)
  (if (boolean=? #t (promedio a b c))
      (* a b c)
      (+ a b c)))
