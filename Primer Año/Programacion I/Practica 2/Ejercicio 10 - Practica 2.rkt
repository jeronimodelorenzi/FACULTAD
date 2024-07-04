;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Ejercicio 10 - Practica 2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp")) #f)))
;---Definicion de la funcion---

;Number -> Number
;Dependiendo la cantidad de años, al multiplicarlo por 12 meses
;obtengo los años en meses.
;-Ejemplos-
;(check-expect (años->meses 5) 60)
;(check-expect (años->meses 10) 120)
(define (años->meses años) (* años 12))

(define MIN-1MES 13) ;refiere a nivel mínimo de hemoglobina normal 13 g/dl
(define MIN-6MESES 10) ;refiere a nivel mínimo de hemoglobina normal 10 g/dl
(define MIN-12MESES 11) ;refiere a nivel mínimo de hemoglobina normal 11 g/dl
(define MIN-60MESES 11.5) ;refiere a nivel mínimo de hemoglobina normal 11.5 g/dl
(define MIN-120MESES 12.6) ;refiere a nivel mínimo de hemoglobina normal 12.6 g/dl
(define MIN-MAS-120MESES 13) ;refiere a nivel mínimo de hemoglobina normal 13 g/dl
                                                        
;Number Number -> Boolean
;Expresamos la edad en años (mediante la funcion años->meses, son pasados a meses)
;y la hemoglobina en g/dl, y devuelve un booleano. Si es anemico devuelve #t,
;de lo contrario retorna #f.
;-Ejemplo-
;(check-expect (anemia 2 12) #t)
;(check-expect (anemia 24 14) #f)
(define (anemia edad hemoglobina)
  (cond [(<= (años->meses edad) 1) (< hemoglobina MIN-1MES)]
        [(<= (años->meses edad) 6) (< hemoglobina MIN-6MESES)]
        [(<= (años->meses edad) 12) (< hemoglobina MIN-12MESES)]
        [(<= (años->meses edad) 60) (< hemoglobina MIN-120MESES)]
        [(<= (años->meses edad) 120) (< hemoglobina MIN-MAS-120MESES)]
        [else (< hemoglobina MIN-MAS-120MESES)]))