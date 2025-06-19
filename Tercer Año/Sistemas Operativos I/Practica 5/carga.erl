-module(carga).
-export([bal/1, servidor/0, cliente/2, start/0]).

bal(Servs) ->
  receive 
    {req, Arg, Pid} ->
      Ref = make_ref(),
      Proc = lists:nth(rand:uniform(length(Servs)), Servs),
      Proc ! {req, Arg, self(), Ref},
      receive
        {reply, Ref, Response} ->
          Pid ! {reply, Response}
      end
  end,
  bal(Servs).

servidor() ->
  receive
    {req, Arg, FromPid, Ref} ->
        Result = Arg * 2,
        timer:sleep(500),
        FromPid ! {reply, Ref, Result}
  end,
  servidor().

cliente(BalPid, Valor) ->
  BalPid ! {req, Valor, self()},
  receive
    {reply, Resp} ->
        io:fwrite("Cliente recibio; ~p~n", [Resp])
  end.

start() ->
  S1 = spawn(fun servidor/0),
  S2 = spawn(fun servidor/0),
  S3 = spawn(fun servidor/0),

  Servidores = [S1, S2, S3],

  Bal = spawn(fun() -> bal(Servidores) end),

  spawn(fun() -> cliente(Bal, 5) end),
  spawn(fun() -> cliente(Bal, 10) end),
  spawn(fun() -> cliente(Bal, 7) end),
  ok.
