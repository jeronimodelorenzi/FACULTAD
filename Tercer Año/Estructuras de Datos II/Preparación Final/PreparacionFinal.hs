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

{-
Final 1 - 2018
-}
type Name = String
data DirTree a = Dir Name [DirTree a] | File Name a deriving Show
type Path = [String]

names :: [DirTree a] -> [Name]
names [] = []
names (x:xs) = toName x : names xs
    where
        toName :: DirTree a -> Name
        toName (Dir n _) = n
        toName (File n _) = n

mkDir :: Path -> Name -> DirTree a -> DirTree a
mkDir p n d = mkdir ("/" : p) n d
    where
        mkdir :: Path -> Name -> DirTree a -> DirTree a
        mkdir [p] newName (Dir dirName xs) 
            | p == dirName && not(exists newName xs) = Dir dirName (Dir newName [] : xs)
            | otherwise                              = Dir dirName xs
        mkdir (p:q:ps) newName (Dir dirName xs)
            | p == dirName = Dir dirName (act (q:ps) newName xs)
            | otherwise    = Dir dirName xs
        mkdir _ _ d = d

        exists :: Name -> [DirTree a] -> Bool
        exists name xs = exists' name (names xs)

        exists' :: Name -> [Name] -> Bool
        exists' _ [] = False
        exists' name (x:xs) = name == x || exists' name xs

        act :: Path -> Name -> [DirTree a] -> [DirTree a]
        act _ _ [] = []
        act p n (q:ps) | (head p) == toName q = (mkdir p n q):ps
                       | otherwise            = q:act p n ps

        toName :: DirTree a -> Name
        toName (Dir n _) = n
        toName (File n _) = n

ls :: Path -> DirTree a -> [Name]
ls p t = ls' ("/":p) t
    where
        ls' [p] (Dir dirName xs) | p == dirName = names xs
                                 | otherwise = []
        ls' (p:q:ps) (Dir dirName xs) | p == dirName = buscar (q:ps) xs
                                      | otherwise = []
        ls' _ _ = []

        buscar :: Path -> [DirTree a] -> [Name]
        buscar _ [] = []
        buscar p (q:ps) = ls' p q ++ buscar p ps

dirtree = Dir "/" [Dir "home" [Dir "luis" [File "Carta.txt" "xxx"], Dir "Pedro" []], Dir "mnt" []]

{-
Final 1 - 2019
-}
data BTree a = E6 | L6 a | N6 Int (BTree a) (BTree a)

stripSufix :: Eq a => BTree a -> BTree a -> Maybe (BTree a)
stripSufix suf sec | size2 suf > size2 sec = Nothing
                   | otherwise = let
                                    k = size2 sec - size2 suf
                                    (prefijo, sufijo) = divide sec k
                                 in
                                    if iguales suf sufijo then Just sufijo else Nothing
    where
        size2 :: BTree a -> Int
        size2 E6 = 0
        size2 (L6 x) = 1
        size2 (N6 s _ _) = s

        divide :: BTree a -> Int -> (BTree a, BTree a)
        divide E6 _ = (E6, E6)
        divide (L6 x) i      | i < 1 = (E6, L6 x)
                             | otherwise = (L6 x, E6)
        divide t@(N6 s l r) i | i < 1   = (E6, t)
                              | i >= s  = (t, E6)
                              | i <= size2 l = let (l', r') = divide l i
                                         in (l', append2 r' r)
                              | otherwise = let (l', r') = divide r i
                                           in (append2 l l', r')

        append2 :: BTree a -> BTree a -> BTree a
        append2 E6 t2 = t2
        append2 t1 E6 = t1
        append2 t1 t2 = N6 (size2 t1 + size2 t2) t1 t2

        iguales :: Eq a => BTree a -> BTree a -> Bool
        iguales E6 E6 = True
        iguales (L6 x) (L6 y) = x == y
        iguales (N6 _ l1 r1) (N6 _ l2 r2) = let
                                                (bL, bR) = iguales l1 l2 ||| iguales r1 r2
                                            in
                                                bL && bR

maxBalance :: Seq s => s Int -> Int
maxBalance s =  let
                    (s_red, red) = scanS (+) 0 s
                    s_append = appendS s_red (singletonS red)
                    (s_min, _) = scanS min maxBound s_append
                    s_res = tabulateS (\i -> nthS s_append i - nthS s_min i) (lengthS s_append) `asTypeOf` s_append
                in
                    reduceS max minBound s_res

{-
Ejercicios finales diciembre x
-}
data Tree2 a = E | L a | N Int (Tree2 a) (Tree2 a) deriving Show

size3 :: Tree2 a -> Int
size3 E = 0
size3 (L _) = 1
size3 (N s _ _) = s

append3 :: Tree2 a -> Tree2 a -> Tree2 a
append3 E t2 = t2
append3 t1 E = t1
append3 t1 t2 = N (size3 t1 + size3 t2) t1 t2

filterInd :: (a -> Bool) -> Tree2 a -> Tree2 (Int, a)
filterInd f t = filterIndAux f t 0
    where
        filterIndAux :: (a -> Bool) -> Tree2 a -> Int -> Tree2 (Int, a)
        filterIndAux _ E _ = E
        filterIndAux f (L x) i | f x = L (i, x)
                               | otherwise = E
        filterIndAux f (N _ l r) i = let
                                        sL = size3 l
                                        (l', r') = filterIndAux f l i ||| filterIndAux f r (i+sL)
                                     in
                                        append3 l' r'

partir :: (Num a, Ord a) => Tree2 a -> (Tree2 (Int,a), Tree2 (Int, a))
partir t = partirAux t 0
    where
        partirAux :: (Num a, Ord a) => Tree2 a -> Int -> (Tree2 (Int,a), Tree2 (Int, a))
        partirAux E _ = (E, E)
        partirAux (L x) i | x >= 0 = (L (i,x), E)
                          | otherwise = (E, L (i, x))
        partirAux (N _ l r) i = let
                                    sL = size3 l
                                    ((lP, lN), (rP, rN)) = partirAux l i ||| partirAux r (i+sL)
                                in
                                    (append3 lP rP, append3 lN rN) 
                                    

cantCeros :: Seq s => s Int -> Int
cantCeros s = let
                s_info = tabulateS (\i -> if nthS s i == 0 then 1 else 0) (lengthS s) `asTypeOf` s
              in
                reduceS (+) 0 s_info

posUnos :: Seq s => s Int -> s Int
posUnos s = let
                ceros = cantCeros s
                (s_red, _) = scanS (+) 0 s
            in
                tabulateS (\i -> ceros + nthS s_red i + nthS s i - 1) (lengthS s) `asTypeOf` s

posCeros :: Seq s => s Int -> s Int
posCeros s = let
                ceros = tabulateS (\i -> if nthS s i == 0 then 1 else 0) (lengthS s) `asTypeOf` s
                (s_red, _) = scanS (+) 0 ceros
             in
                tabulateS (\i -> if nthS s i == 0 then nthS s_red i else max 0 (nthS s_red i-1)) (lengthS s)

posiciones :: Seq s => s Int -> s Int
posiciones s =  let
                    posicionesCero = posCeros s
                    posicionesUno = posUnos s
                in
                    tabulateS (\i-> if nthS s i == 0 then nthS posicionesCero i else nthS posicionesUno i) (lengthS s) `asTypeOf` s

type Doc s = (Int, s String)
type Index s = s (String, s (Int, Int))

makeIndex :: Seq s => s (Doc s) -> Index s
makeIndex s = let
                s_pares = mapS (\(docId, palabras) -> 
                                  tabulateS (\i -> (nthS palabras i, (docId, i))) (lengthS palabras)
                               ) s
                s_flatten = reduceS appendS emptyS s_pares
              in
                collectS s_flatten

moreUsed :: Seq s => Index s -> String
moreUsed s = let
                s_info = mapS (\(string, datos) -> (string, lengthS datos)) s
                compare t1@(str1, cant1) t2@(str2, cant2) = if cant1 >= cant2 then t1 else t2
                (strFinal, _) = reduceS compare ("",0) s_info
             in
                strFinal

incluidos :: Seq s => s (Int, Int) -> Int
incluidos s = let
                s_in = mapS (\(x,y) -> x + y) s
                (maxs, _) = scanS max minBound s_in
                cont = tabulateS (\i -> 
                    if i == 0 
                    then 0 
                    else if nthS s_in i <= nthS maxs i 
                         then 1 
                         else 0
                    ) (lengthS s) `asTypeOf` s_in
              in
                reduceS (+) 0 cont

{-
Ejercicios finales diciembre x
-}
entradas :: Seq s => s Int -> Int -> (Float, Int)
entradas s x = let
                (s_sum, _) = scanS (+) 0 s
                s_info = tabulateS (\i -> if i == 0 then (fromIntegral (nthS s i * x), 0)
                                          else if fromIntegral (nthS s_sum i) / fromIntegral i >= fromIntegral (nthS s (i-1)) 
                                            then (fromIntegral (nthS s i) * 0.5 * fromIntegral x, nthS s i)
                                            else (fromIntegral (nthS s i) * fromIntegral x, 0)) (lengthS s) `asTypeOf` mapS undefined s
               in
                reduceS (\(s1,d1) (s2, d2) -> (s1+s2, d1+d2)) (0,0) s_info

split :: (String -> Bool) -> Tree2 String -> (Tree2 (Int, String), Tree2 (Int, String))
split f t = splitAux f t 0
    where
        splitAux :: (String -> Bool) -> Tree2 String -> Int -> (Tree2 (Int, String), Tree2 (Int, String))
        splitAux _ E _ = (E, E)
        splitAux f (L x) i | f x = (E, L (i, x))
                           | otherwise = (L (i, x), E)
        splitAux f (N _ l r) i = let
                                    sL = size3 l
                                    ((lN, lS), (rN, rS)) = splitAux f l i ||| splitAux f r (i+sL)
                                 in
                                    (append3 lN rN, append3 lS rS)

fromListTree2 :: [String] -> Tree2 String
fromListTree2 [] = E
fromListTree2 [x] = L x
fromListTree2 xs = let
                     len = length xs
                     m = len `div` 2
                     (l, r) = splitAt m xs
                   in
                    N len (fromListTree2 l) (fromListTree2 r)

{-
Ejercicio final 4 - 2019
-}
data Cadena = E7 | L7 Char | N7 Cadena Cadena deriving Show

palindromo :: Cadena -> Bool
palindromo t = let 
                (strOriginal, strReverse) = aplanar t ||| aplanar (reverseCadena t)
               in
                strOriginal == strReverse
    where
        reverseCadena :: Cadena -> Cadena
        reverseCadena E7 = E7
        reverseCadena (L7 x) = L7 x
        reverseCadena (N7 l r) =  let
                                (l', r') = reverseCadena l ||| reverseCadena r
                            in
                                N7 r' l'

        aplanar :: Cadena -> String
        aplanar E7 = ""
        aplanar (L7 x) = [x]
        aplanar (N7 l r) = let
                            (l', r') = aplanar l ||| aplanar r
                           in
                            l' ++ r'

crear :: Int -> (Int -> Char) -> Cadena
crear i f = crear' 0 (i+1)
    where
        crear' inicio fin | inicio == fin = if inicio == 0 || inicio == i+1 then L7 '*' else L7 (f inicio)
                          | otherwise = let
                                            medio = (inicio+fin) `div` 2
                                            (l, r) = crear' inicio medio ||| crear' (medio+1) fin
                                          in
                                            N7 l r

{-
Parcial 2 - 2023
-}
data Tree3 a = E8 | N8 Int (Tree3 a) a (Tree3 a)

filterPrefix :: (a -> Bool) -> Tree3 a -> Tree3 a
filterPrefix _ E8 = E8
filterPrefix f (N8 _ l x r) = let
                                (l', r') = filterPrefix f l ||| filterPrefix f r
                             in
                                if size4 l' == size4 l && f x then N8 (size4 l' + 1 + size4 r') l' x r' else l'
    where
        size4 :: Tree3 a -> Int
        size4 E8 = 0
        size4 (N8 s _ _ _) = s

longestStreak :: Seq s => Int -> s Int -> Int
longestStreak x s = let
                        s_info = mapS (\i-> if i > x then 1 else 0) s
                        s_inter = tabulateS (\i -> (nthS s_info i, i, nthS s_info i, i)) (lengthS s_info) `asTypeOf` mapS undefined s_info
                        compare (0, -2, 0, -2) t = t
                        compare t (0, -2, 0, -2) = t
                        compare (l1, i1, r1, j1) (l2, i2, r2, j2) = if r1 == l2 && j1 == i2-1 then (l1, i1, r2, j2) else (l2, i2, r2, j2)
                        (s_cont, r) = scanS compare (0, -2, 0, -2) s_inter
                        s_app = appendS (dropS s_cont 1) (singletonS r)
                        s_val = mapS (\(l, i, r, j) -> j-i+1) s_app
                    in
                        reduceS max 0 s_val

{-
Final 2 - 2019
-}

mapIndex :: (a -> Int -> b) -> Tree2 a -> Tree2 b
mapIndex f t = mi f t 0
    where
        mi :: (a -> Int -> b) -> Tree2 a -> Int -> Tree2 b
        mi _ E _ = E
        mi f (L x) i = L (f x i)
        mi f (N _ l r) i = let
                            sL = size3 l
                            (l', r') = mi f l i ||| mi f r (i+sL)
                         in
                            N (size3 l' + size3 r') l' r'

fromSlow :: Int -> Int -> Int -> Tree2 Int
fromSlow n m k = let
                    arbol = crearArbol m
                 in
                    mapIndex (\_ i -> n + (i `div` k)) arbol
    where
        crearArbol :: Int -> Tree2 ()
        crearArbol 0 = E
        crearArbol 1 = L ()
        crearArbol m =  let
                            mitad = m `div` 2
                            (l, r) = crearArbol mitad ||| crearArbol (m-mitad)
                        in
                            N m l r

alarma :: Seq s => s (Int, String) -> Int -> Maybe String
alarma s x | lengthS s == 0 = Nothing
           | otherwise =  let
                                s_idx = tabulateS id (lengthS s) `asTypeOf` mapS undefined s
                                s_pesos = mapS fst s
                                (s_sum, r) = scanS (+) 0 s_pesos
                                s_app = appendS (dropS s_sum 1) (singletonS r)
                                s_filter = filterS (\i-> nthS s_app i >= x) s_idx
                            in
                                if lengthS s_filter == 0 then Nothing else Just (snd (nthS s (nthS s_filter 0)))

{-
Final 2 - 2018
-}
data BST a = E9 | N9 (BST a) a (BST a) deriving Show

delete :: Ord a => BST a -> a -> BST a
delete E9 _ = E9
delete (N9 l x r) y | x == y = case (l,r) of
                                (E9, E9) -> E9
                                (_, E9) -> l
                                (E9, _) -> r
                                (_, _) -> let y = minimum2 r in N9 l x (delete r y)
                    | y < x = N9 (delete l y) x r
                    | otherwise = N9 l x (delete r y)
    where
        minimum2 :: BST a -> a
        minimum2 (N9 E9 x _) = x
        minimum2 (N9 l _ _) = minimum2 l

{-
Parcial 2 - 2014
-}
concat2 :: Tree2 (Tree2 a) -> Tree2 a
concat2 E = E
concat2 (L x) = x
concat2 (N _ l r) =  let
                        (l', r') = concat2 l ||| concat2 r
                    in
                        N (size3 l' + size3 r') l' r'

subsequence :: Tree2 a -> Int -> Int -> Tree2 a
subsequence E _ _ = E
subsequence (L x) i j | i == 0 && j >= 0 = L x
                      | otherwise = E
subsequence t@(N s l r) i j | i == 0 && j >= (s-1) = t
                            | j < sL = subsequence l i j
                            | i >= sL = subsequence r (i-sL) (j-sL)
                            | otherwise = let
                                            (l', r') = subsequence l i (sL-1) ||| subsequence r 0 (j-sL)
                                          in
                                            N (size3 l' + size3 r') l' r'
    where sL = size3 l

aa :: Seq s => s Char -> Int
aa s =  let
            s_info = tabulateS (\i -> if nthS s i == 'a' && nthS s (i+1) == 'a' then 1 else 0) (lengthS s-1) `asTypeOf` mapS undefined s
        in
            reduceS (+) 0 s_info

{-
Parcial 1 
-}
data Treap p k = E10 | N10 (Treap p k) p k (Treap p k)

key :: Treap p k -> k
key (N10 _ _ k _) = k

priority :: Treap p k -> p
priority (N10 _ p _ _) = p

isTreap :: (Ord k, Ord p) => Treap p k -> Bool
isTreap t = isBSTTreap t Nothing Nothing && isMaxHeap t
    where
        isBSTTreap :: Ord k => Treap p k -> Maybe k -> Maybe k -> Bool
        isBSTTreap E10 _ _ = True
        isBSTTreap (N10 l _ k r) minB maxB = isValid k minB maxB && isBSTTreap l minB (Just k) && isBSTTreap r (Just k) maxB

        isValid val minB maxB = checkMin val minB && checkMax val maxB

        checkMin val Nothing = True
        checkMin val (Just x) = val >= x

        checkMax val Nothing = True
        checkMax val (Just x) = val <= x

        isMaxHeap :: Ord p => Treap p k -> Bool
        isMaxHeap E10 = True
        isMaxHeap (N10 l p _ r) = checkHijo l p && checkHijo r p && isMaxHeap l && isMaxHeap r

        checkHijo :: Ord p => Treap p k -> p -> Bool
        checkHijo E10 _ = True
        checkHijo (N10 _ p _ _) pPadre = pPadre >= p

insertTreap :: (Ord k, Ord p) => k -> p -> Treap p k -> Treap p k
insertTreap k p E10 = N10 E10 p k E10
insertTreap k p (N10 l p' k' r) | k <= k' = if p > p' then rotateR (N10 (insertTreap k p l) p' k' r)
                                                      else N10 (insertTreap k p l) p' k' r
                                | otherwise = if p > p' then rotateL (N10 l p' k' (insertTreap k p r))
                                                        else N10 l p' k' (insertTreap k p r)
    where
        rotateL (N10 l' p' k' (N10 l p k r)) = N10 (N10 l' p' k' l) p k r
        rotateR (N10 (N10 l p k r) p' k' r') = N10 l p k (N10 r p' k' r')

splitTreap :: (Ord k, Ord p, Num p) => k -> Treap p k -> (Treap p k, Treap p k)
splitTreap _ E10 = (E10, E10)
splitTreap k t = let
                    pMax = priority t
                    (N10 l _ _ r) = insertTreap k (pMax+1) t
                 in
                    (l,r)

{-
Parcial 1 - 2024
-}
data Color = R | B deriving (Eq, Show)
data AATree a =  N11 Color (AATree a) a (AATree a) | E11 deriving (Eq, Show)

isBSTAA :: Ord a => AATree a -> Bool
isBSTAA t = isBST' t Nothing Nothing
    where
        isBST' :: Ord a => AATree a -> Maybe a -> Maybe a -> Bool
        isBST' E11 _ _ = True
        isBST' (N11 _ l x r) minB maxB = isValid x minB maxB && isBST' l minB (Just x) && isBST' r (Just x) maxB

        isValid x minB maxB = checkMin x minB && checkMax x maxB

        checkMin x Nothing = True
        checkMin x (Just minB) = x >= minB

        checkMax x Nothing = True
        checkMax x (Just maxB) = x <= maxB

isAATree :: Ord a => AATree a -> Bool
isAATree t = isBSTAA t && inv2 t && inv3 t
    where
        inv2 :: AATree a -> Bool
        inv2 t = snd (inv2' t)

        inv2' :: AATree a -> (Int, Bool)
        inv2' E11 = (0, True)
        inv2' (N11 c l x r) = let
                                (hBL, bL) = inv2' l
                                (hBR, bR) = inv2' r
                            in
                                if bL && bR && hBL == hBR then (cond c hBL, True) else (0, False)

        cond R h = h
        cond B h = h+1

        inv3 :: AATree a -> Bool
        inv3 E11 = True
        inv3 (N11 _ (N11 R _ _ _) _ _) = False
        inv3 (N11 R _ _ (N11 R _ _ _)) = False
        inv3 (N11 _ l _ r) = inv3 l && inv3 r

memberAA :: Ord a => a -> AATree a -> Bool
memberAA _ E11 = False
memberAA x (N11 _ l y r) | x == y = True
                         | x < y = memberAA x l
                         | otherwise = memberAA x r

insertAA :: Ord a => a -> AATree a -> AATree a
insertAA x t = makeB (ins x t)
    where
        makeB :: AATree a -> AATree a
        makeB (N11 _ l x r) = N11 B l x r

        ins :: Ord a => a -> AATree a -> AATree a
        ins x E11 = N11 R E11 x E11
        ins x (N11 c l y r) | x <= y = split(skew(N11 c (ins x l) y r))
                            | otherwise = split(skew(N11 c l y (ins x r)))

        skew :: AATree a -> AATree a
        skew (N11 color (N11 R a x b) y c) = N11 color a x (N11 R b y c)
        skew t = t
        
        split :: AATree a -> AATree a
        split (N11 color a x (N11 R b y (N11 R c z d))) = N11 R (N11 B a x b) y (N11 B c z d)
        split t = t

{-
Parcial 2 - 2026
-}
data Tree4 a = E12 | L12 a | N12 (Tree4 a) (Tree4 a) deriving (Eq, Show)

intercalate :: Tree4 a -> Tree4 (Tree4 a) -> Tree4 a
intercalate s E12 = E12
intercalate E12 t = flattenTree t
intercalate s (L12 t) = t
intercalate s (N12 l r) = let
                            (l', r') = intercalate s l ||| intercalate s r
                          in
                            append4 l' s r'

flattenTree :: Tree4 (Tree4 a) -> Tree4 a
flattenTree E12 = E12
flattenTree (L12 t) = t
flattenTree (N12 l r) = let
                            (l', r') = flattenTree l ||| flattenTree r
                        in
                            N12 l' r'

append4 :: Tree4 a -> Tree4 a -> Tree4 a -> Tree4 a
append4 E12 _ r = r
append4 l _ E12 = l
append4 l s r = N12 l (N12 s r)

-- mejorGanancia :: Seq s => s Int -> Int
-- mejorGanancia s = let
--                     n = lengthS s
--                     op = max
--                     b = 0
--                     reverse s = tabulateS (\i -> nthS s (n-i-1)) (lengthS s) 
--                     mejorVenta = reverse (fst (scanS op b (reverse s)))
--                     diff = tabulateS (\i -> nthS mejorVenta i - nthS s i) (n-1)
--                   in
--                     if n < 2 then 0 else reduceS max 0 diff

{-
Final 1 - 2025
-}
type Vector a = [a]
type Matriz a = [Vector a]

dimension :: Matriz a -> (Int, Int)
dimension [] = (0, 0)
dimension m@(x:_) = (length m, length x)

elemMatriz :: Int -> Int -> Matriz a -> a
elemMatriz i j xs = (xs !! i) !! j

fila :: Int -> Matriz a -> Vector a
fila _ [] = []
fila i m = m !! i

columna :: Int -> Matriz a -> Vector a
columna _ [] = []
columna j (x:xs) = x !! j : columna j xs

transpose :: Matriz a -> Matriz a
transpose [] = []
transpose m = let
                (_, j) = dimension m
              in
                [columna k m | k <- [0..j-1]]

pagarDeuda :: Seq s => s (Int, Char) -> Int -> Maybe Char
pagarDeuda s x | lengthS s == 0 = Nothing
               | otherwise = let
                                s_idx = tabulateS id (lengthS s) `asTypeOf` mapS fst s
                                s_pesos = mapS fst s
                                (s_sum, r_sum) = scanS (+) 0 s_pesos
                                s_append = appendS (dropS s_sum 1) (singletonS r_sum)
                                s_filter = filterS (\i -> nthS s_append i > x) s_idx
                             in
                                if lengthS s_filter == 0 then Nothing else Just (snd (nthS s (nthS s_filter 0-1)))


concatMapTree :: (a -> Tree4 b) -> Tree4 a -> Tree4 b
concatMapTree f E12 = E12
concatMapTree f (L12 x) = f x
concatMapTree f (N12 l r) = let
                            (l', r') = concatMapTree f l ||| concatMapTree f r
                        in
                            N12 l' r'