import Seq
import Par
import ListSeq

-- 2)
data Tree a = Leaf a | Node Int (Tree a) (Tree a) deriving Show

-- a)
size :: Tree a -> Int
size (Leaf x)     = 1
size (Node s _ _) = s

mapReduceIndex :: (Int -> a -> b) -> (b -> b -> b) -> Tree a -> b
mapReduceIndex f op t = mri f op t 0
    where
        size :: Tree a -> Int
        size (Leaf x)     = 1
        size (Node s _ _) = s

        mri :: (Int -> a -> b) -> (b -> b -> b) -> Tree a -> Int -> b
        mri f op (Leaf x) i     = f i x
        mri f op (Node _ l r) i = let
                                    sizeL = size l
                                    (l', r') = (mri f op l i, mri f op r (i+sizeL))
                                  in
                                    op l' r'

t = Node 3 (Node 2 (Leaf 10) (Leaf 20)) (Leaf 30)

a = mapReduceIndex (\idx valor -> idx * valor) (+) t

-- b)
sumEven :: Tree Int -> Int
sumEven t = mapReduceIndex (\i x -> if even i then x else 0) (+) t

-- 3)
type Pesos      = Float
type Dolares    = Float
type Cotizacion = Float
data Transaccion = Depositar Pesos | Comprar Int Cotizacion | Vender Int Cotizacion

eval :: Transaccion -> (Pesos, Dolares)
eval (Depositar pesos) = (pesos, 0)
eval (Comprar n cot)   = let x = fromIntegral n in (-x * cot, x)
eval (Vender n cot)    = let x = fromIntegral n in (x * cot, -x)

transaccionOk :: Seq s => s Transaccion -> Bool
transaccionOk s =   let
                        transEval = mapS eval s
                        (transScan, (tP, tD)) = scanS (\(x1,y1) (x2,y2) -> (x1+x2, y1+y2)) (0,0) transEval
                        transBool = mapS (\(i,j) -> if (i >= 0) && (j >= 0) then True else False) transScan
                        esValido  = reduceS (&&) True transBool
                    in
                        esValido && tP >= 0 && tD >= 0

transOk :: [Transaccion]
transOk = [Depositar 100000, Comprar 100 1000, Vender 20 500, Comprar 5 1000]

transFail1 :: [Transaccion]
transFail1 = [Depositar 100000, Vender 20 500, Comprar 100 1000, Comprar 5 1000]

transFail2 :: [Transaccion]
transFail2 = [Depositar 100, Comprar 100 1000]