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
  ~&  >  [%pick %watch src.bowl path]
  ^-  (quip card _this)
  :_  this
  =*  id    (slav %uv &1:path)
  =*  ship  (slav %p &2:path)
  ?+  path  (on-watch:def path)
      ::
      [@ ~]
    ?:  (~(has by pita) id)
      ~
    ~&  >>>  [%pick %unexpected-subscription %bad-id]
    ~[[%give %kick ~ ~]]
      ::
      [@ @ ~]
    =/  poll  (~(get by pita) id)
    ?~  poll
      ~&  >>>  [%unexpected-subscription %bad-id]
      ~[[%give %kick ~ ~]]
    =,  u.poll
    ?:  &(=(src.bowl ship) !=((find ~[src.bowl] able) ~))
      ~
    ~&  >>>  [%unexpected-subscription %bad-ship src.bowl]
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
:: Helper to pass all tasks to all ships.
++  mk-quip
  |=  [=poll-id ships=(list ship) tasks=(list task:agent:gall) =_state]
  ^-  (quip card _state)
  :_  state
  %-  zing
  %+  turn  ships
  |=  =ship
  %+  turn  tasks
  |=  =task:agent:gall
  ?-  task
      [%watch *]
    [%pass path.task %agent [ship %pick] task]
      *
    [%pass /(scot %uv poll-id) %agent [ship %pick] task]
  ==
::
++  cmd-handle
  |=  =cmd
  ^-  (quip card _state)
  ?-  -.cmd
      ::
      %create
    =/  =poll  [(mk-poll-id +.cmd) our.bowl +.cmd]
    %:  mk-quip
      poll-id.poll
      able.poll
      ~[[%poke %pick-msg !>((msg %poll-new poll))]]
      state(pita (~(put by pita) poll-id.poll poll))
    ==
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
      %poll-new
    =,  poll
    %^  mk-quip  poll-id  ~[src.bowl]
    ::
    ?:  &((~(has by pita) poll-id) (gte now.bowl open))
      ~&  >>>  [%poll-new %already-running poll]
      :_  state
      ~[[%poke %pick-msg !>((^msg [%poll-reject poll-id %running]))]]
    ::
    ?.  &(=((mk-poll-id +.+.poll) poll-id) =(src.bowl owner.poll))
      ~&  >>>  [%poll-new %invalid-id poll-id %expected (mk-poll-id +.+.poll)]
      :_  state
      ~[[%poke %pick-msg !>((^msg [%poll-reject poll-id %invalid]))]]
    ::
    ~&  [%poll-new %accept poll-id]
    :_  state(pita (~(put by pita) poll-id poll))
    :~  [%watch /(scot %uv poll-id)]
        [%watch /(scot %uv poll-id)/(scot %p our.bowl)]
    ==
    ::
      %poll-reject
    `state
      %pick
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
