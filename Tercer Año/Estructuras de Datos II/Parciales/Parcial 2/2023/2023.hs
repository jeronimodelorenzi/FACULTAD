import Seq
import Par
import ListSeq

-- 2)
data Tree a = E | N Int (Tree a) a (Tree a) deriving Show

filterPrefix :: (a -> Bool) -> Tree a -> Tree a
filterPrefix _ E            = E
filterPrefix p (N s l x r)  = let
                                (l', r') = filterPrefix p l ||| filterPrefix p r
                              in
                                if size l' == size l && p x
                                    then
                                        N (size l' + 1 + size r') l' x r'
                                    else
                                        l'
    where
        size :: Tree a -> Int
        size E              = 0
        size (N s _ _ _)    = s


arbolPrueba :: Tree Int
arbolPrueba = N 6 
                (N 2 (N 1 E 6 E) 6 E) 
                8                      
                (N 3 (N 1 E 1 E) 4 (N 1 E 5 E))

longestStreak :: Seq s => Float -> s Float -> Int
longestStreak val s = let
                        s_info      = mapS (\i -> if i > val then (1,True) else (0, False)) s
                        (s_red, r)  = scanS (\(sL, bL) (sR, bR) -> if bR then 
                                                                        (sL + sR, bL && bR)
                                                                          else
                                                                        (sR, False)) (0,True) s_info
                        s_res       = mapS (\(i, _) -> i) (appendS s_red (singletonS r))
                      in
                        reduceS max 0 s_res

