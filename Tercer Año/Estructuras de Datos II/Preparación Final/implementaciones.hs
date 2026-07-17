{-
BST
-}
data BST a = EmptyBST | NodoBST (BST a) a (BST a) deriving Show

bst :: BST Int
bst = NodoBST 
            (NodoBST 
                (NodoBST EmptyBST 2 EmptyBST) 
                3 
                (NodoBST EmptyBST 4 EmptyBST)
            ) 
            5 
            (NodoBST 
                (NodoBST EmptyBST 6 EmptyBST) 
                7 
                (NodoBST EmptyBST 8 EmptyBST)
            )

memberBST :: Ord a => a -> BST a -> Bool
memberBST _ EmptyBST = False
memberBST x (NodoBST l y r) | x == y = True
                            | x < y = memberBST x l
                            | otherwise = memberBST x r

inorderBST :: BST a -> [a]
inorderBST t = inorderAux t []
    where
        inorderAux :: BST a -> [a] -> [a]
        inorderAux EmptyBST xs = xs
        inorderAux (NodoBST l x r) xs = inorderAux l (x: inorderAux r xs)

isBST :: Ord a => BST a -> Bool
isBST t = isBSTAux t Nothing Nothing
    where
        isBSTAux :: Ord a => BST a -> Maybe a -> Maybe a -> Bool
        isBSTAux EmptyBST _ _ = True
        isBSTAux (NodoBST l x r) minB maxB = isValid x minB maxB && isBSTAux l minB (Just x) && isBSTAux r (Just x) maxB

        isValid x minB maxB = checkMin x minB && checkMax x maxB

        checkMin x Nothing = True
        checkMin x (Just minB) = x >= minB
        
        checkMax x Nothing = True
        checkMax x (Just maxB) = x <= maxB

insertBST :: Ord a => a -> BST a -> BST a
insertBST x EmptyBST = NodoBST EmptyBST x EmptyBST
insertBST x (NodoBST l y r) | x <= y = NodoBST (insertBST x l) y r
                            | otherwise = NodoBST l y (insertBST x r)

deleteBST :: Ord a => a -> BST a -> BST a
deleteBST _ EmptyBST = EmptyBST
deleteBST x (NodoBST l y r) | x < y = NodoBST (deleteBST x l) y r
                            | x > y = NodoBST l y (deleteBST x r)
                            | otherwise = case (l,r) of
                                (EmptyBST, EmptyBST) -> EmptyBST
                                (_, EmptyBST) -> l
                                (EmptyBST, _) -> r
                                (_, _) -> let m = minBST r in NodoBST l m (deleteBST m r)
    where
        minBST :: BST a -> a
        minBST (NodoBST EmptyBST x _) = x
        minBST (NodoBST l _ _) = minBST l

splitBST :: Ord a => a -> BST a -> (BST a, BST a)
splitBST _ EmptyBST = (EmptyBST, EmptyBST)
splitBST x (NodoBST l y r) | x <= y = let 
                                        (ll,lr) = splitBST x l
                                      in
                                        (ll, NodoBST lr y r)
                           | otherwise = let
                                            (rl, rr) = splitBST x r
                                         in
                                            (NodoBST l y rl, rr)

joinBST :: Ord a => BST a -> BST a -> BST a
joinBST EmptyBST t2 = t2
joinBST t1 EmptyBST = t1
joinBST t1@(NodoBST l1 x r1) t2 = let
                                    (l', r') = splitBST x t2
                                  in
                                    NodoBST (joinBST l1 l') x (joinBST r1 r')
                                                     

{-
RBT
-}
data Color = R | B
data RBT a = EmptyRBT | NodoRBT Color (RBT a) a (RBT a)

memberRBT :: Ord a => a -> RBT a -> Bool
memberRBT _ EmptyRBT = False
memberRBT x (NodoRBT _ l y r) | x == y = True
                            | x < y = memberRBT x l
                            | otherwise = memberRBT x r

insertRBT :: Ord a => a -> RBT a -> RBT a
insertRBT x t = makeBlack (ins x t)
    where
        ins :: Ord a => a -> RBT a -> RBT a
        ins x EmptyRBT = NodoRBT R EmptyRBT x EmptyRBT
        ins x (NodoRBT c l y r) | x < y = balance c (ins x l) y r
                                | x > y = balance c l y (ins x r)
                                | otherwise = NodoRBT c l y r
        
        makeBlack :: RBT a -> RBT a
        makeBlack EmptyRBT = EmptyRBT
        makeBlack (NodoRBT _ l x r) = NodoRBT B l x r

        balance :: Color -> RBT a -> a -> RBT a -> RBT a
        balance B (NodoRBT R (NodoRBT R a x b) y c) z d = NodoRBT R (NodoRBT B a x b) y (NodoRBT B c z d)
        balance B (NodoRBT R a x (NodoRBT R b y c)) z d = NodoRBT R (NodoRBT B a x b) y (NodoRBT B c z d)
        balance B a x (NodoRBT R b y (NodoRBT R c z d)) = NodoRBT R (NodoRBT B a x b) y (NodoRBT B c z d)
        balance B a x (NodoRBT R (NodoRBT R b y c) z d) = NodoRBT R (NodoRBT B a x b) y (NodoRBT B c z d)
        balance c l x r = NodoRBT c l x r

{-
Leftist heaps
-}
type Rank = Int
data LHeap a = EmptyLHeap | NodoLHeap Rank a (LHeap a) (LHeap a)

rank :: LHeap a -> Rank
rank EmptyLHeap = 0
rank (NodoLHeap r _ _ _) = r

mergeLHeap :: Ord a => LHeap a -> LHeap a -> LHeap a
mergeLHeap EmptyLHeap h2 = h2
mergeLHeap h1 EmptyLHeap = h1
mergeLHeap h1@(NodoLHeap _ x l1 r1) h2@(NodoLHeap _ y l2 r2) = if x <= y 
                                                                then makeH x l1 (mergeLHeap r1 h2) 
                                                                else makeH y l2 (mergeLHeap h1 r2)
    where
        makeH x h1 h2 = if rank h1 >= rank h2 then NodoLHeap (rank h2+1) x h1 h2 else NodoLHeap (rank h1+1) x h2 h1

insertLHeap :: Ord a => a -> LHeap a -> LHeap a
insertLHeap x h = mergeLHeap (NodoLHeap 1 x EmptyLHeap EmptyLHeap) h

findMinLHeap :: Ord a => LHeap a -> a
findMinLHeap (NodoLHeap _ x _ _) = x

deleteMinLHeap :: Ord a => LHeap a -> LHeap a
deleteMinLHeap (NodoLHeap _ _ l r) = mergeLHeap l r