import Seq
import Par
import ListSeq

-- 1)
data Tree a = Empty | Leaf a | Node Int (Tree a) (Tree a) deriving Show
data MultiDic k v = E | N (MultiDic k v) (k, Tree v) (MultiDic k v) deriving Show

-- i)
isValue :: (Ord k, Eq v) => k -> v -> MultiDic k v -> Bool
isValue _ _ E = False
isValue k v (N l (k2, vT) r)    | k == k2   = isElement v vT
                                | k < k2    = isValue k v l
                                | otherwise    = isValue k v r
    where
        isElement :: Eq v => v -> Tree v -> Bool
        isElement _ Empty       = False
        isElement v (Leaf x)    = x == v
        isElement v (Node _ l r)= let
                                    (inL, inR) = isElement v l ||| isElement v r
                                  in
                                    inL || inR

t1 :: Tree Char
t1 = Node 3 (Leaf 'a') (Node 2 (Leaf 'f') (Leaf 'g'))

t2 :: Tree Char
t2 = Node 2 (Leaf 'm') (Leaf 'a')

dicTest :: MultiDic Int Char
dicTest = N E (1, t1) (N E (2, t2) E)

-- ii)
toMap :: Ord k => MultiDic k v -> Tree (k, Int, v)
toMap E = Empty
toMap (N l (k, vT) r) = let
                                tL = toMap l
                                tM = mapReduceIndex k 0 vT
                                tR = toMap r
                           in
                            merge (merge tL tM) tR
    where
        size :: Tree a -> Int
        size Empty          = 0
        size (Leaf x)       = 1
        size (Node s l r)   = s

        mapReduceIndex :: k -> Int -> Tree v -> Tree (k, Int, v)
        mapReduceIndex _ _ Empty        = Empty
        mapReduceIndex k i (Leaf v)     = Leaf (k, i, v)
        mapReduceIndex k i (Node s l r) = let
                                            sizeL = size l
                                            (l', r') = mapReduceIndex k i l ||| mapReduceIndex k (i+sizeL) r
                                          in
                                            Node s l' r'
        
        merge :: Tree a -> Tree a -> Tree a
        merge t1 Empty  = t1
        merge Empty t2  = t2
        merge t1 t2     = Node (size t1 + size t2) t1 t2

-- 2)
spaml :: Seq s => s Int -> Int
spaml s | n <= 2    = n
        | otherwise = spaml_aux s
    where
        n = lengthS s

        spaml_aux :: Seq s => s Int -> Int
        spaml_aux s = let
                        n           = lengthS s
                        s_dif       = tabulateS (\i-> nthS s (i+1) - nthS s i) (n-1) `asTypeOf` s
                        s_info      = mapS f s_dif
                        (s_red, r)  = scanS g (nthS s_info 0) (dropS s_info 1)
                        s_res       = mapS h (appendS s_red (singletonS r))
                        f           = (\i-> (i, 1, True))
                        g           = (\(vL, sufL, bL) (vR, sufR, bR) -> 
                                        if vL == vR && bR then
                                                            (vR, sufL + sufR, bL && bR)
                                                           else
                                                            (vR, sufR, False))
                        h           = (\(_, i, _) -> i)
                      in
                        1 + reduceS max 0 s_res

s1 = [7,6,5,4,6,8] :: [Int]
s2 = [6,7,5,6] :: [Int]
s3 = [1,2,5,8,12,14,16] :: [Int]