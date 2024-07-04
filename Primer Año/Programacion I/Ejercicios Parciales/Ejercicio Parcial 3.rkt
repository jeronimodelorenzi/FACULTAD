;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio Parcial 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado sera un String que representara el color.

(define ANCHO 400) ;corresponde al ancho de la escena.
(define ALTO 200) ;corresponde al alto de la escena.

;mostrar-numeros : Estado -> Image

(define (mostrar-numeros num)
  (place-image/align (text (number->string num) 20 (if (even? num) "blue" "red"))
                     (/ ANCHO 2) (/ ALTO 2) "center" "center"
                     (empty-scene ANCHO ALTO)))

;mouse-trampa : Estado Number Number String -> Estado

(define (mouse-trampa num x y event)
  (cond [(< y (/ ALTO 2)) (if (mouse=? event "button-down")
                             (random 20) num)]
        [(> y (/ ALTO 2)) (if (mouse=? event "button-down")
                             (+ (random 20) 80) num)]
        [else num]
        ))

#|(define (mouse-handler altura x y event)
  (cond [(string=? event "drag")
         (if (and (>= y RADIO-INICIAL)(<= y (- ALTURA-ESCENA RADIO-INICIAL)))
             y
             (if (<= y (/ ALTURA-ESCENA 2)) RADIO-INICIAL (- ALTURA-ESCENA RADIO-INICIAL))
             )]
        [else altura]))|#

;nuevo-numero : Estado->Estado
(define (nuevo-numero num)
  (random 99))

;terminar : Estado -> Bool
(define (terminar num)
  (= 0 (modulo num 7)))

(big-bang 1
  [to-draw mostrar-numeros]
  [on-tick nuevo-numero 9]
  [on-mouse mouse-trampa]
  [stop-when terminar mostrar-numeros]
  )