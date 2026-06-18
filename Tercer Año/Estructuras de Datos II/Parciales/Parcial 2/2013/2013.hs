import Seq
import Par
import ListSeq

-- 2)
count :: Seq s => s (Int,Int) -> Int
count s = let
            s_snd       = mapS snd s
            (s_maxSnd, _)  = scanS max minBound s_snd
            s_cont         = tabulateS (\i -> if nthS s_snd i <= nthS s_maxSnd i then 1 else 0) (lengthS s) `asTypeOf` mapS (\_ -> 0) s
          in
            reduceS (+) 0 s_cont