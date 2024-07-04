;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 4 - Practica 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El Estado es un Number, que representa la coordenada vertical sobre la que se dibujará
;un círculo.

(define ALTURA-ESCENA 500) ;corresponde a la altura del empty-scene.
(define ANCHO-ESCENA 200) ;corresponde al ancho del empty-scene.

(define RADIO-INICIAL 50) ;corresponde al radio inicial del circulo.

(define DELTA 10) ;corresponde a las unidades que debe subir o bajar el circulo.

;mostrar-circulo: Estado -> Image
;Toma el Estado actual del sistema, y dibuja un círculo centrado horizontalmente,
;y su posición vertical está definida por el Estado.

(define (mostrar-circulo altura)
  (place-image (circle RADIO-INICIAL "solid" "green")
               (/ ANCHO-ESCENA 2) altura
               (empty-scene ANCHO-ESCENA ALTURA-ESCENA)))

;modificador-posición: Estado String -> Estado
;Toma el estado actual y le suma delta unidades si se presiona la flecha de arriba, y en caso contrario,
;si se presiona la flecha de abajo, le resta delta unidades. Nunca permite que la figura se salga
;de la escena.


(define (modificador-posición altura tecla)      
  (cond [(string=? tecla "up") (if (>= (- altura RADIO-INICIAL) DELTA)
                                   (- altura DELTA) altura)]
        [(string=? tecla "down") (if (>= (- ALTURA-ESCENA altura RADIO-INICIAL) DELTA)
                                     (+ altura DELTA) altura)]
        [(string=? tecla " ") ESTADO-INICIAL]
        [else altura]))

;mouse-handler: Estado Number Number String -> Estado
;Dado el estado actual, nos devuelve un nuevo estado en donde la altura corresponde a la coordenada vertical
;del Mouse al hacer click en un lugar de la escena. Nunca permite que la figura se salga de la escena.


(define (mouse-handler altura x y event)
  (cond [(string=? event "drag")
         (if (and (>= y RADIO-INICIAL)(<= y (- ALTURA-ESCENA RADIO-INICIAL)))
             y
             (if (<= y (/ ALTURA-ESCENA 2)) RADIO-INICIAL (- ALTURA-ESCENA RADIO-INICIAL))
             )]
        [else altura]))

(define ESTADO-INICIAL (/ ALTURA-ESCENA 2))

(big-bang ESTADO-INICIAL
  [to-draw mostrar-circulo]
  [on-key modificador-posición]
  [on-mouse mouse-handler]

  )