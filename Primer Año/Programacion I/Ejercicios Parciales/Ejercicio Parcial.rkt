;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio Parcial|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado esta compuesto por un String que representa la figura de la escena.

(define ALTO 500) ;corresponde al alto de la escena.
(define ANCHO 500) ;corresponde al ancho de la escena.
(define COLOR-FONDO "black") ;corresponde al color de fondo de la escena.


;mostrar-imagen : Estado -> Image
;Dado el estado, se insertará dentro de la escena, la imagen correspondiente
;dependiendo del estado.

(define (mostrar-imagen figura)
  (place-image
   (cond [(string=? figura "e") (star 15 "solid" "yellow")]
        [(string=? figura "c") (square 20 "solid" "blue")]
        [(string=? figura "t") (triangle 18 "solid" "green")]) (random ANCHO) (random ALTO)
             (place-image (square 500 "solid" COLOR-FONDO) 250 250
               (empty-scene ALTO ANCHO))))

;manejar-figura : Estado String -> Estado
;Dado el estado, si se preciona la barra espaciadora volvera al estado inicial.

(define (manejar-figura figura tecla)
  (cond [(string=? tecla " ") ESTADO-INICIAL]))


;ticks : Estado -> Estado
;Dado el estado, por cada tick de 0.3 segundos se modifica la figura
;siguiendo el patron: "e", "c", "t", "e", "c", "t", ...
(define (ticks figura)
  (cond [(string=? figura "e") "c"]
        [(string=?  figura "c") "t"]
        [else "e"]))

(define ESTADO-INICIAL "e")

(big-bang ESTADO-INICIAL
  [to-draw mostrar-imagen]
  [on-key manejar-figura]
  [on-tick ticks 2])