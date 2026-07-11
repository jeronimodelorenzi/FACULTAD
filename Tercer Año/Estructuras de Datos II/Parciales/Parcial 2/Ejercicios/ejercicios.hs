import Seq
import Par
import ListSeq
import GHC.Base (undefined)

{-
En una fábrica, los sensores registran el peso de los paquetes que pasan por la cinta. 
Tenés una secuencia de pesos (números enteros). El supervisor te pide un algoritmo 
para calcular la cantidad total de paquetes que pesaron exactamente 100 gramos en todo el día.
-}
cantPeso :: Seq s => Int -> s Int -> Int
cantPeso val s = let
                    s_info = mapS (\i-> if i == val then 1 else 0) s
                  in
                    reduceS (+) 0 s_info

seq1 :: [Int]
seq1 = [100, 20, 40, 50, 100, 90, 101, 345, 100, 10]
seq2 :: [Int]
seq2 = [30, 20, 40, 50]

{-
Estás analizando el historial de un equipo de fútbol. Tenés una secuencia de letras que 
representan los resultados: 'G' (Ganado), 'E' (Empatado), 'P' (Perdido). 
Te piden calcular cuál fue la racha histórica más larga de empates consecutivos.
-}
data ResPartido = G | E | P deriving Eq
cantEmpates :: Seq s => s ResPartido -> Int
cantEmpates s = let
                    s_info      = mapS (\i-> if i == E then (1, True) else (0,False)) s
                    (s_red, r)  = scanS (\(sL, bL) (sR, bR) -> if bR then 
                                                                        (sL + sR, bL && bR) 
                                                                     else 
                                                                        (sR, bR)) (0,True) s_info
                    s_res       = mapS (\(i, _) -> i) (appendS s_red (singletonS r))
                in
                    reduceS max 0 s_res

seq3 :: [ResPartido]
seq3 = [E, G, G, G, E, E, E, E, P, G, E, E, E, P]
seq4 :: [ResPartido]
seq4 = [G,G,G,P]

{-
Un dron escaneó un terreno y te devolvió una secuencia de mediciones topográficas 
(alturas en metros, por ejemplo: [4, 4, 4, 2, 8, 8]). 
Queremos encontrar la longitud de la planicie contigua más larga 
(es decir, la subsecuencia contigua máxima donde todos los números sean exactamente iguales).
-}
mscml :: Seq s => s Int -> Int
mscml s | lengthS s == 0 = 0
        | lengthS s == 1 = 1
        | otherwise      = 
            let
                s_eq    = tabulateS (\i -> if nthS s i == nthS s (i+1)  then (1,1,1,1) else (0,0,0,1)) (lengthS s - 1) `asTypeOf` mapS undefined s
                val     = (0, 0, 0, 0)
                (s_res, _, _, _)   = reduceS combine val s_eq
            in
                s_res+1



s1 = [7,6,5,4,6,8] :: [Int]
s2 = [6,7,5,6] :: [Int]
s3 = [1,2,5,8,12,14,16] :: [Int]          


combine (maxL, prefL, sufL, lL) (maxR, prefR, sufR, lR) =
                    let
                        pref = if prefL == lL then prefL + prefR else prefL
                        suf  = if sufR == lR then sufR + sufL else sufR
                        l    = lL + lR
                        maxT = max maxL (max maxR (sufL+prefR))
                    in
                        (maxT, pref, suf, l)

{-
Dada una secuencia s y un natural n, divide la secuencia en dos con los primeros n elementos de s
y el resto de los elementos.
-}
data Tree a = Empty | N Int (Tree a) (Tree a) | L a deriving Show

divide :: Tree a -> Int -> (Tree a, Tree a)
divide Empty _          = (Empty, Empty)
divide (L a) i          | i <= 0    = (Empty, L a)
                        | otherwise = (L a, Empty)
divide t@(N s l r) i    | i <= 0    = (Empty, t)
                        | i >= s    = (t, Empty)
                        | i <= sL   = let
                                        (ll, lr) = divide l i
                                      in
                                        (ll, append lr r)
                        | otherwise = let
                                        (rl, rr) = divide r (i-sL)
                                      in
                                        (append l rl, rr) 

    where
        append :: Tree a -> Tree a -> Tree a
        append Empty t2 = t2
        append t1 Empty = t1
        append t1 t2    = N (size t1 + size t2) t1 t2

        sL = size l

ejemploArbol :: Tree String
ejemploArbol = 
  N 5 
    (N 3 
      (N 2 (L "x0") (L "x1")) 
      (L "x2")
    ) 
    (N 2 
      (L "x3") 
      (L "x4")
    )

{-
Dadas dos secuencias s y s' devuelve una secuencia de largo |s| + |s'|
con los elementos de s y s' de manera intercalada
-}
interleave :: Tree a -> Tree a -> Tree a
interleave Empty t2         = t2
interleave t1 Empty         = t1
interleave (L a) (L b)      = N 2 (L a) (L b)
interleave (L a) t2     = let
                            (l, r) = divide t2 1
                            (l', r') = interleave (L a) l ||| interleave Empty r
                          in
                            N (size t2 + 1) l' r'
interleave (N s l r) t2 = let
                            sL = size l
                            (l2, r2) = divide t2 sL
                            (l', r') = interleave l l2 ||| interleave r r2
                          in
                            N (s + size t2) l' r'
        
size :: Tree a -> Int
size Empty      = 0
size (L a)      = 1
size (N s _ _)  = s

arbolX :: Tree String
arbolX = 
  N 4 
    (N 2 (L "x0") (L "x1")) 
    (N 2 (L "x2") (L "x3"))


arbolY :: Tree String
arbolY = 
  N 3 
    (N 2 (L "y0") (L "y1")) 
    (L "y2")

{-
Dada una secuencia s, devuelva una secuencia con los indices de s que corresponden
a valores mayores a su promedio historico.
-}
highestIndexes :: Seq s => s Float -> s Int
highestIndexes s =  let
                        (s_sum, _)  = scanS (+) 0 s
                        s_idx       = tabulateS id (lengthS s)
                    in
                        filterS (\i -> if i == 0 then nthS s i > 0 else nthS s i > (nthS s_sum i / fromIntegral i)) s_idx
{-
(+) es O(1)
Sscan pertenece a O(lg(n))
id es O(1)
Stabulate pertenece a O(1)
(\i -> if i == 0 then nthS s i > 0 else nthS s i > (nthS s_sum i / fromIntegral i)) es O(1)
Sfilter pertenece a O(lg(n))
Entonces ShighestIndexes(n) = c1*lg(n) + c2 + c3*lg(n) = (c1 + c3)lg(n) + c2 => ShighestIndexes pertenece a O(lg(n))
-}

{-
Elimina el sufijo dado en una secuencia, devolviendo Nothing si la secuencia no termina con el sufijo dado
o Just xs donde xs es la secuencia que queda antes del sufijo.
-}
stripSufix :: Eq a => Tree a -> Tree a -> Maybe (Tree a)
stripSufix suf s
    | size suf >= size s    = Nothing
    | otherwise             = let
                                k = size s - size suf
                                (prefijo, sufijo) = divide s k
                              in
                                if iguales suf sufijo then Just prefijo else Nothing
        where
            iguales :: Eq a => Tree a -> Tree a -> Bool
            iguales Empty Empty = True
            iguales (L x) (L y) = x == y
            iguales (N _ l1 r1) (N _ l2 r2) = let
                                                (bL, bR) = iguales l1 l2 ||| iguales r1 r2
                                              in
                                                bL && bR
            iguales _ _         = False

sufijoBar :: Tree Char
sufijoBar = 
  N 3 
    (N 2 (L 'b') (L 'a')) 
    (L 'r')

secuenciaFooBar :: Tree Char
secuenciaFooBar = 
  N 6 
    (N 3 
      (N 2 (L 'f') (L 'o')) 
      (L 'o')
    ) 
    (N 3 
      (N 2 (L 'b') (L 'a')) 
      (L 'r')
    )

secuenciaFooBarr :: Tree Char
secuenciaFooBarr = 
  N 7 
    (N 3 
      (N 2 (L 'f') (L 'o')) 
      (L 'o')
    ) 
    (N 4 
      (N 2 (L 'b') (L 'a')) 
      (N 2 (L 'r') (L 'r'))
    )

{-
Cierto periódico quiere manipular los resultados de las elecciones de las paso en Argentina asociando los resultados
por ciudades cercanas de manera conveniente a un partido X.
Para ello, dada una secuencia s con los balances de votos de un partido X, se desea encontrar la suma de una
subsecuencia de s que maximice las sumas de dichos balances. Definir una función maxBalance : Seq Int -> Int
que resuleva el problema.
-}
maxBalance :: Seq s => s Int -> Int
maxBalance s =  let
                    (s_sum, r)  = scanS (+) 0 s
                    s_info = appendS s_sum (singletonS r)
                    (s_min, r2) = scanS min 0 s_info
                    s_red = tabulateS (\i -> nthS s_info i - nthS s_min i) (lengthS s_info) `asTypeOf` s_info
                in
                    reduceS max minBound s_red


mcssScan :: Seq s => s Int -> Int
mcssScan s = let
                -- 1. x = scan (+) 0 s 
                -- (¡Aplicamos el rescate del último elemento fantasma!)
                (s_pref_ex, total) = scanS (+) 0 s
                x = appendS s_pref_ex (singletonS total)
                
                -- 2. m = scan min \infty x
                -- Usamos maxBound como infinito
                (m, _) = scanS min maxBound x
                
                -- 3. tabulate (\j -> x_j - m_j)
                -- Protegemos el índice 0 del underflow matemático y atamos el tipo
                s_red = tabulateS (\j -> 
                            if j == 0 then 0 
                            else nthS x j - nthS m j
                        ) (lengthS x) `asTypeOf` x
             in
                -- max (...)
                reduceS max 0 s_red


{-
Dada una función f y una secuencia s aplique f a cada elemento de la secuencia y a su posición.
-}
mapIndex :: (a -> Int -> b) -> Tree a -> Tree b
mapIndex f t = mi f t 0
    where
        mi :: (a -> Int -> b) -> Tree a -> Int -> Tree b
        mi _ Empty _     = Empty
        mi f (L x) i     = L (f x i)
        mi f (N s l r) i =  let
                                sL = size l
                                (l', r') = mi f l i ||| mi f r (i+sL)
                            in
                                N s l' r'

{-
Dados tres naturales n, m y k, contruye una secuencia de m elementos, comenzando por n
y sumando 1 cada k elementos.
-}
fromSlow :: Int -> Int -> Int -> Tree Int
fromSlow n m k = fromSlowAux n m k 0
    where
        fromSlowAux :: Int -> Int -> Int -> Int -> Tree Int
        fromSlowAux _ 0 _ _ = Empty
        fromSlowAux _ 1 k i = L (n + (i `div` k))
        fromSlowAux n m k i =  let
                                mitad = m `div` 2
                                resto = m - mitad
                                (l , r) = fromSlowAux n mitad k i ||| fromSlowAux n resto k (i+mitad)
                            in
                                N m l r

{-
Dada una secuencia cronológica de ventas realizadas en diferentes horarios y un monto de pesos X,
se desea determinar la hora en que las ventas aculadas alcanzan el valor X.
Escribir una función alarma : Seq (Pesos, Hora) -> Pesos -> Maybe Hora que calcule la hora en que se
llega al monto X o retorne Nothing si nunca se acumuló ese monto. Suponer que se definieron los tipos Peso y Hora.
Definir la función usando scan, con profundidad de orden O(lg(n)), donde n es el largo de la secuencia.
-}
type Pesos = Int
type Horas = String

alarma :: Seq s => s (Pesos, Horas) -> Pesos -> Maybe Horas
alarma s x = let
                s_monto     = mapS fst s
                s_idx       = tabulateS id (lengthS s) `asTypeOf` s_monto
                (s_sum, r)  = scanS (+) 0 s_monto
                s_info      = appendS s_sum (singletonS r)
                s_filter    = filterS (\i -> nthS s_info (i+1) >= x) s_idx `asTypeOf` s_idx
                s_res       = tabulateS (\i -> nthS s (nthS s_filter i)) (lengthS s_filter) `asTypeOf` s
             in
                if (lengthS s_res) == 0 then Nothing else Just (snd (nthS s_res 0))
{-
Salarma(n) = O(1) + O(1) + O(lg) + O(1) + O(lg) + O(1) + O(1) = O(lg)
-}
mergeS :: Seq s => (a -> a -> Ordering) -> s a -> s a -> s a
mergeS cmp s1 s2 = case showtS s1 of
                EMPTY      -> s2
                ELT x      -> let
                                  menores = filterS (\y -> cmp y x == LT) s2
                                  mayores = filterS (\y -> cmp y x /= LT) s2
                              in 
                                  appendS menores (appendS s1 mayores)

                NODE l1 r1 -> let
                                  pivot      = nthS r1 0 
                                  menorPivot = filterS (\i -> cmp i pivot == LT) s2
                                  mayorPivot = filterS (\i -> cmp i pivot /= LT) s2
                                  seq1       = mergeS cmp l1 menorPivot
                                  seq2       = mergeS cmp r1 mayorPivot
                              in 
                                  appendS seq1 seq2

sortS :: Seq s => (a -> a -> Ordering) -> s a -> s a
sortS cmp s = case showtS s of
                    EMPTY       -> s
                    ELT x       -> s
                    NODE l r    ->  let
                                        sortL = sortS cmp l
                                        sortR = sortS cmp r
                                    in
                                        mergeS cmp sortL sortR

collectS :: (Seq s, Ord a) => s (a,b) -> s (a, s b)
collectS s =    let
                    sortSeq     = sortS (\(x1,y1) (x2, y2) -> compare x1 x2) s
                    indices     = tabulateS id (lengthS sortSeq) `asTypeOf` mapS (\_ -> 0::Int) s
                    filtrado    = filterS (\i -> i == 0 || compare (fst (nthS sortSeq i)) (fst (nthS sortSeq (i-1))) /= EQ) indices
                    cantElem    = tabulateS (\i -> if i == (lengthS filtrado -1) 
                                                then (lengthS sortSeq) - (nthS filtrado i) 
                                                else (nthS filtrado (i+1)) - (nthS filtrado i)) (lengthS filtrado) `asTypeOf` filtrado
                    seqCollect  = tabulateS (\i -> let
                                                    inicio = nthS filtrado i
                                                    cant   = nthS cantElem i
                                                    clave  = fst (nthS sortSeq inicio)
                                                    res    = takeS (dropS sortSeq inicio) cant
                                                    val    = mapS snd res
                                                  in (clave, val)) (lengthS filtrado)
                in
                    seqCollect
{-
Dada una secuencia con pares de la forma (Artículo, Precio) ordenada cronológicamente, se desea saber cual fue el artículo
que más cantidad de aumentos tuvo a lo largo del tiempo. Suponiendo que se definió un tipo de datos Art para representar los
distintos artículos, los cuales pueden compararse, definir una función aumentos : Seq (Art, Int) -> (Art, Int), que resuelva 
el problema calculando el árticulo que más cantidad de aumentos tuvo y la cantidad de aumentos.
-}
aumentos :: Seq s => s (Char, Int) -> (Char, Int)
aumentos s = let
                s_collect   = collectS s
                s_aumentos  = mapS (\(art, precios) -> (art, contarAumentos precios)) s_collect
             in
                reduceS (\(x1, c1) (x2, c2) -> if c1 >= c2 then (x1, c1) else (x2, c2)) (' ', -1) s_aumentos
    where
        contarAumentos :: Seq s => s Int -> Int
        contarAumentos s =  let
                                s_cont = tabulateS (\i -> if nthS s i < nthS s (i+1) then 1 else 0) (lengthS s - 1) `asTypeOf` s
                            in
                                reduceS (+) 0 s_cont

{-
Implementar eficientemente la función takeT :: Int -> Tree a -> Tree a.
Esta función recibe un número $n$ y un árbol $t$, y debe devolver un nuevo árbol que contenga solamente los primeros $n$ 
elementos del recorrido inorder original. Si $n$ es mayor o igual al tamaño del árbol, devuelve el árbol intacto. 
Si $n <= 0$, devuelve vacío (E).
-}
takeT :: Int -> Tree a -> Tree a
takeT _ Empty       = Empty
takeT i (L x)       | i <= 0  = Empty
                    | otherwise = L x
takeT i t@(N s l r) | i <= 0  = Empty
                    | i >= s  = t
                    | i <= sL = takeT i l
                    | otherwise = let
                                     r' =  takeT (i-sL) r
                                  in
                                    N i l r'
  where
    sL = size l

{-
Dada una secuencia de temperaturas diarias, queremos encontrar la longitud de la mayor racha de días estrictamente crecientes 
(donde cada día hizo más calor que el anterior).
Programar la función maxCreciente :: Seq s => s Int -> Int
-}
maxCreciente :: Seq s => s Int -> Int
maxCreciente s =  let
                    s_map = tabulateS (\i-> if nthS s i < nthS s (i+1) then (1,1,1,1) else (0,0,0,1)) (lengthS s-1) `asTypeOf` mapS undefined s
                    val = (0, 0, 0, 0)
                    combine (maxL, prefL, sufL, lL) (maxR, prefR, sufR, lR) =
                      let
                        pref = if prefL == lL then prefL + prefR else prefL
                        suf  = if sufR == lR  then sufR + sufL  else sufR
                        l   = lL + lR
                        maxT = max maxL (max maxR (sufL + prefR))
                      in
                        (maxT, pref, suf, l)
                    (s_res, _, _, _) = reduceS combine val s_map
                  in
                    s_res+1

{-
Un molinete de un recital registra una secuencia de enteros cada vez que alguien cruza la puerta.

Si entra alguien, se registra un 1.

Si sale alguien, se registra un -1.
Ejemplo: s = ⟨ 1, 1, 1, -1, 1, -1 ⟩

Implementar una función maxGente :: Seq s => s Int -> Int que, utilizando scanS, determine cuál fue la cantidad histórica 
MÁXIMA de personas que llegaron a estar simultáneamente adentro del recital en algún momento de la noche. 
Asumí que el recital arranca con 0 personas.
-}
maxGente :: Seq s => s Int -> Int
maxGente s =  let
                s_info     = mapS (\i -> if i == 1 then (1, True) else (0,False)) s
                (s_red, r) = scanS (\(sL, bL) (sR, bR) -> if bR then (sL+sR, bL && bR) else (sR, bR)) (0, True) s_info
                s_res      = mapS fst (appendS s_red (singletonS r))
              in
                reduceS max 0 s_res

maxGanancia :: Seq s => s Int -> Int
maxGanancia s = let
                  (s_min, r) = scanS min maxBound s
                  s_info     = appendS s_min (singletonS r)
                  s_resta    = tabulateS (\i -> if i == 0 then 0 else nthS s i - nthS s_info i) (lengthS s) `asTypeOf` s
                in
                  reduceS max 0 s_resta





mscml' :: Seq s => s Int -> Int
mscml' s 
    | lengthS s == 0 = 0
    | lengthS s == 1 = 1
    | otherwise      = 
        let
            -- 1. Mapeamos a (EsNuevo, 1) mirando hacia atrás.
            -- El asTypeOf asegura que Haskell sepa que es una Seq (Bool, Int)
            s_flags = tabulateS (\i -> 
                            if i == 0 then (True, 1)
                            else if nthS s i /= nthS s (i-1) then (True, 1)
                            else (False, 1)
                         ) (lengthS s) `asTypeOf` mapS (\_ -> (True, 1)) s
            
            -- 2. El operador mágico asociativo del Segmented Scan
            combine (b1, v1) (b2, v2) = (b1 || b2, if b2 then v2 else v1 + v2)
            
            -- 3. Hacemos el scan exclusivo con la identidad (False, 0)
            (s_scan, r) = scanS combine (False, 0) s_flags
            
            -- 4. Pegamos el total final al historial (como hicimos en 'alarma')
            s_info = appendS s_scan (singletonS r)
            
            -- 5. Extraemos los contadores y buscamos al campeón
            s_counts = mapS snd s_info `asTypeOf` s
        in
            reduceS max 0 s_counts


{-
prueba [7,6,5,4,6,8] = 4
[(-1,0,-1,0), (-1,1,-1,1), (-1,2,-1,2) (2, 3, 2, 3), (2,4,2,4)]
[(-1,0,)]
-}

prueba :: Seq s => s Int -> Int
prueba s  | lengthS s == 0 = 0
          | lengthS s == 1 = 1
          | otherwise      =
            let
              s_intervalo = tabulateS (\i -> (nthS s (i+1) - nthS s i, i, nthS s (i+1) - nthS s i, i)) (lengthS s-1) `asTypeOf` mapS undefined s
              compare (l1, i, r1, j) (l2, k, r2, l) =
                if r1 == l2 && j == k-1 then (l1, i, r2, l) else (l2, k, r2, l)
              (s_info, r) = scanS compare (0,-2,0,-2) s_intervalo
              s_res = mapS (\(l1, i, r1, j) -> j-i+1) (appendS (dropS s_info 1) (singletonS r))
            in
              1 + reduceS max 0 s_res

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


descomprimir :: Seq s => s Int -> s Int
descomprimir s = let
                    s_secuencias = mapS (\x -> tabulateS (const x) x `asTypeOf` s) s
                 in
                    colapsar s_secuencias
colapsar :: Seq s => s (s Int) -> s Int
colapsar seqs 
        | lengthS seqs == 0 = tabulateS id 0     -- Caso base: vacío
        | lengthS seqs == 1 = nthS seqs 0        -- Caso base: 1 solo elemento
        | otherwise = let
                        -- Partimos a la mitad exacta
                        mitad = lengthS seqs `div` 2
                        izq = takeS seqs mitad 
                        der = dropS seqs mitad 
                      in
                        -- Unimos las mitades resueltas recursivamente
                        appendS (colapsar izq) (colapsar der)



diasDerrumbe :: Seq s => s Float -> s Int
diasDerrumbe s =  let
                    s_idx = tabulateS id (lengthS s) `asTypeOf` mapS undefined s
                    s_info = tabulateS (\i -> if i == 0 then False else nthS s i < (nthS s (i-1) / 2.0)) (lengthS s) `asTypeOf` mapS undefined s
                  in
                    filterS (\i -> nthS s_info i == True) s_idx

rachaCrecimiento :: Seq s => s Int -> Int
rachaCrecimiento s  
  | lengthS s == 0 = 0
  | otherwise = let
                  s_info = tabulateS (\i -> (nthS s i , i, nthS s i , i)) (lengthS s-1) `asTypeOf` mapS undefined s
                  compare (0, -2, 0, -2) t = t
                  compare t (0, -2, 0, -2) = t
                  compare (l1, i1, r1, j1) (l2, i2, r2, j2) =
                    if r1 < l2 && j1 == i2-1 then (l1, i1, r2, j2) else (l2, i2, r2, j2)
                  (s_red, r) = scanS compare (0, -2, 0, -2) s_info
                  s_app = appendS (dropS s_red 1) (singletonS r)
                  s_res = mapS (\(_,i,_,j) -> j-i+1) s_app
                in
                  reduceS max 0 s_res

rachaCrecimiento' :: Seq s => s Int -> Int
rachaCrecimiento' s | lengthS s == 0 = 0
                   | otherwise = racha_aux s
  where
    racha_aux s = let
                    s_info = mapS f s
                    (s_red, r) = scanS g (nthS s_info 0) (dropS s_info 1)
                    s_res = mapS h (appendS s_red (singletonS r))
                    
                    f = \v -> (v,v,1,1)
                    g = \(l1, r1, rc1, s1) (l2, r2, rc2, s2)-> (l1, r2, if r1 < l2 && rc2 == s2 then rc1 + rc2 else rc2, s1+s2)
                    h = \(_, _, rc, _) -> rc
                  in
                    reduceS max 0 s_res

peorGolpe :: Seq s => s Int -> Int
peorGolpe s
  | lengthS s == 0 = 0
  | otherwise = let
                    (s_sum, r_sum) = scanS (+) 0 s
                    s_info = appendS s_sum (singletonS r_sum)
                    (s_min, _) = scanS max 0 s_info
                    s_res = tabulateS (\i -> nthS s_min i - nthS s_info i) (lengthS s_info) `asTypeOf` mapS undefined s
                in
                    reduceS max 0 s_res
                    
                                