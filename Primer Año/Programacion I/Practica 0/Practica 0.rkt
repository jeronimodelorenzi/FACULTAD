;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Practica 0|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;EXPRESIONES
;1)
(-(* 12 5)(* 7 6))

( -(* 3 5)( +(/ (* 7 4) 14)(/ 3 1)))

(+(cos 0.8) 1/5 (* (sin 0.5) 3.5))

;2)
(/ 1 (sin (sqrt 3)))

(* (sqrt 2) (sin pi))

(+ 3 (sqrt (- 4)))

(* (sqrt 5) (sqrt (/ 3 (cos pi))))

;(/ (sqrt 5) (sin (* 3 0))) No se puede resolver porque se esta dividiendo un n° por 0.

;(/ (+ 3) (* 2 4)) El (+ 3) necesitaria un argumento mas.

(* 1 2 3 4 5 6 7 8)

(/ 120 2 3 2 2 5)

;3)

(log 10 5)

(tan 20)

(expt 5 1/2)

(random 8)

(random (max 8))

(random (min 8))

(floor 2.5);Redondea al numero mas chico.

(ceiling 2.5);Redondea al numero mas grande.

(abs -2); Valor abosoluto.

;STRINGS
;1)
(string-append "Hola" "mundo")

(string-append "Pro" "gra" "ma."); Concatena strings.

(number->string 1357); Coniverte un n° en string.

;(string-append "La respuesta es " (+ 21 21)) No es correcta ya que no puede concatenar un string y un n°.

(string-append "La respuesta es " (number->string (+ 21 21))); Convierte el resultado de la suma en string y lo concatena con otro string.

(* (string-length "Hola") (string-length "Chau"));Evalua los caracteres de cada string y los multiplica.

(substring "Programar" 2 2);Devuelve un string vacio.

;(substring "Programar" 2 1);Devuelve error.

;(substring "Programar" 2 10);Devuelve error.

;(substring "Programar" -1 6);Devuelve error.

;BOOLEANS
;1)
(not #t)

(or #t #f)

(and #t #f)

(and #t (or #f (not #f)) (not #t))

(not (= 2 (* 1 3)))

(or (= 2 (* 1 3)) (< 4 (+ 3 2)));

;2)
(> (cos 0) 0)

(=(string-length "Hola, mundo") 14)

(and (< 3 pi) (< pi 4))

(=(sqr 5) (sqrt 625))

(not(string=? "a" (string-ith "Ada Lovelace" 2)))

;IMAGENES
;1)
(circle 100 "solid" "red");(circle 10 "solid" "red") Se modifico el radio.
(circle 10 "solid" "blue");(circle 10 "solid" "red") Se modifico el color.
(circle 10 "outline" "red");(circle 10 "solid" "red") Se modifico el relleno de la figura.

(rectangle 5 20 "solid" "blue");(rectangle 10 20 "solid" "blue") Se modifico el width.

(rectangle 20 12 "solid" "black");(rectangle 20 12 "outline" "magenta") Se modifico el color y el relleno

(overlay (rectangle 20 20 "outline" "blue") (circle 7 "solid" "green"));"overlay" (Inserta una imagen dentro de la otra).
;(overlay (rectangle 20 20 "solid" "blue") (circle 7 "solid" "green"))Se modifico el relleno del rectangulo.

(empty-scene 100 100)

(place-image (circle 10 "solid" "blue") 40 80 (empty-scene 100 100));"place-image" (Inserta una imagen dentro de otra en las cordenadas deseadas).

(+ (image-width (circle 10 "solid" "red")) (image-height (rectangle 10 20 "solid" "blue")))

;FUNCIONES

(define (f x) (+ x 1))

(define (doble x) (* x 2))

(define (h x y) (< x (* 2 y)))

(define (g x y) (< x (doble y)))

(define (cuad-azul x) (square x "solid" "blue"))

;1)
(cuad-azul (doble 20))

(and (h 2 3) (h 3 4))

(= (f 1) (doble 1))

;2)

(define (dist-origen x y)
  (sqrt(+ (sqr x)(sqr y))))
(dist-origen 2 3)

;3)

(define (dist-numeros x1 x2 y1 y2)
  (sqrt(+ (sqr(- x1 x2)) (sqr(- y1 y2)))))
(dist-numeros 1 2 3 4)

;4)

   

;5)

(define (area-cubo x) (* 6 (sqr x)))
(area-cubo 2)

;6)

(define (metro-pie x) (* x 3.281))
(metro-pie 3)

;7)

(define (cel-far x) (+ (* x 9/5) 32))
(cel-far 10)

;8)

(define (posible? x y z) (and (>(+ x y) z) (>(+ x z) y) (>(+ y z) x)))
(posible? 1 3 4)

;9)

(define (pitagorica? x y z) (= (sqr z)(+ (sqr x)(sqr y))))
(pitagorica? 3 4 5)

;10)

(define (suma-long x y) (+ (string-length x) (string-length y)))
(suma-long "hola" "chau")

;11)

(define (comienza? x) (string=? "a" (string-ith x 0)))
(comienza? "andate")

;12)

(define (poner- x i) (string-append (substring x 0 i)"-" (substring x i)))
(poner- "hola" 2)

;PRUEBA
(string-append (substring "Buen año" 0 5) "comienzo de " (substring "Buen año" 5))
