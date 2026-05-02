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




