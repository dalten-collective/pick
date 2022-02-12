/-  *pick, *ring
/+  default-agent, dbug, ring
::
|%
+$  versioned-state
    $%  state-zero
    ==
::
+$  state-zero
    $:  %0
        state:zero
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
  |=  =vase
  ^-  (quip card _this)
  `this(state !<(versioned-state vase))
::
++  on-poke
  ~&  >  [%pick %poke]
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^  =^  cards  state
      ?+  mark  (on-poke:def mark vase)
          ::
          %pick-cmd
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
    ?-    -.cmd
    :: 
        %create
      ::  check if you know everyone
      ?~  g=(gerrymander:hc able)
        ~&  >>>  [%pick %fail %voter-ids %missing]
        `state
      =/  =poll
        :*  (sham cmd eny.bowl)  our.bowl  *tale  *fate
            name  opts
            open  stop  u.g
        ==
      =,  poll
      :_  state(peck (~(put by peck) poll-id poll))
      =/  =knot  (scot %uv poll-id)
      %-  (lead [%pass /[knot]/timer %arvo %b %wait (add open stop)])
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
      ?~  lyt=(lyfe-of our.bowl)    !!
      ?.  (~(has by peck) poll-id)  !!
      =/  pol=poll  (~(got by peck) poll-id)
      =/  ful=(set @udpoint)
        %-  ~(rep in pkey.pol)
        |=  [inn=@uwpublickey out=(set @udpoint)]
        (~(put in out) `@udpoint`inn)
      ::
      =/  blu=slip
        %-  sign:raw:ring
        [pick `poll-id ful (keys-of:hc our.bowl u.lyt) keys-my:hc eny.bowl]
      ::
      (pick-handle poll-id [pick blu])
        ::
        %force-count
      `state
        ::
        %delete
      ~&  [%pick %delete poll-id]
      :_  state(peck (~(del by peck) poll-id))
      =/  =poll  ~|(%bad-poll-id (~(got by peck) poll-id))
      =/  pid=knot  (scot %uv poll-id)
      ?~  lyt=(lyfe-of our.bowl)  ~
      =/  kip=knot  (scot %ud (keys-of our.bowl u.lyt))
      ?.  =(our.bowl host.poll)
        [%pass /[pid]/voters/[kip] %agent [host.poll %pick] %leave ~]~
      :-  [%pass /[pid]/timer %arvo %b %rest (add open.poll stop.poll)]
      :~  :*
        %give  %kick
        ::
        ^-  (list path)
        %-  ~(rep in pkey.poll)
        |=  [in=@uwpublickey out=(list path)]
        :_  out
        `path`/[pid]/voters/(scot %uwpublickey in)
        ::
        ~
      ==  ==
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
      :_  state(peck (~(put by peck) poll-id poll))
      ~|  [%already-has poll-id]
      ?<  (~(has by peck) poll-id)
      ~&  >  [%pick %new-poll %accept poll-id]
      (hear-em:hc poll-id)
        ::
        %new-pick
      (pick-handle poll-id voat)
    ==
  ::
  ++  pick-handle
    |=  [i=poll-id p=voat]
    ^-  (quip card _state)
    =/  =poll  ~|(%bad-poll-id (~(got by peck) i))
    ?>  (~(has in opts.poll) pick.p)
    ::?>  (~(hist test-it:hc poll) voat)
    ?>  (gth (add open.poll stop.poll) now.bowl)
    ?.   =(our.bowl host.poll)
      :_  state(cast (~(put by cast) i p))
      :~  :*
        %pass  /(scot %uv i)  %agent  [host.poll %pick]
        %poke  pick-poke+!>((poke:msg %new-pick i p))
      ==  ==
    =.  poll
      %=  poll
        fate  (~(add ja fate.poll) pick.p p)
        tale  [p tale.poll]
      ==
    =/  piid=knot  (scot %uv i)
    :_  state(peck (~(put by peck) i poll))
    (~(clos test-it:hc poll) piid)
--
::
++  on-watch
  |=  =path
  ~&  >  [%pick %watch src.bowl path]
  ^-  (quip card _this)
  ::  intelligible?
  ?>  ?=([@ %voters @ ~] path)
  ::  appropriate?
  =/  =poll-id  (slav %uv i.path)
  =/  pub=@uwpublickey  (slav %uwpublickey i.t.t.path)
  =/  =poll
    ~|([%invalid-poll poll-id] (~(got by peck) poll-id))
  ~|  [%src-not-able src.bowl]
  ?>  (~(has in pkey.poll) pub)
  ::  allowed and updated
  :_  this
  [%give %fact ~ pick-fact+!>((fact:msg %result tale.poll fate.poll))]~
::
++  on-leave  on-leave:def
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?.  ?=([@ ~] wire)  (on-agent:def wire sign)
  =/  =poll-id  (slav %uv i.wire)
  |^  =^  cards  state
        ?-  -.sign
            ::
            %fact
          ?.  ?=(%pick-fact p.cage.sign)  `state
          (fact-handle !<(fact:msg q.cage.sign))
            ::
            %kick
          :_  state
          (hear-em:hc poll-id)
            ::
            %watch-ack
          ?~  p.sign  `state
          ?.  (~(has by peck) poll-id)
            `state
          =.  lies
            (~(put by lies) poll-id (~(got by peck) poll-id))
          =.  peck  (~(del by peck) poll-id)
          `state
            ::
            %poke-ack
          ~&  sign
          `state
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
      =/  =poll  (~(got by peck) poll-id)
      ?.  (levy tale ~(hist test-it:hc poll))
        ~&  >>>  [%pick %detects %fraud]
        :-  ~
        %=  state
          peck  (~(del by peck) poll-id)
          lies  (~(put by lies) poll-id poll)
        ==
      =.  tale.poll  tale
      =.  fate.poll  fate
      `state(peck (~(put by peck) poll-id poll))
    ==
  ::
  --
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([@ %timer ~] wire)          (on-arvo:def wire sign-arvo)
  ?.  ?=([%behn %wake *] sign-arvo)  ~&  >  sign-arvo  (on-arvo:def wire sign-arvo)
  ?^  error.sign-arvo                (on-arvo:def wire sign-arvo)
  ::
  ?~  poll=(~(get by peck) (slav %uv i.wire))  `this
  :_  this
  (record-fate:hc u.poll)
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
++  lyfe-of
  |=  dem=@p
  ^-  (unit knot)
  =+  lyf=.^((unit @ud) j+/[our]/lyfe/[now]/(scot %p dem))
  ?~  lyf  ~  `(scot %ud u.lyf)
::
++  keys-of
  |=  [dem=@p wen=knot]
  pass:.^([@ =pass *] j+/[our]/deed/[now]/(scot %p dem)/[wen])
::
++  hear-em
  |=  =poll-id
  ^-  (list card)
  ?~  lyt=(lyfe-of our.bowl)  !!
  =/  pid=knot  (scot %uv poll-id)
  =/  kip=knot  (scot %ud (keys-of our.bowl u.lyt))
  :~  :*  
    %pass   /[pid]
    %agent  [src.bowl %pick]
    %watch  /[pid]/voters/[kip]
  ==  ==
::
++  keys-my
  =-  .^(@ j+/[our]/vein/[now]/[-])
  (scot %ud .^(@ud j+/[our]/life/[now]/[our]))
::
++  test-it
  |_  pol=poll
  ++  hist
  |=  rec=voat
  ^-  ?
  %.y
  ::|((dupe rec) (suss rec))
  ++  dupe
    |=  inn=voat
    ?~  new=y.slip.inn  %.y
    %+  levy  tale.pol
    |=  i=voat
    ?~  old=y.slip.i  %.y
    ?!(=(u.new u.old))
  ++  suss
    |=  inn=voat
    :: maybe this should cycle through every time to check all the votes?
    =-  !(verify:raw:ring [pick.inn `poll-id.pol - slip.inn])
    %-  ~(rep in pkey.pol)
    |=([i=@uwpublickey s=(set @udpoint)] (~(put in s) `@udpoint`i))
  ++  dipp
    |=  pid=knot
    ^-  (list card)
    %-  ~(rep in pkey.pol)
    |=  [in=@uwpublickey out=(list card)]
    :_  out
    [%give %kick ~[/[pid]/voters/(scot %uwpublickey in)] ~]
  ++  clos
    |=  pid=knot
    ^-  (list card)
    :~  :*
      %give  %fact
      ::
      %-  ~(rep in pkey.pol)
      |=  [in=@uwpublickey out=(list path)]
      :_  out
      /[pid]/voters/(scot %uwpublickey in)
      ::
      pick-fact+!>((fact:msg %result tale.poll fate.poll))
    ==  ==
  --
::
++  record-fate
  |=  [=poll]
  ^-  (list card)
  =,  poll
  =/  =knot  (scot %uv poll-id)
  :-  [%pass /[knot]/timer %arvo %b %rest (add open stop)]
  %+  welp  `(list card)`(~(clos test-it poll) knot)
  `(list card)`(~(dipp test-it poll) knot)
++  gerrymander
  |=  sip=(set ship)
  ^-  (unit (set @uwpublickey))
  =/  known=(set @uwpublickey)
    %-  ~(rep in sip)
    |=  [s=ship o=(set @uwpublickey)]
    ?~  lyt=(lyfe-of s)  o
    (~(put in o) (keys-of s u.lyt))
  ?~  known  ~
  ?.  =(~(wyt in `(set @)`sip) ~(wyt in `(set @)`known))
    ~
  `known
--