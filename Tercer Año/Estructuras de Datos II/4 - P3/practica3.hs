module Practica3 where


{-
1) El modelo de color RGB es un modelo aditivo que tiene al color rojo, verde y azul
como colores primarios. Cualquier otro color se expresa en términos de los porcentajes
de cada uno de estos tres colores que es necesario combinar en forma aditiva para obtenerlo.
Dichas proporciones caracterizan a cada color de manera biunívoca, por lo que usualmente se
utilizan estos valores como representación de un color.
Definir un tipo Color en este modelo y una función mezclar que permite obtener el promedio
componente a componente entre dos colores.
-}

data Color = RGB {red :: Float, blue :: Float, green :: Float} deriving Show

mezclar :: Color -> Color -> Color
mezclar c1 c2 = RGB {
                    red = prom (red c1) (red c2),
                    blue = prom (blue c1) (blue c2),
                    green = prom (green c1) (green c2)
                    }
    where prom a b = (a+b)/ 2

{-
2) Consideremos un editor de líneas simple. Supongamos que una Linea es una secuencia
de caracteres c1, c2, ..., cn junto con una posición p, siendo 0 <= p <= n, llamada
cursor (consideraremos al cursos a la derecha de un caracter que será borrado o
insertado, es decir, como el cursor de la mayoría de los editores). Se requieren las
siguientes operaciones sobre líneas:
vacia :: Linea (la constante vacia denota la línea vacía).
moverIzq :: Linea -> Linea (la operación moverIzq mueve el cursos una posición a la izquierda
                           (simepre que ello sea posible)).
moverDer :: Linea -> Linea (análogamente para moverDer).
moverIni :: Linea -> Linea (la operación moverIni mueve el cursor al comienzo de la línea).
moverFin :: Linea -> Linea (la operación moverFin mueve el cursos al final de la línea).
insertar :: Char -> Linea -> Linea (insertar agrega un caracter en el lugar donde
                                    se encontraba el cursor, dejando al caracter insertado
                                    a su izquierda).
borrar :: Linea -> Linea (la operación borrar elimina el caracter que se encuentra a la izquierda
                          del cursor).
Definir un tipo de datos Linea e implementar las operaciones dadas.
-}

data Linea = Linea [Char] Int deriving Show

vacia :: Linea
vacia = (Linea [] 0)

moverIzq :: Linea -> Linea
moverIzq (Linea xs 0) = (Linea xs 0)
moverIzq (Linea xs p) = (Linea xs (p-1))

moverDer :: Linea -> Linea
moverDer (Linea xs p)   | length xs == p = (Linea xs p)
                        | otherwise = (Linea xs (p+1))

moverIni :: Linea -> Linea
moverIni (Linea xs p) = (Linea xs 0)

moverFin :: Linea -> Linea
moverFin (Linea xs p) = (Linea xs (length xs))

insertar :: Char -> Linea -> Linea
insertar c (Linea xs p) =
    let nuevaLinea = (take p xs) ++ [c] ++ (drop p xs)
    in (Linea nuevaLinea (p+1))

borrar :: Linea -> Linea
borrar (Linea xs 0) = (Linea xs 0)
borrar (Linea xs p) = 
    let nuevaLinea = (take (p-1) xs) ++ (drop p xs)
    in (Linea nuevaLinea (p-1))

{- 
3) Dado el tipo de datos: 
-}
data CList a = EmptyCL | CUnit a | Consnoc a (CList a) a deriving Show

-- Definición de ejemplo.
clist1 :: CList Int
clist1 = (Consnoc 1 (CUnit 2) 3)

{-
a) Implementar las siguientes operaciones de este tipo algebraico teniendo en cuenta que:
• Las funciones de acceso son headCL, tailCL, isEmptyCL, isCUnit.
• headCL y tailCL no están definidos para una lista vacía.
• headCL toma una CList y devuelve el primer elemento de la misma (el de más a la izquierda).
• tailCL toma una CList y devuelve la misma sin el primer elemento.
• isEmptyCL aplicado a una CList devuelve True si la CList es vacía (EmptyCL) o false en caso contrario.
• isCUnit aplicado a una CList devuelve True sii la CList tiene solo un elemento (CUnit a) o False en caso contrario.
-}

headCL :: CList a -> a
headCL (CUnit a) = a
headCL (Consnoc a xs b) = a

tailCL :: CList a -> CList a
tailCL (CUnit _) = EmptyCL
tailCL (Consnoc _ xs b) =
    case xs of
        EmptyCL -> CUnit b
        CUnit c -> Consnoc c EmptyCL b
        _ -> Consnoc (headCL xs) (tailCL xs) b

isEmptyCL :: CList a -> Bool
isEmptyCL EmptyCL = True
isEmptyCL _ = False

isCUnit :: CList a -> Bool
isCUnit (CUnit _) = True
isCUnit _ = False

-- b) Definir una función reverseCL que toma una CList y devuelve su inversa.
reverseCL :: CList a -> CList a
reverseCL (Consnoc a xs b) = Consnoc b (reverseCL xs) a
reverseCL xs = xs

-- c) Definir una función inits que toma una CList y devuelve una CList con todos
-- los posibles inicios de la CList.

snoc :: CList a -> a -> CList a
snoc EmptyCL a = CUnit a
snoc (CUnit a) b = Consnoc a EmptyCL b
snoc (Consnoc a xs b) c = Consnoc a (snoc xs b) c

inits :: CList a -> CList (CList a)
inits EmptyCL = CUnit EmptyCL
inits c = snoc (inits (reverseCL (tailCL (reverseCL c)))) c

-- d) Definir una función last que toma una CList y devuelve una CList con todas
-- las posibles terminaciones de la CList
cons :: a -> CList a -> CList a
cons a EmptyCL = CUnit a
cons a (CUnit b) = Consnoc a EmptyCL b
cons a (Consnoc b xs c) = Consnoc a (cons b xs) c

lasts :: CList a -> CList (CList a)
lasts EmptyCL = CUnit EmptyCL
lasts c = cons c (lasts (tailCL c))

-- e) Definir una función concatCL que toma una CList de CList y devuelve la CList
-- con todas ellas concatenadas.
appendCL :: CList a -> CList a -> CList a
appendCL EmptyCL ys = ys
appendCL (CUnit x) ys = cons x ys
appendCL (Consnoc a xs b) ys = cons a (appendCL xs (cons b ys))

concatCL :: CList (CList a) -> CList a
concatCL EmptyCL = EmptyCL
concatCL (CUnit xs) = xs
concatCL (Consnoc a xs b) = appendCL a (appendCL (concatCL xs) b)

{-
4) Para el siguiente tipo algebraico:
-}
data Exp = Lit Int | Add Exp Exp | Sub Exp Exp | Prod Exp Exp | Div Exp Exp

-- Definición de ejemplo.
ev1 :: Exp
ev1 = (Div (Sub (Prod (Lit 3) (Add (Lit 4) (Lit 1))) (Lit 1)) (Lit 2))
{-
Defina un evaluador eval :: Exp -> Int.
-}
eval :: Exp -> Int
eval (Lit x) = x
eval (Add x y) = eval x + eval y
eval (Sub x y) = eval x - eval y
eval (Prod x y) = eval x * eval y
eval (Div x y) = eval x `div` eval y

{-
6)
-}

-- a) Considere el evaluador eval :: Exp -> Int del ejercicio 4. ¿Cómo maneja los errores de división por 0?

{-

-}

-- b) Defina un evaluador seval :: Exp -> Maybe Int para controlar los errores de división por 0.