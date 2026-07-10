import Seq
import Par
import ListSeq

{-
Parcial 1 - 2026
-}
type Interval = (Int, Int)
data STree1 a = L1 Interval a | N1 Interval a (STree1 a) (STree1 a) deriving Show

left :: STree1 a -> Int
left (L1 (i, _) _) = i
left (N1 (i, _) _ _ _) = i

right :: STree1 a -> Int
right (L1 (_, j) _) = j
right (N1 (_, j) _ _ _) = j

isSTree :: STree1 a -> Bool
isSTree (L1 (i,j) _) = i == j
isSTree (N1 (i,j) _ l r) = i == left l && j == right r && right l + 1 == left r && isSTree l && isSTree r

val :: STree1 a -> a
val (L1 _ x) = x
val (N1 _ x _ _) = x

fromList :: Num a => [a] -> STree1 a
fromList xs = fromListAux xs 0
    where
        fromListAux :: Num a => [a] -> Int -> STree1 a
        fromListAux [x] i = L1 (i,i) x
        fromListAux xs i =  let
                                n = length xs
                                mitad = n `div` 2
                                (l', r') = splitAt mitad xs
                                l = fromListAux l' i
                                r = fromListAux r' (i+length l')
                            in
                                N1 (i, right r) (val l + val r) l r

nth :: Num a => Int -> STree1 a -> Maybe a
nth i (L1 (a,b) x) | i == a = Just x
                   | otherwise = Nothing
nth i (N1 (a,b) x l r) | i < a || i > b = Nothing
                       | i <= right l   = nth i l
                       | otherwise      = nth i r

included :: Interval -> Interval -> Bool
included (x1, y1) (x2, y2) = x1 >= x2 && y1 <= y2

sumQuery :: Num a => STree1 a -> Interval -> a
sumQuery (L1 (i,j) x) (a,b) | included (i,j) (a,b) = x
                            | otherwise = 0
sumQuery (N1 (i,j) x l r) (a,b) | included (i,j) (a,b) = x
                                | b < i || a > j       = 0  -- Si son disjuntos, cortamos la recursión acá
                                | otherwise            = sumQuery l (a,b) + sumQuery r (a,b)

{-
Recuperatorio parcial 1 - 2026
-}
data Tree1 a = N2 (Tree1 a) a (Tree1 a) | L2 a | E2 deriving Show

isMinHeap :: Ord a => a -> Tree1 a -> Bool
isMinHeap _ E2 = True
isMinHeap x (L2 y) = x <= y
isMinHeap x (N2 l y r) = x <= y && isMinHeap y l && isMinHeap y r

prune :: Ord a => Tree1 a -> a -> Tree1 a
prune E2 _ = E2
prune (L2 x) y | x < y = L2 x
               | otherwise = E2
prune (N2 l x r) y | x >= y = E2
                   | otherwise = N2 (prune l y) x (prune r y)

append :: Ord a => Tree1 a -> Tree1 a -> Tree1 a
append h1 E2 = h1
append E2 h2 = h2
append h1@(N2 l1 x r1) h2@(N2 l2 y r2) = if x <= y then N2 l1 x (append r1 h2) else N2 (append h1 l2) y r2

{-
Parcial 1 - 2025
-}
data Scapegoat a = E3 | N3 a Int (Scapegoat a) (Scapegoat a) deriving (Eq, Show)

size :: Scapegoat a -> Int
size E3 = 0
size (N3 _ s _ _ ) = s

isBST :: Ord a => Scapegoat a -> Bool
isBST t = isBSTaux t Nothing Nothing
    where
        isBSTaux :: Ord a => Scapegoat a -> Maybe a -> Maybe a -> Bool
        isBSTaux E3 _ _ = True
        isBSTaux (N3 x _ l r) minB maxB = isValid x minB maxB && isBSTaux l minB (Just x) && isBSTaux r (Just x) maxB

        isValid val minB maxB = checkMin val minB && checkMax val maxB

        checkMin _ Nothing = True
        checkMin val (Just minB) = val >= minB

        checkMax _ Nothing = True
        checkMax val (Just maxB) = val <= maxB

isScapegoatTree :: Ord a => Scapegoat a -> Bool
isScapegoatTree E3 = True
isScapegoatTree t = checkInv t && isBST t
    where
        checkInv :: Ord a => Scapegoat a -> Bool
        checkInv E3 = True
        checkInv (N3 _ s l r) = 3 * size l <= 2 * s && 3 * size r <= 2 * s && checkInv l && checkInv r

member :: Ord a => a -> Scapegoat a -> Bool
member _ E3 = False
member x (N3 y _ l r) | x == y = True
                      | x <= y = member x l
                      | otherwise = member x r

rebuild :: Scapegoat a -> Scapegoat a
rebuild t = rebuildAux (inorder t []) (size t)
    where
        inorder :: Scapegoat a -> [a] -> [a]
        inorder E3 xs = xs
        inorder (N3 x _ l r) xs = inorder l (x : inorder r xs)

        rebuildAux :: [a] -> Int -> Scapegoat a
        rebuildAux [] _ = E3
        rebuildAux xs s = let
                            mitad = s `div` 2
                            (l, m:r) = splitAt mitad xs
                            sDer = s - mitad - 1
                          in
                            N3 m s (rebuildAux l mitad) (rebuildAux r sDer)

insert :: Ord a => a -> Scapegoat a -> Scapegoat a
insert x E3 = N3 x 1 E3 E3
insert x (N3 y s l r) | x <= y = let
                                    l' = insert x l
                                    nodo = N3 y (s+1) l' r
                                in
                                    if 3 * size l' <= 2 * (s+1) then nodo else rebuild nodo
                      | otherwise = let
                                        r' = insert x r
                                        nodo = N3 y (s+1) l r'
                                    in
                                        if 3 * size r' <= 2 * (s+1) then nodo else rebuild nodo

{-
Final 1 - 2026
-}
data Trie = E4 | N4 String [Trie] deriving (Show, Eq)

isPrefix :: String -> String -> Bool
isPrefix [] _ = True
isPrefix _ [] = False
isPrefix (x:xs) (y:ys) = x == y && isPrefix xs ys

inv2 :: Trie -> Bool
inv2 E4 = True
inv2 (N4 x []) = True
inv2 (N4 x xs) = inv2List x xs
    where
        toString :: Trie -> String
        toString E4 = []
        toString (N4 x _) = x

        inv2List :: String -> [Trie] -> Bool
        inv2List _ [] = True
        inv2List x (y:ys) = isPrefix x (toString y) && inv2 y && inv2List x ys

inv3 :: Trie -> Bool
inv3 E4 = True
inv3 (N4 x []) = True
inv3 (N4 _ xs) = inv3List xs
    where
        toString :: Trie -> String
        toString E4 = []
        toString (N4 x _) = x

        inv3List :: [Trie] -> Bool
        inv3List [] = True
        inv3List (x:xs) = checkRest (toString x) xs && inv3 x && inv3List xs

        checkRest :: String -> [Trie] -> Bool
        checkRest _ [] = True
        checkRest x (y:ys) = not (isPrefix x (toString y)) && not (isPrefix (toString y) x) && checkRest x ys

isTrie :: Trie -> Bool
isTrie E4 = True
isTrie t@(N4 x _) = x == "" && inv2 t && inv3 t
    where
        toString :: Trie -> String
        toString E4 = []
        toString (N4 x _) = x

prefixes :: String -> Trie -> [String]
prefixes _ E4 = []
prefixes p (N4 s hs)
    | isPrefix p s = s : prefixesAux p hs
    | otherwise    = prefixesAux p hs
  where
    prefixesAux :: String -> [Trie] -> [String]
    prefixesAux _ [] = []
    prefixesAux p (x:xs) = prefixes p x ++ prefixesAux p xs

coldWaveDays :: Seq s => s (Float, Float) -> Float -> Float
coldWaveDays s t =  let
                        s_dat = tabulateS (\i -> if fst (nthS s i) <= t && snd (nthS s i) <= t then (1, i, 1, i) else (0, i, 0, i)) (lengthS s) `asTypeOf` mapS undefined s
                        compare (0, -2, 0, -2) tupla = tupla
                        compare tupla (0, -2, 0, -2) = tupla
                        compare (l1, i1, r1, j1) (l2, i2, r2, j2) =
                            if r1 == 1 && l2 == 1 && j1 == i2 - 1 then (l1, i1, r2, j2) else (l2, i2, r2, j2)
                        (s_red, res) = scanS compare (0, -2, 0, -2) s_dat
                        s_append = appendS (dropS s_red 1) (singletonS res)
                        s_res = mapS (\(l, i, r, j) -> if l == 1 then j - i + 1 else 0) s_append
                        resultado = reduceS max 0 s_res
                    in
                        if resultado < 3 then 0 else fromIntegral resultado

{-
Final 2 - 2026
-}
data GTree a = N5 a [GTree a] deriving (Show, Eq)

elemT :: Eq a => a -> GTree a -> Bool
elemT x (N5 y ys) | x == y = True
                  | otherwise = elemTAux x ys
    where
        elemTAux :: Eq a => a -> [GTree a] -> Bool
        elemTAux _ [] = False
        elemTAux x (y:ys) =  elemT x y || elemTAux x ys

        val :: GTree a -> a
        val (N5 x _) = x


descendent :: Eq a => a -> a -> GTree a -> Bool
descendent x y (N5 z zs) | x == z = buscarY y zs
                         | otherwise = descendentAux x y zs
    where
        descendentAux :: Eq a => a -> a -> [GTree a] -> Bool
        descendentAux _ _ [] = False
        descendentAux x y (z:zs) = descendent x y z || descendentAux x y zs

        buscarY :: Eq a => a -> [GTree a] -> Bool
        buscarY _ [] = False
        buscarY y (z:zs) = elemT y z || buscarY y zs

        val :: GTree a -> a
        val (N5 x _) = x

arbolPrueba :: GTree Int
arbolPrueba = 
    N5 1 [
        N5 2 [
            N5 5 [],
            N5 6 []
        ],
        N5 3 [],
        N5 4 [
            N5 7 [
                N5 8 [],
                N5 9 [],
                N5 10 []
            ]
        ]
    ]