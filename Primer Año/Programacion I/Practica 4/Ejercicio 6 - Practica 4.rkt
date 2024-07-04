;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 6 - Practica 4|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado inicial será una estructura posn que representa
;la posicion sobre la que se va a dibujar la mosca.

(define ALTO-ESCENA 1000)
(define ANCHO-ESCENA 1000)
(define ESCENA (empty-scene ALTO-ESCENA ANCHO-ESCENA))

(define TAM-MOSCA 30)
(define MOSCA (circle TAM-MOSCA "solid" "red"))

(define DELTA 50)
(define GAMMA 30)

(define ESTADO-INICIAL (make-posn (/ ALTO-ESCENA 2) (/ ANCHO-ESCENA 2)))
(define ESTADO-FINAL (make-posn -1 -1))

;posn=? : posn1 posn2 -> Boolean
;Toma dos datos posn y devuelve #t si son iguales, si no devuelve #f.

(define (posn=? posn1 posn2)
  (and (= (posn-x posn1) (posn-x posn2)) (= (posn-y posn1) (posn-y posn2))))

;mostrar-mosca : Estado -> Image
;Dado el estado, devuelve una imagen en la escena con las coordenadas dadas.
;Si el estado es ESTADO-FINAL nos devuelve un mensaje "MOSCA ATRAPADA".

(define (mostrar-mosca estado)
  (if (not (posn=? estado ESTADO-FINAL))
      (place-image MOSCA (posn-x estado) (posn-y estado) ESCENA)
      (place-image (text "MOSCA ATRAPADA" 50 "black") (/ ANCHO-ESCENA 2) (/ ALTO-ESCENA 2) ESCENA)))

;coor-random : Number -> Estado
;Dada una coordenada aleatoria, suma o resta DELTA unidades.

(define (coor-random coordenada)
  (if (= (random 2) 0) (- coordenada DELTA) (+ coordenada DELTA)))

;coor-x : Number -> Number
;dada una coordenada x, suma o resta DELTA unidades.
;Si la coordenada es mayor al ancho de la pantalla, la mosca no podra salir.

(define (coor-x coorx)
  (cond [(< (- coorx TAM-MOSCA DELTA) 0) (+ coorx DELTA)]
        [(> (+ coorx TAM-MOSCA DELTA) ANCHO-ESCENA) (- coorx DELTA)]
        [else (coor-random coorx)]))

;coor-x : Number -> Number
;dada una coordenada x, suma o resta DELTA unidades.
;Si la coordenada es mayor al ancho de la pantalla, la mosca no podra salir.

(define (coor-y coory)
  (cond [(< (- coory TAM-MOSCA DELTA) 0) (+ coory DELTA)]
        [(> (+ coory TAM-MOSCA DELTA) ANCHO-ESCENA) (- coory DELTA)]
        [else (coor-random coory)]))

;mover-mosca : Estado -> Estado
;Dado un estado, nos devuelve la posicion en la cual se desplaza la mosca
;aleatoriamente dentro de la escena.

(define (mover-mosca estado)
  (make-posn (coor-x (posn-x estado)) (coor-y (posn-y estado))))

;distancia : posn posn -> Number
;Dado dos puntos en el plano representados por estructuras
;calcula la distancia entre ellos y la devuelve.

;(check-expect (distancia (make-posn 0 0) (make-posn 3 4)) 5)
;(check-expect (distancia (make-posn 0 3) (make-posn 4 0)) 5)
;(check-expect (distancia (make-posn 0 0) (make-posn 0 0)) 0)

(define (distancia p q)
      (sqrt (+ (sqr (- (posn-x p) (posn-x q))) (sqr (- (posn-y p) (posn-y q))))))

;aplastar-mosca : Estado Number Number String -> Boolean
;Dado el estado actual y las coordenadas donde se clickeo, nos devuelve el ESTADO-FINAL
;si la distancia del evento y el estado es menor a GAMMA unidades, si no nos devuelve
;el estado actual.

(define (aplastar-mosca estado x y event)
  (cond [(string=? event "button-down") (if (< (distancia estado (make-posn x y)) GAMMA)
                                       ESTADO-FINAL
                                       estado)]
        [else estado]))

(define (terminar estado)
  (posn=? estado ESTADO-FINAL))


(big-bang ESTADO-INICIAL
  [to-draw mostrar-mosca]
  [on-tick mover-mosca 0.1]
  [on-mouse aplastar-mosca]
  [stop-when terminar mostrar-mosca]
  )
