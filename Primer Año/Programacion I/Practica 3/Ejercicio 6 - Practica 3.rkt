;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 6 - Practica 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El Estado será un String y representará la cadena de caracteres
;que hayamos escrito en ese momento.

(define ANCHO-ESCENA 800) ;corresponde al alto del empty-scene.
(define ALTO-ESCENA 60) ;corresponde al ancho del empty-scene.

(define TAMAÑO-FUENTE 20) ;corresponde al tamaño de la fuente.
(define COLOR-FUENTE "indigo") ;corresponde al color de la fuente.

;imprimir-cadena : Estado -> Image
;Dado el estado, imprime la cadena que escribimos en el momento
;dentro de la escena.

(define (imprimir-cadena estado)
  (place-image/align (text estado TAMAÑO-FUENTE COLOR-FUENTE)
                     0 30 "left" "center" (empty-scene ANCHO-ESCENA ALTO-ESCENA)))

;borrar : String -> String
;Dado un estado, nos devuelve el el estado con el último caracter removido.

(define (borrar estado)
  (substring estado 0 (- (string-length estado) 1) ))

;agregar : Estado String -> Estado
;Dado el estado actual y la tecla presionada, devuelve un Estado nuevo, con la tecla
;presionada, adicionada al final.

(define (agregar estado tecla)
  (cond [(string=? tecla "\b") (if (= 0 (string-length estado))
                                   estado
                                   (borrar estado))]
        [else (string-append estado tecla)]))

(define TEXTO-INICIAL "")

(big-bang TEXTO-INICIAL
  [to-draw imprimir-cadena]
  [on-key agregar])