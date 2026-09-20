import Control.Applicative hiding (many)
import Parsing

{-
2) Extender el parser de expresiones visto en clase para permitir el uso de la resta y la división, basándose en la
siguiente extensión a la gramática:
expr → term (’+’ expr | ’-’ expr | ε)
term → factor (’*’ term | ’/’ term | ε)
-}
expr :: Parser Int
expr = do
    t <- term
    expr' t

expr' :: Int -> Parser Int
expr' acc = 
    (do symbol "+"
        t <- term
        expr' (acc+t))
    <|> (do symbol "-"
            t <- term
            expr' (acc-t))
    <|> return acc

term :: Parser Int
term = do
    f <- factor
    term' f

term' :: Int -> Parser Int
term' acc = 
    (do symbol "*"
        f <- factor
        term' (acc*f))
    <|> (do symbol "/"
            f <- factor
            term' (acc `div` f))
    <|> return acc

factor :: Parser Int
factor = 
    (do symbol "("
        e <- expr
        symbol ")"
        return e)
    <|> natural

{-
3) Escribir un transformador que al recibir un parser, devuelva un nuevo parser que se comporta
como el original pero que también acepta opcionalmente que las cadenas estén entre parentesis.
-}
transformador :: Parser a -> Parser a
transformador p =
    (do symbol "("
        val <- transformador p
        symbol ")"
        return val)
    <|> p

{-
4) Modificar el parser del ejercicio 2 para que en lugar de evaluar una expresión genere un 
árbol de sintaxis abstracta dado por el tipo:
-}
data Expr = Num Int | BinOp Op Expr Expr deriving Show
data Op = Add | Mul | Min | Div deriving Show

exprEst :: Parser Expr
exprEst = do
    t <- termEst
    exprEst' t

exprEst' :: Expr -> Parser Expr
exprEst' acc = 
    (do symbol "+"
        t <- termEst
        exprEst' (BinOp Add acc t))
    <|> (do symbol "-"
            t <- termEst
            exprEst' (BinOp Min acc t))
    <|> return acc

termEst :: Parser Expr
termEst = do
    f <- factorEst
    termEst' f

termEst' :: Expr -> Parser Expr
termEst' acc = 
    (do symbol "*"
        f <- factorEst
        termEst' (BinOp Mul acc f))
    <|> (do symbol "/"
            f <- factorEst
            termEst' (BinOp Div acc f))
    <|> return acc

factorEst :: Parser Expr
factorEst = 
    (do symbol "("
        e <- exprEst
        symbol ")"
        return e)
    <|> (do n <- natural
            return (Num n))

{-
5) Podemos modelizar una subfamilia de los tipos de datos de Haskell mediante el siguiente
tipo de datos:
-}
data Basetype = DInt | DChar | DFloat deriving Show
type Hasktype = [Basetype]
{-
Al tipo Int -> Char -> Float podemos representarlo como [DInt, DChar, DFloat] :: Hasktype. 
Escribir un parser para esta subfamilia de los tipos de Haskell.
-}
basetype :: Parser Basetype
basetype = do
    symbol "Int"
    return DInt
    <|> do symbol "Char"
           return DChar
    <|> do symbol "Float"
           return DFloat

hasktype :: Parser Hasktype
hasktype = sepBy1 basetype (symbol "->")

{-
6) Escribir un parser para listas heterogéneas de enteros y caracteres por extensión
usando el formato de Haskell. Defina un tipo de datos adecuado para representar estas listas parseadas.
Por ejemplo, una cadena a parsear es la siguiente [1, 'a', 'b', 2, 3, 'c']
-}
data Elementos = Entero Int | Caracter Char deriving Show

elementos :: Parser Elementos
elementos = do
    n <- integer
    return (Entero n)
    <|> do symbol "'"
           c <- letter
           symbol "'"
           return (Caracter c)

lista :: Parser [Elementos]
lista = do symbol "["
           x <- sepBy elementos (symbol ",")
           symbol "]"
           return x

{-
7) Podemos modelizar otra subfamilia de los tipos de datos de Haskell, más expresiva que la del
ejercicio 5, mediante el siguiente tipo de datos:
-}
data Hasktype2 = DInt2 | DChar2 | DFloat2 | Fun Hasktype2 Hasktype2 deriving Show
{-
Por ejemplo el tipo Int -> Char -> Float será representado mediante el término Fun DInt (Fun DChar DFloat),
mientras que el tipo (Int -> Char) ->, que no pertenece a la subfamilia del ejercicio 5, será representado con
Fun (Fun DInt DChar) DFloat. Escribir un parser para esta sufamilia de tipos de Haskell.
-}
basetype2 :: Parser Hasktype2
basetype2 = do
    symbol "Int"
    return DInt2
    <|> do symbol "Char"
           return DChar2
    <|> do symbol "Float"
           return DFloat2

hasktype2 :: Parser Hasktype2
hasktype2 = do
    x <- basetype2
    do symbol "->"
       y <- hasktype2
       return (Fun x y)
       <|> return x
    <|> do symbol "("
           x <- hasktype2
           symbol ")"
           do symbol "->"
              y <- hasktype2
              return (Fun x y)
              <|> return x

{-
9) La siguiente gramática es una simplificación de la declaración de tipos en C:
declaration → type specifier declarator ’;’
declarator → ’*’ declarator | direct declarator
direct declarator → direct declarator ’[’ constant expression ’]’ | ’(’ direct declarator ’)’ | identifier
type specifier → ’int’ | ’char’ | ’float’
constant expression → number
Construir un parser para esta gramática y dar los tipos de datos adecuados para representar estas declaraciones
-}
data Specificer = CInt | CChar | CFloat deriving Show
--data Declarator = Ptr Declarator | Di Direct

