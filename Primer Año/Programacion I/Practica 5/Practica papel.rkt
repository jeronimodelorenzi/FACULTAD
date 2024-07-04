;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Practica papel|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "elevator.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct Usr [login pass permiso])
;Usr es (String, String, Number)
;Un elemento Usr representa el registro de una persona con acceso al sistema
; operativo donde
;login: es el nombre identificador de la persona,
;pass: es la contraseña de acceso,
;permiso: es el identificador de los permisos en el sistema que tiene la persona
; Si tiene permiso de administración, el valor es 0; en otro caso es 1.


; 0 es el identificador de permisos de administración del sistema
(define ADMIN 0)
;1 es el identificador de permisos de uso básico del sistema
(define USRPERMISO 1)

(define ANA (make-Usr "ana" "12345678" ADMIN))
(define LUIS (make-Usr "luis" "12345678" USRPERMISO))
(define MARTA (make-Usr "marta" "R34dlsoA" ADMIN))
(define L1 (list ANA LUIS))
(define L2 (list ANA LUIS MARTA))

(check-expect (cambioClave ANA "aaa") ANA)
(check-expect (cambioClave ANA "12345678") ANA)
(check-expect (cambioClave ANA "abcdefghi") (make-Usr "ana""abcdefghi" ADMIN))

;1)

(define (clave-8c? nueva-clave)
  (if (>= (string-length nueva-clave) 8)#t #f))

(define (cambioClave u nueva-clave)
  (if (and (clave-8c? nueva-clave)(not (string=? (Usr-pass u) nueva-clave)))
      (make-Usr (Usr-login u) nueva-clave (Usr-permiso u))
      u))

;2)

;agregaUsr: String String Number List(Usr) ->List(Usr)
;Esta función agrega un nuevo registro de una persona con acceso al sistema.
;Para esto recibe un nombre identificador de la persona, una contraseña de acceso,
; un identificador de permisos y la lista de registros de personas con acceso
; al sistema. Si no existe un registro con el identificador recibido, agrega uno
; nuevo a la lista, con la correspondiente información, y la devuelve;
; en caso contrario, no lo agrega y devuelve la lista original.

(check-expect (agregaUsr "marta" "R34dlsoA" ADMIN L1) L2)
(check-expect (agregaUsr "luis" "R34dlsoA" ADMIN L1) L1)
(check-expect (agregaUsr "marta" "R34dlsoA" ADMIN empty) (list MARTA))


(define (agregaUsr login pass permiso l)
  (cond [(empty? l) (list (make-Usr login pass permiso))]
        [(string=? (Usr-login (first l)) login) l]
        [else (cons (first l) (agregaUsr login pass permiso (rest l)))]))

;3)

;esAdmin?: Usr ->Boolean
;Esta función recibe el registro de una persona usuaria del sistema y determina
; si tiene premisos de administración.

(check-expect (esAdmin? ANA) #t)
(check-expect (esAdmin? LUIS) #f)

(define (esAdmin? u)
  (= ADMIN (Usr-permiso u)))


;4)

;cantAdmin: List(Usr) ->Number
;Esta función recibe una lista de registro de personas usuarias del sistema y
; devuelve la cantidad de personas que tienen permisos de administración.

(check-expect (cantAdmin L2) 2)
(check-expect (cantAdmin (list LUIS)) 0)
(check-expect (cantAdmin empty) 0)

(define (cantAdmin l)
  (cond [(empty? l) 0]
        [(cons? l) (if (esAdmin? (first l))
                       (+ 1 (cantAdmin (rest l)))
                       (cantAdmin (rest l)))]))

;5)
;eliminaUsr: String List(Usr) ->List(Usr)
;Esta función recibe un identificador de persona en el sistema y la lista de
; registros de personas con acceso al sistema. Si existe un registro con tal
; identificador lo elimina de la lista y devuelve la lista resultante; en caso
; contrario devuelve la lista sin modificaciones.

(check-expect (eliminaUsr "marta" L2) L1)
(check-expect (eliminaUsr "daniel" L2) L2)
(check-expect (eliminaUsr "marta" empty) empty)

(define (eliminaUsr login l)
  (cond [(empty? l) empty]
        [(not(string=? login (Usr-login (first l)))) (cons (first l) (eliminaUsr login (rest l)))]
                       [else (eliminaUsr login (rest l))]))
    
;6)

;bloquearClaves: List(Usr) ->List(Usr)
;Esta función recibe una la lista de registros de personas con acceso al sistema,
; cambia la clave de cada registro a "nula" y devuelve la lista modificada.

(check-expect (bloquearClaves L1) (list (make-Usr "ana" "nula" ADMIN)
(make-Usr "luis" "nula" USRPERMISO)))
(check-expect (bloquearClaves empty) empty)

(define (cambioNula u)
(make-Usr (Usr-login u) "nula" (Usr-permiso u)))
    

(define (bloquearClaves l)
  (cond [(empty? l) empty]
        [(cons? l) (cons (cambioNula (first l)) (bloquearClaves (rest l)))]))
  
;7)

;intercala: Lista(Any) Lista(Any) ->Lista(Any)
;Esta función intercala los elementos de dos listas dadas.

(check-expect (intercala (list 1 2 3) (list "A" "B")) (list 1 "A" 2 "B" 3))
(check-expect (intercala (list "A" "B") (list 1 2 3) ) (list "A" 1 "B" 2 3))

(define (intercala l1 l2)
  (cond [(or (empty? l1) (empty? l2)) l1]
        [else (cons (first l1) (intercala l2 (rest l1)))]))

;8) 

;ultimo : List (Any) ->Any
;Devuelve el último elemento de una lista NO vacía.
(check-expect (ultimo (list 1 2 3)) 3)
(check-expect (ultimo (list 1 2)) 2)
(check-expect (ultimo (list 1)) 1)

(define (ultimo l)
  (cond [(empty? l) empty]
        [else (if (boolean=? (cons? (first l)) (empty? (rest l)))
                  (ultimo (rest l))
                  (first l))]))

;listaCapicua:List(Number) ->Boolean
;Determina si la secuencia de una lista de números de un dígito forman un número
;capicúa.



;-5.2

;idLargos: List(Usr) ->List(String)
;Esta función recibe una lista de Usr y devuelve la lista de los identificadores
;con más de 3 caracteres.
(check-expect (idLargos (list ANA LUIS MARTA)) (list "luis" "marta"))
(check-expect (idLargos (list ANA)) empty)


(define (largo? u)
  (if (> (string-length (Usr-login u)) 3)
      #t #f))

(define (idLargos l)(map Usr-login (filter largo? l)))

;sumNumericos: List(String) ->Number
;Recibe una lista de Strings y devuelve la suma todos aquellos que son enteros no
;negativos.
(check-expect (sumNumericos (list "12-9" "12" "sol" "1nos" "33.5" "10")) 22)
(check-expect (sumNumericos (list "-12" "sol" "33.5")) 0)
(check-expect (sumNumericos empty) 0)

(define (sumNumericos l)(foldr + 0 (map string->number(filter string-numeric? l))))

;infAn: List(Number) Number ->List(Number)
;infAn recibe una lista de números y un número n; y devuelve la lista de números
;inferiores a n.
(check-expect (infAn (list 1 2 3 4) 3) (list 1 2))
(check-expect (infAn (list 1 2 3 4) 1) empty)

(define (infAn l n) 
  (local [(define (menor-a-n? x) (< x n))] (filter menor-a-n? l)))

;minimo: List(Number) ->Number
;Esta función recibe una lista NO vacía de números cualesquiera y devuelve el menor.
(check-expect (minimo (list -1.6 5 3 -80 6 57.9 0)) -80)
(check-expect (minimo (list -88 1 2 3 4 5)) -88)

(define (minimo l)
  (foldr min (first l) (rest l)))

(minimo (list -1.6 5 3 -80 6 57.9 0))

 ;primeroPares: List(Number) ->List(Number)
;Esta función recibe una lista NO vacía de enteros y los ordena ubicando primero
;los pares y luego los impares.
(check-expect (primeroPares (list 9 -5 6 3 -2 8 0 12 100 7))
(list 6 -2 8 0 12 100 9 -5 3 7))

 (define (primeroPares l)
  (local [(define pares (filter even? l))
          (define impares (filter odd? l))]
    (foldr cons impares pares)))  
                                        




