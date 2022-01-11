/-  *pick
/+  default-agent, dbug
::
|%
+$  versioned-state
    $%  state-zero
    ==
::
+$  state-zero
    $:  %0
        =pita
    ==
::
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-zero
=*  state  -
^-  agent:gall
=<
::
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    hc    ~(. +> bowl)
::
++  on-init
  ~&  >  [%pick %init]
  on-init:def
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  ~&  >  [%pick %reload]
  on-load:def
::
++  on-poke
  ~&  >  [%pick %poke]
  |=  [=mark =vase]
  ^-  (quip card _this)
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
        %pick-cmd
      (cmd-handle:hc !<(cmd vase))
      ::
        %pick-msg
      (msg-handle:hc !<(msg vase))
    ==
  [cards this]
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
|_  =bowl:gall
++  mk-vote-id
  |=  name=@t
  ^-  @uv
  (sham name src.bowl eny.bowl)
::
++  cmd-handle
  |=  =cmd
  ^-  (quip card _state)
  =,  cmd
  ?-  -.cmd
      %mkvote
    =.  pita  (~(put by pita) (mk-vote-id name) +.cmd)
    :_  state
    =-  ~&  >  -  -
    %+  turn  able
    |=  =ship
    :*  %pass   ~[name]
        %agent  [ship %pick]
        %poke   %pick-msg   !>((msg %vote-new +.cmd))
    ==
      %pick
    `state
      %collate
    `state
      %delete
    `state
  ==
::
++  msg-handle
  |=  =msg
  ^-  (quip card _state)
  =,  msg
  ?-  -.msg
      %vote-new
    `state
::    =/  vote-wire=path  /vote/(scot %uv vote-id)
::    =+  ?:  (check-vote-id vote src.bowl)
::          [%watch vote-wire]
::        [%poke %pick-transact !>(`transaction`[%vote-reject vote-id])]
::    =.  pita  (~(put by pita) vote-id +.msg)
::    :_  state
::    ~[[%pass vote-wire %agent [src.bowl %pick] -]]
      %vote-reject
    `state
      %pick
    `state
      %pick-ack
    `state
      %pick-reject
    `state
      %result
    `state
      %result-ack
    `state
      %result-reject
    `state
  ==
--
