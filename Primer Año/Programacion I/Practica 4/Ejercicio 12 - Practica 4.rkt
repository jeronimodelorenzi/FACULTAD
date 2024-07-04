;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 12 - Practica 4|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Definimos la estructura Persona

(define-struct Persona [nombre peso unidadP estatura unidadE])
;Persona es del tipo [String Number String Number String]
;1er campo: el nombre y apellido.
;2do campo: el valor numérico de su peso.
;3er campo: un string que representa la unidad en la cual está
           ;dado el peso (valores posibles: "g" o "kg").
;4to campo: el valor numérico de la estatura.
;5to campo: un string que representa la unidad en la cual está
           ;dada la estatura (valores posibles: "m" o "cm").

;pasaje-peso : Persona -> Number
;Dada una persona, nos devuelve su peso en kg.
;Sabemos que 1kg = 1000g.

(check-expect (pasaje-peso (make-Persona "Victoria Haploide"
                                            60
                                            "kg"
                                            153
                                            "cm")) 60)
(check-expect (pasaje-peso (make-Persona "Roberto Pasteur"
                                            80000
                                            "g"
                                            1.9
                                            "m")) 80)
                                            

(define (pasaje-peso persona)
  (if (string=? (Persona-unidadP persona) "kg")
      (Persona-peso persona)
      (/ (Persona-peso persona) 1000)))

;pasaje-estatura : Persona -> Number
;Dada una persona, nos devuelve su peso en m.
;Sabemos que 1m = 100cm

(check-expect (pasaje-estatura (make-Persona "Victoria Haploide"
                                            60
                                            "kg"
                                            153
                                            "cm")) 1.53)
(check-expect (pasaje-estatura (make-Persona "Roberto Pasteur"
                                            80000
                                            "g"
                                            1.9
                                            "m")) 1.9)

(define (pasaje-estatura persona)
  (if (string=? (Persona-unidadE persona) "m")
      (Persona-estatura persona)
      (/ (Persona-estatura persona) 100)))

;IMC : Persona -> Number
;Dada una persona, calcula su indice de masa corporal

(check-within (IMC (make-Persona "Victoria Haploide"
                                            60
                                            "kg"
                                            153
                                            "cm")) 25.63 0.1)
(check-within (IMC (make-Persona "Roberto Pasteur"
                                            80000
                                            "g"
                                            1.9
                                            "m")) 22.16 0.1)

(define (IMC persona)
  (if (not(Persona? persona)) "Tipo de dato inválido"
      (/ (pasaje-peso persona) (sqr(pasaje-estatura persona)))))