-module(serverID).
-include("/home/jeronimodelorenzi/Escritorio/FACULTAD/Tercer Año/Sistemas Operativos I/Erlang/serverID.hrl").

-export([iniciar/0, terminar/0]).
-export([server_init/1]).
-export([nuevo_nombre/1, quien_es/1, lista_id/0]).

iniciar() ->
  Pid = spawn(serverID, server_init, [self()]),
  receive
    ok -> register(servidorIds, Pid),
    ok
  end.

nuevo_nombre(Nombre) ->
  servidorIds ! {nuevoId, Nombre, self()},
  receive
    {ok, N} -> N;
    _ -> error
  end.

quien_es(Id) ->
  servidorIds ! {buscarId, Id, self()},
  receive
    {ok, N} -> N;
    _ -> error
  end.

lista_id() ->
  servidorIds ! {verLista, self()},
  receive
    {ok, List} -> List;
    _ -> error
  end.

terminar() ->
  servidorIds ! {fin, self()},
  unregister(servidorIds),
  receive
    ok -> ok;
    _ -> error
  end.

server_init(PInit) ->
  PInit ! ok,
  servidor_nombres(maps:new(), 0).

servidor_nombres(Map, N) ->
  receive
    #nuevoId{nombre = Nombre, cid = CId} ->
      NId = N+1,
      CId ! {ok, NId},
      servidor_nombres(maps:put(NId, Nombre, Map), NId);
    {buscarId, NId, CId} ->
      case maps:find(NId, Map) of
        {ok, Nombre} -> CId ! {ok, Nombre};
        error -> CId ! {error, notfound}
      end,
      servidor_nombres(Map, N);
    {verLista, CId} ->
      CId ! {ok, maps:to_list(Map)},
      servidor_nombres(Map, N);
    {fin, CId} ->
      CId ! ok;
    _ -> io:fwrite("Otras cosas~n")
  end.
