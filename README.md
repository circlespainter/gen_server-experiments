# `gen_server` experiments

Experiments about `gen_server:call`, process linking and process monitoring.

The process arrangement is:

- The `Main` process spawns a new process `P`, `start_link`s a server `Server` and spawns a process `Iter`, then it starts an infinite receive-print loop.
- `P` immediately starts an infinite receive-print loop.
- `Iter` either links or monitors `P` (choose by reviewing commented code in `iter.erl`) and then starts a receive-call loop.
- `Server`, upon call, kills `P`, sleep some rather long time and then either reply or die (choose by reviewing commented code in `server.erl`).

The main focus is about which signals, messages and/or return values `Iter` receives while in `call` because of the death of linked/monitored `P`.

Findings are:

- If monitoring, Erlang/OTP delays reception of `P`'s `DOWN` by `Iter` until `call` completes.
  - If `Server` dies instead of returning, `P` too dies while `call` is still in progress.
- If linking, `Iter` receive the termination signal due to `P`'s exit and dies while `call` is still in progress.

Elixir's behavior has been tested only in the monitoring case and it matches Erlang/OTP, it is expected to match also in the other cases.

## Getting started

Install Erlang/OTP 18+, then:

```
$ erl
# ...
erl> c(p). c(stack_server). c(iter). c(main). spawn(main, start, []).
```
