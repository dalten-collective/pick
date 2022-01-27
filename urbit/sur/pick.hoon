::  pick Structures - ~dalten Collective
::
|%
::
:: Manage your polls:
::
+$  cmd
  $%  [%create name=@t =(set pick) open=@da stop=@da =able]
      [%pick =poll-id =pick]
      [%force-count =poll-id]
      [%delete =poll-id]
  ==
::
:: Manage interstellar activity
::
++  msg
  |%
  +$  poke
    $%  [%new-poll =poll]
        [%pick =poll-id =pick =tell]
    ==
  +$  fact
    $%  [%result =tale =fate]
    ==
  --
::
:: Defining polls
::
+$  poll-id     @uv
+$  tell        @uv  :: hash for verification
+$  pick        @t
+$  pita        (map poll-id [host=ship =poll])
+$  able        (set ship)
+$  tale        (jar pick tell)
+$  fate        (list [@u (list pick)])
+$  poll        $:  =poll-id  =tale
                    name=@t   opts=(set pick)    open=@da    
                    stop=@da  =able
                ==
--
