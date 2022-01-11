::  pick Structures - ~dalten Collective
::
|%
::
:: Manage your polls:
::
+$  cmd
  $%  [%create name=@t =opts open=@da stop=@da =able]
      [%pick =poll-id opt=@u]
      [%collate =poll-id]
      [%delete =poll-id]
  ==
::
:: Manage interstellar activity
::
+$  msg
  $%  [%poll-new =poll]
      [%poll-reject =poll-id why=?(%invalid %running %unwanted)]
      [%pick =poll-id pick=@u]
      [%pick-ack =poll-id]
      [%pick-reject =poll-id why=?(%invalid %unable %expired)]
      [%result =poll-id pick=(lest @u)]
      [%result-ack =poll-id]
      [%result-reject =poll-id why=?(%invalid %false %running)]
  ==
::
:: Defining polls
::
+$  poll-id      @uv
+$  opts         (map @u @t)
+$  pita         (map poll-id poll)
+$  able         (list ship)
+$  poll         $:  =poll-id  name=@t   =opts
                     open=@da  stop=@da  =able
                 ==
--
