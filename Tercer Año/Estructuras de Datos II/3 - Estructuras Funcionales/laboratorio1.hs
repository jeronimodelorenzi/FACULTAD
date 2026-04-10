module Laboratorio1 where

import Data.List
import Data.Char

{-
1) Corregir los siguientes programas de modo que sean aceptados por GHCi.
-}

-- a) Como la función 'not' ya está definida en el preludio, necesitamos cambiar
-- el nombre para poder ejecutarla.
myNot b = case b of
    True -> False
    False -> True

-- b) 'in' es una palabra reservada en Haskell, con lo cual modificamos el nombre
-- para poder ejecutarla.
myIn [x]         =  []
myIn (x:xs)      =  x : myIn xs
myIn []          =  error "empty list"

-- c) Las funciones deben comenzar en minúscula, ya que las mayusculas 
-- definen constructores, con lo cual, cambiamos el nombre de la función.
-- Como length ya existe, tomamos otro nombre.
myLength []        =  0
myLength (_:l)     =  1 + myLength l

-- d) El error está en como se utiliza el operador cons.
list123 = 1:(2:(3:[]))

-- e) Modificamos la definición de la función manteniendo la definición prefija
-- y con paréntesis.
(++!) [] ys = ys
(++!) (x:xs) ys = x:((++!) xs ys)

-- f) Para que sean aceptados por GHCi necesitamos aplicar los paréntesis.
addToTail x xs = map (+x) (tail xs)

-- g) Eliminamos el punto y agregamos paréntesis.
listmin xs = head (sort xs)

-- h)
smap f [] = []
smap f [x] = [f x]
smap f (x:xs) = f x : (smap f xs)

{-
2) Definir las siguientes funciones y determinar su tipo.
-}

-- a) five, que dado cualquier valor, devuelve 5.
five :: a -> Int
five _ = 5

-- b) apply, que toma una función y un valor, y devuelve el resultado de
-- aplicar la función al valor dado.
apply :: (a -> b) -> a -> b
apply f x = f x


-- c) ident, la función identidad
ident :: a -> a
ident a = a

-- d) first, que toma un par ordenado, y devuelve su primera componente.
first :: (a,b) -> a
first (x,_) = x

-- e) derive, que aproxima la derivada de una función dada un punto dado.
derive :: Floating a => (a -> a) -> a -> a
derive f x = (f (x + h) - f x) / h
    where h = 0.000001

-- f) sign, la función signo.
sign :: (Ord a, Num a) => a -> a
sign x | x > 0 = 1
       | x < 0 = -1
       | otherwise = 0

-- g) vabs, la función valor absoluto (usando sign y sin usarla).
vabs_sign :: (Num a, Ord a) => a -> a
vabs_sign x = x * sign x

my_vabs :: (Num a, Ord a) => a -> a
my_vabs x | x >= 0 = x
          | x < 0 = -x

-- h) pot, que toma un entero y un número, y devuelve el resultado de elevar el
-- segundo a la potencia dada por el primero.
pot :: (Integral a, Num b) => a -> b -> b
pot 0 x = 1
pot n x = x^n

-- i) xor, el operador de disyunción exclusiva.
xor :: Bool -> Bool -> Bool
xor False True = True
xor True False = True
xor _ _ = False

-- j) max3, que toma tres números enteros y devuelve el máximo entre ellos.
max3 :: Ord a => a -> a -> a -> a
max3 a b c = max a (max b c)

-- k) swap, que toma un par y devuelve el par con sus componentes invertidas.
swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

{-
3) Definir una función que determine si un año es bisiesto o no, de de acuerdo
a la siguiente definición:

año bisiesto 1. m. El que tiene un día más que el año común, añadido al mes de febrero.
Se repite cada cuatro años, a excepción del último de cada siglo cuyo número de 
centenas no sea múltiplo de cuatro. (Diccionario de la Real Academia Espaola, 22ª ed.)
-}
esBisieto :: (Integral a) => a -> Bool
esBisieto año | año `mod` 400 == 0      = True
              | año `mod` 100 == 0      = False
              | año `mod` 4 == 0        = True
              | otherwise               = False

{-
4) Define un operador infijo *$ que implemente la multiplicación de un vector
por un escalar. Reseprentaremos a los vectores meidante listas de Haskell. Así,
dada una lista ns y un número n, el valor ns *$ n debe ser igual a la lista ns
co todos sus elementos multiplicados por n.

Por ejemplo, [2, 3] *$ 5 == [10, 15].
El operador *$ debe definirse de manera que la siguiente expresión sea válida:
v = [1, 2, 3] *$ 2 *$ 4
-}
infixl *$
(*$) :: Num a => [a] -> a -> [a]
ns *$ n = map (*n) ns

{-
5) Definir las siguientes funciones usando listas por comprensión.
-}

-- a) 'divisors', que dado un entero positivo 'x' devuelve la lista de de los
-- divisores de 'x' (o la lista vacía si el entero no es positivo).
divisors :: Integral a => a -> [a]
divisors x = [y | y <- [1..x], x `mod` y == 0]

-- b) 'matches', que dados un entero 'x' y una lista de enteros descarta de la lista
-- los elementos distintos a 'x'.
matches :: Int -> [Int] -> [Int]
matches x xs = [x | y <- xs, y == x]

-- c) 'cuadrupla', que dado un entero 'n', devuelve todas las cuadruplas '(a,b,c,d)'
-- que satisfacen a^2 + b^2 = c^2 + d^2, donde 0 <= a,b,c,d <= 'n'.
cuadrupla :: Int -> [(Int, Int, Int, Int)]
cuadrupla n = [(a,b,c,d) | a <- [0..n], b <- [0..n], c <- [0..n], d <- [0..n], a^2+b^2==c^2+d^2]

-- d) 'unique', que dada una lista 'xs' de enteros, devuelve una lista 'xs' 
-- sin elementos repetidos.
unique :: [Int] -> [Int]
unique xs = [x | (x,i) <- zip xs [0..], not (elem x (take i xs))]

{-
6) El producto escalar de dos listas de enteros de igual longitud es la suma de los
productos de los elementos sucesivos (misma posición) de ambas listas.
Definir una función 'scalarProduct' que devuelva el producto escalar de dos listas.
-}

scalarProduct :: [Int] -> [Int] -> Int
scalarProduct xs ys = sum [x * y | (x,y) <- zip xs ys]

{-
7) Definir mediante recursión explicita las siguientes funciones y escribir su
tipo más general.
-}

-- a) 'suma', que suma todos los elementos de una lista de números.
suma :: Num a => [a] -> a
suma [] = 0
suma (x:xs) = x + suma xs

-- b) 'alguno', que devuelve True si algún elemento de una lista de valores
-- booleanos es True, y False en caso contrario.
alguno :: [Bool] -> Bool
alguno [] = False
alguno (x:xs)   | x = True
                | otherwise = alguno xs

-- c) 'todos', que devuelve True si todos los elementos de una lista de valores
-- booleanos son True, y False en caso contrario.
todos :: [Bool] -> Bool
todos [] = True
todos (x:xs)    | not x = False
                | otherwise = todos xs

-- d) 'codes', que dada una lista de caracteres, devuelve la lista de sus ordinales.
codes :: String -> [Int]
codes [] = []
codes (x:xs) = ord x : codes xs

-- e) 'restos', que calcula la lista de los restos de la división de los elementos
-- de una lista de números dada por otro número dado.
restos :: [Int] -> Int -> [Int]
restos [] _ = []
restos (x:xs) n = (x `mod` n) : restos xs n

-- f) 'cuadrados', que dada una lista de números, devuelve la lista de sus cuadrados.
cuadrados :: [Int] -> [Int]
cuadrados [] = []
cuadrados (x:xs) = x^2 : cuadrados xs

-- g) 'longitudes', que dada una lista de listas, devuelve la lista de sus longitudes.
longitudes :: [[a]] -> [Int]
longitudes [] = []
longitudes (x:xs) = length x : longitudes xs

-- h) 'orden', que dada una lista de pares de números, devuelve la lista de aquellos
-- pares en los que la primera componente es menor que el triple de la segunda.
orden :: [(Int,Int)] -> [(Int,Int)]
orden [] = []
orden ((x,y):xs)    | x < y*3 = (x,y) : orden xs
                    | otherwise = orden xs

-- i) 'pares', que dada una lista de enteros, devuelve la lista de los elementos pares.
pares :: [Int] -> [Int]
pares [] = []
pares (x:xs)    | even x = x : pares xs
                | otherwise = pares xs

-- j) 'letras', que dada una lista de caracteres, devuelve la lista de aquellos
-- que son letras (minúsculas o mayúsculas).
letras :: String -> [Char]
letras [] = []
letras (x:xs)   | isAlpha x = x : letras xs
                | otherwise = letras xs

-- k) 'masDe', que dada una lista de listas 'xss' y un número 'n', devuelve la lista
-- de aquellas listas de 'xss' con longitud mayor que 'n'.
masDe :: [[a]] -> Int -> [[a]]
masDe [] _ = []
masDe (x:xs) n  | length x > n = x : masDe xs n
                | otherwise = masDe xs n