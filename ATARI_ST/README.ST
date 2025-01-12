unzip 4.01 for the Atari ST
===========================

I have compiled unzip.prg with TURBO C 2.0 for the ATARI ST, probably
the best C compiler available for the Atari ST.

My modifications to unzip have been:

- forget about the maze of #ifdefs. Until someone cleans it up,
  use just the setup in the beginning of unzip.h.  Essentially
  after that setup, the code compiles like a MSDOS/TURBOC
  variant.  However this link is quite fragile since the
  MSDOS side might hack the code so that it can no longer compile
  on the Atari.

- an alignment problem in the data (unzip.c)

- set '\' as the path character for the Atari ST (misc.c)

- misc. optimizations (ReadByte, READBIT), which you can safely ignore.

- I did not clean up the code, so that some warnings will still
  appear (prototypes, casts etc.)

I am providing UNZIP.PRG for the Atari ST as unz_prg.arc.
This file, and the patches are contained in unz_st.tar.Z
since 'patch' is required to apply the modifications.
Also I think that the Atari ST version might be somehow integrated
into the main distribution.

Attention:
==========
1)
 The accompanying binary contains a special version of the startup file
 which is capable to recognize extended parameters a la Beckemeyer/Mark
 Williams shell, using the "ARGV=" Environment variable.

2)
 Although the Turbo C compiler is quite good, the libs are buggy!
 Therefore I cannot garantee that any unzip.prg compiled with Turbo C
 will ever run successfully. Mine seems to be ok., but I have fixed
 various problems for my lib. Especially the stat() was making trouble.

However, if someone wants to compile it the same way I did,
there are essentially 3 ways:
- using a shell, and the command line compiler TCC,
  as indicated by the script 'MAKEIT',

- using some sort of make and 'MAKEFILE.ST'
  ( in my special case, I had to call make through the script 'TCM')
  This and the previous case bothrequire also 'TLINK.OPT'

- using the interactive version 'TC' of Turbo C and
  the supplied 'UNZIP.PRJ'.

Please read the note above about problems which might arise
when you recompile unzip on your Atari.

General considerations:
=======================

The configuration of a widely portable tool is always a little bit
complicated, but unzip.h is really not up to the task.

I could not manage to compile anything correctly (on the Atari)
until I had thrown away all of those #ifdefs.

For good portability (using the preprocessor) you must:

- not use #ifdef/ifndef but rathe rely on #if THIS or
  #if THAT == 0. That will allow you to combine those constants
  in any way you want.

- use something like ANSI_C which you can control yourself.
  __STDC__ is not a safe way to handle this, since e.g. TURBO C
  does not set __STDC__ as soon as additional keywords are allowed.
  However __STDC__ implies ANSI_C. Also, since ANSI C is the
  mainstream C, the major version should comply to it.

- break down important sections (MSDOS/OS2), UNIX, VMS, others;
  perhaps allow more categories as OS, COMPILER, TERMINAL type etc.
  and let these be configured in central place.

- don't rely on guesses from switches set by the compiler. That works
  only for a few versions.
