

data Color = R | B deriving (Eq, Show)
data AATree a = N Color a (AATree a) (AATree a) | E deriving (Eq, Show)

t1 :: AATree Int
t1 = N B 4 
        (N B 2 
            (N B 1 E E) 
            (N B 3 E E)
        ) 
        (N R 11 
            (N B 8 
                (N B 5 E E) 
                (N B 9 E E)
            )
            (N B 15 
                (N B 13 
                    E 
                    (N R 14 E E)
                )
                (N R 20
                    (N B 19 E E)
                    (N B 21 E E)
                )
            )
        )

myMinimum :: AATree a -> a
myMinimum (N _ a E _) = a
myMinimum (N _ _ l _) = myMinimum l

myMaximum :: AATree a -> a
myMaximum (N _ a _ E) = a
myMaximum (N _ _ _ r) = myMaximum r

isBST :: Ord a => AATree a -> Bool
isBST E = True
isBST (N _ a E E) = True
isBST (N _ a l E) = a >= myMaximum l && isBST l
isBST (N _ a E r) = a < myMinimum r && isBST r
isBST (N _ a l r) = a >= myMaximum l && a < myMinimum r && isBST l && isBST r

isAATree :: Ord a => AATree a -> Bool
isAATree (N R _ _ _) = False
isAATree t = isBST t && inv2 t && inv1_3 t
    where
        inv2 :: AATree a -> Bool
        inv2 t = snd (inv2Aux t)
        
        inv2Aux :: AATree a -> (Int, Bool)
        inv2Aux E = (0, True)
        inv2Aux (N c _ l r) = let
                                (h1, b1) = inv2Aux l
                                (h2, b2) = inv2Aux r
                              in
                                if b1 && b2 && h1==h2 then (cond c h1, True)
                                                      else (0, False)
        cond R h = h 
        cond B h = h + 1

        inv1_3 :: AATree a -> Bool
        inv1_3 E = True
        inv1_3 (N _ _ (N R _ _ _) _) = False
        inv1_3 (N R _ _ (N R _ _ _)) = False
        inv1_3 (N _ _ l r) = inv1_3 l && inv1_3 r
    
member :: Ord a => a -> AATree a -> Bool
member a E = False
member a (N _ b l r)    | a == b    = True
                        | a <= b    = member a l
                        | otherwise = member a r 

insert :: Ord a => a -> AATree a -> AATree a
insert a t = makeB (ins a t)
    where
        makeB :: AATree a -> AATree a
        makeB (N _ a l r) = N B a l r

        ins :: Ord a => a -> AATree a -> AATree a
        ins a E = N R a E E
        ins a (N c b l r)   | a < b     = split(skew (N c b (ins a l) r)) 
                            | a > b     = split(skew (N c b l (ins a r)))
                            | otherwise = N c b l r

        skew :: AATree a -> AATree a
        skew (N color y (N R x a b) c) = N color x a (N R y b c)
        skew t = t

        split :: AATree a -> AATree a
        split (N B x a (N R y b (N R z c d))) = N R y (N B x a b) (N B z c d)
        split t = t