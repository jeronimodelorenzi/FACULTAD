
module Lab02 where

{-
   Laboratorio 2
   EDyAII 2022
-}

import Data.List

-- 1) Dada la siguiente definición para representar árboles binarios:

data BTree a = E | Leaf a | Node (BTree a) (BTree a)

-- Definimos arboles para testear.
-- t1 = Árbol perfecto.
t1 :: BTree Int
t1 = Node (Node (Leaf 1) (Leaf 2)) (Node (Leaf 3) (Leaf 4))
-- t2 = Árbol vacío.
t2 :: BTree Int
t2 = E
-- t3 = Árbol cualquiera.
t3 :: BTree Int
t3 = Node (Node (Node E (Leaf 1)) (Node (Leaf 2) (Leaf 3))) (Node (Leaf 4) E)


-- Definir las siguientes funciones:

-- a) altura, devuelve la altura de un árbol binario.

altura :: BTree a -> Int
altura E = -1
altura (Leaf _) = 0
altura (Node l r) = 1 + max (altura l) (altura r)

-- b) perfecto, determina si un árbol binario es perfecto (un árbol binario es perfecto si cada nodo tiene 0 o 2 hijos
-- y todas las hojas están a la misma distancia desde la raı́z).

perfecto :: BTree a -> Bool
perfecto E = True
perfecto (Leaf _) = True
perfecto (Node l r) = perfecto l && perfecto r && (altura l == altura r)

-- c) inorder, dado un árbol binario, construye una lista con el recorrido inorder del mismo.

inorder :: BTree a -> [a]
inorder E = []
inorder (Leaf a) = [a]
inorder (Node l r) = (inorder l) ++ (inorder r)


-- 2) Dada las siguientes representaciones de árboles generales y de árboles binarios (con información en los nodos):

data GTree a = EG | NodeG a [GTree a] deriving (Show)

data BinTree a = EB | NodeB (BinTree a) a (BinTree a) deriving (Show)

{- Definir una función g2bt que dado un árbol nos devuelva un árbol binario de la siguiente manera:
   la función g2bt reemplaza cada nodo n del árbol general (NodeG) por un nodo n' del árbol binario (NodeB ), donde
   el hijo izquierdo de n' representa el hijo más izquierdo de n, y el hijo derecho de n' representa al hermano derecho
   de n, si existiese (observar que de esta forma, el hijo derecho de la raı́z es siempre vacı́o).
   
   
   Por ejemplo, sea t: 
       
                    A 
                 / | | \
                B  C D  E
               /|\     / \
              F G H   I   J
             /\       |
            K  L      M    

   g2bt t =
         
                  A
                 / 
                B 
               / \
              F   C 
             / \   \
            K   G   D
             \   \   \
              L   H   E
                     /
                    I
                   / \
                  M   J  
-}

-- Definimos el árbol del ejemplo.
t4 :: GTree Char
t4 = NodeG 'A' [
                  NodeG 'B' 
                  [
                     NodeG 'F' 
                     [
                        NodeG 'K' [],
                        NodeG 'L' []
                     ],
                     NodeG 'G' [],
                     NodeG 'H' []
                  ],
                  NodeG 'C' [],
                  NodeG 'D' [],
                  NodeG 'E' 
                  [
                     NodeG 'I' 
                     [
                        NodeG 'M' []
                     ],
                     NodeG 'J' []
                  ]
               ]

g2bt :: GTree a -> BinTree a
g2bt EG = EB
g2bt (NodeG a x) = NodeB (gL2bt x) a EB

gL2bt :: [GTree a] -> BinTree a
gL2bt [] = EB
gL2bt (NodeG a x:xs) = NodeB (gL2bt x) a (gL2bt xs)


-- 3) Utilizando el tipo de árboles binarios definido en el ejercicio anterior, definir las siguientes funciones: 
{-
   a) dcn, que dado un árbol devuelva la lista de los elementos que se encuentran en el nivel más profundo 
      que contenga la máxima cantidad de elementos posibles. Por ejemplo, sea t:
            1
          /   \
         2     3
          \   / \
           4 5   6
                             
      dcn t = [2, 3], ya que en el primer nivel hay un elemento, en el segundo 2 siendo este número la máxima
      cantidad de elementos posibles para este nivel y en el nivel tercer hay 3 elementos siendo la cantidad máxima 4.
   -}

-- Árbol binario.
t5 :: BinTree Int
t5 = NodeB (NodeB EB 2 (NodeB EB 4 EB)) 1 (NodeB (NodeB EB 5 EB) 3 (NodeB EB 6 EB))

dcn :: BinTree a -> [a]
dcn t = buscar (zip [0 ..] (levels t)) []
   where
      buscar [] xs = xs
      buscar ((n,x):xs) ts =
         if length x == 2^n
            then buscar xs x
            else buscar xs ts

levels :: BinTree a -> [[a]]
levels EB = []
levels (NodeB l a r) = [a] : mLevels (levels l) (levels r)

mLevels :: [[a]] -> [[a]] -> [[a]]
mLevels [] ys = ys
mLevels xs [] = xs
mLevels (x:xs) (y:ys) = (x++y) : mLevels xs ys


{- b) maxn, que dado un árbol devuelva la profundidad del nivel completo
      más profundo. Por ejemplo, maxn t = 2   -}

maxn :: BinTree a -> Int
maxn t = buscar (zip [0..] (levels t)) 0
   where
      buscar [] n = n
      buscar ((i,x):xs) n =
         if length x == 2^i
            then buscar xs (i+1)
            else buscar xs n


{- c) podar, que elimine todas las ramas necesarias para transformar
      el árbol en un árbol completo con la máxima altura posible. 
      Por ejemplo,
         podar t = NodeB (NodeB EB 2 EB) 1 (NodeB EB 3 EB)
-}

podar :: BinTree a -> BinTree a
podar t = podarAux t (maxn t)

podarAux:: BinTree a -> Int -> BinTree a
podarAux _ 0 = EB
podarAux EB _ = EB
podarAux (NodeB l a r) n = NodeB (podarAux l (n-1)) a (podarAux r (n-1))