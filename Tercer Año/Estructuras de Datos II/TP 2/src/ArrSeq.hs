
module ArrSeq where
import qualified Arr as A
import Arr ((!))

import Seq
import Par

b = A.fromList [1,2,3,1]
b2 = A.fromList [4,5,6]
c = A.fromList [A.fromList [1,2,3,4], A.fromList [1,2,3,4], A.fromList [1,2,3,4], A.empty, emptyS, singletonS 2]

instance Seq A.Arr where
    --emptyS     :: s a
    emptyS = A.empty

    --singletonS :: a -> s a
    singletonS x = A.fromList [x]

    --lengthS    :: s a -> Int 
    lengthS x = A.length x
    
    --nthS       :: s a -> Int -> a 
    nthS x i = x!i

    --tabulateS  :: (Int -> a) -> Int -> s a
    tabulateS f n = A.tabulate f n

    --mapS       :: (a -> b) -> s a -> s b 
    mapS f x = tabulateS (\i -> f (nthS x i)) (lengthS x)

    filterS p xs = joinS (tabulateS aux (lengthS xs))  -- join \in O(|s|) + \sum_(i=0)^{|s|-1} O(|s_i|) | tabulate \in O(\sum_(i=0)^{n-1} O(f s_i))
                        where                          -- lengthS \in O(1)
                            aux i | p (nthS xs i) = singletonS (nthS xs i) -- nthS \in O(1) | singletonS \in O(1) 
                                  | otherwise     = emptyS

    --appendS    :: s a -> s a -> s a
    appendS x y = tabulateS aux (lx + ly)
                    where
                        lx = lengthS x
                        ly = lengthS y
                        aux i   | i < lx  = nthS x i
                                | otherwise = nthS y (i - lx)

    --takeS      :: s a -> Int -> s a
    takeS x 0 = emptyS
    takeS x i | len == 0  = emptyS
              | i > len   = x
              | otherwise = A.subArray 0 i x
                    where len = lengthS x

    --dropS      :: s a -> Int -> s a
    dropS x 0 = x
    dropS x i | i == 0  = x
              | i > len = emptyS
              | otherwise = A.subArray i (len - i) x
                    where len = lengthS x

    --showtS     :: s a -> TreeView a (s a)
    showtS x | len == 0  = EMPTY
             | len == 1  = ELT (nthS x 0)
             | otherwise = let mid = (lengthS x) `div` 2 in NODE (takeS x mid) (dropS x mid)
            where len = lengthS x

                                
    --showlS     :: s a -> ListView a (s a)
    showlS x | len == 0  = NIL
             | otherwise = CONS (nthS x 0) (dropS x 1) 
                where len = lengthS x
    
    --joinS      :: s (s a) -> s a
    joinS x = A.flatten x

    --reduceS    :: (a -> a -> a) -> a -> s a -> a
    reduceS op e xs | len == 0  = e
                    | len == 1  = op e (nthS xs 0)
                    | otherwise = reduceS op e (A.tabulate contraer mitad)
                        where 
                            len   = lengthS xs
                            mitad = (len+1) `div` 2
                            contraer i  | odd len && i == mitad - 1  = nthS xs (2*i)
                                        | otherwise                  = op (nthS xs (2*i)) (nthS xs (2*i + 1))

    --scanS      :: (a -> a -> a) -> a -> s a -> (s a, a)
    scanS op e xs  | len == 0 = (emptyS, e)
                   | len == 1 = (singletonS e, op e (nthS xs 0))
                   | otherwise = (expanded, red)
                        where
                            len  = lengthS xs
                            half = if even len then len `div` 2 else (len `div` 2)+ 1
                        
                            mapeo_1 i | (2*i) < len-1 = op (nthS xs (2*i)) (nthS xs (2*i+1))
                                      | otherwise     = nthS xs (2*i)
                                    
                            -- Se utiliza A.tabulate, ya que contracted se llama recursivamente y scanS no sabe que es del mismo tipo que xs 
                            contracted = A.tabulate mapeo_1 half

                            (s, red) = scanS op e contracted
                            
                            mapeo_2 i | even i    = nthS s (i `div` 2)
                                        | otherwise = op (nthS s (i `div` 2)) (nthS xs (i - 1))
                            
                            expanded = tabulateS mapeo_2 len

    --fromList   :: [a] -> s a
    fromList x = A.fromList x
