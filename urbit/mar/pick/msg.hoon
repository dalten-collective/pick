::
::  pick-msg mar file
::
/-  *pick
|_  message=msg
++  grad  %noun
++  grow
  |%
  ++  noun  message
  --
++  grab
  |%
  ++  noun
    |=  n=*
    ~&  >  [%grab n]
    (msg n)
  --
--