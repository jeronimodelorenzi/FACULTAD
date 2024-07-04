;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 12 - Practica 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;Representaremos la cantidad de litros restantes con Number.
;Representaremos la clase de combustible con String, el cual será "Grado 2" o "Grado 3".
;La autonomía restante en ciudad y ruta, la representaremos con String.

(define CITY_G2 8)  ;en km/l
(define ROAD_G2 11) ;en km/l

(define IMPROVE_G3 0.1) ;Mejora Grado 3


;mensaje: Number Number -> String
;Dadas las autonomías en ciudad y ruta, nos devuelve un string unificándolas.

(check-expect (mensaje_autonomia 160 220) "Autonomía en ciudad: 160km. Autonomía en ruta: 220km.")
(check-expect (mensaje_autonomia 176 242) "Autonomía en ciudad: 176km. Autonomía en ruta: 242km.")

(define (mensaje_autonomia city road)
  (string-append "Autonomía en ciudad: " (number->string city)
                 "km. Autonomía en ruta: " (number->string road) "km.")
  )


;autonomia: Number String -> String
;Dada la cantidad de litros restantes, y el tipo de combustible que estamos utilizando,
;devuelve la autonomía en ciudad y ruta.

(check-expect (autonomia 20 "Grado 2") "Autonomía en ciudad: 160km. Autonomía en ruta: 220km.")
(check-expect (autonomia 20 "Grado 3") "Autonomía en ciudad: 176km. Autonomía en ruta: 242km.")
(check-expect (autonomia 20 "Grado 1") "Ingrese un tipo correcto de combustible.")

(define (autonomia litros combustible)
  (cond [(string=? combustible "Grado 2") (mensaje_autonomia (* litros CITY_G2)(* litros ROAD_G2))]
        [(string=? combustible "Grado 3") (mensaje_autonomia (* litros CITY_G2 (+ 1 IMPROVE_G3))
                                                             (* litros ROAD_G2 (+ 1 IMPROVE_G3)))]
        
        [else "Ingrese un tipo correcto de combustible."]
        )
  )