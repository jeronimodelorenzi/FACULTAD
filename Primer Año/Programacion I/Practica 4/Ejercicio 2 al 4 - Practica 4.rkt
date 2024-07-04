;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 1 - Practica 4|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;dist-origen : posn -> Number
;Dado un punto en el plano representado
;por una estructura posn, nos deuvelve su distacia al origen

(check-expect (dist-origen (make-posn 4 3)) 5)
(check-expect (dist-origen (make-posn 6 0))6)
(check-expect (dist-origen (make-posn -4 -3))5)

(define (dist-origen p)
  (if (not (posn? p)) (error "dist-origen: espera posn")
      (sqrt (+ (sqr (posn-x p)) (sqr (posn-y p))))))
      

;simetrico : posn -> posn
;Dada un posicion representada por una estructura posn,
;nos devuelve su simetria.

(check-expect (simetrico (make-posn 5 0)) (make-posn -5 0))
(check-expect (simetrico (make-posn 4 2))(make-posn -4 -2))
(check-error (simetrico 1) "simetrico: espera posn")

(define (simetrico p)
  (if (not (posn? p)) (error "simetrico: espera posn")
      (make-posn (- (posn-x p))(- (posn-y p)))))

;distancia : posn posn -> Number
;Dado dos puntos en el plano representados por estructuras
;calcula la distancia entre ellos y la devuelve.

(check-expect (distancia (make-posn 0 0) (make-posn 3 4)) 5)
(check-expect (distancia (make-posn 0 3) (make-posn 4 0)) 5)
(check-expect (distancia (make-posn 0 0) (make-posn 0 0)) 0)
(check-error (distancia 1 1) "Tipos incorrectos para la función")

(define (distancia p q)
  (if (not (and (posn? p) (posn? q)))
      (error "Tipos incorrectos para la función")
      (sqrt (+ (sqr (- (posn-x p) (posn-x q))) (sqr (- (posn-y p) (posn-y q)))))))
      