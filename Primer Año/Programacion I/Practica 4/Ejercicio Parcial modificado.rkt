;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio Parcial modificado|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; DISEÑO DE DATOS: El estado corresponde a una estructura posn
; el cual representa la coordenada por donde se moverá el circulo.

; DEFINICIÓN DE CONSTANTES

(define ALTO 400) ;alto de la escena
(define ANCHO 600) ;ancho de la escena
(define TAM 50) ; tamaño de objeto
(define ESCENA (empty-scene ANCHO ALTO)) ; escena vacía



(define DELTA 50) ;unidades de desplazamiento

(define INICIAL (make-posn (/ TAM 2) (/ ALTO 2))) ; estado inicial.

;determinar-color : Number -> String
;Dado una coordenada, representada con un Number, determina el color dependiendo de:
;                                 -Si el circulo se desplaza entre coordenadas menores a 200 tendrá color amarillo.
;                                 -Si el circulo se desplaza entre coordenadas mayores a 200 y menores a 400 tendrá color naranja.
;                                 -Si el circulo se desplaza entre coordenadas mayores a 400 y menores a 600 tendrá color amarillo.
;-Ejemplos-
;(check-expect (determinar-color 40) "yellow")
;(check-expect (determinar-color 500) "red")
;(check-expect (determinar-color 450) "orange")

(define (determinar-color x)
  (cond [(<= x 200) "yellow"]
        [(and (> x 200) (<= x 400)) "orange"]
        [(and (> x 400) (<= x 600)) "red"]
        [else "yellow"]))

;---------- Función asociada a la cláusula to-draw  de la expresión big-bang
; interpretar : Estado -> Image
; Interpreta el estado devolviendo una imagen 

(define (interpretar estado)
         (place-image (circle TAM "solid" (determinar-color (posn-x estado))) (posn-x estado) (posn-y estado)
                      ESCENA))
  
;------ Función asociada al evento 1 y a la cláusula on-tick de la expresión big-bang.
; manejarEvento1 : Estado -> Estado
; Dado el estado, si la coordenada es menor al ancho, se desplazara DELTA unidades hacia la derecha,
; cambiando de color segun lo especificado anteriormente. Si la coordenada donde se encuentra el circulo
; pasa los limites del ancho, volvera al principio de la escena.

(define (manejarEvento1 estado)
 (if (< (posn-x estado) ANCHO)
     (make-posn(+ (posn-x estado) DELTA)(posn-y estado))
     INICIAL
    ))

;----- Función asociada al evento 2 y a la cláusula on-mouse de la expresión big-bang.
; manejarEvento2 : Estado Number Number String -> Estado 
; Dado el estado, si se hace un click con el mouse en la escena, el circulo se posicionará en la coordenada x
; donde fue hecho el click, caso contrario, si no se realiza ningun click, sigue su recorrido normal.

(define (manejarEvento2 estado x y event)
  (cond [(not (mouse=? event "button-down")) estado]
        [else (make-posn x y)]))

; --- Expresión big-bang -------

(big-bang INICIAL
  [to-draw interpretar]
  [on-mouse manejarEvento2]
  [on-tick manejarEvento1 1]
  )