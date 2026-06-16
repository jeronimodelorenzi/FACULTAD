{- HLINT ignore "Use tuple-section" -}
module Practica where

import Seq
import ListSeq
import Par

{-
1) Usando la función scan y otras funciones del TAD Secuencias, definir las siguientes funciones:
-}

--a) promedios : Seq Int -> Seq Float, que dada una secuencia de enteros calcule el promedio de 
--cada comienzo de la lista. Por ejemplo, promedio <2,4,3,7,9> = <2,3,3,4,5>.
promedios :: Seq s => s Int -> s Float
promedios s =   let
                    (sum, v) = scanS (+) 0 s
                in
                    tabulateS (\i -> fromIntegral (if i < (lengthS s)-1 
                                                                then nthS sum (i+1) 
                                                                else v) / fromIntegral (i+1))
                    (lengthS s)

-- b) mayores : Seq Int -> Int, que dada una secuencia de eneteros devuelva la cantidad de enteros
-- de la secuencia que son mayores a todos los anteriores. Por ejemplo, mayores <1,2,5,3,5,2,7,9> = 4.
mayores :: Seq s => s Int -> Int
mayores s =     let
                    (maximos, _)        = scanS max minBound s
                    esMaximo            = (tabulateS (\i -> if  nthS s i > nthS maximos i then 1 else 0) (lengthS s) `asTypeOf` s)
                    esMaximoSinNeutro   = dropS esMaximo 1
                in
                    reduceS (+) 0 esMaximoSinNeutro

{-
2) Los números de Fibbonacci son una secuencia de enteros dados por la siguiente recurrencia
F_(-1) = 1, F_0 = 0, F_1 = 1, F_n = F_(n-1) + F_(n-2)
Usando esta definición es posible probar por inducción la siguiente propiedad:
(1 1 1 0)^n = (F_(n+1) F_n F_n F_(n-1))
Dar una definición de la función fibSeq : Nat -> Seq Nat, que dado un natural n calcule la secuencia
de los primeros n números de Fibonacci, cuyo trabajo y profundidad sean W(n) = n y lg(n). Utilizar la función scan.
-}
type Nat = Int
fibSeq :: Seq s => Nat -> s Nat
fibSeq n =  let
                identidad               = (1,0,0,1)
                matrizFib               = (1,1,1,0)
                seqMatrizFib            = tabulateS (\_ -> matrizFib) n 
                (seqMatrizFibScan, _)   = scanS multMatriz identidad seqMatrizFib
            in
                mapS (\(_,f_n, _, _ ) -> f_n) seqMatrizFibScan
                
                    where
                        multMatriz :: (Nat,Nat,Nat,Nat) -> (Nat,Nat,Nat,Nat) -> (Nat,Nat,Nat,Nat)
                        multMatriz (a1,a2,a3,a4) (b1,b2,b3,b4) = (a1*b1 + a2*b3, a1*b2 + a2*b4,
                                                                  a3*b1 + a4*b3, a3*b2 + a4*b4)

{-
3) Considerar el siguiente problema: si se vierte agua sobre un histograma, ¿cuánta agua (en términos del área)
queda almacenada sobre el mismo? VER DIBUJO.
El problema puede resolverse calculando la cantidad de agua que queda almacenada sobre cada barra del histograma.
Por ejemplo, para una barra b_i la cantidad de agua que se acumula sobre esta es igual al maximo entre 0 y
min(maxL, maxR)- altura(b_i) donde maxL es valor máximo entre las alturas de las barras que están a la izquierda
de b_i y maxR es el valor máximo entre las alturas de las barras que están a la derecha de b_i.
Definir una función aguaHist que dada una secuencia de enteros (que represente un histograma) devuelva la cantidad
de agua almacenada, utilizando las funciones scan y reduce.
-}
aguaHist :: Seq s => s Int -> Int
aguaHist s =    let
                    (maxL, _)    = scanS max 0 s
                    (maxR, _)    = scanS max 0 (reverseS s)
                    maxRReverse  = reverseS maxR
                    agua         = (tabulateS (\i -> let aguaAux = min(nthS maxL i) (nthS maxRReverse i) - nthS s i
                                            in max 0 aguaAux) (lengthS s) `asTypeOf` s)
                in
                    reduceS (+) 0 agua
                        where
                            reverseS sec = (tabulateS (\i -> nthS sec (lengthS sec  - i - 1)) (lengthS sec) `asTypeOf` sec)

{-
4) El problema de determinar si en una expresión los paréntesis están bien anidados (todo paréntesis que se abre se cierra,
y en ningún prefijo hay más cerrados que abiertos), puede resolverse utilizando una función matchParen : Seq Paren -> Bool,
que dada una secuencia del tipo:
-}
data Paren = Open | Close deriving (Show, Eq)
{-
(que representa los caracteres '(' y ')'), devuelva True si la secuencia contiene la misma cantidad de valores Open que Close
y además cada prefijo de la secuencia no contiene menos valores Open que Close, y False en caso contrario.
-}

-- a) Dar una definición de matchParen que implemente un algoritmo 'Divide & Conquer'. La función showT del TAD de secuencias
-- puede ser de utilidad para dividir una secuencia en dos.
matchParen :: Seq s => s Paren -> Bool
matchParen s = matchP s == (0,0)
    where
        matchP :: Seq s => s Paren -> (Int, Int)
        matchP sec = case showtS sec of
                        EMPTY       -> (0,0)
                        ELT Open    -> (0,1)
                        ELT Close   -> (1,0)
                        NODE l r    ->
                            let
                                (il, jl) = matchP l
                                (ir, jr) = matchP r
                                match    = min jl ir
                                i        = il + ir - match       
                                j        = jl + jr - match
                            in
                                (i,j)

-- b) Dar una definición de matchParen que utilice la función scan. Comparar los costos (trabajo y profundidad) de las dos versiones.
matchParenScan :: Seq s => s Paren -> Bool
matchParenScan s =  let 
                        (pasos, tot) = scanS (+) 0 (mapS (\i -> case i of Open -> 1; Close -> -1) s)
                        isNeg = reduceS min 0 pasos
                    in
                        tot == 0 && isNeg >= 0

{-
5) Dada una secuencia de enteros, el problema conocido como 'la subsecuencia contigua creciente más larga0 consiste en encontrar
la cantidad mayor de crecimientos contiguos en una secuencia.
sccml <9, 3, 5, 1, 3, 4, 5, 6, 8, 1> = 5
sccml <5, 6, 2, 3, 5, 1, 9>          = 2
sccml <1, 4, 6, 7, 8, 11, 12, 3>     = 6
-}

-- a) Definir una función sccml : Seq Int -> Int , que resuelva el problema utilizando un algoritmo de 'Divide & Conquer'.
sccml :: Seq s => s Int -> Int
sccml s = let (maxTotal, _, _, _, _) = sccmlAux s in maxTotal
    where
        sccmlAux :: Seq s => s Int -> (Int, Int, Int, Int, Int)
        sccmlAux s = case showtS s of
                        EMPTY    -> (0, 0, 0, 0, 0)
                        ELT v    -> (0, 0, 0, v, v)
                        NODE l r ->
                            let 
                                (maxL, prefL, sufL, priValL, ultValL) = sccmlAux l
                                (maxR, prefR, sufR, priValR, ultValR) = sccmlAux r
                                mid  = if ultValL < priValR then 1 else 0
                                pref = if prefL == (lengthS l-1) && ultValL < priValR then prefL + mid + prefR else prefL
                                suf  = if sufR == (lengthS r-1) && ultValL < priValR then sufL + mid + sufR else sufR
                                maxP = maximum [maxL, maxR, sufL + mid + prefR]
                            in
                                (maxP, pref, suf, priValL, ultValR)

-- b) Dar otra definición de la función sccml, utilizando la función scan.
sccmlScan :: Seq s => s Int -> Int
sccmlScan s =   let
                    sCrec = tabulateS (\i -> if nthS s i < nthS s (i+1) then (1,1,1,1) else (0,0,0,1)) (lengthS s-1) `asTypeOf` mapS (\_ -> val) s
                    val = (0, 0, 0, 0)
                    combine (max1, pref1, suf1, l1) (max2, pref2, suf2, l2) =
                        let
                            pref = if pref1 ==l1 then pref1+pref2 else pref1
                            suf  = if suf2 == l2 then suf2 + suf1 else suf2
                            maxT = max max1 (max max2 (suf1 + pref2))
                            len = l1 + l2
                        in
                            (maxT, pref, suf, len)
                    (_, (maxTotal, _, _, _)) = scanS combine val sCrec
                in
                    maxTotal

sccmlScan' :: Seq s => s Int -> Int
sccmlScan' s = let
                    s_info      = tabulateS (\i -> if nthS s i < nthS s (i+1) then (1, True) else (0,False)) (lengthS s -1) `asTypeOf` mapS (\_ -> (0,False)) s
                    (s_red, r)  = scanS (\(sL, bL) (sR, bR) -> if bR then (sL + sR, bL && bR) else (sR, False)) (0,True) s_info
                    s_res       = mapS (\(i, _) -> i) (appendS s_red (singletonS r))
                in
                    reduceS max 0 s_res


                    
{-
5) Dada una secuencia de enteros s, se desea determinar el tamaño del siguiente conjunto:
multiplos(s) = {(i,j) | 0 <= i < j < |s|, mod(s_i, s_j) == 0}
Por ejemplo, multiplos (<12,4,6,3,2>) tiene tamaño 7, multiplos (<4,6,2>) 2 y ,multiplos (<1,2,3,4,5>) 0.
Dar una definición de la función cantMultiplos : s Int -> Int, que dada una secuencia s calcule el tamaño de
Multiplos (s), en término de operaciones paralelizables, como por ejemplo map y reduce.
-}
cantMultiplos :: Seq s => s Int -> Int
cantMultiplos s =   let
                        seqIsMult = tabulateS (\i -> let
                                                        seqSinI     = dropS s (i+1)
                                                        multiplos   = mapS (\j -> 
                                                                                if nthS s i `mod` j == 0 
                                                                                    then 1 else 0) seqSinI
                                                    in  
                                                        reduceS (+) 0 multiplos) (lengthS s) `asTypeOf` s
                    in
                        reduceS (+) 0 seqIsMult

{-
7) Definir las siguientes operaciones que permiten extender el TAD Secuencias.
-}

-- a) merge : (a -> a -> Ordering) -> Seq a -> Seq a -> Seq a, que dadas una relación de orden y dos secuencias
-- ordenadas (respecto a esta relación) s_1 y s_2, construye una secuencia ordenada con los elementos de s_1 y s_2-
-- Definir la función utilizando un algoritmo 'Divide & Conquer'
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

-- b) sort : (a -> a -> Ordering) -> Seq a -> Seq a, que ordena una secuencia según una relación de orden dada.
sortS :: Seq s => (a -> a -> Ordering) -> s a -> s a
sortS cmp s = case showtS s of
                    EMPTY       -> s
                    ELT x       -> s
                    NODE l r    ->  let
                                        sortL = sortS cmp l
                                        sortR = sortS cmp r
                                    in
                                        mergeS cmp sortL sortR

-- c) maxE : (a -> a -> Ordering) -> Seq a -> a, que devuelve el máximo de una secuencia.
maxE :: Seq s => (a -> a -> Ordering) -> s a -> a
maxE cmp s =   let 
                    maxCmp x y = if cmp x y == GT then x else y
                in
                    reduceS maxCmp (nthS s 0) s

-- d) maxS : (a -> a -> Ordering) -> Seq a -> Nat, que devuelve el índice de un máximo en la secuencia.
maxS :: Seq s => (a -> a -> Ordering) -> s a -> Int
maxS cmp s =    let 
                    valorIndice     = tabulateS (\i -> (nthS s i, i)) (lengthS s) `asTypeOf` mapS (\x -> (x, 0::Int)) s
                    maxCmp (x1, i1) (x2, i2) = if cmp x1 x2 == GT then (x1,i1) else (x2,i2) 
                    (maxV, maxI)    = reduceS maxCmp (nthS valorIndice 0) valorIndice
                in
                    maxI

-- e) group : (a -> a -> Ordering) -> Seq a -> Seq a, que dada una secuencia agrupa los elementos iguales contiguos.
-- Por ejemplo, group <1,1,2,3,4,4,2,2> = <1,2,3,4,2>
groupS :: Seq s => (a -> a -> Ordering) -> s a -> s a
groupS cmp s =  let
                    indices     = tabulateS id (lengthS s)
                    filtrado    = filterS (\i -> i == 0 || cmp (nthS s i) (nthS s (i-1)) /= EQ) indices
                in
                    mapS (\i -> nthS s i) filtrado

-- f) collect : Seq (a,b) -> Seq (a, Seq b), que recolecta todos los datos asociados a cada clave y devuelve una
-- secuencia de pares ordenada segun el primer elemento. Por ejemplo,
-- collect <(2,"A"), (1, "B"), (1, "C"), (2, "D")> = <(1, <"B", "C">), (2, <"A", "D">)>
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
8) Una universidad cuenta con una base de datos de los estudiantes que rindieron los exámenes de ingrreso y las notas de las evaluaciones realizadas.
Un estudiante ingresa a la universidad si e promedio de los resultados de los exámenes es mayor o igual a 70 y quedará en lista de espera si el promedio
es mayor a 50 y menor a 70. Se desea saber cuantos estudiantes aprobaron el ingreso, cuantos quedaron en lista de espera y cuantos no podrían ingresar a
la universidad, junto con las notas máxima de cada uno de los 3 casos.

Definir una función datosIngreso : Seq (String, Seq Int) -> Seq (Int, Int) que dada una secuencia con los nombres de los estudiantes y las notas de los exámenes,
calcule los datos necesarios (cantidad de alumnos, nota máxima) de los exámenes de ingreso. Definirla en términos de mapCollectReduce
-}
datosIngreso :: Seq s => s (String, s Int) -> s (Int, Int)
datosIngreso s =    let
                        mapeoAlumnos = mapS mapAlumno s
                        alumnosAgrupados = collectS mapeoAlumnos
                    in
                        mapS mapGrupo alumnosAgrupados 
                            where
                                mapAlumno :: Seq s => (String, s Int) -> (Int, Int)
                                mapAlumno (nombre, notas) = let
                                                    promedio    = fromIntegral (reduceS (+) 0 notas) / fromIntegral(lengthS notas)
                                                    maxNota     = maxE compare notas
                                                    categoria   = if promedio >= 70 then 0
                                                                            else if promedio > 50 then 1
                                                                            else 2
                                                in
                                                    (categoria, maxNota)
                                
                                mapGrupo :: Seq s => (Int, s Int) -> (Int, Int)
                                mapGrupo (_, notasMax) =  let
                                                                n       = lengthS notasMax
                                                                notaMax = maxE compare notasMax
                                                            in
                                                                (n, notaMax)

{-
9)
-}

-- a) Definir una función countCaract : Seq (Seq Char) -> Seq (Char, Int) que dada una colección de textos calcule la cantidad
-- de veces con que aparecen los caracteres en los textos. Definirla en términos de mapCollectReduce.
countCaract :: Seq s => s (s Char) -> s (Char, Int)
countCaract s = let
                    seqAplanada = joinS s
                    letrasTupla = mapS (\i-> (i, 1)) seqAplanada
                    letrasGrupo = collectS letrasTupla
                    letrasTotal = mapS (\(letra, cant) -> (letra, reduceS (+) 0 cant)) letrasGrupo
                in
                    letrasTotal       
            
-- b) Definir una función huffman : Seq (Seq Char) -> Seq (Int Seq Char) que dada una colección de textos calcule las frecuencias
-- con que cada caracter aparece en los textos. La secuencia resultado debe contener pares de la forma (n, caracteres con frecuencia n).
-- y debe estar ordenada según la frecuencias de los caracteres. Utilizar las funciones countCaract, map y collect.
huffman :: Seq s => s (s Char) -> s (Int, s Char)
huffman s = let
                aparicionLetras = countCaract s
                swapTupla       = mapS (\(letra, cant) -> (cant, letra)) aparicionLetras
                frecuenciaLetra = collectS swapTupla
            in     
                frecuenciaLetra