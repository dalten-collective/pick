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
  ~&  >  [%pick %on-init]
  on-init:def
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  ~&  >  [%pick %on-load]
  on-load:def
::
++  on-poke
  ~&  >  [%pick %poke]
  |=  [=mark =vase]
  |^  ^-  (quip card _this)
  =^  cards  state
    ?+  mark  (on-poke:def mark vase)
        ::
        %cmd
      ?>  =(src.bowl our.bowl)
      (cmd-handle !<(cmd vase))
        ::
        %pick-poke
      ?<  =(src.bowl our.bowl)
      (poke-handle !<(poke:msg vase))
    ==
  [cards this]
  ::
  ++  cmd-handle
    |=  =cmd
    ^-  (quip card _state)
    =,  cmd
    ?-  -.cmd
        ::
        %create
      =/  =poll  [(sham cmd eny.bowl) (picks) +.cmd]
      =,  poll
      :_  state(pita (~(put by pita) poll-id [our.bowl poll]))
      =/  poll-id  (scot %uv poll-id)
      %-  (lead [%pass /[poll-id]/timer %arvo %b %wait stop])
      %+  turn  ~(tap in able)
      |=  =ship
      :*
        %pass   /[poll-id]/voters/(scot %p ship)
        %agent  [ship %pick]
        %poke   %pick-poke   !>((poke:msg %new-poll poll))
      ==
        ::
        %pick
      `state
        ::
        %collate
      `state
        ::
        %delete
      ~&  [%pick %delete poll-id]
      state(pita (~(del by pita) poll-id))
      =/  [host=ship =poll]  ~|(%bad-poll-id (~(got by pita) poll-id))
      =/  =knot  (scot %uv poll-id)
      ?.  =(our.bowl host)
        ~[[%pass /[knot] %agent [host %pick] %leave ~]]
      :~ 
        [%give %kick ~[/[knot]/voters] ~]
        [%pass /[knot]/timer %arvo %b %rest stop.poll]
      ==
    ==
  ::
  ++  poke-handle
    |=  =poke:msg
    ^-  (quip card _state)
    =,  poke
    ?-  -.poke
        ::
        %new-poll
      =,  poll
      :_  state(pita (~(put by pita) poll-id [src.bowl poll]))
      ~|  [%already-has poll-id]
      ?<  (~(has by pita) poll-id)
      ~&  >  [%pick %new-poll %accept poll-id]
      (watch-src:hc poll-id)
        ::
        %pick
      `state
    ==
  --
::
++  on-watch
  |=  =path
  ~&  >  [%pick %watch src.bowl path]
  ^-  (quip card _this)
  ?>  ?=([@ %voters ~] path)
  =/  =poll-id  (slav %uv i.path)
  =/  =poll  ~|([%invalid-poll poll-id] poll:(~(got by pita) poll-id))
  ~|  [%src-not-able src.bowl able.poll]
  ?>  (~(has in able.poll) src.bowl)
  `this
::
++  on-leave  on-leave:def
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  |^  ^-  (quip card _this)
  ?.  ?=([@ ~] wire)  (on-agent:def wire sign)
  =/  poll-id  (slav %uv i.wire)
  =^  cards  state
    ?+  -.sign  `state
        ::
        %fact
      ?.  ?=(%pick-fact p.cage.sign)  `state
      (fact-handle !<(fact:msg q.cage.sign))
        ::
        %kick
      :_  state
      (watch-src:hc poll-id)
        ::
        %watch-ack
      ?~  p.sign  `state
      `state(pita (~(del by pita) poll-id)) :: TODO display error message
    ==
  [cards this]
  ::
  ++  fact-handle
    |=  =fact:msg
    ^-  (quip card _state)
    =,  fact
    ?-  -.fact
        ::
        %result
      `state
    ==
  --
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([@ %timer ~] wire)  (on-arvo:def wire sign-arvo)
  ?.  ?=([%behn %wake *] sign-arvo)  (on-arvo:def wire sign-arvo)
  ?^  error.+.sign-arvo  (on-arvo:def wire sign-arvo)
  =/  res  (~(get by pita) (slav %uv i.wire))
  ?~  res  `this
  `this
  :: TODO actually count votes lol
::
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
|_  =bowl:gall
::
++  watch-src
  |=  =poll-id
  ^-  (list card)
  =/  =knot  (scot %uv poll-id)
  ~[[%pass /[knot] %agent [src.bowl %pick] %watch /[knot]/voters]]
--
