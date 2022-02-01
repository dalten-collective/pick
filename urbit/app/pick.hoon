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
=<
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
  ^-  (quip card _this)
  |^
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
      =/  =poll  [(sham cmd eny.bowl) (tale) ~ +.cmd]
      =,  poll
      :_  state(pita (~(put by pita) poll-id [our.bowl poll]))
      =/  =knot  (scot %uv poll-id)
      %-  (lead [%pass /[knot]/timer %arvo %b %wait stop])
      %+  murn  ~(tap in able)
      |=  =ship
      ?:  =(ship our.bowl)  ~
      %-  some
      :*
        %pass   /[knot]/voters/(scot %p ship)
        %agent  [ship %pick]
        %poke   %pick-poke   !>((poke:msg %new-poll poll))
      ==
        ::
        %pick
      ~&  >  [%pick %cmd-pick]
      (pick-handle poll-id pick (sign:as:privkey:hc pick))
        ::
        %force-count
      `state
        ::
        %delete
      ~&  [%pick %delete poll-id]
      :_  state(pita (~(del by pita) poll-id))
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
        %new-pick
      %^  pick-handle  poll-id
        ~|(%invalid-signature (need (sure:as:(pubkey:hc src.bowl) seal)))
      seal
    ==
  ::
  ++  pick-handle
    |=  [=poll-id =pick =seal]
    ^-  (quip card _state)
    =/  [host=ship =poll]  ~|(%bad-poll-id (~(got by pita) poll-id))
    =,  poll
    ?>  (~(has in able) src.bowl)
    ?>  (~(has in opts) pick)
    =.  tale.poll  (~(put ju tale) pick [src.bowl seal])
    =.  able.poll  (~(del in able) src.bowl)
    :_  state(pita (~(put by pita) poll-id [host poll]))
    ?:  =(our.bowl host)
      ?^  able  ~
      (result-card /(scot %uv poll-id)/voters tale)
    :~  :*
      %pass   /(scot %uv poll-id)
      %agent  [host %pick]
      %poke   %pick-poke   !>((poke:msg %new-pick poll-id pick seal))
    ==  ==
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
  ^-  (quip card _this)
  ?.  ?=([@ ~] wire)  (on-agent:def wire sign)
  =/  =poll-id  (slav %uv i.wire)
  |^
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
      ?.  (verify-tale:hc tale) :: TODO check that all ships are able
        ~&  %false-tale  `state
      =/  result  (~(got by pita) poll-id)
      =.  tale.poll.result  tale
      =.  fate.poll.result  (some fate)
      `state(pita (~(put by pita) poll-id result))
    ==
  --
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([@ %timer ~] wire)          (on-arvo:def wire sign-arvo)
  ?.  ?=([%behn %wake *] sign-arvo)  (on-arvo:def wire sign-arvo)
  ?^  error.sign-arvo                (on-arvo:def wire sign-arvo)
  =/  result  (~(get by pita) (slav %uv i.wire))
  ?~  result  `this
  :_  this
  (result-card /[i.wire]/voters tale.poll.u.result)
::
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
|_  =bowl:gall
++  our  (scot %p our.bowl)
++  src  (scot %p src.bowl)
++  now  (scot %da now.bowl)
::
++  life-of
  |=  their=knot
  ^-  knot
  (scot %ud .^(@ud j+/[our]/life/[now]/[their]))
::
++  watch-src
  |=  =poll-id
  ^-  (list card)
  =/  =knot  (scot %uv poll-id)
  ~[[%pass /[knot] %agent [src.bowl %pick] %watch /[knot]/voters]]
::
++  pubkey
  |=  =ship
  ^-  acru:ames
  =/  their=knot  (scot %p ship)
  %-  com:nu:crub:crypto
  =<  pass
  .^([life=@ud =pass (unit)] j+/[our]/deed/[now]/[their]/(life-of their))
::
++  privkey
  ^-  acru:ames
  %-  nol:nu:crub:crypto
  .^(ring j+/[our]/vein/[now]/(life-of src))
::
++  verify-tale
  |=  =tale
  ^-  ?
  %-  ~(all by tale)
  |=  set=(set [ship seal])
  %-  ~(all in set)
  |=  [=ship =seal]
  ?=  ^  (sure:as:(pubkey ship) seal)
--
::
:: Pure helpers
::
|%
::
++  result-card
  |=  [=path =tale]
  ^-  (list card)
  =/  ordered  ((ordered-map @u (list pick)) gte)
  =;  =fate
    ~[[%give %fact ~[path] %pick-fact !>((fact:msg %result tale fate))]]
  %-  tap:ordered
  %-  ~(rep by tale)
  |=  [[=pick all=(set *)] acc=(tree [@u (list pick)])]
  =/  count  ~(wyt in all)
  %^  put:ordered  acc
    count
  [pick (fall (get:ordered acc count) ~)]
--
