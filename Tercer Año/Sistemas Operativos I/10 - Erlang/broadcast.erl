-module(broadcast).
-export([iniciar/0, terminar/0]).
-export([broadcast/1, registrar/0]).
-export([loopBroadcast/2]).

iniciar() ->
  Broadcast = spawn(?MODULE, loopBroadcast, [[], self()]),
  register(broadcast, Broadcast),
  ack().

ack() ->
  receive
    serverOk ->
      ok;
    serverErr ->
      err
  end.

terminar() ->
  broadcast ! {fin, self()},
  unregister(broadcast),
  ack().

broadcast(Msg) ->
  broadcast ! {env, self(), Msg},
  ack().

registrar() ->
  broadcast ! {reg, self()},
  ack().

loopBroadcast(St) ->
  receive
    {fin, Pid} ->
      Pid ! serverOk, 
      ok;
    {env, Pid, Msg} ->
      list:foreach(fun (X) -> X ! Msg end, St),
      Pid ! serverOk,
      loopBroadcast(St);
    {reg, Pid} ->
      Pid ! serverOk,
      loopBroadcast([Pid | St])
  end.
loopBroadcast(St, Pid) ->
  Pid ! serverOK,
  loopBroadcast(St).
      