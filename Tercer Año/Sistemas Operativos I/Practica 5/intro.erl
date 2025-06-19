-module(intro).
-export([init/0]).

match_test () ->
    {A,B} = {5,4},
    %{C,C} = {5,4},
    {B,A} = {4,5},
    {D,D} = {5,5}.

string_test () -> [
    helloworld == 'helloworld',
    "helloworld" < 'helloworld',
    helloworld == "helloworld",
    [$h,$e,$l,$l,$o,$w,$o,$r,$l,$d] == "helloworld",
    [104,101,108,108,111,119,111,114,108,100] < {104,101,108,108,111,119,111,114,108,100},
    [104,101,108,108,111,119,111,114,108,100] > 1,
    [104,101,108,108,111,119,111,114,108,100] == "helloworld"].

tuple_test (P1, P2) ->
    io:fwrite("El nombre de P1 es ~p y el apellido de P2 es ~p~n", [nombre(P1), apellido(P2)]).

apellido({persona, _, {apellido, Apellido}}) ->
        Apellido.
nombre({persona, {nombre, Nombre}, _}) ->
        Nombre.

filtrar_por_apellido(Personas, Apellido) ->
    [Nombre || {persona, {nombre, Nombre}, {apellido, Ap}} <- Personas, Ap == Apellido].
    

init() ->
    P1 = {persona, {nombre, "Juan"}, {apellido, "Gomez"}},
    P2 = {persona, {nombre, "Carlos"}, {apellido, "Garcia"}},
    P3 = {persona, {nombre, "Javier"}, {apellido, "Garcia"}},
    P4 = {persona, {nombre, "Rolando"}, {apellido, "Garcia"}},
    match_test(),
    tuple_test(P1, P2),
    string_test(),
    Garcias = filtrar_por_apellido([P4, P3, P2, P1], "Garcia"),
    io:format("Garcias: ~p~n", [Garcias]),
    ok.

% Justifique cu´ales match de la funci´on match_test deber´ıan ser v´alidos y cu´ales no

% {A,B} = {5,4} al no estar inicializados, A = 5 y B = 4.
% {C,C} = {5,4} no matchea ya que como no esta inicializado, C = 5, luego compara si C == 4.
% {B,A} = {4,5} matchea ya que antes se inicializan, B == 4 y A == 5.
% {D,D} = {5,5} matchea ya que D = 5 y luego D == 5.

% Explique el resultado de cada una de las comparaciones de la funci´on string_test/0.

% helloworld == 'helloworld' devuelve true debido a que ambos son el mismo atomo.
% "helloworld" < 'helloworld' devuelve true debido a que la lista que forma el string "helloworld"
%                             es menor que un atomo en Erlang.
% helloworld == "helloworld" devuelve false debido a que helloworld es un atomo y "helloworld" un string.
% [$h,$e,$l,$l,$o,$w,$o,$r,$l,$d] == "helloworld" devuelve true dendo a que la lista es la notación
% de caracteres del string.
% [104,101,108,108,111,119,111,114,108,100] < {104,101,108,108,111,119,111,114,108,100},
% devuelve true debido a que las listas son menores a las tuplas en Erlang
% [104,101,108,108,111,119,111,114,108,100] > 1 devuelve true debido que la lista es mayor que los enteros
% en Erlang
% [104,101,108,108,111,119,111,114,108,100] == "helloworld" devuelve true debido que los números
% representan los caracteres de "helloworld"

