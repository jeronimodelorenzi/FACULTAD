;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 3 - Practica 3|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;El estado es el paso del tiempo que hace que el circulo vaya cambiando su tamaño.

(define ESCENA (empty-scene 300 300)) ;corresponde a una escena vacia de 300 x 300.

;color-tamaño Estado -> String
;Dado el estado actual del circulo, devuelve un string que equivale a un color:
;Entre 0 y 50 - AMARILLO
; Entre 51 y 100 - ROJO
; Mayor a 100 - VERDE

;(check-expect (color-tamaño 49) "yellow")
;(check-expect (color-tamaño 110) "red")
;(check-expect (color-tamaño 55) "green")

(define (color-tamaño tamaño)
  (cond [(<= tamaño 50) "yellow"]
        [(>= tamaño 100) "red"]
        [else "green"]))

;muestra-circulo: Estado -> Image
;Dado un estado, nos devuelve la imagen correspondiente a mostrar por el programa.

(define (mostrar-circulo tamaño)
  (place-image (circle tamaño "solid" (color-tamaño tamaño)) 150 150 ESCENA))

;decrecimiento : Estado -> Estado
;Dado un numero, devuelve el predecesor de un numero positivo.
;(check-expect (decrecimiento 100) 99)
;(check-expect (decrecimiento 0) 100)
;(check-expect (decrecimiento -1) "Inserte un numero positivo")

(define (decrecimiento n)
  (if (>= n 0)
      (if (= 0 n) 100 (- n 1))
      "Inserte un numero positivo"))

;crecimiento : Estado -> Estado
;Dado un numero, devuelve el sucesor de un numero positivo.
;(check-expect (crecimiento 1) 2)
;(check-expect (crecimiento 100) 0)
;(check-expect (crecimiento -1) "Inserte un numero positivo")

(define (crecimiento n)
  (if (>= n 0)
      (if (= n (/ 300 2)) 0 (+ n 1))
      "Inserte un numero positivo"))

;diametro : Estado String -> Estado
;Dado el estado actual, si se presiona un dígito, devuelve el nuevo estado con el valor de
;10*d. Para cualquier otra tecla no ocurre nada.
;(check-expect (diametro 100 "5") 50)
;(check-expect (diametro 100 "a") 100)

(define (diametro tamaño tecla)
  (if (string-numeric? tecla) 
      (* 10 (string->number tecla))
      tamaño))

;terminar : Estado -> Bool
;Dado el estado, si el radio es mayor a 110 o menor a 10 el programa finaliza.
;(check-expect (terminar 100) #f)
;(check-expect (terminar 110) #t)

(define (terminar radio)
  (if (or (< radio 10) (> radio 110)) #t #f))

  

(define ESTADO-INICIAL-DECRECIMIENTO 100)
(define ESTADO-INICIAL-CRECIMIENTO 11)

(big-bang ESTADO-INICIAL-CRECIMIENTO
  [to-draw mostrar-circulo]
  [on-key diametro]
  [on-tick crecimiento]
  [stop-when terminar])