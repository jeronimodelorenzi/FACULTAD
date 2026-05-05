{-
LHEAPS
-}

data LHeap a = E1 | N1 Int a (LHeap a) (LHeap a)

rank :: LHeap a -> Int
rank (N1 r _ _ _) = r

makeNode1 :: a -> LHeap a -> LHeap a -> LHeap a
makeNode1 x E1 r = N1 1 x r E1
makeNode1 x l r  | rank l < rank r   = N1 (rank l + 1) x r l
                | otherwise         = N1 (rank r + 1) x l r

merge :: Ord a => LHeap a -> LHeap a -> LHeap a
merge h1 E1 = h1
merge E1 h2 = h2
merge h1@(N1 _ x l1 r1) h2@(N1 _ y l2 r2)     | x <= y    = makeNode1 x (merge l1 h2) r1
                                            | otherwise = makeNode1 y (merge l2 h1) r2

isLeftist :: Ord a => LHeap a -> Bool
isLeftist t = isHeap t && isLeftistAux t
    where
        compHijo :: Ord a => a -> LHeap a -> Bool
        compHijo x (N1 _ y _ _) = x <= y

        isHeap :: Ord a => LHeap a -> Bool
        isHeap E1 = True
        isHeap (N1 _ x E1 r) = compHijo x r && isHeap r
        isHeap (N1 _ x l E1) = compHijo x l && isHeap l
        isHeap (N1 _ x l r) = compHijo x l && compHijo x r && isHeap l && isHeap r

        isLeftistAux :: Ord a => LHeap a -> Bool
        isLeftistAux E1 = True
        isLeftistAux (N1 _ _ l r) = rank l >= rank r && isLeftistAux l && isLeftistAux r


{-
STree
-}

data STree a = E2 | N2 Int (STree a) a (STree a)

size :: STree a -> Int
size E2 = 0
size (N2 s _ _ _) = s

makeNode2 :: STree a -> a -> STree a -> STree a
makeNode2 l x r = N2 (size l + size r + 1) l x r

isSTree :: Ord a => STree a -> Bool
isSTree t = isBST t && sizeCheck t
    where
        minimum :: STree a -> a
        minimum (N2 _ E2 x _) = x
        minimum (N2 _ l _ _) = minimum l

        maximum :: STree a -> a
        maximum (N2 _ _ x E2) = x
        maximum (N2 _ _ _ r) = maximum r

        isBST :: Ord a => STree a -> Bool
        isBST E2 = True
        isBST (N2 _ E2 x E2) = True
        isBST (N2 _ l x E2) = x >= maximum l && isBST l
        isBST (N2 _ E2 x r) = x < minimum r && isBST r
        isBST (N2 _ l x r) = x >= maximum l && x < minimum r && isBST l && isBST r

        sizeCheck :: Ord a => STree a -> Bool
        sizeCheck (N2 s l _ r) = s == (size l + size r + 1) && sizeCheck l && sizeCheck r

nth :: STree a -> Int -> a
nth t i = nthAux t i 1
    where 
        nthAux :: STree a -> Int -> Int -> a
        nthAux (N2 _ l x r) i j     | i == j        = x
                                    | i <= size l   = nthAux l i (j+1)
                                    | otherwise     = nthAux r i (j+1)


{-
AVL
-}

data AVL a = E3 | N3 Int (AVL a) a (AVL a)

height :: AVL a -> Int
height E3 = 0
height (N3 h _ _ _) = h

node :: AVL a -> a -> AVL a -> AVL a
node l a r = N3 (1 + max (height l) (height r)) l a r

isAVL :: Ord a => AVL a -> Bool
isAVL t = isBST t && isAVLAux t
    where
        minimum :: AVL a -> a
        minimum (N3 _ E3 x _) = x
        minimum (N3 _ l _ _) = minimum l

        maximum :: AVL a -> a
        maximum (N3 _ _ x E3) = x
        maximum (N3 _ _ _ r) = maximum r

        isBST :: Ord a => AVL a -> Bool
        isBST E3 = True
        isBST (N3 _ E3 x E3) = True
        isBST (N3 _ l x E3) = x >= maximum l && isBST l
        isBST (N3 _ E3 x r) = x < minimum r && isBST r
        isBST (N3 _ l x r) = x >= maximum l && x < minimum r && isBST l && isBST r

        isAVLAux :: Ord a => AVL a -> Bool
        isAVLAux E3 = True
        isAVLAux (N3 h l _ r) = h == maxAltura+1 && abs restaAlturas <= 1 && isAVLAux l && isAVLAux r
            where 
                restaAlturas = height l - height r
                maxAltura = max (height l) (height r)

rotateL :: AVL a -> AVL a
rotateL (N3 _ a x (N3 _ b y c)) = node (node a x b) y c
rotateL t = t

{-
ITree
-}

type Intervalo = (Int, Int)
data ITree = E4 | N4 Int ITree Intervalo ITree

maxFin :: ITree -> Int
maxFin E4 = -1
maxFin (N4 m _ _ _) = m

crearNodo :: ITree -> Intervalo -> ITree -> ITree
crearNodo l (x, y) r = N4 (max (maxFin l) (max y (maxFin r))) l (x, y) r

seCruzan :: Intervalo -> Intervalo -> Bool
seCruzan (x1, y1) (x2, y2) =    x2 >= x1 && x2 <= y1 ||
                                y2 >= x1 && y2 <= y1 ||
                                x1 >= x2 && x1 <= y2 ||
                                y1 >= x2 && y1 <= y2

buscarInterseccion :: ITree -> Intervalo -> Maybe Intervalo
buscarInterseccion E4 _ = Nothing
buscarInterseccion t@(N4 m l intervalo r) (x,y)     | seCruzan intervalo (x,y)  = Just intervalo
                                                    | maxFin l >= x  = buscarInterseccion l (x,y)
                                                    | otherwise      = buscarInterseccion r (x,y)

{-
QuadTree
-}

data Color = Blanco | Negro deriving Eq
data QuadTree = Hoja Color | N5 QuadTree QuadTree QuadTree QuadTree 

invertir :: QuadTree -> QuadTree
invertir (Hoja Blanco) = Hoja Negro
invertir (Hoja Negro) = Hoja Blanco
invertir (N5 a b c d) = N5 (invertir a) (invertir b) (invertir c) (invertir d)

espejoHorizontal :: QuadTree -> QuadTree
espejoHorizontal (Hoja x) = Hoja x
espejoHorizontal (N5 a b c d) = N5 (espejoHorizontal b) (espejoHorizontal a) (espejoHorizontal d) (espejoHorizontal c)

mezclar :: QuadTree -> QuadTree -> QuadTree
mezclar (Hoja Negro) _ = Hoja Negro
mezclar _ (Hoja Negro) = Hoja Negro
mezclar (Hoja Blanco) t = t
mezclar t (Hoja Blanco) = t
mezclar (N5 a1 b1 c1 d1) (N5 a2 b2 c2 d2) = N5 (mezclar a1 a2) (mezclar b1 b2) (mezclar c1 c2) (mezclar d1 d2)

esLiso :: QuadTree -> Bool
esLiso (Hoja _) = True
esLiso (N5 (Hoja a) (Hoja b) (Hoja c) (Hoja d)) = not (a == b && b == c && c == d)
esLiso (N5 a b c d) = esLiso a && esLiso b && esLiso c && esLiso d

        