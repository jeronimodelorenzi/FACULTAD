;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Ejercicios - Practica 5.2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;Ejercicio 1

;a-12

;pares: List(Number) -> List(Number)
;Dada una lista de numeros,nos devuelve una nueva lista con los
;numeros pares.

(check-expect (pares (list 1 2 3 4 5 6 7 8 9 10)) (list 2 4 6 8 10))
(check-expect (pares (list 1 3 5 7 9)) empty)
(check-expect (pares empty) empty)

(define (pares l) (filter even? l))

;a-13

;menor5?: String -> Boolean
;Dado un String,nos determina si este tiene una longitud menor a 5.

(check-expect (menor5? "hola!") #true)
(check-expect (menor5? "hola") #true)
(check-expect (menor5? "Buenos días") #false)

(define (menor5? s) (<= (string-length s) 5))

(check-expect (cortas (list "Mama" "Pacos" "Matambrito" "Messi" "Luxemburgo" "Patanes")) (list "Mama" "Pacos" "Messi"))
(check-expect (cortas (list "Matambrito" "Luxemburgo" "Patanes")) empty)
(check-expect (cortas empty) empty)

(define (cortas l) (filter menor5? l))

;a-15

;Ejercicio 15

(define MAX 5)

;distancia : Posn -> Number
;Dada una estructura posn nos devuelve la distancia al origen.

(check-expect (distancia (make-posn 4 3)) 5)
(check-expect (distancia (make-posn 0 3)) 3)

(define (distancia p)
  (sqrt (+ (sqr (posn-x p)) (sqr (posn-y p)))))

;distanciaMAX? : posn -> Boolean
;Dado la distancia de al origen de dos puntos, nos devuelve #t si es menor al MAX

(check-expect (distanciaMAX? (make-posn 4 3)) #f)
(check-expect (distanciaMAX? (make-posn 0 3)) #t)

(define (distanciaMAX? p)
  (< (distancia p) MAX))

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

(define (cerca l)(filter distanciaMAX? l))

;a-16

;positivos : List(Number) -> List(Number)
;Dada una lista de numeros devuelve una lista con aquellos numeros positivos.

(check-expect (positivos (list -1 -40 -23 2 5 6)) (list 2 5 6))
(check-expect (positivos (list -1 -40 -23 )) empty)

(define (positivos l)(filter positive? l))

;a-17 [Sin completar]
;igual-0? Number -> Boolean
;Dado un numero, nos dice si no es igual a 0.

(check-expect (igual-0? 1) #t)
(check-expect (igual-0? 0) #f)
(define (igual-0? a) (not(= a 0)))

;eliminar-0 : List(Number) -> List(Number)
;Dada una lista de numeros, nos devuelve una lista nueva borrando ocurrencias del 0.

(check-expect (eliminar-0 (list 1 0 0 0 7 6 0)) (list 1 7 6))
(check-expect (eliminar-0 empty) empty)

(define (eliminar-0 l) (filter igual-0? l))

(check-expect (eliminar (list 1 2 2 3 4 5 7 6 2 2 8) 2) (list 1 3 4 5 7 6 8))

(define (eliminar l n)
  (local [(define (n=? x) (not(= x n)))] (filter n=? l)))

;Ejercicio 8

;raices : list(Number) -> list(Number)
;Dada una lista de numeros, nos devuelve otra lista
;con las raices cuadradas de cada numero.

(check-expect (raices (list  0 1 4 9 16 25)) (list 0 1 2 3 4 5))

(define (pos0? x)
  (>= x 0))

(define (raices l) (map sqrt (filter pos0? l)))

;Ejercicio 9
;distancias : list(posn) -> list(Number)
;Dada una lista de puntos en el plano, devuelve una lista con las distancia.

(check-expect (distancias (list (make-posn 3 4) (make-posn 10 0))) (list 5 10))
(check-expect (distancias (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) (list 5 4 13))
(check-expect (distancias empty) empty)

(define (distancias l) (map distancia l))

;Ejercicio 10
;anchos : list(Image) -> list(Number)
;Dada una lista de imagenes, nos devuelve el ancho de cada una.

(check-expect (anchos
               (list (circle 30 "solid" "red")
                     (rectangle 10 30 "outline" "blue"))) (list 60 10))
(check-expect (anchos empty) empty)

(define (anchos l)(map image-width l))

;Ejercicio 11

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

(define (signos l)(map signo l))

;Ejercicio 12

;cuadrados : list(Number) -> list(Number)
;Dada una lista de numeros, devuelve una lista con los cuadrados de los numeros.

(check-expect (cuadrados empty) empty)
(check-expect (cuadrados (list 1 2 3)) (list 1 4 9))

(define (cuadrados l)(map sqr l))

;Ejercicio 13

;longitudes : list(String) -> list(Number)
;Dada una lista de palabras, nos devuelve la longitud de cada palabra.

(check-expect (longitudes (list "Hola" "" "Mundo")) (list 4 0 5))
(check-expect (longitudes empty) empty)

(define (longitudes l)(map string-length l))

;Ejercicio 14

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

(define (convertirFC l)(map fahr->celsius l))

;Ejercicio 15

;prod : list(Number) -> Number
;Dada una lista de numeros, devuelve una lista de los productos.

(check-expect (prod empty) 1)
(check-expect (prod (list 1 2 3 4 5)) 120)

(define (prod l)(foldr * 1 l))

;Ejercicio 16

;pegar : list(String) -> String
;Dada una lista de string, devuelve la concatenacion de todos los elementos.

(check-expect (pegar empty) "")
(check-expect (pegar (list "Las " "lis" "tas " "son " "complicadas" "."))
              "Las listas son complicadas.")

(define (pegar l)(foldr string-append "" l))

;Ejercicio 17

;Una Lista-numeros-naturales es:
;- '()
;- (cons NumerosNaturales Lista-numeros-naturales)

;maximo : Lista-numeros-naturales -> Number
;Dada una lista de numeros naturales, devuelve el mas grande de la lista.

(check-expect (maximo (list 23 543 325 0 75)) 543)
(check-expect (maximo empty) 0)

(define (maximo l)(foldr max 0 l))

;Ejercicio 18

; cuadrados : ListN -> ListN
; calcula los cuadrados de todos los elementos de una lista de números

(check-expect (cuadrados! (list 1 2 3 4 5)) (list 1 4 9 16 25))
(check-expect (cuadrados! empty) empty)
(check-expect (cuadrados! (list 11 13 9)) (list 121 169 81))

(define (cuadrados! l) (map sqr l))

; suma : ListN -> Number
; suma todos los elementos de una lista de números

(check-expect (suma! (list 1 2 3 4 5)) 15)
(check-expect (suma! empty) 0)
(check-expect (suma! (list 11 13 9)) 33)

(define (suma! l) (foldr + 0 l))

; sumcuad : ListN -> Number
; suma los cuadrados de una lista de números

(check-expect (sumcuad (list 1 2 3 4 5)) 55)
(check-expect (sumcuad empty) 0)
(check-expect (sumcuad (list 11 13 9)) 371)

(define (sumcuad l) (suma! (cuadrados! l)))

;Ejercicio 19

;sumdist : List(posn)-> Number
;Dada una lista de puntos en el plano, devuelva la suma de las distancia.

(check-expect (sumdist empty) 0)
(check-expect (sumdist (list (make-posn 3 4) (make-posn 0 4) (make-posn 12 5))) 22)

(define (sumdist l)(foldr + 0 (map distancia l)))

;Ejercicio 20

;multPar : List(Number) -> Number
;Dada una lista de numeros, devuelve el producto de los numeros pares.

(check-expect (multPar (list 1 2 3 4 5 6)) 48)

(define (multPar l)(foldr * 1 (filter even? l)))

;Ejercicio 21

;sumAbs : List(Number) -> Number
;Dada una lista de numeros, devuelve la suma de los valores absolutos.

(check-expect (sumAbs (list 3 -2 4 0 1 -5)) 15)

(define (sumAbs l)(foldr + 0 (map abs l)))

;Ejercicio 22

;positivo-0 : Number -> Boolean
;Dado un numero, nos devuelve si es positivo, incluyendo al 0
(define (positivo-0? a) (>= a 0))

;raices : List(Number) -> List(Number)
;Dada una lista de numeros, devuelve una lista con las raices cuadradas
;de los numeros no negativos.

(check-expect (raices! (list 16 -4 9 0)) (list 4 3 0))

(define (raices! l)(map sqrt (filter positivo-0? l)))

;Ejercicio 23

(check-expect (area (rectangle 20 40 "solid" "red"))800)
(check-expect (area (circle 20 "solid" "red")) 1600)

(define (area img)(* (image-width img)(image-height img)))

(check-expect (ancha? (rectangle 20 40 "solid" "red")) #f)
(check-expect (ancha? (rectangle 50 40 "solid" "red")) #t)

(define (ancha? img) (> (image-width img) (image-height img)))

(check-expect (saa (list (circle 20 "solid" "red")
                         (rectangle 40 20 "solid" "blue")
                         (rectangle 10 20 "solid" "yellow")
                         (rectangle 30 20 "solid" "green"))) 1400)

(define (saa l)
  (foldr + 0 (map area (filter ancha? l))))

;Ejercicio 24

(check-expect (algun-pos (list (list 1 3 -4 -2) (list 1 2 3 -5) (list 4 -9 -7 8 -3))) #true)
(check-expect (algun-pos (list empty (list 1 2 3))) #true)
(check-expect (algun-pos (list (list -1 2 -3 4 -5) empty (list -3 -4))) #false)

(define (algun-pos l)
  (local[(define (suma-positiva? l)
    (> (foldr + 0 l) 0))]
  (ormap suma-positiva? l)))

  
;Ejercicio 25

(check-expect (long-lists (list (list 1 2 3 4 5) (list 1 2 3 4 5 6) (list 87 73 78 83 33))) #true)
(check-expect (long-lists (list '() '() (list 1 2 3))) #false)
(check-expect (long-lists (list (list 1 2 3 4 5) empty)) #false)

(define (long-lists l)
  (local[(define (mayor4? l)
           (> (length l) 4))]
    (andmap mayor4? l)))

;Ejercicio 26

(check-expect (todos-true (list 5 #true "abc" #true "def")) #true)
(check-expect (todos-true (list 1 #true (circle 10 "solid" "red") -12 #false)) #false)

(define (todos-true l)
  (foldr andp #t (filter boolean? l)))

(define (andp a b) (and a b))

;Ejercicio 27

(define-struct Alumno [nombre nota faltas])
; alumno (String, Number, Natural).
; - nombre representa el nombre del alumno.
; - nota representa la calificación obtenida por el alumno (entre 0 y 10).
; - faltas: número de clases a las el alumno no asistió.

(check-expect (destacado? (make-Alumno "Jeronimo" 9 2))#t)

;destacado? : Alumno -> Boolean
;Dada la nota del alumno, devuelve verdadero si la nota es mayor igual que 9.

(define (destacado? a)
  (>= (Alumno-nota a) 9))

(check-expect (destacado (list (make-Alumno "Jeronimo" 9 2)
                               (make-Alumno "Pablo" 10 5)
                               (make-Alumno "Pedro" 3 9)
                               (make-Alumno "Pi" 1 17)
                               (make-Alumno "Pepi" 7 6)))
              (list "Jeronimo" "Pablo"))

;destacado : List(Alumno) -> List(Alumno)
;Dada una lista de alumnos, devuelve una lista con los alumnos destacados.

(define (destacado l)(map Alumno-nombre (filter destacado? l)))

;condicion : Alumno -> String
;Dado un alumno, determina la condicion dependiendo de:
;- Si la nota es mayor o igual a 8, su condición es "Promovido".
;- Si la nota es menor a 6, su condición es "Libre".
;- En cualquier otro caso, la condición es "Regular".

(check-expect (condicion (make-Alumno "Jeronimo" 9 2)) "Promovido")
(check-expect (condicion (make-Alumno "Pablo" 10 5)) "Promovido")
(check-expect (condicion (make-Alumno "Pedro" 3 9)) "Libre")
(check-expect (condicion (make-Alumno "Pi" 1 17)) "Libre")
(check-expect (condicion (make-Alumno "Pepi" 7 6)) "Regular")

(define (condicion a)
  (cond [(< (Alumno-nota a) 6) "Libre"]
        [(and (>= (Alumno-nota a) 6)(< (Alumno-nota a) 8)) "Regular"]
        [else "Promovido"]))

;libre? : Alumno -> String
;Dado un alumno, nos dice si  esta libre.

(check-expect (libre? (make-Alumno "Jeronimo" 9 2)) #f)
(check-expect (libre? (make-Alumno "Pablo" 10 5)) #f)
(check-expect (libre? (make-Alumno "Pedro" 3 9)) #t)
(check-expect (libre? (make-Alumno "Pi" 1 17)) #t)
(check-expect (libre? (make-Alumno "Pepi" 7 6)) #f)

(define (libre? a)
  (string=? (condicion a) "Libre"))

;exito : List(Alumno) -> Boolean
;Dada una lista de alumnos, devuelve verdadero si ninguno esta libre.

(check-expect (exito (list (make-Alumno "Jeronimo" 9 2)
                               (make-Alumno "Pablo" 10 5)
                               (make-Alumno "Pedro" 3 9)
                               (make-Alumno "Pi" 1 17)
                               (make-Alumno "Pepi" 7 6))) #f)

(check-expect (exito (list (make-Alumno "Jeronimo" 9 2)
                           (make-Alumno "Pablo" 10 5))) #t)

(check-expect (exito (list(make-Alumno "Pi" 1 17)
                     (make-Alumno "Pepi" 7 6))) #f)

(define (exito l)(empty?(filter libre? l)))

;regular? : Alumno -> Boolean
;Dado un alumno, nos devuelve si es regular.

(check-expect (regular? (make-Alumno "Jeronimo" 9 2)) #f)
(check-expect (regular? (make-Alumno "Pablo" 10 5)) #f)
(check-expect (regular? (make-Alumno "Pedro" 3 9)) #f)
(check-expect (regular? (make-Alumno "Pi" 1 17)) #f)
(check-expect (regular? (make-Alumno "Pepi" 7 6)) #t)

(define (regular? a)
  (string=? (condicion a) "Regular"))

;sumar-faltas : Alumno Number -> Number
;Dado un alumno y un elemento neutro (0), nos devuelve las faltas.

(check-expect (sumar-faltas (make-Alumno "Jeronimo" 9 2) 0) 0)
(check-expect (sumar-faltas (make-Alumno "Pepi" 7 6) 0) 6)

(define (sumar-faltas a cero)
  (if (regular? a)
      (+ (Alumno-faltas a) cero)
      cero))

(check-expect (faltas-regulares (list (make-Alumno "Jeronimo" 9 2)
                               (make-Alumno "Pablo" 10 5)
                               (make-Alumno "Pedro" 3 9)
                               (make-Alumno "Pi" 1 17)
                               (make-Alumno "Pepi" 7 6))) 6)

(define (faltas-regulares l)(foldr sumar-faltas 0 (filter regular? l)))

;promovido? : Alumno -> Boolean
;Dado un alumno, nos devuelve si es promovido.

(check-expect (promovido? (make-Alumno "Jeronimo" 9 2)) #t)
(check-expect (promovido? (make-Alumno "Pablo" 10 5)) #t)
(check-expect (promovido? (make-Alumno "Pedro" 3 9)) #f)
(check-expect (promovido? (make-Alumno "Pi" 1 17)) #f)
(check-expect (promovido? (make-Alumno "Pepi" 7 6)) #f)

(define (promovido? a)
  (string=? (condicion a) "Promovido"))

;prom-faltas : Alumno -> Boolean
;Dado un alumno, si es promovido, devuelve si no falto a 3 clases o mas.

(check-expect (prom-faltas (make-Alumno "Jeronimo" 9 2)) #t)
(check-expect (prom-faltas (make-Alumno "Pablo" 10 5)) #f)
(check-expect (prom-faltas (make-Alumno "Pedro" 3 9)) #f)
(check-expect (prom-faltas (make-Alumno "Pi" 1 17)) #f)
(check-expect (prom-faltas (make-Alumno "Pepi" 7 6)) #f)

(define (prom-faltas a)
  (if (promovido? a)
      (not(>= (Alumno-faltas a) 3))
      #f))

;promovidos-ausentes : List(Alumnos) -> List(Alumno-nombre)
;Dada una lisa de alumnos, devuelve una lista con los alumnos promovidos
;que no faltaron a tres clases o mas.

(check-expect (promovidos-ausentes (list (make-Alumno "Jeronimo" 9 2)
                               (make-Alumno "Pablo" 10 5)
                               (make-Alumno "Pedro" 3 9)
                               (make-Alumno "Pi" 1 17)
                               (make-Alumno "Pepi" 7 6))) (list "Jeronimo"))

(define (promovidos-ausentes l)(map Alumno-nombre (filter prom-faltas l)))