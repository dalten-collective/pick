::
::  pick-cmd mar file
::
/-  *pick
|_  command=cmd
++  grad  %noun
++  grow
  |%
  ++  noun  command
  --
++  grab
  |%
  ++  noun  cmd
  ++  json
    |=  jon=^json             :: take a
    =,  dejs:format
    %-  cmd
      ::
    %.  jon
    %-  of
    :~  [%delete (se %uv)]
        [%force-count (se %uv)]
        [%pick (ot ~[poll-id+(se %uv) pick+so])]
        :-  %create
        %-  ot
        :~  [%name so]
            [%opts (as so)]
            [%open di]
            [%stop (cu (lift (cury mul ~s1)) (mu ni))]
            [%able (as (se %p))]
        ==
    ==
  --
--