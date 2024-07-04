;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 9|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Definimos la estructura Auto

(define-struct Auto [modelo año combustible rendimiento])

(define PRECIO-PEAJE 50)
(define PRECIO-NAFTA 19)
(define PRECIO-DIESEL 17)

(define KM-PEAJE 100)

(define AÑO-ACTUAL 2023)

;antiguedad : Auto -> Number
;Dado el Año del auto, calcula su antiguedad.

(check-expect (antiguedad (make-Auto "focus" 2011 "nafta" 14)) 12)

(define (antiguedad auto)
  (- AÑO-ACTUAL (Auto-año auto)))

;rendimiento-dism : Auto -> Number
 
(check-expect (rendimiento-dism (make-Auto "focus" 2011 "nafta" 14))0.1)

(define (rendimiento-dism auto)
  (cond [(< (antiguedad auto) 1) 0]
        [(and (>= (antiguedad auto) 1)(<= (antiguedad auto) 5)) 0.02]
        [(and (> (antiguedad auto) 5)(<= (antiguedad auto) 10)) 0.06]
        [(and (> (antiguedad auto) 10)(<= (antiguedad auto) 15)) 0.1]
        [(> (antiguedad auto) 15) 0.15]))

;rendimiento-real : Auto -> Number

(check-expect (rendimiento-real (make-Auto "focus" 2011 "nafta" 14))1.4)

(define (rendimiento-real auto)
  (* (Auto-rendimiento auto) (rendimiento-dism auto)))

;cantidad-peajes : Number -> Number

(check-expect (cantidad-peajes 250) 2)

(define (cantidad-peajes distancia)
  (floor (/ distancia KM-PEAJE)))

;precio-peaje: Number -> Number

(check-expect (precio-peaje 250) 100)

(define (precio-peaje distancia)
  (* PRECIO-PEAJE (cantidad-peajes distancia)))

;precio-combustible : Auto -> Number

(check-expect (precio-combustible (make-Auto "focus" 2011 "nafta" 14)) 19)

(define (precio-combustible auto)
  (if (string=? (Auto-combustible auto) "diesel") 17 19))

;costo-viaje : Auto Number -> Number

(check-within (costo-viaje (make-Auto "focus" 2011 "nafta" 14) 250) 3492.85 0.1)

(define (costo-viaje auto distancia)
  (+ (precio-peaje distancia) (* (precio-combustible auto) (/ distancia (rendimiento-real auto)))))



  