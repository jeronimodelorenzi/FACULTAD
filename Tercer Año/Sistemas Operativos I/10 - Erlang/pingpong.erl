-module(pingpong).
-export([pong/0, ping/0, play/0]).

pong() ->
  receive
    {0, PidPing} ->
      io:fwrite("Final pong!~n"),
      PidPing ! {fin, self()};
    {fin, _} ->
      io:fwrite("Pong recv fin~n"),
      ok;
    {N, PidPing} ->
      io:fwrite("Pong! Recv: ~p~n", [N]),
      PidPing ! {(N-1), self()},
      pong()
  end.

ping() ->
  receive
    {0, PidPong} ->
      io:fwrite("Final ping!~n"),
      PidPong ! {fin, self()};
    {fin, _} ->
      io:fwrite("Ping recv fin~n"),
      ok;
    {N, PidPong} ->
      io:fwrite("Ping! Recv: ~p~n", [N]),
      PidPong ! {(N-1), self()},
      ping()
  end.

play() ->
  PidPong = spawn(pingpong, pong, []),
  PidPing = spawn(pingpong, ping, []),
  PidPing ! {10, PidPong},
  playok.