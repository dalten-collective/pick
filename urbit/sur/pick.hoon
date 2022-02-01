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
        [%new-pick =poll-id =pick =seal]
    ==
  +$  fact
    $%  [%result =tale =fate]
    ==
  --
::
:: Defining polls
::
+$  poll-id     @uv
+$  pick        @t
+$  seal        @ux
+$  pita        (map poll-id [host=ship =poll])
+$  able        (set ship)
+$  tale        (jug pick [=ship =seal])
+$  fate        (list [@u (list pick)])
+$  poll        $:  =poll-id  =tale  fate=(unit fate)
                    name=@t   opts=(set pick)    open=@da
                    stop=@da  =able
                ==
--
