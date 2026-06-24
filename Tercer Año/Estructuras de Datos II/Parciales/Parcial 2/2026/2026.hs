data Tree a = E | L a | N (Tree a) (Tree a) deriving Show
intercalate :: Tree a -> Tree (Tree a) -> Tree a
intercalate s E         = E
intercalate E t         = flattenS t
intercalate s (L t)     = t
intercalate s (N l r)   = let
                            (l', r') = (intercalate s l, intercalate s r)
                          in
                            appendS l' s r'

flattenS :: Tree (Tree a) -> Tree a
flattenS E       = E
flattenS (L t)   = t
flattenS (N l r) = let (l', r') = (flattenS l, flattenS r) in N l' r'

appendS :: Tree a -> Tree a -> Tree a -> Tree a
appendS E s r = r
appendS l s E = l
appendS l s r = N l (N s r)

t1 :: Tree Int
t1 = N (L 1) (L 0)

t2 :: Tree (Tree Int)
t2 = N 
        (N 
            (L (N (L 2) (L 3))) 
            (L (N (N (L 4) (L 5)) (L 6)))
        ) 
        (L (L 8))