-module(mailbox).
-export([sleep/1, empty_mailbox/0, priority_process/0]).

sleep(N) ->
  receive 
    %%
  after 
    N -> ok
  end.

priority_process() ->
  receive
    msg1 -> 
      io:fwrite("Recibido msg1~n"),
      priority_process()
  after
    0 -> 
      receive
        msg2 -> 
          io:fwrite("Recibido msg2~n"),
          priority_process()
      after
        0->
          no_msg
      end
  end.

empty_mailbox() ->
  receive
    _MsgCu -> empty_mailbox()
  after 0 ->
    ok
  end. 

      