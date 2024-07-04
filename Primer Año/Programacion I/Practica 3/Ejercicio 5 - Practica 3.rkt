;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 5 - Practica 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado es un String que guarda el color central de la escena, que cambiará
;a medida que pasen los ticks del reloj. Y pasará por los siguientes colores:
;-Amarillo
;-Rojo
;-Verde
;-Azul
;en este orden.

(define ALTO-ESCENA 200) ;corresponde al alto del empty-scene.
(define ANCHO-ESCENA 200) ;corresponde al ancho del empty-scene.

(define COLOR-FONDO "white") ;corresponde al color del fondo del empty-scene.

(define RADIO-CIRCULO 50) ;corresponde al radio del circulo

;mostrar-circulo : Estado -> Image
;Dado un estado, nos devuelve la imagen correspondiente a mostrar por el programa.

(define (mostrar-circulo color)
  (place-image (circle RADIO-CIRCULO "solid" color) 100 100
               (empty-scene ALTO-ESCENA ANCHO-ESCENA)))

;colores : Estado -> Estado
;Dado el estado, por cada tick de segundo modifica el color siguiendo el patrón
;antes dicho. Repitiendo el proceso cuando termine.

(define (colores color)
  (cond [(string=? color "yellow") "red"]
        [(string=? color "red") "green"]
        [(string=? color "green") "blue"]
        [else "yellow"]))

(define ESTADO-INICIAL "yellow")

(big-bang ESTADO-INICIAL
  [to-draw mostrar-circulo]
  [on-tick colores 0.2])





