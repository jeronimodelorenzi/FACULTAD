;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Metodo Montecarlo - Practica 7|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Estas primera parte nos define una funcion que genera numeros aleatorios
;; en un intervalo real determinado.
;; Recordemos que la funcion random nos devuelve un natural, pero para
;; nuestro problema necesitamos numeros aleatorios fraccionarios.

(define RAND-MAX 4294967087) ; nuomero maximo para valores aleatorios

; aleatorio : Number Number -> Number
; dados dos numeros a y b, devuleve un numero aleatorio en el intervalo [a,b].

(define (aleatorio a b) (+ a (* (- b a) (/  (+ 1 (random RAND-MAX)) (* 1.0 RAND-MAX)))))

;; fin de la parte para generar numeros aleatorios. No es necesario entender como funciona,
;; solo basta con entender el proposito de aleatorio

;; Definimos algunas constantes:

(define RADIO 3.0) ; radio del ci­rculo
(define CENTRO (make-posn -1 -0.5)) ; coordenadas del centro del circulo

(define MAX 300000) ; cantidad de puntos a generar para nuestra estimacion

; generar-puntos : Natural -> List(posn)
; Dado un natural n, devuelve una lista con n puntos aleatorios,
; con ambas componentes en el intervalo [-RADIO, RADIO]. Es decir, dentro del cuadrado.

(define (generar-puntos n)
  (cond [(zero? n) empty]
        [else (cons (make-posn (aleatorio 0 2) (aleatorio 0 2))
                    (generar-puntos (- n 1)))]))

; distancia : posn posn -> Number
; dados dos puntos, devuelve su distancia

(check-expect (distancia (make-posn 15 0) (make-posn 3 0)) 12)
(check-expect (distancia (make-posn 2 1) (make-posn 6 4)) 5)
(check-expect (distancia (make-posn 0 16) (make-posn 0 0)) 16)

(define (distancia p q)
  (sqrt (+ (sqr (abs (- (posn-x p) (posn-x q)))) (sqr (abs (- (posn-y p) (posn-y q)))))))

; adentro? : posn -> Boolean
; dada una posicion, determina si cae en el circulo centrado en CENTRO y cuyo radio es RADIO

(check-expect (adentro? (make-posn 0 0)) #t)
(check-expect (adentro? (make-posn RADIO (* 2 RADIO))) #f)
(check-expect (adentro? (make-posn RADIO RADIO)) #f)

(define (adentro? p) (<= (distancia p CENTRO) RADIO)) 

; generamos una lista con muchos puntos aleatorios

(define LISTA (generar-puntos MAX))

; nos quedamos con aquellos que estan dentro del circulo

(define ADENTRO (filter adentro? LISTA))

; aproximamos el area del circulo a partir de la proporcion de puntos que
; caen dentro del ci­rculo:

(define AREA (* 4.0 (/ (length ADENTRO) (length LISTA))))


;; Como en nuestro caso ya sabemos cual es el area de la superficie (pi),
;; podemos usar nuestro resultado como una estimacion de este numero.
;; Veamos que tan buena estimacion es, calculando el error relativo porcentual
;; respecto del valor que nos proporciona racket:
; calculamos el porcentaje de error:

(define ERROR (* 100 (/ (abs (- pi AREA)) pi)))


(string-append "Nuesta aproximacion de pi es: " (number->string  (exact->inexact AREA)))

(string-append "Con un porcentaje de error de: " (number->string ERROR) "% (si lo comparamos con el valor que nos proporciona DrRacket)") 