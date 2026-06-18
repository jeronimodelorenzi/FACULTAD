import Seq
import Par
import ListSeq

-- 2)
data Tree a = E | L a | N Int (Tree a) (Tree a) deriving Show

concatT :: Tree (Tree a) -> Tree a
concatT E            = E
concatT (L t)        = t
concatT (N _ l r) = let
                        (l', r') = concatT l ||| concatT r
                      in
                        append l' r'
    where
        size :: Tree a -> Int
        size E              = 0
        size (L _)          = 1
        size (N s _ _)   = s

        append :: Tree a -> Tree a -> Tree a
        append t1 E     = t1
        append E t2     = t2
        append t1 t2    = N (size t1 + size t2) t1 t2
seqT :: Tree (Tree Int)
seqT = 
  N 3 
    (N 2 
      (L (N 3 (N 2 (L 5) (L 2)) (L 3))) 
      (L (L 6))                         
    ) 
    (L (N 2 (L 8) (L 0)))

subsequence :: Tree a -> Int -> Int -> Tree a
subsequence E _ _       = E
subsequence (L a) i j               | i == 0 && j >= 0  = L a
                                    | otherwise         = E
subsequence t@(N s l r) i j         | i == 0 && j >= s-1  = t
                                    | j < sL            = subsequence l i j
                                    | i >= sL           = subsequence r (i-sL) (j-sL)
                                    | otherwise         = let
                                                            (l', r') = subsequence l i (sL-1) ||| subsequence r 0 (j-sL)
                                                          in
                                                            append l' r'
                                                                where
                                                                    append :: Tree a -> Tree a -> Tree a
                                                                    append t1 E     = t1
                                                                    append E t2     = t2
                                                                    append t1 t2    = N (size t1 + size t2) t1 t2

                                                                    size :: Tree a -> Int
                                                                    size E         = 0
                                                                    size (L _)     = 1
                                                                    size (N s _ _) = s

                                                                    sL = size l

seqT2 :: Tree Int
seqT2 = 
  N 6 
    (N 3 
      (N 2 (L 1) (L 2)) 
      (L 3)
    ) 
    (N 3 
      (N 2 (L 4) (L 5)) 
      (L 6)
    )

-- 3)
unifique :: Seq s => s Int -> s Int
unifique s = let
                s_info  = tabulateS (\i -> (nthS s i, i)) (lengthS s)
                s_sort1 = sortS (\(x1, i1) (x2, i2) -> if x1 == x2 then compare i1 i2 else compare x1 x2) s_info
                s_group = groupS (\(x1, _) (x2, _) -> compare x1 x2) s_sort1
                s_sort2 = sortS (\(_, i1) (_, i2) -> compare i1 i2) s_group
             in
                mapS fst s_sort2
                    where
                        groupS :: Seq s => (a -> a -> Ordering) -> s a -> s a
                        groupS cmp s = let
                                        s_idx = tabulateS id (lengthS s)
                                        s_filter = filterS (\i -> i == 0 || cmp (nthS s i) (nthS s (i-1)) /= EQ) s_idx
                                       in
                                        mapS (\i -> nthS s i) s_filter

aa :: Seq s => s Char -> Int
aa s    | lengthS s < 2  = 0
        | otherwise = let
                        s_info = tabulateS (\i -> if nthS s i == 'a' && nthS s (i+1) == 'a' then 1 else 0) (lengthS s-1) `asTypeOf` mapS (\_ -> 0) s
                      in
                        reduceS (+) 0 s_info
