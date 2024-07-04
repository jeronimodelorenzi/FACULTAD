;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Ejercicio 1 - Practica 7|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define CARAS 6)

;simular-dado : Natural -> List(Natural)
;Dado un número natural n y devuelva una lista con n números aleatorios entre 1 y CARAS.

(define (simular-dado m)
    (cond [(zero? m) '()]
          [(positive? m) (cons (+ 1 (random CARAS)) (simular-dado (sub1 m)))]))

;intervalo : Natural -> List(Number)
;Dado un numero natural, devuelve la liosta (list 1 2 ... n).

(define (intervalo n)
  ;aux : Natural -> Number
  (local ((define (aux m)
           (cond [(zero? m) '()]
                 [(positive? m) (cons m (aux (sub1 m)))])))
  (reverse (aux n))))

(define MAX 60000)
(define EXPERIMENTO (simular-dado MAX))
(define VALORES (intervalo CARAS))

;frecuencia : Natural List(Natural) -> Natural
;Dado un número natural n y una lista de naturales, devuelve lacantidad de veces que n aparece en la lista. 

(define (frecuencia n l)
  (cond [(empty? l) 0]
        [(= (first l) n) (+ 1 (frecuencia n (rest l)))]
        [else (frecuencia n (rest l))]))

;frecuencia-relativa : Natural List(simular-dado) -> Number
;Dado un Natural entre 1 y Carasm y una lista de simular-dado calcula la proporción de veces que aparece el numero.

(check-expect (frecuencia-relativa 2 (list 1 2 3)) 1/3)
(check-expect (frecuencia-relativa 2 (list 2 2 2)) 1)

(define (frecuencia-relativa n l) (/  (frecuencia n l) (length l)))

;frec-rel-exp : Natural -> Number
;devuelve la frecuencia relativa de un valor en nuestro EXPERIMENTO:

(define (frec-rel-exp n) (frecuencia-relativa n EXPERIMENTO))

(define FRECUENCIAS-RELATIVAS (map frec-rel-exp VALORES))

