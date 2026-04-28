type Interval = (Int, Int)
data ITree = E | N ITree Interval ITree deriving Show

t1 :: ITree
t1 = N (N E (1,3) E) (5,7) (N E (10,12) E)

right :: ITree -> Int
right (N _ x E) = snd x
right (N _ _ r) = right r

left :: ITree -> Int
left (N E x _) = fst x
left (N l _ _) = left l

checkIT :: ITree -> Bool
checkIT E = True
checkIT t = checkInterval t && checkITAux t
    where
        checkInterval :: ITree -> Bool
        checkInterval E = True
        checkInterval (N l x r) = fst x <= snd x && checkInterval l && checkInterval r

        checkITAux :: ITree -> Bool
        checkITAux E = True
        checkITAux (N E _ E) = True
        checkITAux (N l x E) = fst x - 1 > right l && checkITAux l
        checkITAux (N E x r) = snd x + 1< left r && checkITAux r
        checkITAux (N l x r) = fst x -1 > right l && snd x + 1 < left r && checkITAux l && checkITAux r

{-
Queremos obtener la recurrencia de la función checkIT.
Veamos que checkInterval realiza la recurrencia en todos los nodos,
por lo que si n tiene altura h, en el peor de los casos l y r tienen altura h-1.
Del mismo modo para checkITAux. Entonce por cada llamada recursiva realizamos 2
veces la recursión con h-1 elementos.
Y siempre llegamos hasta una hoja al utilizar left y right. Entonces podemos definir
la recurrencia de checkIT como T(h) = 2T(h-1) + O(h)
-}

splitMax :: ITree -> (Interval, ITree)
splitMax (N E x E) = (x, E)
splitMax (N l x E) = (x, l)
splitMax (N l x r) = let
                        (i, t') = splitMax r
                     in
                        (i, N l x t')

merge :: ITree -> ITree -> ITree
merge l E = l
merge E r = r
merge l r = let 
                (i, t') = splitMax r
            in
                 N t' i r

delElem :: ITree -> Int -> ITree
delElem E _ = E
delElem (N l (x,y) r) i | i < x             = N (delElem l i) (x,y) r
                        | i > y             = N l (x,y) (delElem r i)
                        | i == x && i == y  = merge l r
                        | i == x            = N l (x+1, y) r
                        | i == y            = N l (x, y-1) r
                        | otherwise         = N l (x, i-1) (N E (i+1, y) r)