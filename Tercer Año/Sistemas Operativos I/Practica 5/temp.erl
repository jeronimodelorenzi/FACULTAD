-module(temp).
-export([wait/1, cronometro/3]).
-export([fun/0]).

wait(N) ->
    receive
    after N ->
        chau
    end.

fun() -> io:fwrite("Hola~n").

cronometro(Fun, 0, Periodo)-> chau.
cronometro(Fun, Hasya, Periodo) ->
    Fun(),
    receive after Periodo ->
        cronometro(Fun, Hasta - Periodo, Periodo).



