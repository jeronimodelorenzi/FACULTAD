;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio Parcial 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado del sistema sera un Number que guardará el grado de la rotación.

(define ANCHO 200) ;corresponde al ancho de la escena.
(define ALTO 200) ;corresponde al alto de la escena.
(define COLOR-FONDO "black") ;corresponde al color de fondo de la escena.

;mostrar-triangulo : Estado -> Image
;Dado el estado, mostrará un triangulo dentro de una escena y rotará.
;Si su grado de rotacion es par, el triangulo será color azul, si no verde.

(define (mostrar-triangulo rotacion)
  (place-image (rotate rotacion (if(even? rotacion)
                          (triangle 50 "solid" "blue")
                          (triangle 50 "solid" "green"))) 100 100
               (place-image (square 200 "solid" COLOR-FONDO) 100 100
                            (empty-scene ANCHO ALTO))))

;rotacion-nula : Estado Number Number String -> Estado
;Dado el estado, si se hace click dentro de la escena la rotacion volvera
;al estado inicial, de lo contrario seguira la rotación

(define (rotacion-nula rotacion x y event)
  (if (mouse=? event "button-down")
      ESTADO-INICIAL rotacion))

;incrementar : Estado -> Estado
;Dado el estado, incrementara la rotación 5 grados.

(define (incrementar rotacion)
  (+ 5 rotacion))

(define ESTADO-INICIAL 0)
 
(big-bang ESTADO-INICIAL
  [to-draw mostrar-triangulo]
  [on-mouse rotacion-nula]
  [on-tick incrementar 0.2])