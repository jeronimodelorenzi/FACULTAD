-module(contador).
-export([iniciar/0, terminar/1]).
-export([incrementar/1, decrementar/1, valor/1, loop/1]).

iniciar() ->
  spawn(contador, loop, [0]).

terminar(Contador) ->
  Contador ! fin.

incrementar(Contador) ->
  Contador ! inc.

decrementar(Contador) ->
  Contador ! dec.

valor(Contador) ->
  Contador ! {val, self()},
  receive
    N -> N
  end.

loop(N) ->
  receive
    fin -> ok;
    inc -> loop(N+1);
    dec -> loop(N-1);
    {val, Pid} -> Pid ! N, loop(N)
  end.
