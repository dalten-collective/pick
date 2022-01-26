::  pick Structures - ~dalten Collective
::
|%
::
:: Manage your polls:
::
+$  cmd
  $%  [%create name=@t =opts open=@da stop=@da =able]
      [%pick =poll-id pick=@u]
      [%collate =poll-id]
      [%delete =poll-id]
  ==
::
:: Manage interstellar activity
::
++  msg
  |%
  +$  poke
    $%  [%new-poll =poll]
        [%pick =poll-id pick=@u]
    ==
  +$  fact
    $%  [%result =poll-id pick=(lest @u)]
    ==
  --
::
:: Defining polls
::
+$  poll-id     @uv
+$  opts        (map @u @t)
+$  picks       (jug @u ship)
+$  pita        (map poll-id [host=ship =poll])
+$  able        (set ship)
+$  poll        $:  =poll-id  =picks   :: host=ship
                    name=@t   =opts    open=@da    
                    stop=@da  =able
                ==
--
