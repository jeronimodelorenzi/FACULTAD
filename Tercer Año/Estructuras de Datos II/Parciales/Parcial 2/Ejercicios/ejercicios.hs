import Seq
import Par
import ListSeq

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
                s_eq    = tabulateS (\i -> if nthS s i == nthS s (i+1) 
                                            then 
                                                (1,1,1,1) 
                                            else 
                                                (0,0,0,1)) (lengthS s - 1) `asTypeOf` mapS undefined s
                val     = (0, 0, 0, 0)
                combine (maxL, prefL, sufL, lL) (maxR, prefR, sufR, lR) =
                    let
                        pref = if prefL == lL then prefL + prefR else prefL
                        suf  = if sufR == lR then sufR + sufL else sufR
                        l    = lL + lR
                        maxT = max maxL (max maxR (sufL+prefR))
                    in
                        (maxT, pref, suf, l)
                (s_res, _, _, _)   = reduceS combine val s_eq
            in
                s_res+1

        