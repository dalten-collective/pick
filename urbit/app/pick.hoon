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
  ?>  ?=([@ ~] path)

  =/  poll  ~|(["no such poll" i.path] (~(got by pita) (slav %uv i.path)))
  ~|  ["src not able" src.bowl able.poll]
  ?>  (src-able:hc able.poll)
  `this
::
++  on-leave
  |=  =path
  ^-  (quip card _this)
  ~&  [%on-leave path]
  `this
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ~&  [%on-agent wire sign]
  `this
::  =*  poll-id  (slav %uv &1:wire)
::  =*  ship     (slav %p &2:wire)
::  =^  cards  state
::  ?+  wire  (on-agent:def wire sign)
::      [@ *]
::    `state
::    ?+  -.sign  (on-agent:def wire sign)
::        ::
::        %kick
::      :_  state
::      :~  :*
::        %pass   wire
::        %agent  [src.bowl %pick]
::        %watch  wire
::      ==  ==
::        ::
::        %fact
::      ?+  p.cage.sign  (on-agent:def wire sign)
::          %pick-msg
::        `state :: (msg-handle:hc !<(msg q.cage.sign))
::      ==
::    ==
::  ==
::  [cards this]
::
++  on-arvo   on-arvo:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
|_  bol=bowl:gall
++  my
  |=  =poll
  ^-  ?
  =(our.bol owner.poll)
::
++  src-able
  |=  =able
  ^-  ?
  (~(has in able) src.bol)
::
++  src-owns
  |=  =poll
  |*  res=*
  ^+  res
  ~|  [%not-owner src.bol poll-id.poll]
  ?>  =(owner.poll src.bol)
  res
::
++  mk-poll-id
  |=  poll=[@t opts @da @da able]
  ^-  @uv
  (sham poll src.bol)
::
++  cmd-handle
  |=  =cmd
  ^-  (quip card _state)
  =,  +.cmd
  ?-  -.cmd
      ::
      %create
    =/  =poll  [(mk-poll-id +.cmd) our.bol ~ +.cmd]
    =,  poll
    :_  state(pita (~(put by pita) poll-id.poll poll))
    %+  turn  ~(tap in able)
    |=  =ship
    :*
      %pass   /(scot %uv poll-id)
      %agent  [ship %pick]
      %poke   %pick-msg  !>((msg %poll-new poll))
    ==
      ::
      %pick
    `state
      ::
      %collate
    `state
      ::
      %delete
    :_  state(pita (~(del by pita) poll-id))
    =/  =poll  ~|("bad-poll-id" (~(got by pita) poll-id))
    =/  =wire  /(scot %uv poll-id)
    ?:  (my poll)
      ~[[%give %kick ~[wire] ~]]
    ~[[%pass wire %agent [owner.poll %pick] %leave ~]]
  ==
::
++  msg-handle
  |=  =msg
  ^-  (quip card _state)
  =,  msg
  ?-  -.msg
      ::
      %poll-new
    =,  poll
    :_  state(pita (~(put by pita) poll-id poll))
    ?>  =(src.bol owner.poll)
    ~|  [%duplicate-poll poll-id]
    ?<  (~(has by pita) poll-id)
    ~&  >  [%poll-new %accept poll-id]
    =/  =wire  /(scot %uv poll-id)
    ~[[%pass wire %agent [owner %pick] %watch wire]]
      ::
      %poll-edit
    %-  (src-owns poll)
    `state
    ::
      %pick
    =/  poll  (~(got by pita) poll-id)
    =,  poll
    ?>  &((my poll) (src-able able) (~(has by opts) pick))
    =/  new-poll  poll(picks (~(put ju picks) pick src.bol))
    `state(pita (~(put by pita) poll-id new-poll))
    ::
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
