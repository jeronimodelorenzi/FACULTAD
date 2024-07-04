;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 10 - Practica 4|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Definimos la estructura Estudiante

(define-struct Estudiante [nombre promedio asistencia])
;Estudiante es del tipo [String Number Number]
;El primer campo representa el nombre del estudiante.
;El segundo campo representa el promedio de sus calificaciones (0 a 10).
;El tercer campo representa el porcentaje de asistencia (0 a 100)

;estado-asistencias : Estudiante -> Boolean
;Dado la cantidad de asistencias, devuelve #t si es mayor a 60,
;#f caso contrario.

(check-expect (estado-asistencias (make-Estudiante "Rocio" 10 80)) #t)

(define (estado-asistencias estudiante)
  (>= (Estudiante-asistencia estudiante) 60))

;estado-nota : Estado -> String
;Dado el promedio de las notas, si es mayor a 6 y menor a 8 el alumno es regular,
;si la nota es mayor igual a 8 es promovido.

(check-expect (estado-nota (make-Estudiante "Rocio" 10 80)) "Promovido")

(define (estado-nota estudiante)
  (cond [(< (Estudiante-promedio estudiante) 6) "Libre"]
        [(and (>= (Estudiante-promedio estudiante) 6)
              (< (Estudiante-promedio estudiante) 8)) "Regular"]
        [else "Promovido"]))

;condicion : Estudiante -> String
;Toma un estudiante y nos devuelve en que condicion se encuentra
;siguiente las siguientes reglas:
;Si el/la estudiante tiene un porcentaje de inasistencia mayor al 40% queda automáticamente libre, sin importar el promedio de sus calificaciones.
;Si el/la estudiante tiene una asistencia mayor o igual al 60%:
    ;y tiene una nota inferior a 6, también se considera libre.
    ;y tiene una nota mayor o igual a 6 y menor estricta que 8, se considera regular.
    ;y una nota mayor o igual a 8, se considera promovido/a.
;En caso de que no se ingrese un estudiante nos devuelve un error de tipo.

(check-expect (condicion "a") "Tipo de dato inválido")
(check-expect (condicion (make-Estudiante "Rocio" 10 80)) "Promovido")
(check-expect (condicion (make-Estudiante "Paco" 6 61)) "Regular")

(define (condicion estudiante)
  (cond [(not(Estudiante? estudiante)) "Tipo de dato inválido"]
        [(estado-asistencias estudiante) (estado-nota estudiante)]
        [else "Libre"]))