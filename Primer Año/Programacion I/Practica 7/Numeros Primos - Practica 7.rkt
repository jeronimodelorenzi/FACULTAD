;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |Ejercicio 3 - Practica 7|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; intervalo : N N -> List(N)
; dados dos numeros naturales, devuelve una lista con todos los numeros entre a y b
(check-expect (intervalo 2 4) (list 2 3 4))
(check-expect (intervalo 4 4) (list 4))
(check-expect (intervalo 5 4) empty)

(define (intervalo a b)
  (cond [(> a b) '()]      
        [(= a b) (list a)]    
        [else (cons a (intervalo (add1 a) b))])) 

; elimimar-multiplos: N List(N) -> List(N)
; dados un natural positivo n y una lista l, elimina todos los multiplos de n en l.
(check-expect (eliminar-multiplos 3 (list 4 6 11 15)) (list 4 11))
(check-expect (eliminar-multiplos 1 (intervalo 1 1000)) empty)

(define (eliminar-multiplos n l)
  (cond [(empty? l) '()]                      
        [(= (modulo (first l) n) 0)(eliminar-multiplos n (rest l))]
        [else (cons (first l) (eliminar-multiplos n (rest l)))])) 

; eratostenes : List(N) -> List(N)
; dada una lista que inicialmente es de la forma [2, .., n] para algun n, realiza el procedimiento de eratostenes
(check-expect (eratostenes (intervalo 2 10)) (list 2 3 5 7))
(check-expect (eratostenes empty) empty)
(check-expect (eratostenes (intervalo 2 17)) (list 2 3 5 7 11 13 17))

(define (f n c)
       (cond [(< n (* c c)) #t]
             [(zero? (modulo n c)) #f]
             [else (f n (add1 c))]))
(define (prime? n) (f n 2))

(define (eratostenes l)
  (cond [(empty? l) '()]
        ((not (prime? (car l))) '())
        [(<= (length l) 2) l]
        [else (cons (first l) (eratostenes (eliminar-multiplos (first l) (rest l))))]))


; criba-eratostenes : N -> List(N)
; dado un natural n>=2, devuelve la lista de todos los numeros primos hasta n
(check-expect (criba-eratostenes 10) (list 2 3 5 7))
(check-expect (criba-eratostenes 2) (list 2))
(check-expect (criba-eratostenes 20) (list 2 3 5 7 11 13 17 19))

(define (criba-eratostenes n)
  (cond [(not(>= n 2)) '()]
        [else (eratostenes (intervalo 2 n))]))


(define (concatenar-con-saltos l)
  (cond [(empty? l) '()]
        [(empty? (rest l)) (first l)]
        [else (string-append (first l) "\n" (concatenar-con-saltos (rest l)))]))

(define primos (criba-eratostenes 10000))
(define primos-string (map number->string primos))

(define (guardar-primos)
      (write-file "primos.txt" (concatenar-con-saltos primos-string)))

  (guardar-primos)


(define MAX 10000)
(define LISTA-DE-PRIMOS (read-file "primos.txt"))



