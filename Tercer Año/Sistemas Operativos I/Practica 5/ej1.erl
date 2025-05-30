-module(intro).
-export([init/0]).
match_test () ->
    {A,B} = {5,4},
    {C,C} = {5,4},
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

apellido (P) ->

tuple_test (P1, P2) ->
    io:fwrite("El nombre de P1 es ~p y el apellido de P2 es ~p~n", [nombre(P1), apellido(P2)]).
    apellido (P) -> ok.
    nombre (P) -> ok.

filtrar_por_apellido(Personas, Apellido) -> ok.

init () ->
    P1 = {persona, {nombre, "Juan"}, {apellido, "Gomez"}},
    P2 = {persona, {nombre, "Carlos"}, {apellido, "Garcia"}},
    P3 = {persona, {nombre, "Javier"}, {apellido, "Garcia"}},
    P4 = {persona, {nombre, "Rolando"}, {apellido, "Garcia"}},
    match_test(),
    tuple_test(P1, P2),
    string_test(),
    Garcias = filtrar_por_apellido([P4, P3, P2, P1], "Garcia").

% Justifique cu´ales match de la funci´on match_test deber´ıan ser v´alidos y cu´ales no

% {A,B} = {5,4} al no estar inicializados, A = 5 y B = 4.
% {C,C} = {5,4} no matchea ya que como no esta inicializado, C = 5, luego compara si C == 4.
% {B,A} = {4,5} matchea ya que antes se inicializan, B == 4 y A == 5.
% {D,D} = {5,5} matchea ya que D = 5 y luego D == 5.

