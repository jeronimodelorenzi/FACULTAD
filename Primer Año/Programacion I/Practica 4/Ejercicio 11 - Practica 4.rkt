;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 11 - Practica 4|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Definimos la estructura Casa

(define-struct Casa [propietario direccion superficie zona])
;Casa es del tipo [String String Number String]
;Propietario corresponde al nombre de la persona que vende la casa.
;Direccion corresponde a la direccion de la casa.
;Superficie corresponde a la superficie de la casa en metros cuadrados.
;Zona corresponde al tipo de zona en la que se encuentra, en consecuencia cambia el valor.

(define ZONA-A 20000)
(define ZONA-B 15000)
(define ZONA-C 10000)
(define ZONA-D 5000)

(define SELLADO-MILLON 5)
(define SELLADO-NORMAL 3)

;verificar-zona : Casa -> Boolean

(check-expect (verificar-zona (make-Casa "Messi Carlos" "Ov.La 4" 250 "A")) #t )

(define (verificar-zona casa)
  (or (string=? (Casa-zona casa) "A")
      (string=? (Casa-zona casa) "B")
      (string=? (Casa-zona casa) "C")
      (string=? (Casa-zona casa) "D")))

;precio-zona: Casa -> Number
;Dada una Casa, nos devuelve el precio por m2, dependiendo de la zona
;en la que se encuentre.

(check-expect (precio-zona (make-Casa "Messi Carlos" "Ov.La 4" 250 "A")) ZONA-A)

(define (precio-zona casa)
  (cond [(string=? (Casa-zona casa) "A") ZONA-A]
        [(string=? (Casa-zona casa) "B") ZONA-B]
        [(string=? (Casa-zona casa) "C") ZONA-C]
        [(string=? (Casa-zona casa) "D") ZONA-D]))

;porcentaje-recibir: Number -> Number
;Recibe un descuento en porcentaje, y nos devuelve el porcentaje de la casa
;que tenemos que pagar. Hacemos una conversion de porcentaje,
;sabiendo que 100% es 1, 0% es 0, 50% es 0.5, etc.

(check-expect (porcentaje-recibir SELLADO-MILLON) 0.95)

(define (porcentaje-recibir descuento)
  (- 1 (/ descuento 100)))

(check-expect (monto (make-Casa "Messi Carlos" "Ov.La 4" 250 "A")) 4750000)

;monto : Casa -> Number
;Recibe una Casa y nos devuelve el monto que recibe el vendedor por vender la casa.
;Aqui aplicamos los precios que se descontaran por la venta.

(define (monto casa)
  (if (>= (* (Casa-superficie casa)(precio-zona casa)) 1000000)
      (* (Casa-superficie casa)(precio-zona casa) (porcentaje-recibir SELLADO-MILLON))
      (* (Casa-superficie casa)(precio-zona casa) (porcentaje-recibir SELLADO-NORMAL))))

(define (construye-frase propietario direccion monto)
  (string-append "El señor "
                 propietario " recibira "
                 (number->string monto)
                 " pesos por la venta de su propiedad ubicada en la calle " direccion))



(define (venta casa)
  (if (not (Casa? casa)) "Tipo de dato incorrecto"
      (if (not(verificar-zona casa)) "No se puede calcular el precio de venta por no disponer de los valores del metro cuadrado para la zona solicitada"
                               (construye-frase (Casa-propietario casa)(Casa-direccion casa)(monto casa)))))
  

                 
