;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Practica 1|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;LEYES DE REDUCCION

;1)
(define
  (tamaño? x y) ;x alto e y es el ancho
  (if (> x y) "Angosta" "Ancha"))
(tamaño? 4 4)

;2)

(define
  (b-tamaño? x y) ;x alto e y es el ancho
  (if (= x y) "Cuadrada" (if (> x y) "Angosta" "Ancha")))
(b-tamaño? 2 2)

;3)

(define (lados a1 a2 a3)
        (if (and (= a1 a2) (= a2 a3))
            "equilátero"
            (if (or (= a1 a2) (= a2 a3) (= a3 a1))
                "isósceles"
                "escaleno")))
;4)

(define (trianguloError a1 a2 a3)
        (if (= (+ a1 a2 a3) 180)
            (lados a1 a2 a3)
            "Error: No es un triángulo"))

;5)

(define PC 60)
(define PL 8)
(define (cantidad c l)
  (if (and (>= l 5) (>= c 4)) (+ (- (* l PL) (* l PL 0.15)) (- (* c PC) (* c PC 0.1)))
      (if (and(< l 5)(>= c 4))(+ (- (* c PC) (* c PC 0.1)) (* PL l) )
          (if (and (< c 4) (>= l 5)) (+ (- (* l PL) (* l PL 0.15)) (* PC c) )(+ (* PL l) (* PC c))) ) ))

;6)


(define (cantidad2 c l)
  (if (>= (+ c l) 10) (- (+ (* PL l)(* PC c)) (*(+ (* PC c)(* PL l)) 0.18))
  (if (and (>= l 5) (>= c 4)) (+ (- (* l PL) (* l PL 0.15)) (- (* c PC) (* c PC 0.1)))
      (if (and(< l 5)(>= c 4))(+ (- (* c PC) (* c PC 0.1)) (* PL l) )
          (if (and (< c 4) (>= l 5)) (+ (- (* l PL) (* l PL 0.15)) (* PC c) )(+ (* PL l) (* PC c))) ) )))
(cantidad2 5 5)



;7)
(define (pitagorica? a b c) (if (= (sqr a) (+ (sqr b) (sqr c))) #true
          (if (= (sqr b) (+ (sqr a) (sqr c))) #true
                   (if (= (sqr c) (+ (sqr a) (sqr b))) #true #false))))
(pitagorica? 2 4 5)

;8)


(define (pitagorica?2 x y z)
  (if(= (sqr z)(+ (sqr x)(sqr y))) (string-append "Los numeros " (number->string x)", "(number->string y)" y "(number->string z) " forman una terna pitagorica") #f))
(pitagorica?2 3 4 5)


;9)

(define (collatz n)
   (if (even? n) (/ n 2)
               (+ (* 3 n)1)))
(collatz 3)

;BANDERAS

;a)

(define PERU
  (place-image (rectangle 30 90 "solid" "red") 15 30
               (place-image (rectangle 30 90 "solid" "white") 45 45
                            (place-image (rectangle 30 90 "solid" "red") 75 30
                                         (empty-scene 90 60)))))

;b)

(define ITALIA
  (place-image (rectangle 30 90 "solid" "green") 15 30
               (place-image (rectangle 30 90 "solid" "white") 45 45
                            (place-image (rectangle 30 90 "solid" "red") 75 30
                                         (empty-scene 90 60)))))

;c)

(define (elegirColor x y z) (place-image (rectangle 30 90 "solid" x) 15 45
               (place-image (rectangle 30 90 "solid" y) 45 45
                            (place-image (rectangle 30 90 "solid" z) 75 45
                                         (empty-scene 90 60)))))

;d)

(define ALEMANIA (place-image (rectangle 90 20 "solid" "black") 45 10
                        (place-image (rectangle 90 20 "solid" "red") 45 30
                                 (place-image (rectangle 90 20 "solid" "yellow") 45 50
                                              (empty-scene 90 60)))))

;e)

(define HOLANDA (place-image(rectangle 90 20 "solid" "red") 45 10
                            (place-image(rectangle 90 20 "solid" "white") 45 30
                                        (place-image(rectangle 90 20 "solid" "blue") 45 50
                                                    (empty-scene 90 60)))))

;f)

(define (elegirColor2 x y z) (place-image (rectangle 90 20 "solid" x) 45 10
               (place-image (rectangle 90 20 "solid" y) 45 30
                            (place-image (rectangle 90 20 "solid" z) 45 50
                                         (empty-scene 90 60)))))
;g)

(define vertical 1)
(define horizaontal 20)
(define (elegirColor3 x y z) (place-image (rectangle 90 20 "solid" x) 45 10
               (place-image (rectangle 90 20 "solid" y) 45 30
                            (place-image (rectangle 90 20 "solid" z) 45 50
                                         (empty-scene 90 60)))))

;i)
(define ARGENTINA
  (place-image (rectangle 90 20 "solid" "cyan") 45 10
               (place-image (circle 7 "solid" "yellow") 45 30
               (place-image (rectangle 90 20 "solid" "white") 45 30
                            (place-image(rectangle 90 20 "solid" "cyan") 45 50
                                        (empty-scene 90 60))))))

(define SUDAN
  (place-image (rotate 270(triangle 120 "solid" "green")) 0 30
               (place-image (rectangle 90 20 "solid" "red") 45 10
                            (place-image (rectangle 90 20 "solid" "white") 45 30
                                         (place-image (rectangle 90 20 "solid" "black") 45 50
                                                      (empty-scene 90 60))))))

(define CAMERUN
  (place-image (rectangle 30 90 "solid" "green") 15 30
               (place-image (star 10 "solid" "yellow") 45 30
               (place-image (rectangle 30 90 "solid" "red") 45 45
                            (place-image (rectangle 30 90 "solid" "yellow") 75 30
                                         (empty-scene 90 60))))))
               
(define BRASIL
  (place-image (circle 10 "solid" "blue") 45 30
               (place-image (rhombus 40 120 "solid" "yellow") 45 30
                            (place-image (rectangle 90 60 "solid" "green") 45 30
                                         (empty-scene 90 60)))))
                                                      
               

                    
                               




