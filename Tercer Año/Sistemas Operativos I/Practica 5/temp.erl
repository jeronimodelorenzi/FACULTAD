-module(temp).
-export([wait/1, cronometro/3]).
-export([saludo/0]).

wait(N) ->
  receive
  after N ->
    chau
  end.

saludo() -> io:fwrite("Hola~n").

cronometro(_Fun, Hasta, _Periodo) when Hasta =< 0 -> chau;
cronometro(Fun, Hasta, Periodo) ->
  Fun(),
    receive after Periodo ->
      cronometro(Fun, Hasta - Periodo, Periodo)
    end.



