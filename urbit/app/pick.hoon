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
  |^  =^  cards  state
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
      =/  =poll  [(sham cmd eny.bowl) our.bowl (tale) ~ +.cmd]
      =,  poll
      :_  state(pita (~(put by pita) poll-id poll))
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
      (pick-handle poll-id pick (sign:as:privkey:hc (jam [poll-id pick])))
        ::
        %force-count
      `state
        ::
        %delete
      ~&  [%pick %delete poll-id]
      :_  state(pita (~(del by pita) poll-id))
      =/  =poll  ~|(%bad-poll-id (~(got by pita) poll-id))
      =/  =knot  (scot %uv poll-id)
      ?.  =(our.bowl host.poll)
        ~[[%pass /[knot]/voters %agent [host.poll %pick] %leave ~]]
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
      =.  host.poll.poke  src.bowl
      =,  poll
      :_  state(pita (~(put by pita) poll-id poll))
      ~|  [%already-has poll-id]
      ?<  (~(has by pita) poll-id)
      ~&  >  [%pick %new-poll %accept poll-id]
      (watch-src:hc poll-id)
        ::
        %new-pick
      =-  (pick-handle poll-id pick seal)
      ~|  %invalid-seal
      ;;  [=poll-id =pick]
      ~|  %invalid-signature
      (cue (need (sure:as:(pubkey:hc src.bowl) seal)))
    ==
  ::
  ++  pick-handle
    |=  [=poll-id =pick =seal]
    ^-  (quip card _state)
    =/  =poll  ~|(%bad-poll-id (~(got by pita) poll-id))
    =,  poll
    ?>  (~(has in able) src.bowl)
    ?>  (~(has in opts) pick)
    =^  c1=(list card)  poll
      =.  tale.poll  (~(add ja tale) pick [src.bowl seal])
      =.  able.poll  (~(del in able) src.bowl)
      :_  poll
      ?:  =(our.bowl host)  ~
      :~  :*
        %pass  /(scot %uv poll-id)  %agent  [host %pick]
        %poke  pick-poke+!>((poke:msg %new-pick seal))
      ==  ==
    =^  c2=(list card)  pita
      ?.  &(=(able ~) =(our.bowl host))
        `(~(put by pita) poll-id poll)
      (record-fate:hc poll)
    [(weld c1 c2) state]
--
::
++  on-watch
  |=  =path
  ~&  >  [%pick %watch src.bowl path]
  ^-  (quip card _this)
  ?>  ?=([@ %voters ~] path)
  =/  =poll-id  (slav %uv i.path)
  =/  =poll  ~|([%invalid-poll poll-id] (~(got by pita) poll-id))
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
  |^  =^  cards  state
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
          `state(pita (~(del by pita) poll-id))
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
      =/  voters  (tellers tale)
      =/  =poll  (~(got by pita) poll-id)
      =/  all-able  (weld (tellers tale.poll) ~(tap in able.poll))
      ?.  &((verify-tale:hc tale) =(fate (tally tale)) (all-in voters all-able))
        `state
      =.  tale.poll  tale
      =.  fate.poll  (some fate)
      =.  able.poll  ~
      `state(pita (~(put by pita) poll-id poll))
    ==
  ::
  ++  tellers
    |=  =tale
    ^-  (list ship)
    (turn `(list [ship seal])`(zing ~(val by tale)) head)
  ::
  ++  all-in
    |=  [xs=(list *) ys=(list *)]
    ^-  ?
    =-  ?=(^ -)
    %+  roll  xs
    |:  [x=(*) remaining-ys=`(unit _ys)`(some ys)]
    %+  biff  remaining-ys
    |=  =_ys
    %+  bind  (find ~[x] ys)
    |=(@ (oust [+< 1] ys))
  --
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([@ %timer ~] wire)          (on-arvo:def wire sign-arvo)
  ?.  ?=([%behn %wake *] sign-arvo)  (on-arvo:def wire sign-arvo)
  ?^  error.sign-arvo                (on-arvo:def wire sign-arvo)
  =/  poll  (~(get by pita) (slav %uv i.wire))
  ?~  poll  `this
  =^  cards  pita  (record-fate:hc u.poll)
  [cards this]
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
  pass:.^([life=@ud =pass (unit)] j+/[our]/deed/[now]/[their]/(life-of their))
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
  |=  xs=(list [ship seal])
  %+  levy  xs
  |=  [=ship =seal]
  ?=  ^  (sure:as:(pubkey ship) seal)
::
++  record-fate
  |=  [=poll]
  ^-  (quip card ^pita)
  =,  poll
  =/  =^fate  (tally tale)
  =.  fate.poll  (some fate)
  =/  =knot  (scot %uv poll-id)
  :_  (~(put by pita) poll-id poll)
  :~
    [%give %fact ~[/[knot]/voters] pick-fact+!>((fact:msg %result tale fate))]
    [%pass /[knot]/timer %arvo %b %rest stop]
  ==
--
::
:: Pure helpers
::
|%
::
++  tally
  |=  =tale
  ^-  fate
  =/  ordered  ((ordered-map @u (list pick)) gte)
  %-  tap:ordered
  %-  ~(rep by tale)
  |=  [[=pick all=(list *)] acc=(tree [@u (list pick)])]
  =/  count  (lent all)
  %^  put:ordered  acc
    count
  [pick (fall (get:ordered acc count) ~)]
--
