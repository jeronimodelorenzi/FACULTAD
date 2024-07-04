;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |Ejercicios - Practica 5.1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Ejercicio 1

(define lista5nombres(cons "Jeronimo"
                           (cons "Rocio"
                                 (cons "Paco"
                                       (cons "Pepe"
                                             (cons "Turin" '()))))))
;Ejercicio 2

;(cons "1" (cons "2" '())) es un ejemplo de lista de contactos porque sus valores son
;Strings y al estar definida asi esta bien. En cambio (cons 2 '()) no lo es pues
;su primer elemento es un Number que no esta definido en la lista Contactos.

;Ejercicio 3

;Booleanos es:
;- una lista vacia '()
;- una expresion del tipo (cons Boolean Booleanos)

;Ejercicio 4

; contiene-Marcos? : Contactos -> Booleano
; dada una lista de Contactos, determina si "Marcos" es un elemento de la misma
(check-expect (contiene-Marcos? '()) #false)
(check-expect (contiene-Marcos? (cons "Sara" (cons "Pedro" (cons "Esteban" '())))) #false)
(check-expect (contiene-Marcos? (cons "A" (cons "Marcos" (cons "C" '())))) #true)
(check-expect (contiene-Marcos? (cons "Juan" '())) #false)
(check-expect (contiene-Marcos? (cons "Marcos" '())) #true)

(define (contiene-Marcos? l)
  (cond [(empty? l) #false]
        [(cons? l) (if (string=? (first l) "Marcos")
                       #true
                       (contiene-Marcos? (rest l)))]))

;Ejercicio 5
;Lista-de-contactos es:
;- '()
;- una expresion del tipo (cons Nombre-persona Lista-de-contactos)


;contiene? : Lista-de-contactos String -> Boolean
;Dada una lista de contactos, determina si un nombre está en la lista.

(check-expect (contiene? (list "Messi" "Paco" "Pedro") "Messi") #t)
(check-expect (contiene? (list "Messi" "Paco" "Pedro") "Pedro") #t)
(check-expect (contiene? (list "Messi" "Paco" "Pedro") "Jero") #f)

(define (contiene? l nombre)
  (cond [(empty? l) #f]
        [(cons? l) (if (member? nombre l) #t #f)]))        ;Una opcion

#|(define (contiene? l nombre)
  (cond [(empty? l) #f]
        [(cons? l) (or (string=? nombre (first l))        ;Otra opcion.
                       (contactos? (rest l) nombre))]))|#

;Ejercicio 7

;Una Lista-de-montos es:
;– '()
;– (cons NumeroPositivo Lista-de-montos)
;Lista-de-montos representa una lista con montos de dinero.

(define lista1 (list 1 2 3 4 5))
(define lista2 (list 6 7 8 9 10))
(define lista3 (list -6 7 8 9 10))

;suma : Lista-de-montos -> Number
;Dada una lista, nos devuelve la suma de los montos de la lista.

(check-expect (suma lista1) 15)
(check-expect (suma lista2) 40)
(check-expect (suma '()) 0)

(define (suma l)
  (cond [(empty? l) 0]
        [(cons? l) (+ (first l) (suma (rest l)))]))

;Ejercicio 8

;Una Lista-de-numeros es:
;– '()
;– (cons Numero Lista-de-numeros)

;pos? : Lista-de-numeros -> Boolean
;Dada una lista, nos dice si los valores de la lista estan definidos.

(check-expect (pos? (list 2 3 4)) #t)

(define (pos? l)
  (cond [(empty? l) #t]
        [(cons? l) (and (>= (first l) 0) (pos? (rest l)))]))

;checked-suma : Lista-de-numeros -> Number
;Dada una lista, si los elementos de la lista estan bien definidos los suma.

(check-expect (checked-suma lista1) 15)
(check-expect (checked-suma lista3) "La funcion espera Lista-de-montos")

(define (checked-suma l)
    (if (pos? l)
        (suma l)
        "La funcion espera Lista-de-montos"))

;Ejercicio 9

;Una Lista-Boolean es:
; - '()
; - (cons Boolean Lista-Boolean)

;todos-verdaderos : Lista-Boolean -> Boolean
;Dada la lista, si todos los valores son booleanos devuelve verdadero,
;caso contrario falso.

(check-expect (todos-verdaderos (list #t #t #t)) #t)
(check-expect (todos-verdaderos (list #t #t #f)) #f)
(check-expect (todos-verdaderos (list)) #t)

(define (todos-verdaderos l)
  (cond [(empty? l) #t]
        [(cons? l) (and (first l)(todos-verdaderos (rest l)))]))

;uno-verdadero : Lista-Boolean -> Boolean
;Dada una lista, devuelve verdadero si solo un elemento es verdadero.

(check-expect (uno-verdadero (list #f #t #f)) #t)
(check-expect (uno-verdadero (list #t #f #f)) #t)
(check-expect (uno-verdadero (list)) #f)
(check-expect (uno-verdadero (list #f #f #f)) #f)

(define (uno-verdadero l)
  (cond [(empty? l) #f]
        [(cons? l) (if (boolean=? (first l) #t)
                       #t
                       (uno-verdadero (rest l)))]))

;Ejercicio 10

;Una Lista-elementos es:
;- '()
;- (cons Elemento Lista-elementos)

;cant-elementos : Lista-elementos -> Number
;Dada una lista, nos devuelve la cantidad de elementos.

(check-expect (cant-elementos lista1) 5)
(check-expect (cant-elementos (list)) 0)

(define (cant-elementos l)
  (cond [(empty? l) 0]
        [(cons? l) (+ 1 (cant-elementos (rest l)))]))

;Ejercicio 11

;Tomamos Lista-de-montos.

;promedio : Lista-de-montos -> Number
;Dada una lista, nos calcula el promedio de los elementos.

(check-expect (promedio lista1) 3)
(check-expect (promedio lista2) 8)

(define (promedio l)
  (cond [(empty? l) 0]
        [(cons? l) (/ (suma l) (cant-elementos l))]))

;Ejercicio 12

;Una Lista-numeros es:
;- '()
;- (cons Numero Lista-numeros)

;pares : Lista-numeros -> list(Number)
;Dada una lista, nos devuelve una lista con los numeros pares.

(check-expect (pares (list 1 2 3 4 5 6 7 8 9 10)) (list 2 4 6 8 10))
(check-expect (pares (list 1 3 5 7 9)) empty)
(check-expect (pares empty) empty)


(define (pares l)
  (cond [(empty? l) empty]
        [(cons? l) (if (even? (first l))
                       (cons (first l) (pares (rest l)))
                       (pares (rest l)))]))

;Ejercicio 13

;Una Lista-palabras es:
;- '()
;- (cons Palabra Lista-palabras)

;cortas : Lista-palabras -> list(String)
;Dada una lista, nos devuelve una lista con las palabras de longitud menor a 5.

(check-expect (cortas (list "Mama" "Pacos" "Matambrito" "Messi" "Luxemburgo" "Patanes")) (list "Mama" "Pacos" "Messi"))
(check-expect (cortas (list "Matambrito" "Luxemburgo" "Patanes")) empty)
(check-expect (cortas empty) empty)

(define (cortas l)
  (cond [(empty? l) l]
        [(cons? l) (if (<= (string-length (first l)) 5)
                       (cons (first l) (cortas (rest l)))
                       (cortas (rest l)))]))

;Ejercicio 14

;mayores : List(Number) Number -> List(Number)
;Dada una lista de numeros y un numero n, nos devuelve una lista
;con los numeros mayores al n.

(check-expect (mayores lista1 2) (list 3 4 5))
(check-expect (mayores lista2 11) empty)
(check-expect (mayores empty 1) empty)

(define (mayores l n)
  (cond [(empty? l) empty]
        [(cons? l) (if (> (first l) n)
                       (cons (first l) (mayores(rest l) n))
                       (mayores (rest l ) n))]))

;Ejercicio 15

(define MAX 5)

;distancia : Posn -> Number
;Dada una estructura posn nos devuelve la distancia al origen.

(check-expect (distancia (make-posn 4 3)) 5)
(check-expect (distancia (make-posn 0 3)) 3)

(define (distancia p)
  (sqrt (+ (sqr (posn-x p)) (sqr (posn-y p)))))

;cerca : List(posn) -> List(posn)
;Dada una lista de estructuras posn devuelve los puntos que estan
;a distancia menor a MAX.

(check-expect (cerca
               (list (make-posn 3 5)
                     (make-posn 1 2)
                     (make-posn 0 1)
                     (make-posn 5 6))) (list (make-posn 1 2) (make-posn 0 1)))
(check-expect (cerca empty) empty)
(check-expect (cerca
               (list (make-posn 3 4)
                     (make-posn 10 10))) empty)
(check-expect (cerca
               (list (make-posn 1 1)
                     (make-posn 10 10))) (list (make-posn 1 1)))
(check-expect (cerca
               (list (make-posn 15 23)
                     (make-posn 10 10))) empty)

(define (cerca l)
  (cond [(empty? l) empty]
        [(cons? l) (if (< (distancia(first l)) MAX)
                       (cons (first l) (cerca (rest l)))
                       (cerca (rest l)))]))

;Ejercicio 16

;positivos : List(Number) -> List(Number)
;Dada una lista de numeros devuelve una lista con aquellos numeros positivos.

(check-expect (positivos (list -1 -40 -23 2 5 6)) (list 2 5 6))
(check-expect (positivos (list -1 -40 -23 )) empty)

(define (positivos l)
  (cond [(empty? l) empty]
        [(cons? l) (if (> (first l) 0)
                       (cons (first l)(positivos (rest l)))
                       (positivos (rest l)))]))

;Ejercicio 17

;eliminar : list(Number) Number -> list(Number)
;Dada una lista de numeros y un numero n, nos devuelve una lista sin
;las ocurrencias del n.

(check-expect (eliminar (list 1 2 3 4 3 5 3 3 6 3) 3) (list 1 2 4 5 6))
(check-expect (eliminar (list 1 2 3 4) 5) (list 1 2 3 4))
(check-expect (eliminar (list 1 2 3 4) 4) (list 1 2 3))
(check-expect (eliminar (list 1 4 3 4) 4) (list 1 3))
(check-expect (eliminar (list 5 5 5 5) 5) empty)
(check-expect (eliminar empty 5) empty)

(define (eliminar l n)
  (cond [(empty? l) empty]
        [(cons? l) (if (not(= (first l) n))
                   (cons (first l)(eliminar (rest l) n))
                   (eliminar(rest l) n))]))

;Ejercicio 18
;raices : list(Number) -> list(Number)
;Dada una lista de numeros, nos devuelve otra lista
;con las raices cuadradas de cada numero.

(check-expect (raices (list  0 1 4 9 16 25)) (list 0 1 2 3 4 5))

(define (raices l)
  (cond [(empty? l) empty]
        [(cons? l) (if (>= (first l) 0)
                       (cons (sqrt (first l))(raices (rest l)))
                       (raices (rest l)))]))

;Ejercicio 19
;distancias : list(posn) -> list(Number)
;Dada una lista de puntos en el plano, devuelve una lista con las distancia.

(check-expect (distancias (list (make-posn 3 4) (make-posn 10 0))) (list 5 10))
(check-expect (distancias (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) (list 5 4 13))
(check-expect (distancias empty) empty)

(define (distancias l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (distancia (first l)) (distancias (rest l)))]))

;Ejercicio 20
;anchos : list(Image) -> list(Number)
;Dada una lista de imagenes, nos devuelve el ancho de cada una.

(check-expect (anchos
               (list (circle 30 "solid" "red")
                     (rectangle 10 30 "outline" "blue"))) (list 60 10))
(check-expect (anchos empty) empty)

(define (anchos l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (image-width (first l))(anchos (rest l)))]))

;Ejercicio 21

;signo: Number -> Number
;Toma un numero como argumento y devuelve 0 si es 0, 1 si es positivo
;y -1 si es negativo

(check-expect (signo 0) 0)
(check-expect (signo 4) 1)
(check-expect (signo -4) -1)

(define (signo x)
        (cond [(< x 0) -1]
              [(= x 0) 0]
              [(> x 0) 1]
              ))

;signos: List(Number) -> List(Number)
;Dada una lista de numeros nos devuelve una lista con los signos de
;cada uno de los elementos, de acuerdo a la funcion signo.

(check-expect (signos (list 0 1 2 0 -4 -4 2)) (list 0 1 1 0 -1 -1 1))
(check-expect (signos empty) empty)
(check-expect (signos (list -2 -1 0 0 1 2)) (list -1 -1 0 0 1 1))

(define (signos l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (signo (first l)) (signos (rest l)))]))

;Ejercicio 22
;cuadrados : list(Number) -> list(Number)
;Dada una lista de numeros, devuelve una lista con los cuadrados de los numeros.

(check-expect (cuadrados empty) empty)
(check-expect (cuadrados (list 1 2 3)) (list 1 4 9))

(define (cuadrados l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (sqr (first l)) (cuadrados (rest l)))]))

;Ejercicio 23
;longitudes : list(String) -> list(Number)
;Dada una lista de palabras, nos devuelve la longitud de cada palabra.

(check-expect (longitudes (list "Hola" "" "Mundo")) (list 4 0 5))
(check-expect (longitudes empty) empty)

(define (longitudes l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (string-length (first l)) (longitudes (rest l)))]))

;Ejercicio 24

;fahr->celsius : Number -> Number
;Dada una temperatura en grados Fahrenheit, la convierte en Celsius.

(check-expect (fahr->celsius 32) 0)
(check-expect (fahr->celsius 33.8) 1)

(define (fahr->celsius n)
  (*(- n 32) 5/9))

;Una Lista-de-temperaturas es:
;- '()
;(cons Number Lista-de-temperaturas)

;convertirFC : Lista-de-temperaturas -> Lista-de-temperaturas
;Dada una lista de temperaturas en grados Fahrenheit,
;nos devuelve una lista de temperaturas en grados Celsius.

(check-within (convertirFC (list 32 100)) (list 0 37.7) 0.10)
(check-expect (convertirFC empty) empty)

(define (convertirFC l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (fahr->celsius (first l)) (convertirFC (rest l)))]))

;Ejercicio 25

;prod : list(Number) -> Number
;Dada una lista de numeros, devuelve una lista de los productos.

(check-expect (prod empty) 1)
(check-expect (prod (list 1 2 3 4 5)) 120)

(define (prod l)
  (cond [(empty? l) 1]
        [(cons? l) (* (first l) (prod (rest l)))]))

;Ejercicio 26

;pegar : list(String) -> String
;Dada una lista de string, devuelve la concatenacion de todos los elementos.

(check-expect (pegar empty) "")
(check-expect (pegar (list "Las " "lis" "tas " "son " "complicadas" "."))
              "Las listas son complicadas.")

(define (pegar l)
  (cond [(empty? l) ""]
        [(cons? l) (string-append (first l) (pegar (rest l)))]))

;Ejercicio 27

;Una Lista-numeros-naturales es:
;- '()
;- (cons NumerosNaturales Lista-numeros-naturales)

;maximo : Lista-numeros-naturales -> Number
;Dada una lista de numeros naturales, devuelve el mas grande de la lista.

(check-expect (maximo (list 23 543 325 0 75)) 543)
(check-expect (maximo empty) 0)

(define (maximo l)
  (cond [(empty? l) 0]
        [(cons? l) (if (> (first l) (maximo (rest l)))
                       (first l)
                       (maximo (rest l)))]))

;Ejercicio 28

;sumdist : list(posn)-> Number
;Dada una lista de puntos en el plano, devuelva la suma de las distancia.

(check-expect (sumdist empty) 0)
(check-expect (sumdist (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) 22)

(define (sumdist l)
  (cond [(empty? l) 0]
        [(cons? l) (+ (distancia (first l)) (sumdist (rest l)))]))

;Ejercicio 29

;sumcuad : list(Number) -> Number
;Dada una lista de numeros, devuelve la suna de sus cuadrados.

(check-expect (sumcuad empty) 0)
(check-expect (sumcuad (list 1 2 3)) 14)

(define (sumcuad l)
  (cond [(empty? l) 0]
        [(cons? l) (+ (sqr (first l)) (sumcuad (rest l)))]))