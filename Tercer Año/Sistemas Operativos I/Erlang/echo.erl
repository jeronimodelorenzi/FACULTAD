-module(echo).
-define(Puerto, 1234).
-define(Timeout, 5000).
-export([iniciar/0, fin/1, receptor/1, echo_resp/1]).

iniciar() ->
  {ok, Socket} = gen_tcp:listen(?Puerto, [binary, {active, false}]),
  spawn(?MODULE, receptor, [Socket]),
  Socket.

fin(Socket) ->
  gen_tcp:close(Socket),
  fin.

receptor(Socket) ->
  case gen_tcp:accept(Socket) of
    {ok, CSocket} ->
      spawn(?MODULE, echo_resp, [CSocket]);
    {error, closed} ->
      io:format("Se cerro el closed~n"),
      exit(normal);
    {error, Reason} ->
      io:format("Fallo la espera del cliente por ~p~n", [Reason])
    end,
  receptor(Socket).

echo_resp(Socket) ->
  case gen_tcp:recv(Socket, 0, ?Timeout) of
    {ok, Paquete} ->
      io:format("Me llego ~p~n", [Paquete]),
      gen_tcp:send(Socket, Paquete),
      echo_resp(Socket);
    {error, timeout} ->
      io:format("No se recibio un mensaje por 5 segundos"),
      get_tcp:close(Socket);
    {error, closed} ->
        io:format("El cliente cerro la conexion~n")
  end.