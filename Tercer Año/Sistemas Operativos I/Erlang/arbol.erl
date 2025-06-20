-module(arbol).
-export([crear/0]).

-record(abb, {valor, izq = nil, der, nil}).

crear() ->
  Hoja20 = #abb{valor = 20},
  Hoja40 = #abb{valor = 40},
  Hoja100 = #abb{valor = 100},

  Hoja30 = #abb{valor = 30, izq = Hoja20, der = Hoja40},
  Hoja90 = #abb{valor = 90, der = Hoja100},

  Arbol= #abb{valor = 50, izq = Hoja30, der= Hoja90},
  Arbol.