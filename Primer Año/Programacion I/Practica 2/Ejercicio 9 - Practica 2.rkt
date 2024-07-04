;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 9 - Practica 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))

;---Definicion de la funcion---

(define CUOTA-MENSUAL 650) ;referencia $650, el valor original de la cuota mensual
(define DESC-DOS-AMIGOS 0.1) ;referencia 10%, el descuento que obtiene c/uno sobre la cuota
(define DESC-MAS-AMIGOS 0.2) ;referencia 20%, el descuento que obtiene c/uno sobre la cuota
(define DESC-DOS-MESES 0.15) ;referencia 15%, el descuento que se obtiene al abonar dos meses juntos
(define DESC-MAS-MESES 0.25) ;referencia 25%, el descuento que se obtiene al abonar tres o mas meses juntos
(define DESC-MAX 0.35) ;referencia 35%, el descuento maximo que se puede hacer

;Number -> Number
;Dependiendo la cantidad de personas, aplica un descuento segun la promocion.
;-Ejemplos-
;(check-expect (descuento-persona 4) 0.2)
;(check-expect (descuento-persona 2) 0.1)
;(check-expect (descuento-persona 1) 0)
(define (desc-persona persona)
  (cond [(>= persona 3) DESC-MAS-AMIGOS]
        [(= persona 2)DESC-DOS-AMIGOS]
        [else 0])) 

;Number -> Number
;Dependiendo la cantidad de meses, aplica un descuento segun la promocion.
;-Ejemplos-
;(check-expect (desc-meses 4) 0.25)
;(check-expect (desc-meses 2) 0.15)
;(check-expect (desc-meses 1) 0)
(define (desc-meses meses)
  (cond [(>= meses 3) DESC-MAS-MESES]
        [(= meses 2) DESC-DOS-MESES]
        [else 0]))

;Number Number -> Number
;Dependiendo de la cantidad de personas y de meses,
;calcula el descuento total dependiendo la promocion y el valor maximo.
;-Ejemplos-
;(check-expect (desc-total 4 5) 0.35)
;(check-expect (desc-total 2 2) 0.25)
;(check-expect (desc-total 1 1) 0)
(define (desc-total persona meses)
  (min(+ (desc-persona persona) (desc-meses meses))DESC-MAX))

;Number -> Number
;Dependiendo de los meses, calcula el precio sin descuento.
;-Ejemplos-
;(check-expect (monto-bruto 2) 1300)
;(check-expect (monto-bruto 5) 3250)
;(check-expect (monto-bruto 1) 650)
(define (monto-bruto meses)
  (* CUOTA-MENSUAL meses))

;Number Number -> Number
;Dependiendo un monto de dinero y un descuento,
;se calcula el descuento que se aplico.
;-Ejemplos-
;(check-expect (aplicar-desc 1300 0.15) 1105)
;(check-expect (aplicar-desc 3250 0.25) 2437.5)
;(check-expect (aplicar-desc 650 0) 650)
(define (aplicar-desc monto descuento)
  (* monto (- 1 descuento)))


;Representamos la cantidad de personas que se anotan,
;la cantidad de meses que abonan y el monto con numeros
;Number Number -> Number
;Dependiendo de la cantidad de personas y de los meses,
;calcula el monto que debe pagar cada persona el instituto
;(check-expect (monto-persona 2 2) 975)
;(check-expect (monto-persona 3 5) 2112.5)
(define (monto-persona persona meses)
  (aplicar-desc (monto-bruto meses) (desc-total persona meses)))