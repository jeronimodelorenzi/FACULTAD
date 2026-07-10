module ListSeq where
import Seq
import Par


instance Seq [] where
    emptyS = []

    singletonS x = [x]

    lengthS [] = 0
    lengthS (x:xs) = 1 + lengthS xs

    nthS [] _ = error "No definido para lista vacía"
    nthS (x:xs) ind | ind == 0 = x
                    | otherwise = nthS xs (ind-1)

    tabulateS f k = aux f (k-1) 0
                        where
                            aux f n i | i == n    = [f n]
                                      | otherwise = x:rest
                                            where 
                                                (x, rest) = (f i) ||| aux f n (i+1)

    mapS _ [] = []
    mapS f (x:xs) = let (fx, fxs) = f x ||| mapS f xs
                    in  fx:fxs

    filterS _ [] = []
    filterS p (x:xs) =  let (px, pxs) = p x ||| filterS p xs
                        in if px then x:pxs else pxs

    appendS x y = x ++ y 
    
    takeS xs 0 = []
    takeS [] _ = []
    takeS (x:xs) num = x:(takeS xs (num-1))

    dropS xs 0 = xs
    dropS [] _ = []
    dropS (x:xs) num = (dropS xs (num-1))
    
    -- data TreeView a t = EMPTY | ELT a | NODE t t
    showtS [] = EMPTY
    showtS [x] = ELT x
    showtS x = let
                mid = lengthS x `div` 2 
                (l, r) = (takeS x mid) ||| (dropS x mid)
               in NODE l r

    -- data ListView a t = NIL | CONS a t
    showlS [] = NIL
    showlS (x:xs) = CONS x xs

    -- joinS      :: s (s a) -> s a
    joinS [] = []
    joinS (xs:xss) = appendS xs (joinS xss)
    
    -- reduceS    :: (a -> a -> a) -> a -> s a -> a
    reduceS _ e [] = e
    reduceS op e [x] = op e x
    reduceS op e xs = reduceS op e (contraer op xs)
                        where
                            contraer :: (a -> a -> a) -> [a] -> [a]
                            contraer op [] = []
                            contraer op [x] = [x]
                            contraer op (x:y:xs) = let (res, rest) = op x y ||| contraer op xs in res : rest

    -- scanS      :: (a -> a -> a) -> a -> s a -> (s a, a)
    scanS op e [] = ([], e) 
    scanS op e [x] = ([e], op e x)
    scanS op e xs = let (l, r) = scanS op e (contraer op xs) in (expandir op xs l True, r)
                        where
                            contraer :: (a -> a -> a) -> [a] -> [a]
                            contraer op [] = []
                            contraer op [x] = [x]
                            contraer op (x:y:xs) = let (res, rest) = op x y ||| contraer op xs in res : rest

                            expandir :: (a -> a -> a) -> [a] -> [a] -> Bool -> [a]
                            expandir op _ [] _ = []
                            expandir op [x] (y:ys) p    | p         = [y]
                                                        | otherwise = [op y x]
                            expandir op (x1:x2:xs) (y:ys) p     | p         = y : expandir op (x1:x2:xs) (y:ys) (not p)
                                                                | otherwise = let (res, rest) = op y x1 ||| expandir op xs ys (not p)
                                                                              in res: rest

    -- fromList   :: [a] -> s a
    fromList xs = xs