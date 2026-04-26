module Practica4 where

infixr 2 |||
(|||) :: a -> b -> (a, b)
a ||| b = (a, b)

{-
1) Si un árbol binario es dado como un nodo con dos subárboles idénticos se puede
aplicar la técnica sharing para que los subárboles sean representados por el mismo
árbol. Definir las siguientes funciones de manera que se puedan compartir la mayor
cantidad posible de elementos de los árboles creados.
-}

data Tree a = Empty | Nodo (Tree a) a (Tree a) deriving Show

-- a) completo :: a -> Int -> Tree a, tal que dado un valor x de tipo a y un entero d,
-- crea un árbol binario completo de altura d con el valor de x en cada nodo.
completo :: a -> Int -> Tree a
completo _ 0 = Empty
completo x d = Nodo t x t
    where t = completo x (d-1)

-- b) balanceado :: a -> Int -> Tree a, tal que dado un valor x de tipo a y un entero
-- n, crea un árbol binario balanceado de tamaño n, con el valor de x en cada nodo.
balanceado :: a -> Int -> Tree a
balanceado _ 0 = Empty
balanceado x n  | odd n = Nodo r x r
                | otherwise = Nodo l x r
    where 
        restNodes = (n-1) `div` 2
        r = balanceado x restNodes
        l = balanceado x (restNodes+1)

{-
2) Definir las siguientes funciones sobre árboles binarios de búsqueda (bst):
-}
-- Definición de BST.
data BST a = Hoja | NodoBST (BST a) a (BST a) deriving Show

-- Árbol de ejemplo.
t1 :: BST Int
t1 = NodoBST (NodoBST (NodoBST Hoja 2 Hoja) 3 (NodoBST Hoja 4 Hoja)) 5 (NodoBST (NodoBST Hoja 6 Hoja) 8 (NodoBST Hoja 9 Hoja))

t2 :: BST Int
t2 = NodoBST (NodoBST Hoja 1 Hoja) 3 (NodoBST Hoja 6 Hoja)

noBST :: BST Int
noBST = NodoBST (NodoBST (NodoBST Hoja 4 Hoja) 2 Hoja) 3 (NodoBST Hoja 7 Hoja)

-- Definiciones auxiliares
minimumBST :: Ord a => BST a -> a
minimumBST (NodoBST Hoja x _)   = x
minimumBST (NodoBST l x _)      = minimumBST l

preorder :: BST a -> [a]
preorder Hoja               = []
preorder (NodoBST l a r)    = [a] ++ preorder l  ++ preorder r

-- 1) maximum :: Ord a => BST a -> a, que calcula el máximo valor en un bst.
maximumBST :: Ord a => BST a -> a
maximumBST (NodoBST _ x Hoja) = x
maximumBST (NodoBST _ x r)    = maximumBST r

-- 2) checkBST :: Ord a => BST a -> Bool, que chequea si un árbol binario es un bst.
checkBST :: Ord a => BST a -> Bool
checkBST Hoja = True
checkBST (NodoBST Hoja x Hoja)  = True
checkBST (NodoBST Hoja x r)     = x < minimumBST r && checkBST r
checkBST (NodoBST l x Hoja)     = x >= maximumBST l && checkBST l
checkBST (NodoBST l x r)        = x >= maximumBST l && x < minimumBST r && checkBST l && checkBST r

-- 3) splitBST :: Ord a => BST a -> a -> (BST a, BST a), que dado un árbol bst t y un elemento x,
-- devuelva una tupla con un bst con los elementos de t menores o iguales a x y un bst con los
-- elementos de t mayores a x.
splitBST :: Ord a => BST a -> a -> (BST a, BST a)
splitBST Hoja x = (Hoja, Hoja)
splitBST (NodoBST l y r) x  | x == y    = (NodoBST l y Hoja, r)
                            | x < y     = let (l', r') = splitBST l x
                                          in (l', NodoBST r' y r)
                            | otherwise = let (l', r') = splitBST r x
                                          in (NodoBST l y l', r')

-- 4) join :: Ord a => BST a -> BST a -> BST a, que una los elementos de dos árboles bst en uno.
join :: Ord a => BST a -> BST a -> BST a
join Hoja b = b
join a Hoja = a
join t1@(NodoBST l1 a r1) t2@(NodoBST l2 b r2) 
            = let (l', r') = splitBST t2 a
              in NodoBST (join l1 l') a (join r1 r')

{-
3) La definición de member dada en teoría (la cual determina si un elemento está en un bst)
realiza en el peor caso 2*d comparaciones, donde d es la altura del árbol. Dar una definición
de member que realice a lo sumo d+1 comparaciones. Para ello definir member en términos de una
función auxiliar que tenga como parámetro el elemento candidato, el cual puede ser igual al
elemento que se desea buscar (por ejemplo, el último elemento para el cual la comparación de
a <= b retornó True) y que chequee que los elementos son iguales sólo cuando llega a una hoja
del árbol.
-}

-- Definición original de member (2*d operaciones).
memberBST :: Ord a => a -> BST a -> Bool
memberBST a Hoja = False
memberBST x (NodoBST l y r)     | x == y    = True
                                | x < y     = memberBST x l
                                | otherwise = memberBST x r

-- Definición eficiente de member (d+1 operaciones).
memberEficiente :: Ord a => a -> BST a -> Bool
memberEficiente a Hoja = False
memberEficiente a tree = memberEficienteAux a Nothing tree
    where
        memberEficienteAux :: Ord a => a -> Maybe a -> BST a -> Bool
        memberEficienteAux x Nothing Hoja           =  False
        memberEficienteAux x (Just cand) Hoja       = x == cand
        memberEficienteAux x cand (NodoBST l y r)   | x < y     = memberEficienteAux x cand l
                                                    | otherwise = memberEficienteAux x (Just y) r

{-
4) La función insert dada en teoría para insertar un elemento en un rbt puede
optimizarse eliminando comparaciones innecesarias hechas por la función balance.
Por ejemplo, en la definición de la función ins cuando se aplica balance sobre el
resultado de aplicar insert x sobre el subárbol izquierdo (l) y el subárbol 
derecho (r), los casos de balance para testear que se viola el invariante 1 en el
subárbol derecho no son necesarios dado que r es un rbt.
-}

-- Definición de RBT
data Color = R | B deriving Show
data RBT a = E | T Color (RBT a) a (RBT a) deriving Show

-- Definición original de insert.
insert :: Ord a => a -> RBT a -> RBT a
insert x t = makeBlack (ins x t)
    where
        ins :: Ord a => a -> RBT a -> RBT a
        ins x E = T R E x E
        ins x (T c l y r)   | x < y     = balance c (ins x l) y r
                            | x > y     = balance c l y (ins x r)
                            | otherwise = T c l y r
        makeBlack :: RBT a -> RBT a
        makeBlack E             = E
        makeBlack (T _ l x r)   = T B l x r
-- Rebalanceo
balance :: Color -> RBT a -> a -> RBT a -> RBT a
balance B (T R (T R a x b) y c) z d = (T R (T B a x b) y (T B c z d))
balance B (T R a x (T R b y c)) z d = (T R (T B a x b) y (T B c z d))
balance B a x (T R (T R b y c) z d) = (T R (T B a x b) y (T B c z d))
balance B a x (T R b y (T R c z d)) = (T R (T B a x b) y (T B c z d))
balance c l a r                     = T c l a r

-- a) Definir dos funciones lbalance y rbalance que chequeen que el invariante 1
-- se cumple en los subárboles izquierdo y derecho respectivamente.
lbalance :: Color -> RBT a -> a -> RBT a -> RBT a
lbalance B (T R (T R a x b) y c) z d    = (T R (T B a x b) y (T B c z d))
lbalance B (T R a x (T R b y c)) z d    = (T R (T B a x b) y (T B c z d))
lbalance c l a r                        = T c l a r

rbalance :: Color -> RBT a -> a -> RBT a -> RBT a
rbalance B a x (T R (T R b y c) z d)    = (T R (T B a x b) y (T B c z d))
rbalance B a x (T R b y (T R c z d))    = (T R (T B a x b) y (T B c z d))
rbalance c l a r                        = T c l a r

-- b) Reemplazar las llamadas a balance en ins por llamadas a alguna de estas
-- dos funciones
insertBalance :: Ord a => a -> RBT a -> RBT a
insertBalance x t = makeBlack (ins x t)
    where
        ins :: Ord a => a -> RBT a -> RBT a
        ins x E = T R E x E
        ins x (T c l y r)   | x < y     = lbalance c (ins x l) y r
                            | x > y     = rbalance c l y (ins x r)
                            | otherwise = T c l y r
        makeBlack :: RBT a -> RBT a
        makeBlack E             = E
        makeBlack (T _ l x r)   = T B l x r

-- Testeo RBT
rbt1 = insertBalance 2 (insertBalance 4 (insertBalance 3 
            (insertBalance 1(insertBalance 8 (insertBalance 6 (insertBalance 7 (insertBalance 5 E)))))))

{-
Los árboles 1-2-3 son árboles binarios de búsqueda donde los nodos pueden guardar
múltiples valores y tener entre 2 y 4 hijos.
Específicamente, en un árbol 1-2-3 los nodos internos son de la forma:
2-node: Contienen un valor y dos hijos.
3-node: Contienen dos valores y tres hijos.
4-node: Contienen tres valores y cuatro hijos.
-}

-- 1) Definir un tipo de datos que represente árboles 1-2-3.
data Arbol123 a = Em
                | Node2 (Arbol123 a) a (Arbol123 a)
                | Node3 (Arbol123 a) a (Arbol123 a) a (Arbol123 a)
                | Node4 (Arbol123 a) a (Arbol123 a) a (Arbol123 a) a (Arbol123 a)
                deriving Show

-- 2) Definir una función que transforme red-black trees en arboles 1-2-3.
-- Paralelizar cuando sea posible.
rbt2arbol123 :: RBT a -> Arbol123 a
rbt2arbol123 E = Em
rbt2arbol123 (T B (T R a y b) x (T R c z d))    = let ((l', m1'), (m2', r')) = ((rbt2arbol123 a) ||| (rbt2arbol123 b)) ||| ((rbt2arbol123 c) ||| (rbt2arbol123 d))
                                                  in Node4 l' y m1' x m2' z r'
rbt2arbol123 (T B a x (T R b y c))              = let (l', (m', r')) = (rbt2arbol123 a) ||| ((rbt2arbol123 b) ||| (rbt2arbol123 c))
                                                  in Node3 l' x m' y r'
rbt2arbol123 (T B (T R a y b) x c)              = let (l', (m', r')) = (rbt2arbol123 a) ||| ((rbt2arbol123 b) ||| (rbt2arbol123 c))
                                                  in Node3 l' y m' x r'
rbt2arbol123 (T B a x b)                        = let (l', r') = (rbt2arbol123 a) ||| (rbt2arbol123 b)
                                                  in Node2 l' x r'

{-
Definir una función fromList :: [a] -> Heap a, que cree un leftist heap a partir
de una lista, convirtiendo cada elemento de la lista en un heap de un solo elemento
y aplicando la función merge hasta obtener un solo heap. Aplicar la función merge n
veces, donde n es la longitud de la lista que recibe como argumento la función.
-}

-- Definición de leftist heap.
type Rank = Int
data Heap a = Emp | N Rank a (Heap a) (Heap a) deriving Show

-- Heap de ejemplo.
listToHeap = [5,3,2,1,6,4]

-- Función auxiliares.
rank :: Heap a -> Rank
rank Emp = 0
rank (N r _ _ _) = r

merge :: Ord a => Heap a -> Heap a -> Heap a
merge h1 Emp = h1
merge Emp h2 = h2
merge h1@(N _ x a1 b1) h2@(N _ y a2 b2) | x <= y    = makeH x a1 (merge b1 h2)
                                        | otherwise = makeH y a2 (merge h1 b2)
    where
        makeH x a b | rank a >= rank b  = N (rank b + 1) x a b
                    | otherwise = N (rank a + 1) x b a


fromList :: Ord a => [a] -> Heap a 
fromList [] = Emp
fromList x  = let x' = elem2Heap x
             in fromListAux x'
    where 
        elem2Heap []        = []
        elem2Heap (x:xs)    = (N 1 x Emp Emp):elem2Heap xs

        fromListAux []      = Emp
        fromListAux (x:xs)  = merge x (fromListAux xs)

fromList2 :: Ord a => [a] -> Heap a
fromList2 []        = Emp
fromList2 (x:xs)    = merge (N 1 x Emp Emp) (fromList2 xs)

{-
7) Un pairing heap es un árbol general que satisface la invariante de heap.
Para implementar pairing heap en Haskell definimos el siguiente tipo de datos:
-}
data PHeaps a = Empt | Root a [PHeaps a] deriving Show

{-
Definir las siguientes funciones:
-}

-- a) isPHeap :: Ord a => PHeaps a -> Bool, determina si un árbol es un pairing 
-- heap, es decir, cumple con el invariante de heap.
isPHeap :: Ord a => PHeaps a -> Bool
isPHeap Empt            = True
isPHeap (Root x [Empt]) = True
isPHeap (Root x hs)     = isPHeapAux x hs
    where
        isPHeapAux :: Ord a => a -> [PHeaps a] -> Bool
        isPHeapAux _ []             = True
        isPHeapAux x (Empt:hs)      = isPHeapAux x hs
        isPHeapAux x (Root y h:hs)  = (x <= y) && (isPHeap (Root y h)) && (isPHeapAux x hs)

--b) merge :: Ord a => PHeaps a -> PHeaps a -> PHeaps a, que una dos pairing heap.
-- Para ello, comparar las raíces de ambos árboles y elegir la menor como raíz del
-- nuevo heap, agregar el árbol con mayor raíz como hijo de éste.
mergePH :: Ord a => PHeaps a -> PHeaps a -> PHeaps a
mergePH h1 Empt = h1
mergePH Empt h2 = h2
mergePH h1@(Root x1 hs1) h2@(Root x2 hs2)   | x1 <= x2  = Root x1 (h2:hs1)
                                            | otherwise = Root x2 (h1:hs2)

-- c) insert :: Ord a => PHeaps a -> a -> PHeaps a, que nserte un elemento en un
-- pairing hespd. Puede ser útil la función merge.
insertPH :: Ord a => PHeaps a -> a -> PHeaps a
insertPH h x = mergePH h (Root x [])

-- d) concatHeaps :: Ord a => [PHeaps a] -> PHeaps a, que dada una lista de pairing
-- heaps construya otro con los elementos del mismo.
concatHeaps :: Ord a => [PHeaps a] -> PHeaps a
concatHeaps [] = Empt
concatHeaps (x:xs) = mergePH x (concatHeaps xs)

-- e) delMin :: Ord a => PHeaps a -> Maybe (a, PHeaps a), que dado un pairing heaps,
-- devuelva si el árbol no es vacío un par con el menor elemento y un pairing heap
--  sin este elemento, o Nothing en otro caso.
delMin :: Ord a => PHeaps a -> Maybe (a, PHeaps a)
delMin Empt = Nothing
delMin (Root x hs) = Just (x, concatHeaps hs)

-- Caso de prueba
pheap1 = insertPH (insertPH (insertPH (insertPH (insertPH (insertPH Empt 1) 4) 3) 8) 7) 12
pheap2 = insertPH (insertPH Empt 5) 0