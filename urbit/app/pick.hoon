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
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+  path  (on-watch:def path)
      [%poll @ *]
    ?:  (~(has by pita) (slav %uv i.t.path))
      ~&  >  [%successful-subscription path]
      `this
    ::
    ~&  >>>  [%unexpected-subscription %bad-id]
    :_  this
    ~[[%give %kick ~ ~]]
  ==
::
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
|_  =bowl:gall
++  mk-poll-id
  |=  poll=[@t opts @da @da able]
  ^-  @uv
  (sham poll src.bowl)
::
++  pass-card
  |=  [=ship =poll-id =task:agent:gall]
  ^-  card
  [%pass ~[%poll (scot %uv poll-id)] %agent [ship %pick] task]
::
++  cmd-handle
  |=  =cmd
  ^-  (quip card _state)
  ?-  -.cmd
      ::
      %create
    =/  =poll  [(mk-poll-id +.cmd) +.cmd]
    =.  pita  (~(put by pita) poll-id.poll poll)
    :_  state
    %+  turn  able.poll
    |=  =ship
    (pass-card ship poll-id.poll [%poke %pick-msg !>((msg %poll-new poll))])
      ::
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
      %poll-new :: TODO make the branching logic clearer/simpler
    =,  poll
    ?:  &((~(has by pita) poll-id) (gte now.bowl open))
      ~&  >>>  [%poll-new %already-running poll]
      :_  state
      :~  %^  pass-card
            src.bowl
          poll-id
        [%poke %pick-msg !>((^msg [%poll-reject poll-id %running]))]
      ==
    ?.  =((mk-poll-id +.poll) poll-id)
      ~&  >>>  [%poll-new %invalid-id poll-id %expected (mk-poll-id +.poll)]
      :_  state
      :~  %^  pass-card
            src.bowl
          poll-id
        [%poke %pick-msg !>((^msg [%poll-reject poll-id %invalid]))]
      ==
    ~&  [%poll-new %accept poll-id]
    =.  pita  (~(put by pita) poll-id poll) :: TODO deal with unsubbing if poll exists
    :_  state
    =-  ~&  >  -  -
    ~[(pass-card src.bowl poll-id [%watch ~[%poll (scot %uv poll-id)]])]
    ::
      %poll-reject
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
