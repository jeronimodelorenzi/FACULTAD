{-
El tipo abstracto de datos Secuencias representa una colección ordenada de elementos,
junto con operaciones (idealmente paralelizables) sobre éstas. Consideraremos las 
implementaciones de secuencias mediantes lístas de árboles. La diferencia de ambas es
el costo de las operaciones.
Definir las siguientes funciones, correspondientes a la interfaz de Secuencias, implementando
las secuencias con árboles binarios, definidos con el siguiente tipo de datos:
-}
data BTree a = Empty | Node Int (BTree a) a (BTree a) deriving Show

{-
donde se almacenan los tamaños de los árboles en los nodos. Suponer que el recorrido
inorder del árbol da el orden de los elementos de la secuencia. Calcular el trabajo
y la profundidad de cada una. Resolver la recurrencia y expresar la solución en 
términos del orden O.
-}

size :: BTree a -> Int
size Empty = 0
size (Node s _ _ _) = s

-- nth, calcula el n-ésimo elemento de una secuencia.
nth :: BTree a -> Int -> a
nth (Node s l x r) i
    | i < sizeIzq   = nth l i
    | i > sizeIzq   = nth r (i - sizeIzq - 1)
    | otherwise     = x
    where
        sizeIzq = size l
{-
W(n) = W(n/2) + O(1) = S(n)
Como es constante, podemos tomar f(x) = 1.
Comparamos n^(lg_b(a)) = n^(lg_2(1)) = n^0 = 1.
Entonces tenemos que 1 ∈ θ(1), con lo cual por segundo caso del
Teorema Maestro tenemos que W(n) ∈ O(lg(n)).
-}

-- cons, inserta un elemento al comienzo de la secuencia.
cons :: a -> BTree a -> BTree a
cons x Empty = Node 1 Empty x Empty
cons x (Node s l y r) = Node (s+1) (cons y l) x r
{-
W(n) = W(n/2) + O(1) = S(n)
W(n) ∈ O(lg(n)).
-}

-- tabulate, la cual dada una función f y un entero n devuelve una secuencia de
-- tamaño n, donde cada elemento de la secuencia es el resultado de aplicar f al
-- índice del elemento.
tabulate :: (Int -> a) -> Int -> BTree a
tabulate f n = tabulateAux f 0 n
    where
        tabulateAux :: (Int -> a) -> Int -> Int -> BTree a
        tabulateAux _ _ 0 = Empty
        tabulateAux f i n = let
                                mid = n `div` 2
                                x = f (i+mid)
                                (l, r) = (tabulateAux f i mid, tabulateAux f (i+mid+1) (n-mid-1))
                            in
                                Node n l x r
{-
W(n) = 2W(n/2) + O(1)
S(n) = W(n/2) + O(1)
-}

-- map, la cual dada una función f y una secuencia s, devuelve el resultado de 
-- aplicar f sobre cada elemento de s.
mapT :: (a -> b) -> BTree a -> BTree b
mapT f Empty = Empty
mapT f (Node s l x r) = let
                            (mapIzq, mapDer) = (mapT f l, mapT f r)
                        in
                            Node s mapIzq (f x) mapDer
{-
W(n) = 2W(n/2) + O(1)
S(n) = W(n/2) + O(1)
-}

-- take, tal que dados un entero n y una secuencia s devuelve los primeros
-- n elementos de s.
takeT :: Int -> BTree a -> BTree a
takeT _ Empty = Empty
takeT n t@(Node s l x r)
    | n <= 0        = Empty
    | n >= s        = t
    | n <= sizeIzq   = takeT n l
    | otherwise  = Node n l x (takeT (n - sizeIzq - 1) r)
    where
        sizeIzq = size l
{-
W(n) = W(n/2) + O(1) = S(n)
W(n) ∈ O(lg(n)).
-}

-- drop, tal que dados un entero n y una secuencia s devuelve la secuencia sin
-- los primeros n elementos.
dropT :: Int -> BTree a -> BTree a
dropT _ Empty = Empty
dropT n t@(Node s l x r)
    | n <= 0        = t
    | n >= s        = Empty
    | n <= sizeIzq  = Node (s-n) (dropT n l) x r
    | otherwise     = dropT (n - sizeIzq - 1) r
    where
        sizeIzq = size l
{-
W(n) = W(n/2) + O(1) = S(n)
W(n) ∈ O(lg(n)).
-}

{-
2) El problema de calcular la máxima suma de una subsecuencia contigua de una
secuencia dada s puede resolverse con un algoritmo "Divide & Conquer" que en cada
llamada recursiva calcule: la máxima suma de una subsecuencia contigua de s,
la máxima suma de un prefijo de s, la máxima suma de un sufijo de s y la suma de
todos loselementos de s. Dado el siguiente tipo de datos:
-}
data Tree a = E | Leaf a | Join (Tree a) (Tree a)

-- a) Definir una función mcss, que calcula la máxima suma de una subsecuencia
-- contigua de una secuencia dada, en términos de mapreduce.
mapreduce :: (a -> b) -> (b -> b -> b) -> b -> Tree a -> b
mapreduce f g e = mr
    where 
        mr E = e
        mr (Leaf x) = f x
        mr (Join l r) = 
            let (l', r') = (mr l, mr r)
            in g l' r'

mcss :: (Num a, Ord a) => Tree a -> a
mcss t = let (mFinal, _, _, _) = mapreduce f g e t
         in mFinal
    where
        e = (0, 0, 0, 0)
        
        f a = (max a 0, max a 0, max a 0, a)
        
        g (mIzq, mPIzq, mSIzq, mTIzq)
          (mDer, mPDer, mSDer, mTDer)
          =
          (max mIzq (max mDer (mSIzq + mPDer)), max mPIzq (mTIzq + mPDer), 
           max mSDer (mTDer + mSIzq), mTIzq + mTDer)

{-
Dados los diferentes valores de las acciones de YP a lo largo del tiempom se
desea saber cual es la mejor ganancia que se puede obtener al comprar acciones
un día y venderlas otro.
Definir una función mejorGanancia que calcule la mejor gancia dada una secuencia
de valores, utilizando el siguiente algoritmo:
• Armar pares de la forma (compra, ventas), donde compra es el precio al cual se puede
comprar una acción y ventas los distintos valores en que puede venderse.
• Para cada par de la forma (compra, ventas) calcular las diferencias venta - compra,
donde venta es un elemento de ventas.
• Tomar el número máximo de las diferencias calculadas en el paso anterior.

Definir las siguientes funciones, que implementan distintas partes del algoritmo
y utilizarlas para definir mejorGanancia.
• sufijos, tal que dado un árbol t construye otro con los sufijos de cada elemento de t.
• conSufijos, la cual dado un árbol t reemplaza cada elemento v de t por el par
(v, sufijos de v en t).
• maxT, la cual calcula el máximo elemento de un árbol de enteros.
• maxAll, calcula el máximo elemento de un árbol de árboles de enteros.
-}
sufijos :: Tree Int -> Tree (Tree Int)
sufijos t = sufijosAux t E
    where
        sufijosAux :: Tree Int -> Tree Int -> Tree (Tree Int)
        sufijosAux E _ = E
        sufijosAux (Leaf _) suf = Leaf suf
        sufijosAux (Join l r) suf = let
                                        izq = sufijosAux l (Join r suf)
                                        der = sufijosAux r suf
                                    in
                                        Join izq der

zipTree :: Tree a -> Tree b -> Tree (a,b)
zipTree E E = E
zipTree (Leaf x) (Leaf y) = Leaf (x,y)
zipTree (Join l1 r1) (Join l2 r2) = Join (zipTree l1 l2) (zipTree r1 r2)
zipTree _ _ = E

conSufijos :: Tree Int -> Tree (Int, Tree Int)
conSufijos t = zipTree t (sufijos t) 

reduceTree :: (a -> a -> a) -> a -> Tree a -> a
reduceTree f e E = e
reduceTree f e (Leaf x) = x
reduceTree f e (Join l r) = let (l', r') = (reduceTree f e l, reduceTree f e r)
                            in f l' r'

maxT :: Tree Int -> Int
maxT t = reduceTree max 0 t

maxAll :: Tree (Tree Int) -> Int
maxAll t = mapreduce maxT max 0 t

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f E = E
mapTree f (Leaf x) = Leaf (f x)
mapTree f (Join l r) = let (l', r') = (mapTree f l, mapTree f r)
                       in Join l' r'

mejorGanancia :: Tree Int -> Int
mejorGanancia t = maxGanancia
    where
        sufijosTree = conSufijos t

        diferenciaTree = mapTree resta sufijosTree

        maxGanancia = maxT diferenciaTree

        resta :: (Int, Tree Int) -> Int
        resta (v, t) = mapreduce (\x -> x - v) max 0 t                 

{-
4) Dadas las siguientes funciones:
-}
data T a = E | N (T a) a (T a)
altura :: T a -> Int
altura E = 0
altura (N l x r) = 1 + max (altura l) (altura r)

-- a) Definir una función combinar, que satisfaga la siguiente
-- especificación.
-- • Combinar t1 t2 contiene todos los elementos de t1 y t2 y no contiene ningún otro elemento.
-- • altura (combinar t1 t2) <= 1 + max (altura t1, altura t2)
-- • Wcombinar(d1, d2), Scombinar(d1, d2) ∈ O(d1), donde d1 y d2 son las alturas de los árboles
-- t1 y t2 que recibe como argumento la función combinar.
combinar :: T a -> T a -> T a
combinar E t2 = t2
combinar t1 E = t1
combinar t1@(N l1 x r1) t2@(N l2 y r2) 
            | altura t1 >= altura t2  = N l1 x (combinar r1 t2)
            | otherwise               = N (combinar t1 l2) y r2

-- b) Definir una función filterT (similar a filter sobre listas) que satisfaga
-- la siguiente especificación:
-- Sean p :: a -> Bool y t:: T a:
-- • filterT p t contiene todos los elementos de t que satisfacen p y no contiene
-- ningún otro elemento.
-- • altura (filterT p t) <= altura t
-- • SfilterT(d) ∈ O(d^2) donde d es l altura del árbol que recibe como argumeto filterT.
filterT :: (a -> Bool) -> T a -> T a
filterT _ E = E
filterT p (N l x r) | p x = N (filterT p l) x (filterT p r)
                    | otherwise = combinar (filterT p l) (filterT p r)

-- c) Definir una función quicksort, que implemente el algoritmo quicksort sobre árboles.
-- Utilizar en la definición las funciones definidas anteriormente.
-- Sea t: T Int, quicksortT t es un árbol binario de búsqueda que contiene todos los elementos
-- de t y ningún otro elemento.
-- • Calcular WquicksortT(n) en el peor caso, siendo n la cantidad de nodos del árbol que recibe
-- como argumento la función.
-- • Suponiendo que quicksortT recibe un árbol balanceado, calcular el trabajo y la profundida de
-- la función en el pero caso, el mejor caso y suponiendo que el pivote divide a los datos en la
-- proporción 1 a 9. ¿Qué cambiaría en el último caso si la proporción es 1 a 99?
quicksortT :: T Int -> T Int
quicksortT E = E
quicksortT (N l x r) = N (quicksortT menores) x (quicksortT mayores)
    where
        resto = combinar l r
        menores = filterT (< x) resto
        mayores = filterT (> x) resto

{-
5) Considere el tipo de datos BTree del ejercicio 1.
-}

-- a) Definir una función splitAt tal que dado un árbol t y un entero i construya dos árboles t1 y t2
-- que contengan, t1 los i elementos de más a la izquierda de t y t2 los restantes.
-- Definir splitAt de manera que satisfaga la siguiente especificación:
-- • max (altura t1, altura t2) <= altura t
-- • size t1 = i
-- • toList t1 ++ toList t2 = toList t
-- • WsplitAt(d), SsplitAt(d) ∈ O(d), donde d es la altura del árbol que recibe la función.
splitAtTree :: BTree a -> Int -> (BTree a, BTree a)
splitAtTree Empty _ = (Empty, Empty)
splitAtTree t@(Node s l x r) i
    | i <= 0        = (Empty, t)
    | i >= s        = (t, Empty)
    | i <= sizeIzq   =
        let (menores, mayores) = splitAtTree l i
        in (menores, Node (s-i) mayores x r)
    | otherwise     =
        let (menores, mayores) = splitAtTree r (i - sizeIzq - 1)
        in (Node i l x menores, mayores)
    where sizeIzq = size l

-- b) Definir una función rebalance, que dado un árbol t construya un árbol balanceado con
-- los mismos elementos de t (un árbol es balanceado si para cada par de hijos de un nodo
-- cualquierda l1 y l2 la profundidad de los mismos difiere en a lo sumo 1).
rebalance :: BTree a -> BTree a
rebalance Empty = Empty
rebalance (Nodo s l x r)
    | abs (sizeIzq - sizeDer) == 1  = if 

    where
        abs x   | x < 0     = -x
                | otherwise = x 

