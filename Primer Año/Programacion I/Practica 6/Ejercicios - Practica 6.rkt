;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Ejercicios - Practica 6|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;1)

;sumanat : Natural Natural -> Number
;Toma dos números naturales y sin usar + devuelve un natural que es la suma de ambos.

(check-expect (sumanat 2 3) 5)
(check-expect (sumanat 5 5) 10)
(check-expect (sumanat 1 3) 4)

(define (sumanat n1 n2)
  (cond [(zero? n2) n1]
        [(positive? n2) (sumanat (add1 n1)(sub1 n2))]))

;2)

;multiplicar : Natural Natural -> Number
;Toma dos numeros naturales y sin usar el * y + los multiplica.

(check-expect (multiplicar 3 9) 27)
(check-expect (multiplicar 7 2) 14)
(check-expect (multiplicar 3 3) 9)

(define (multiplicar n1 n2)
  (cond [(zero? n2) 0]
        [(positive? n2) (sumanat n1 (multiplicar n1 (sub1 n2)))]))

;3)

;powenat : Natural Natural -> Number
;Toma dos numeros naturales y devuelve el resultado de elevar
;el primero a la potencia del segundo.

(check-expect (powernat 2 0) 1)
(check-expect (powernat 0 2) 0)
(check-expect (powernat 3 3) 27)

(define (powernat n1 n2)
  (cond [(zero? n2) 1]
        [(positive? n2) (multiplicar n1 (powernat n1 (sub1 n2)))]))

;4)

;sigma ; Natural (Natural -> Number) -> Number
;Dados un numero natural y una funcion, devuelve la sumatoria de f
;para los valores de 0 hasta n.

(check-expect (sigma 4 sqr) 30)
(check-expect (sigma 10 identity) 55)

(define (sigma n f)
  (cond [(zero? n) (f 0)]
        [(positive? n) (+ (f n) (sigma (sub1 n) f))]))

;5)
;---G---

(check-expect (g 2) 1.125)
(check-within (g 3) 1.16 0.1)
(check-within (g 4) 1.177 0.01)

;g : Natural (Natural -> Number) -> Number
;Dado un numero natural, devuelve la sumatoria de de la funcion g
;(reciproco de un numero elevado al cubo), para los valores de 0 hasta n.

(define (g n)
  (cond [(zero? n) n]
        [(positive? n) (+ (/ 1 (expt n 3)) (g (sub1 n)))]))

;---R---

(check-expect (r 2) 0.75)
(check-expect (r 3) 0.875)
(check-expect (r 4) 0.9375)

;r : Natural (Natural -> Number) -> Number
;Dado un numero natural, devuelve la sumatoria de de la funcion r
;(reciproco de 2 elevado a la n), para los valores de 0 hasta n.

(define (r n)
  (cond [(zero? n) n]
        [(positive? n) (+ (/ 1 (expt 2 n)) (r (sub1 n)))]))

;---S---

(check-within (s 2) 1.16 0.1)
(check-within (s 3) 1.916 0.01)
(check-within (s 4) 2.716 0.01)

;s : Natural (Natural -> Number) -> Number
;Dado un numero natural, devuelve la sumatoria de de la funcion s
;(cociente entre n y n sumado a 1), para los valores de 0 hasta n.

(define (s n)
  (cond [(zero? n) n]
        [(positive? n) (+ (/ n (+ n 1)) (s (sub1 n)))]))

;---T---

;t : Natural (Natural -> Number) -> Number
;Dado un numero natural, devuelve la sumatoria de de la funcion t
;(reciproco de un numero sumado a 1), para los valores de 0 hasta n.

(check-within (t 2) 0.83 0.1)
(check-within (t 3) 1.083 0.01)
(check-within (t 4) 1.283 0.01)

(define (t n)
  (cond [(zero? n) n]
        [(positive? n) (+ (/ 1 (+ n 1)) (t (sub1 n)))]))

;6)

;intervalo : Natural -> List(Number)
;Dado un numero natural, devuelve la lista (list 1 2 ... n).

(check-expect (intervalo 4) (list 1 2 3 4))
(check-expect (intervalo 8) (list 1 2 3 4 5 6 7 8))
(check-expect (intervalo 2) (list 1 2))

(define (intervalo n)
  ;aux : Natural -> Number
  (local ((define (aux m)
           (cond [(zero? m) '()]
                 [(positive? m) (cons m (aux (sub1 m)))])))
  (reverse (aux n))))

;7)

;facnat : Natural -> Natural
;Toma un número natural y devuelve su factorial.

(check-expect (facnat 5) 120)
(check-expect (facnat 4) 24)
(check-expect (facnat 6) 720)

(define (facnat n)
  (cond [(zero? n) 1]
        [(positive? n) (* n (facnat (sub1 n)))]))

;8)

;fibnat : Natural -> Number
;Toma un número natural y devuelve el valor correspondiente a la secuencia de Fibonacci para ese valor.

(check-expect (fibnat 0) 1)
(check-expect (fibnat 5) 8)
(check-expect (fibnat 1) 1)

(define (fibnat n)
  (cond [(zero? n) 1]
        [(zero? (sub1 n)) 1]
        [(positive? n) (+ (fibnat (sub1 n)) (fibnat (sub1(sub1 n))))]))

;9)

;list-fibonacci : Natural -> List(Natural)
;Dado un número n devuelve una lista con los primeros n+1 valores de la serie de fibonacci, ordenados de mayor a menor.

(check-expect (list-fibonacci 4) (list 5 3 2 1 1))
(check-expect (list-fibonacci 0) (list 1))

(define (list-fibonacci n)
  (cond [(zero? n) (cons 1 '())]
        [(positive? n) (cons (fibnat n)(list-fibonacci (sub1 n)))]))

;10)

;aux-g : Natural -> Number
;Dado un numero natural devuelve la funcion g tal que :
;                                                       g(0) = 1
;                                                       g(1) = 2
;                                                       g(2) = 3
;                                                       g(n) = g (n-1) * g (n-2) * g (n-3) para todo n mayor o igual a 3.

(define (aux-g n)
  (cond [(zero? n) 1]
        [(= n 1) 2]
        [(= n 2) 3]
        [(>= n 3) (* n (aux-g (sub1 n)))]))

(check-expect (list-g 4)
              (list 36 9 3 2 1))
(check-expect (list-g 0)
              (list 1))

;list-g Natural -> List(Natural)
;dado un número n devuelve la lista con los valores que resulta de evaluar a g en n, n-1, n-2,...,0. 

(define (list-g n)
  (cond [(zero? n) (cons 1 '())]
        [(positive? n) (cons (aux-g n)(list-g (sub1 n)))]))

;11)

;componer: (Number -> Number) -> Natural -> Number
;Dados una función f, un número natural n y un valor x, devuelve el resultado de aplicar n veces la función f a x.

(check-expect (componer sqr 2 5) 625)
(check-expect (componer add1 5 13) 18)
(check-expect (componer identity 9999 100) 100)
(check-expect (componer sqrt 3 256) 2)

(define (componer f n x)
  (cond [(zero? n) x]
        [(positive? n) (f (componer f (sub1 n) x))]))

;12)

;multiplos : Natural Natural -> List(Natural)
;Dado dos numeros naturales, devuelve una lista con los primeros n multiplos positivos de m.

(check-expect (multiplos 4 7) (list 28 21 14 7))
(check-expect (multiplos 0 11) '())

(define (multiplos n m)
  (cond [(zero? n) '()]
        [(positive? n) (cons (* m n) (multiplos (sub1 n) m))]))


;13)

;funcion : Natural (Natural -> Boolean) -> Boolean
;Dado un numero natural y una funcion devuelve #t sii alguno de los valores es #t.

(check-expect (funcion 3 negative?) #false)
(check-expect (funcion 7 even?) #true)

(define (funcion n f)
  (cond [(zero? n) (f 0)]
        [else (or (f n) (funcion (sub1 n) f))]))

;14)

;circulos : Natural -> Image
;Dado un número natural n, devuelve una imagen cuadrada de tamaño 2*n^2 que contiene n círculos
;centrados en la imagen, con radios i^2 para todos los i naturales en [1,n].

(define (graficar-circulos n)
(circle n "outline" "slateblue"))

(define (circulos n)
  (local
    [
     (define LADO_ESCENA (* 2 (sqr n)))
     (define ESCENA_N (empty-scene LADO_ESCENA LADO_ESCENA))
     (define CENTRO (/ LADO_ESCENA 2))

     ; circulos-aux : Natural -> Image
     (define (circulos-aux m)
       (cond [(zero? m) ESCENA_N]
             [else (place-image (circle (sqr m) "outline" "blue")
                                CENTRO
                                CENTRO
                                (circulos-aux (sub1 m)))]))]
    ; -- IN --
    (circulos-aux n)))

;15)

(define ESCENA (empty-scene 200 200))

;graficar-cuadrados : Natural Number -> Image
;La función graficar-cuadrados toma un valor de lado lad y un ángulo ang,
;y a partir de ahí grafica un cuadrado de lado lad y lo rota en un ángulo ang.

(define (graficar-cuadrados lad ang)
(rotate ang (square lad "outline" "slateblue")))

;cuadrado : Natural Number -> Image
;La función cuadrados toma un valor inicial m y un ángulo ang,
;y dibuja una serie de m cuadrados con lados de tamaños de los cuadrados perfectos de 1 a m,
;rotando en 20 cada cuadrado.

(define (cuadrado m ang)
  (cond [(zero? m) ESCENA]
        [(positive? m) (place-image (graficar-cuadrados (sqr m) ang) 100 100 (cuadrado (sub1 m) (+ ang 20)))]))

;16)

(check-expect (cuotas 10000 0 18) '())
(check-expect (cuotas 10000 1 12) (list 10100))
(check-expect (cuotas 30000 3 12) (list 10100 10200 10300))
(check-expect (cuotas 100000 4 18) (list 25375 25750 26125 26500))

(define (cuotas total n i)
  (local ((define (cuantas-cuotas total n i j)
            (cond [(= j (add1 n)) '()]
                  [(positive? n) (cons (+ (/ total n) (* (/ total n) (/ i (* 100 12)) j))
                                      (cuantas-cuotas total n i (add1 j)))])))
    (cuantas-cuotas total n i 1)))

;Ejercicio 1 Parcial Naturales

(check-expect (fs 5)
              (list 0 2 5 5 9 19))
(check-expect (fs 0)
              (list 0))

;aux-g : Natural -> Number
;Dado un numero natural devuelve la funcion g tal que :
;                                                       f(0) = 0
;                                                       f(1) = 2
;                                                       f(2) = 5
;                                                       f(n) = f(n-1) + 2 * f(n-3) para todo n mayor o igual a 3.

(define (aux-f n)
  (cond [(zero? n) 0]
        [(= n 1) 2]
        [(= n 2) 5]
        [(>= n 3) (+ (aux-f (sub1 n)) (* 2 (aux-f (- n 3))))]))

;fs : Natural -> List(Natural)
;Dado un número n devuelve la lista con todos los valores entre (f 0) y (f n).

(define (fs n)
  (reverse
   (cond [(zero? n) (list 0)]
         [(positive? n) (cons (aux-f n) (reverse (fs (sub1 n))))])))

;Ejercicio 2 Parcial Naturales
    
(define ESCENAS (empty-scene 300 300))

;graficar-elipses : Natural -> Image
;La función dibujar-elipses toma un valor de lado n, y a partir de ahí grafica una elipse de tamaño:
;(10*n) * (5*n) , (10*(n-1)) * (5*(n-1)), ..., 20 * 10, 10 * 5,
;y lo rota coincidiendo con el valor del doble de n.

(define (dibujar-elipses n)
  (cond [(zero? n) ESCENAS]
        [(positive? n) (place-image (rotate (* n 2) (ellipse (* 10 n) (* 5 n) "outline" "blue")) 150 150 (dibujar-elipses (sub1 n)))]))

;Ejercicio 3 Parcial Naturales

;goldbach : Natural -> Posn
;Dado un número par n >= 4 encuentre dos números primos cuya suma resulte

(define (f n c)
       (cond [(< n (* c c)) #t]
             [(zero? (modulo n c)) #f]
             [else (f n (add1 c))]))
(define (prime? n) (f n 2))

(define (goldbach n)
  (local
    [(define (goldbach-aux a)
       (cond [(and (prime? a) (prime? (- n a))) (make-posn a (- n a))]
             [(>= a (/ n 2)) (error "No se encontraron números primos cuya suma sea " n)]
             [else (goldbach-aux (add1 a))]))]
    (goldbach-aux 2)))

;Ejercicio 4 Parcial Naturales

;aprox-pi : Natural -> Number

(define (aprox-pi n)
  (local [(define (aux m)
    (cond [(zero? m) 0]
        [(positive? n) (+ (/ 1 (sqr m)) (aux (sub1 m)))]))]
    (sqrt (* 6 (aux n)))))


