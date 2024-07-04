;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio de prueba - Practica 4|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado del programa será una estructura posn que toma
;la posicion en el plano del circulo.

(define ANCHO 500)
(define ALTO 250)

(define DELTA 20)

(define ESCENA (empty-scene ANCHO ALTO))

(define CIRCULO (circle 30 "solid" "red"))
(define CIRCANCHO (image-width CIRCULO))

;mostrar-circulo : Estado -> Image
;Dado el estado, muestra un circulo en una escena vacia dependiendo
;la posicion inical.

(define (mostrar-circulo estado)
  (place-image CIRCULO
               (posn-x estado) (posn-y estado) ESCENA))

;mover-circulo : Estado String -> Estado
;Dado el estado, al tocar flecha derecha se desplazara DELTA unidades hacia la derecha
;en sentido del eje x, lo mismo pero a la izquierda con flecha izquierda.
;En caso de precionar otra tecla no se modifica el estado.
;Cuando el circulo llegue al limite, vuelve al estado inicial.

(define (mover-circulo estado tecla)
  (cond [(not(key=? tecla "right")) estado]
        [(<= (+ (posn-x estado) (/ CIRCANCHO 2) DELTA) ANCHO) (make-posn(+ (posn-x estado) DELTA)(posn-y estado))]
        [else ESTADO-INICIAL]))

;manejar-circulo : Estado Number Number String -> Estado
;Dado el estado, al hacer click en una posicion de la escena,
;el circulo se situa dicha posicion.

(define (manejar-circulo estado x y evento)
  (cond [(not(mouse=? evento "button-down")) estado]
        [else (make-posn x y)]))

(define ESTADO-INICIAL (make-posn (/ CIRCANCHO 2) (/ ALTO 2)))

(big-bang ESTADO-INICIAL
    [to-draw mostrar-circulo]
    [on-key mover-circulo]
  [on-mouse manejar-circulo])
        
        
        