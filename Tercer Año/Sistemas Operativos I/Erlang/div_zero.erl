-module(div_zero).
-export([capzero/0, tira_error/0]).

tira_error() ->
  throw(mi_error).

capzero() ->
  try
    %R = A div B,
    %io:fwrite("Resultado: ~p~n", [R])
    tira_error()
  catch
    error:badarith ->
      io:fwrite("Excepcion division por cero~n");
    throw:mi_error ->
      io:fwrite("Excepcion mi_error~n")
  end.
   