-module(iter).

-export([start/2]).

start(PidS, PidP) ->
  % io:fwrite("Iter: linking ~p~n", [PidP]),
  % Link = link(PidP),
  % io:fwrite("Iter: linked ~p: ~p~n", [PidP, Link]),
  io:fwrite("Iter: monitoring ~p~n", [PidP]),
  Mon = monitor(process, PidP),
  io:fwrite("Iter: monitored ~p: ~p~n", [PidP, Link]),
  loop(PidS, PidP).

loop(PidS, PidP) ->
  io:fwrite("Iter: receiving~n"),
  receive
    M -> io:fwrite("Iter: received ~p~n", [M])
  after
    100 -> io:fwrite("Iter: receive timeout~n", [])
  end,
  io:fwrite("Iter: calling server ~p on ~p~n", [PidS, PidP]),
  Res = gen_server:call(PidS, PidP),
  io:fwrite("Iter: got ~p~n", [Res]),
  start(PidS, PidP).
