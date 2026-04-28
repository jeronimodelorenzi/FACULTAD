data Treap p k = E | N (Treap p k) p k (Treap p k) deriving Show

t1 :: Treap Int Char
t1 = N 
        (N
            (N E 2 'a' E)
        4 'c'    
            (N E 0 'e' E)
        )
     9 'h'
        (N E 7 'j' E)

key :: Treap p k -> k
key (N _ _ k _) = k

priority :: Treap p k -> p
priority (N _ p _ _) = p

isTreap :: (Ord k, Ord p) => Treap p k -> Bool
isTreap t = isBST t && isMaxHeap t
    where
        maximum :: Treap p k -> k
        maximum (N _ _ k E) = k
        maximum (N _ _ _ r) = maximum r

        minimum :: Treap p k -> k
        minimum (N E _  k _) = k
        minimum (N l _ _ _) = minimum l

        isBST :: Ord k => Treap p k -> Bool
        isBST E = True
        isBST (N E _ k E) = True
        isBST (N l _ k E) = k >= maximum l && isBST l
        isBST (N E _ k r) = k < minimum r && isBST r
        isBST (N l _ k r) = k >= maximum l && k < minimum r && isBST l && isBST r

        checkHijo :: Ord p => Treap p k -> p -> Bool
        checkHijo E _ = True
        checkHijo (N _ pHijo _ _) pPadre = pHijo <= pPadre 

        isMaxHeap :: Ord p => Treap p k -> Bool
        isMaxHeap E = True
        isMaxHeap (N l p _ r) = checkHijo l p && checkHijo r p && isMaxHeap l && isMaxHeap r

insert :: (Ord k, Ord p) => k -> p -> Treap p k -> Treap p k
insert k' p' E = N E p' k' E
insert k' p' (N l p k r)    | k' <= k  = if p' > p then rotateR (N (insert k' p' l) p k r) 
                                                   else N (insert k' p' l) p k r 
                            | otherwise = if p' > p then rotateL (N l p k (insert k' p' r))
                                                    else N l p k (insert k' p' r)
    where
        rotateL (N l' p' k' (N l p k r)) = N (N l' p' k' l) p k r
        rotateR (N (N l p k r) p' k' r') = N l p k (N r p' k' r')

split :: (Ord k, Ord p, Num p) => k -> Treap p k -> (Treap p k, Treap p k)
split _ E = (E,E)
split k' t = let
                pMax = priority t
                (N l _ _ r) = insert k' (pMax + 1) t
             in
                (l,r)

                        