-module(p).

-export([start/0]).

start() ->
  receive
    M ->
      io:fwrite("P: received ~p~n", [M]),
      start()
  end.
