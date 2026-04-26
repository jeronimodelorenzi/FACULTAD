import Data.List
data Scapegoat a = E | N a Int (Scapegoat a) (Scapegoat a) deriving (Eq, Show)
t1 :: Scapegoat Int
t1 = N 10 10 (N 7 6 (N 5 4 (N 3 2 (N 1 1 E E) E) (N 6 1 E E)) (N 8 1 E E)) (N 15 3 (N 12 1 E E) (N 20 1 E E))

t2 :: Scapegoat Int
t2 = N 10 10 (N 7 6 (N 6 4 (N 3 3 (N 1 1 E E) (N 5 1 E E)) E) (N 8 1 E E)) (N 15 3 (N 12 1 E E) (N 20 1 E E))

mySize :: Scapegoat a -> Int
mySize E = 0
mySize (N _ s _ _) = s

minimumBST :: Scapegoat a -> a
minimumBST (N a _ E _) = a
minimumBST (N a _ l _) = minimumBST l

maximumBST :: Scapegoat a -> a
maximumBST (N a _ _ E) = a
maximumBST (N a _ _ r) = maximumBST r

isBST :: Ord a => Scapegoat a -> Bool
isBST E = True
isBST (N a _ E E) = True
isBST (N a _ E r) = a < minimumBST r && isBST r
isBST (N a _ l E) = a >= maximumBST l && isBST l
isBST (N a _ l r) = a >= maximumBST l && a < minimumBST r
                    && isBST l && isBST r

isScapegoatTree :: Ord a => Scapegoat a -> Bool
isScapegoatTree E = True
isScapegoatTree t = isBalanced t && isBST t 
    where
        isBalanced :: Scapegoat a -> Bool
        isBalanced E = True
        isBalanced t@(N _ s l r) = 3 * mySize l <= 2 * s && 3 * mySize r <= 2 * s
                                 && isBalanced l && isBalanced r

member :: Ord a => a -> Scapegoat a -> Bool
member a E = False
member a (N b _ l r)    | a == b    = True
                        | a < b     = member a l
                        | otherwise = member a r                             

t3 :: Scapegoat Int
t3 = N 6 4 (N 3 3 (N 1 1 E E) (N 5 1 E E)) E

rebuild :: Scapegoat a -> Scapegoat a
rebuild t = rebuildAux (inorder t) (mySize t)
    where
        inorder :: Scapegoat a -> [a]
        inorder E = []
        inorder (N a s l r) = inorder l ++ [a] ++ inorder r

        rebuildAux :: [a] -> Int -> Scapegoat a
        rebuildAux [] _ = E
        rebuildAux xs s = let
                            mitad = s `div` 2
                            (izq, m:der) = splitAt mitad xs
                            sDer = s - mitad - 1
                         in N m s (rebuildAux izq mitad) (rebuildAux der sDer)

myInsert :: Ord a => a -> Scapegoat a -> Scapegoat a
myInsert a E = N a 1 E E
myInsert a (N b s l r)  | a <= b    = let
                                        hijoIzq = myInsert a l
                                        nuevoNodo = N b (s+1) hijoIzq r
                                      in
                                        if 3 * mySize hijoIzq <= 2 * (s+1) then nuevoNodo else rebuild nuevoNodo
                        | otherwise = let
                                        hijoDer = myInsert a r
                                        nuevoNodo = N b (s+1) l hijoDer
                                      in
                                        if 3 * mySize hijoDer <= 2 * (s+1) then nuevoNodo else rebuild nuevoNodo


