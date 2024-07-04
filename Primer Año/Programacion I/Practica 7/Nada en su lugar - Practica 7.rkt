;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Nada en su lugar - Practica 7|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define (shuffle l)
            (if (empty? l) empty
                (local ((define randpos (random (length l)))
                        (define num (list-ref l randpos))
                        (define resto (remove num l)))
                  (cons num (shuffle resto)))))

(define (jugar-partida N)
  (local [(define mazo (shuffle (build-list N add1)))
  (define (aux l i)
    (cond
      [(empty? l) #t]  ; Se ganó la partida
      [(= (first l) (+ i 1)) #f]  ; Se perdió la partida
      [else (aux (rest l) (+ i 1))]))]
  (aux mazo 0)))

(define (calcular-probabilidad N num-partidas)
  (local [(define (jugar-partidas n ganadas)
    (cond
      [(= n num-partidas) (/ ganadas num-partidas)]  ; Proporción de partidas ganadas
      [else
       (let ((partida-ganada (jugar-partida N)))
         (jugar-partidas (+ n 1) (+ ganadas (if partida-ganada 1 0))))]))]
  (jugar-partidas 0 0)))

; Parámetros del juego
(define N 40)
(define num-partidas 10000)

(define probabilidad (calcular-probabilidad N num-partidas))

(if (> probabilidad 0.5)
    "Rocío debería aceptar la apuesta de Lautaro."
    "Rocío no debería aceptar la apuesta de Lautaro.")