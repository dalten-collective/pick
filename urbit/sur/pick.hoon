::  pick Structures - ~dalten Collective
::
|%
::
:: Manage your votes:
::
+$  cmd
  $%  [%newvote name=@t =opts open=@da stop=@da =able]
      [%pick =vote-id opt=@u]
      [%collate =vote-id]
      [%delete =vote-id]
  ==
::
:: Manage interstellar activity
::
+$  msg
  $%  [%vote-receive =vote]
      [%vote-reject =vote-id]
      [%pick =vote-id pick=@u]
      [%pick-ack =vote-id]
      [%pick-reject =vote-id why=?(%invalid %unable %expired)]
      [%result =vote-id pick=(lest @u)]
      [%result-ack =vote-id]
      [%result-reject =vote-id why=?(%invalid %false %running)]
  ==
::
:: Defining votes
::
+$  vote-id      @uv
+$  opts         (map @u @t)
+$  pita         (map vote-id vote)
+$  able         (list ship)
+$  vote         $:  name=@t   =opts
                     open=@da  stop=@da  =able
                 ==
--
