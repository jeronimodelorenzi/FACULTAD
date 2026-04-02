module Practica2 where

import Data.List
import Data.Char

{-
1) Dar el tipo completo de las siguientes funciones.
-}

-- a)
test :: (Eq a, Num a) => (a -> a) -> a -> Bool
test f x = f x == x + 2

-- b)
esMenor :: Ord a=> a -> a -> Bool
esMenor y z = y < z

-- c)
eq :: Eq a => a -> a -> Bool
eq a b = a == b

-- d)
showVal :: (Show a) => a -> String
showVal x = "Valor:" ++ show x

{-
2) Dar el tipo de las siguientes operaciones y explicar su propósito.
-}

-- (+5): es del tipo Num a => a -> a
-- Suma 5 a un número dado.

-- (0<): es del tipo (Ord a, Num a) => a -> Bool
-- Verifica si el número pasado es mayor a 0.

-- ('a':): es del tipo [Char] -> String
-- Agrega al principio de una cadena de caracteres el caracter 'a'.

-- (++"\n"): es del tipo [Char] -> String
-- Agrega al final de una cadena de caracteres el caracter '\n'.

-- filter (== 7): es del tipo (Eq a, Num a) => [a] -> [a]
-- Dada una lista de valores numéricos, devuelve una lista con aquellos iguales al 7.

-- map (++[1]): es del tipo Num a => [[a]] -> [[a]]
-- Dada una lista de listas de números, agrega al final de cada elemento
-- de la lista el número 1.

{-
3) Dar al menos dos ejemplos de funciones que tengan el tipo indicado en cada caso.
-}

-- a) (Int -> Int) -> Int
f_a :: (Int -> Int) -> Int
f_a f = f 3

-- b) Int -> (Int -> Int)
f_b :: Int -> (Int -> Int)
f_b x = (+x)

-- c) (Int -> Int) -> (Int -> Int)
f_c :: (Int -> Int) -> (Int -> Int)
f_c f = (+ f 3)

-- d) Int -> Bool
f_d :: Int -> Bool
f_d x = x == 2

-- e) Bool -> (Bool -> Bool)
f_e :: Bool -> (Bool -> Bool)
f_e b = (&& b)

-- f) (Int, Char) -> Bool
f_f :: (Int, Char) -> Bool
f_f (x,c) = ord c == x

-- g) (Int, Int) -> Int
f_g :: (Int, Int) -> Int
f_g (x,y) = x+y

-- h) Int -> (Int, Int)
f_h :: Int -> (Int, Int)
f_h x = (x,x+1)

-- i) a -> Bool
f_i :: a -> Bool
f_i _ = True

-- j) a -> a
f_j :: a -> a
f_j a = a

{-
4) Indicar si cada una de las siguientes expresiones está o no bien formada.
En caso de que lo esté determinar el valor que denota, en caso contrario
especificar si el error es sintáctico o de tipos.
-}

-- a) if true then false else true where false = True; true = False
-- El error es de sintaxis debido a que se está utilizando un ;.

-- b) if if then then else else
-- El error es de sintaxis debido a que faltan las condiciones.

-- c) False == (5 >= 4)
-- Está bien formada. False == (5 >= 4) => False == True => False.

-- d) 1 < 2 < 3
-- El error es de tipos, ya que despues de realizar la primer comparación,
-- obtenemos un Bool y lo comparamos con un Int.

-- e) 1 + if ('a' < 'z') then -1 else 0
--  Está bien formada. 1 + if ('a' < 'z') then -1 else 0 => 1 + if True then -1 else 0
-- => 1 + (-1) => 0

-- f) if fst p then fst p else snd p where p = (True,2)
-- El error es de tipos, ya que ambas ramas del if (then, else) deben tener el
-- mismo tipo, en este caso tienen Bool e Int.

-- g) if fst p then fst p else snd p where p = (True,False)
-- Está bien formada. if fst p then fst p else snd p where p = (True,False) =>
-- if True then fst p else snd p => True

{-
5) Reescribr cada una de las siguientes definiciones sin usar let, where o if.
-}

-- a) f x = let (y,z) = (x,x) in y
f x = x

-- b) greather (x,y) = if x > y then True else False
greather (x,y) = x > y

-- c) f(x,y) = let z = x + y in g(z,y) where g(a,b) = a - b
f2 (x,y) = x -- x + y - y

{-
6) Pasar de notación Haskell a notación de funciones anónimas 
(llamada notación lambda).
-}

-- a) smallest, definida por
-- smallest (x,y,z) | x <= y && x <= z = x
--                  | y <= x && y <= z = y
--                  | z <= x && z <= y = z
smallest :: Ord(a) => (a,a,a) -> a
smallest = \(x, y, z) -> if x <= y && x <= z 
                            then x 
                            else if y <= x && y <= z
                                then y
                                else z

-- b) second x = \x -> x
second :: a -> b -> b
second = \_ y -> y

-- c) andThen, definida por
-- andThen True y = y
-- andThen False y = False
andThen :: Bool -> Bool -> Bool
andThen = \b y -> if b then y else False

-- d) twice f x = f (f x)
twice :: (a->a) -> a -> a
twice = \f x -> f(f x)

-- e) flip f x y = f y x
flip :: (a->b->c) -> b -> a -> c
flip = \f x y -> f y x

-- f) inc = (+1)
inc :: Num a => a -> a
inc = \x -> (+1) x

{-
7) Pasar de notación lambda a notación Haskell.
-}

-- a) iff = \x -> \y -> if x then not y else y
iff :: Bool -> Bool -> Bool
iff x y | x = not y
        | otherwise = y

-- b) alpha = \x -> x
alpha :: a -> a
alpha x = x

{-
8) Suponiendo que f y g tienen los siguientes tipos
  f :: c -> d
  g :: a -> b -> c
y sea h definida como
  h x y = f (g x y)
Determinar el tipo de h e indicar cuáles de las siguientes definiciones son
equivalentes a la dada.
Dar el tipo de la función (.).
-}

-- La función (.) es del tipo:
--(.) :: (b->c) -> (a->b) -> a -> c

-- La función h es del tipo:
--h :: a -> b -> g

-- h = f . g no es equivalente ya que g toma un argumento del tipo a y devuelve
-- una función b->c, y f toma como argumento c. Con lo cual como estamos pasando
-- una función como argumento de f, no es válido.

-- h x = f . g x
-- INCOMPLETO

{-
9) La función zip3 zipea 3 listas. Dar una definición recursiva de la función y
otra definición con el mismo tipo que utilice la función zip.
-}

-- Recursiva.
zip3Rec :: [a] -> [b] -> [c] -> [(a,b,c)]
zip3Rec (x:xs) (y:ys) (z:zs) = (x,y,z) : zip3Rec xs ys zs
zip3Rec _ _ _ = []

-- Con zip
zip3zip :: [a] -> [b] -> [c] -> [(a,b,c)]
zip3zip x y z = [(a,b,c) | ((a,b),c) <- zip (zip x y) z]

{-
10) Indicar bajo qué suposiciones tienen sentido las siguientes ecuaciones.
Para aquellas que tengan sentido, indicar si son verdaderas y en caso de no serlo
modifciar su lado derecho para que resulten verdaderas.
-}

-- a) [[]] + xs = xs
-- La suposición tiene sentido solo si xs es una lista de listas.
-- Por lo tanto no es verdadera.
-- [[]] ++ xs = ([]: xs)

-- b) [[]] ++ xs = [xs]
-- La suposción tiene sentido solo si xs es una lista de listas.
-- Pero si xs es una lista de listas, entonces [xs]
-- es una lista de lista de listas.
-- No es verdadera debido a que [[]]++xs = [[],xs]

-- c) [[]] ++ xs = [] : xs
-- La suposición tiene sentido si xs es una lista de listas.
-- Es verdadera.

-- d) [[]] ++ xs = [[],xs]
-- La suposición tiene sentido si xs es una lista de listas.
-- Es verdadera.

-- e) [[]] ++ [xs] = [[], xs]
-- La suposición tiene sentido si xs es una lista.
-- Es verdadera.

-- f) [[]] ++ [xs] = [xs]
-- La suposición tiene sentido si xs es una lista.
-- No es verdadera debido a que [[]]++[xs] = [[], xs]

-- g) [] ++ xs = []:xs
-- La suposición tiene sentido si xs es una lista.
-- No es verdadera, porque estamos concatenando una lista vacía
-- a una lista con elementos, pero no se produce ningun cambio.
-- [] ++ xs = xs

-- h) [] ++ xs = xs
-- La suposición tiene sentido si xs es una lista.
-- Es verdadera

-- i) [xs] ++ [] = [xs]
-- La suposición tiene sentido si xs es una lista o lista de listas.
-- Es verdadera.

-- j) [xs] ++ [xs] = [xs,xs]
-- La suposición tiene sentido si xs es una lista o lista de listas.
-- Es verdadera.

{-
11) Inferir, de ser posible, los tipos de las siguientes funciones.
(suponer que sqrt :: Float -> Float)
-}

-- a) modulus = sqrt . sum . map (^2)
-- (^2) :: Num a => a -> a
-- map (^2) :: Num a => [a] -> [a]
-- sum :: Num a => [a] -> a
-- sqrt :: Float -> Float
-- Tenemos sqrt(sum(map(^2)))
-- Con lo cual modulus :: [Float] -> Float

-- b) vmod [] = []
--    vmod (v:vs) = modulus v: vmod vs
-- vmod :: [[Float]] -> [Float]

{-
12) Dado el siguiente tipo para representar números binarios:
type NumBin = [Bool]
donde el valor False representa el 0 y True el 1. Definir las sigientes operaciones
tomando como convención una representación Little-Endian
(i.e. el primer elemento de las listas de dígitos es el dígito menos significativo
del número representado).
-}

type NumBin = [Bool]

-- a) suma binaria
sumBin :: NumBin a => a -> a -> a
sumBim 

