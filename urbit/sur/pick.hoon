::  pick Structures - ~dalten Collective
::
/-  *ring
::
|%
::
:: Manage your polls:
::
+$  cmd
  $%  [%create name=@t opts=(set pick) open=@da stop=@dr =able]
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
        [%new-pick =poll-id =voat]
    ==
  +$  fact
    $%  [%result =tale =fate]
    ==
  --
::
:: defining polls
::
::  poll > created using [%create name=@t =(set pick) open=@da stop=@dr =able]
::  - poll-id > a unique id and the linkage scope for the ring signature.
::    it's generated using the command you pass in and some entropy
::  - host > the host of the vote
::  - tale > a list of voats.
::  - fate > a jar of pick tale, or the individual tallies w/ their validation
::  - pick > an option for which the voter can cast their ballot
::  - name > a human-legible identifier for the vote TODO: include details
::  - open > when the poll doors open and
::  - stop > when the polls close, relative to the start
::  - able > specifies the users allowed to participate
::  - pkey > the public keys of all the able, per the host
+$  poll        $:  =poll-id  host=ship  =tale   =fate
                    name=@t   opts=(set @t) 
                    open=@da  stop=@dr  =pkey
                ==
::
+$  able        (set ship)
+$  poll-id     @uv
+$  pick        @t
+$  fate        (jar pick voat)
+$  tale        (list voat)
+$  pkey        (set @udpoint)
+$  voat        [=pick =slip]
::
::  state objects
::  - peck > votes you're participating in
::  - cast > private and temporary record of votes you cast
++  zero
  |%
  +$  state       [=peck =cast =lies]
  +$  peck        (map poll-id poll)
  +$  cast        (map poll-id voat)
  +$  lies        (map poll-id poll)
  --
::
::  buried deep beneath is a type for handling *gasp*
::  voter ids
::
+$  evil          (map ship ?(%alien %known))
+$  rotn          ship-state:ames
+$  slip          raw-ring-signature
--
