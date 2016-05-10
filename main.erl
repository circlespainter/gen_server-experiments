-module(main).

-export([start/0]).

start() ->
  io:fwrite("Main: spawning P", []),
  PidP = spawn(p, start, []),
  io:fwrite("Main: spawned P as ~p, sparting Server~n", [PidP]),
  {ok, PidS} = gen_server:start_link(stack_server, [], []),
  io:fwrite("Main: started Server as ~p, spawning Iter~n", [PidS]),
  Iter = spawn(iter, start, [PidS, PidP]),
  io:fwrite("Main: spawned Iter as ~p~n", [Iter]),
  rec().

rec() ->
  receive
    M ->
      io:fwrite("Main: received ~p~n", [M]),
      rec()
  end.
