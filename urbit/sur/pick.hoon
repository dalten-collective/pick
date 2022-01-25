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
+$  msg
  $%  [%poll-new =poll]
      [%poll-edit =poll]
      [%pick =poll-id pick=@u]
      [%pick-reject =poll-id why=?(%invalid %unable %expired)]
      [%result =poll-id pick=(lest @u)]
      [%result-ack =poll-id]
      [%result-reject =poll-id why=?(%invalid %false %running)]
  ==
::
:: Defining polls
::
+$  poll-id     @uv
+$  opts        (map @u @t)
+$  picks       (jug @u ship) :: TODO change to signatures?
+$  pita        (map poll-id poll)
+$  able        (set ship)
+$  poll        $:  =poll-id  owner=ship  =picks
                    name=@t   =opts       open=@da    
                    stop=@da  =able
                ==
--
