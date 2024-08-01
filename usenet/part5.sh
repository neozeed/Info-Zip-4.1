#! /bin/sh
# into a shell via "sh file" or similar.  To overwrite existing files,
# type "sh file -c".
# The tool that generated this appeared in the comp.sources.unix newsgroup;
# send mail to comp-sources-unix@uunet.uu.net if you want that tool.
# Contents:  ./v41/ATARI_ST/README.ST ./v41/ATARI_ST/TLINK.OPT
#   ./v41/ATARI_ST/tc_cfg.uue ./v41/MAC/macfile.c
#   ./v41/MSDOS/MAKEFILE.DOS ./v41/VMS/VMSnotes ./v41/VMS/vms_attr.c
#   ./v41/unreduce.c ./v41/unshrink.c ./v41/unzip.1 ./v41/unzip.man
#   ./v41/ziprules.txt
# Wrapped by kent@sparky on Sun May 19 19:40:39 1991
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
echo If this archive is complete, you will see the following message:
echo '          "shar: End of archive 5 (of 6)."'
if test -f './v41/ATARI_ST/README.ST' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/README.ST'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/README.ST'\" \(3193 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/README.ST' <<'END_OF_FILE'
Xunzip 4.01 for the Atari ST
X===========================
X
XI have compiled unzip.prg with TURBO C 2.0 for the ATARI ST, probably
Xthe best C compiler available for the Atari ST.
X
XMy modifications to unzip have been:
X
X- forget about the maze of #ifdefs. Until someone cleans it up,
X  use just the setup in the beginning of unzip.h.  Essentially
X  after that setup, the code compiles like a MSDOS/TURBOC
X  variant.  However this link is quite fragile since the
X  MSDOS side might hack the code so that it can no longer compile
X  on the Atari.
X
X- an alignment problem in the data (unzip.c)
X
X- set '\' as the path character for the Atari ST (misc.c)
X
X- misc. optimizations (ReadByte, READBIT), which you can safely ignore.
X
X- I did not clean up the code, so that some warnings will still
X  appear (prototypes, casts etc.)
X
XI am providing UNZIP.PRG for the Atari ST as unz_prg.arc.
XThis file, and the patches are contained in unz_st.tar.Z
Xsince 'patch' is required to apply the modifications.
XAlso I think that the Atari ST version might be somehow integrated
Xinto the main distribution.
X
XAttention:
X==========
X1)
X The accompanying binary contains a special version of the startup file
X which is capable to recognize extended parameters a la Beckemeyer/Mark
X Williams shell, using the "ARGV=" Environment variable.
X
X2)
X Although the Turbo C compiler is quite good, the libs are buggy!
X Therefore I cannot garantee that any unzip.prg compiled with Turbo C
X will ever run successfully. Mine seems to be ok., but I have fixed
X various problems for my lib. Especially the stat() was making trouble.
X
XHowever, if someone wants to compile it the same way I did,
Xthere are essentially 3 ways:
X- using a shell, and the command line compiler TCC,
X  as indicated by the script 'MAKEIT',
X
X- using some sort of make and 'MAKEFILE.ST'
X  ( in my special case, I had to call make through the script 'TCM')
X  This and the previous case bothrequire also 'TLINK.OPT'
X
X- using the interactive version 'TC' of Turbo C and
X  the supplied 'UNZIP.PRJ'.
X
XPlease read the note above about problems which might arise
Xwhen you recompile unzip on your Atari.
X
XGeneral considerations:
X=======================
X
XThe configuration of a widely portable tool is always a little bit
Xcomplicated, but unzip.h is really not up to the task.
X
XI could not manage to compile anything correctly (on the Atari)
Xuntil I had thrown away all of those #ifdefs.
X
XFor good portability (using the preprocessor) you must:
X
X- not use #ifdef/ifndef but rathe rely on #if THIS or
X  #if THAT == 0. That will allow you to combine those constants
X  in any way you want.
X
X- use something like ANSI_C which you can control yourself.
X  __STDC__ is not a safe way to handle this, since e.g. TURBO C
X  does not set __STDC__ as soon as additional keywords are allowed.
X  However __STDC__ implies ANSI_C. Also, since ANSI C is the
X  mainstream C, the major version should comply to it.
X
X- break down important sections (MSDOS/OS2), UNIX, VMS, others;
X  perhaps allow more categories as OS, COMPILER, TERMINAL type etc.
X  and let these be configured in central place.
X
X- don't rely on guesses from switches set by the compiler. That works
X  only for a few versions.
END_OF_FILE
  if test 3193 -ne `wc -c <'./v41/ATARI_ST/README.ST'`; then
    echo shar: \"'./v41/ATARI_ST/README.ST'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/README.ST'
fi
if test -f './v41/ATARI_ST/TLINK.OPT' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/TLINK.OPT'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/TLINK.OPT'\" \(189 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/TLINK.OPT' <<'END_OF_FILE'
Xe:\tc\lib\mystart.o
Xunzip.o
Xfile_io.o
Xmapname.o
Xmatch.o
Xmisc.o
Xunimplod.o
Xunreduce.o
Xunshrink.o
Xe:\tc\lib\tcstdlib.lib
Xe:\tc\lib\tcextlib.lib
Xe:\tc\lib\tctoslib.lib
Xe:\tc\lib\tcstdlib.lib
X
END_OF_FILE
  if test 189 -ne `wc -c <'./v41/ATARI_ST/TLINK.OPT'`; then
    echo shar: \"'./v41/ATARI_ST/TLINK.OPT'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/TLINK.OPT'
fi
if test -f './v41/ATARI_ST/tc_cfg.uue' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/tc_cfg.uue'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/tc_cfg.uue'\" \(3355 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/tc_cfg.uue' <<'END_OF_FILE'
Xbegin 640 TC.CFG
XM`@(`"C0`````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````93I<=&-<:6YC;'5D90``````````````````````````````
XM`````$%405))7U-4/3$`````````````````````````````````````````
XM````````````````````````````````````````````````````,C4``#$P
XM,``S,@``,@``````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM``````````````0`````````````````````````````````````````93I<
XM=&-<;&EB````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM1CI<54Y:25!<54Y:25`N4%)*````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM``````````````````````````````````````````````````!&.EQ53EI)
XM4%P`12Y/````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````/S\_````````````````````````
XM`0`"`$8`%$8Z7%5.6DE07%5.6DE0+D@`4%Q53EI)4"Y(````*`````,`````
XM```````)^:8``#>*`P``")&6````$"`@`I8```!A````$`````````````C`
XM=B`@`I8````!````$````````````````0`(``$`"``!`````0```!``"=(B
XM``````#+````RP````$`1@`41CI<54Y:25!<54Y:25`N4%)*`%5.6DE0+D@`
XM```H`````P````````````GYI@``-XH#```(D98````0("`"E@```&$````0
XM````````````",!V("`"E@````$````0```````````````!``@``0`(``$`
XM```!````$``)TB(``0```+(```"R`````0!&`!1-97-S86=E<P``````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM```````````````````````````````"````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XA````````````````````````````````````````````
X`
Xend
END_OF_FILE
  if test 3355 -ne `wc -c <'./v41/ATARI_ST/tc_cfg.uue'`; then
    echo shar: \"'./v41/ATARI_ST/tc_cfg.uue'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/tc_cfg.uue'
fi
if test -f './v41/MAC/macfile.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/MAC/macfile.c'\"
else
  echo shar: Extracting \"'./v41/MAC/macfile.c'\" \(3616 characters\)
  sed "s/^X//" >'./v41/MAC/macfile.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  mac.c
X
X  This source file is used by the mac port to support commands not available
X  directly on the Mac, i.e. mkdir().
X  It also helps determine if we're running on a Mac with HFS and a disk
X  formatted for HFS (HFS - Hierarchical File System; compared to its predecessor,
X  MFS - Macintosh File System).
X  
X  ---------------------------------------------------------------------------*/
X
X#include "unzip.h"
X
X#ifdef MACOS
Xstatic short wAppVRefNum;
Xstatic long lAppDirID;
Xint hfsflag;            /* set if disk has hierarchical file system */
X
Xvoid macfstest(int vrefnum, int wd)
X{
X    Str255 st;
X
X    /* is this machine running HFS file system? */
X#ifdef THINK_C
X    if (FSFCBLen <= 0) {
X#else
X    if (*(short *)FSFCBLen <= 0) {
X#endif
X        hfsflag = false;
X    }
X    else
X    {
X        hfsflag = true;
X    }
X
X    /* get the file's volume reference number and directory ID */
X    if (hfsflag == true) {
X        WDPBRec    wdpb;
X        OSErr err = noErr;
X
X        if (vrefnum != 0) {
X            wdpb.ioCompletion = false;
X            wdpb.ioNamePtr = st;
X            wdpb.ioWDIndex = 0;
X            wdpb.ioVRefNum = vrefnum;
X            err = PBHGetVol(&wdpb, false);
X        
X            if (err == noErr) {
X                wAppVRefNum = wdpb.ioWDVRefNum;
X                lAppDirID = wdpb.ioWDDirID;
X            }
X        }
X
X        /* is the disk we're using formatted for HFS? */
X        hfsflag = IsHFSDisk(wAppVRefNum);
X    }
X} /* mactest */
X
Xstatic int IsHFSDisk(short wRefNum)
X{
X    /* get info about the specified volume */
X    if (hfsflag == true) {
X        HParamBlockRec    hpbr;
X        Str255 temp;
X        short wErr;
X        
X        hpbr.volumeParam.ioCompletion = 0;
X        hpbr.volumeParam.ioNamePtr = temp;
X        hpbr.volumeParam.ioVRefNum = wRefNum;
X        hpbr.volumeParam.ioVolIndex = 0;
X        wErr = PBHGetVInfo(&hpbr, 0);
X
X        if (wErr == noErr && hpbr.volumeParam.ioVFSID == 0
X            && hpbr.volumeParam.ioVSigWord == 0x4244) {
X                return true;
X        }
X    }
X
X    return false;
X} /* IsHFSDisk */
X
Xint mkdir(char *path, int mode)
X{
X    OSErr    err = -1;
X
X    if (path != 0 && strlen(path)<256 && hfsflag == true) {
X        HParamBlockRec    hpbr;
X        Str255    st;
X        short     wVol;
X        long      lDirID;
X
X        CtoPstr(path);
X        hpbr.fileParam.ioNamePtr = st;
X        hpbr.fileParam.ioCompletion = NULL;
X        err = PBHGetVol((WDPBPtr)&hpbr, false);
X        if (err == noErr) {
X            wVol = hpbr.wdParam.ioWDVRefNum;
X            lDirID = hpbr.wdParam.ioWDDirID;
X            hpbr.fileParam.ioCompletion = NULL;
X            hpbr.fileParam.ioVRefNum = wVol;
X            hpbr.fileParam.ioDirID = lDirID;
X            hpbr.fileParam.ioNamePtr = path;
X            err = PBDirCreate(&hpbr, false);
X        }    
X        PtoCstr(path);
X    }
X
X    return err;
X} /* mkdir */
X
Xvoid SetMacVol(char *pch, short wVRefNum)
X{
X    OSErr err = -1;
X
X    if (hfsflag == true) {
X        HParamBlockRec  hpbr;
X        Str255  st;
X
X        hpbr.wdParam.ioCompletion = NULL;
X        hpbr.wdParam.ioNamePtr = st;
X        hpbr.wdParam.ioVRefNum = wVRefNum;
X        hpbr.wdParam.ioWDIndex = 0;
X        hpbr.wdParam.ioWDProcID = 0;
X        hpbr.wdParam.ioWDVRefNum = 0;
X        err = PBGetWDInfo(&hpbr, false);
X        if (err == noErr) {
X            hpbr.wdParam.ioCompletion = NULL;
X            hpbr.wdParam.ioNamePtr = NULL;
X            err = PBHSetVol(&hpbr, false);
X        }
X    } else {
X        err = SetVol(pch, wVRefNum);
X    }
X} /* SetMacVol */
X#endif /* MACOS */
END_OF_FILE
  if test 3616 -ne `wc -c <'./v41/MAC/macfile.c'`; then
    echo shar: \"'./v41/MAC/macfile.c'\" unpacked with wrong size!
  fi
  # end of './v41/MAC/macfile.c'
fi
if test -f './v41/MSDOS/MAKEFILE.DOS' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/MSDOS/MAKEFILE.DOS'\"
else
  echo shar: Extracting \"'./v41/MSDOS/MAKEFILE.DOS'\" \(2964 characters\)
  sed "s/^X//" >'./v41/MSDOS/MAKEFILE.DOS' <<'END_OF_FILE'
X#  Makefile.DOS    Makefile for UnZip 4.0, using Microsoft C Compiler 5.0
X#                  and Microsoft MAKE 4.02 (or later versions).  Users of
X#                  MSC 6.0 and NMAKE can use the regular makefile by typing
X#                  "nmake msc_dos".]
X#
X#                  Works just fine as it stands for Turbo C v2.0.
X#                  You'll have to uncomment and/or edit for Include
X#                  and Library paths.
X#
X#  Notes:  (1) Uncomment the appropriate compiler/OS options below.
X#          (2) Change the various CFLAGS as appropriate for your environment
X#              and libraries.
X#              For MSC:  -AS specifies small-model library; -FPi87
X#              specifies inline 80x87 support (there is no floating-point
X#              math in unzip, but that's my default library); and -G2 enables
X#              80286 instructions.  QuickC uses the medium memory model, as
X#              I recall (-AM and/or -qc).
X#              The "ALL:" target is used by MSC 6.0 with old MAKE; thanks to 
X#              Bo Kullmar for that fix.
X#          (3) Rename this file to "unzip" on a DOS system; typing "make
X#              unzip" with MSC (or "make -funzip" with TC) then builds
X#              unzip.exe.
X#
X#  Greg Roelofs
X#  roelofs@amelia.nas.nasa.gov
X#
X
X#####################
X# MACRO DEFINITIONS #
X#####################
X
X# Turbo C 2.0 for MS-DOS:
X# ----------------------
X# tcc is usually configured with -I and -L set appropriately...
XCC = tcc
XCFLAGS = -ms -O -Z
XINCL = #-Ic:\turboc\include
XLD = tcc
XLDFLAGS = -ms #-Lc:\turboc\lib
XLDFLAGS2 =
X
X# MSC for MS-DOS:
X# --------------
X# CC = cl
X# CFLAGS = -AS -Ox -G2 -FPi87    # change to -FPi if coprocessor not installed
X# INCL =
X# LD = link
X# LDFLAGS = /NOI
X# LDFLAGS2 = ,$*;
X
X# MSC with SDK for OS/2:
X# ---------------------
X# CC = cl
X# CFLAGS = -AS -Ox -G2 -DOS2
X# INCL = -Ic:\m5\include         # for example
X# LD = link
X# LDFLAGS = /NOI
X# RM = del
X# LIBC = c:\m5\lib\p\slibce
X# LIBD = c:\m5\lib\doscalls.lib
X# LIBA = c:\m5\lib\api.lib
X
XOBJS = unzip.obj file_io.obj mapname.obj match.obj misc.obj\
X       unimplod.obj unreduce.obj unshrink.obj
X
X
X###############################################
X# BASIC COMPILE INSTRUCTIONS AND DEPENDENCIES #
X###############################################
X
XALL	: unzip.exe
X
X.c.obj:
X        $(CC) -c $(CFLAGS) $(INCL) $*.c
X
Xunzip.obj:      unzip.c unzip.h
X
Xfile_io.obj:    file_io.c unzip.h
X
Xmapname.obj:    mapname.c unzip.h
X
Xmatch.obj:      match.c unzip.h
X
Xmisc.obj:       misc.c unzip.h
X
Xunimplod.obj:   unimplod.c unzip.h
X
Xunreduce.obj:   unreduce.c unzip.h
X
Xunshrink.obj:   unshrink.c unzip.h
X
X# DOS:
X# ---
Xunzip.exe:     $(OBJS)
X        $(LD) $(LDFLAGS) $(OBJS) $(LDFLAGS2)
X
X# OS/2:
X# ----
X# unziptmp.exe:  $(OBJS)
X#         $(LD) $(LDFLAGS) $(OBJS), $*.exe,,$(LIBC)+$(LIBD);
X#
X# unzip.exe:     unziptmp.exe
X#         bind unziptmp.exe $(LIBD) $(LIBA) -o unzip.exe
X#         $(RM) unziptmp.exe
X#         $(RM) *.obj
X#         $(RM) *.map
END_OF_FILE
  if test 2964 -ne `wc -c <'./v41/MSDOS/MAKEFILE.DOS'`; then
    echo shar: \"'./v41/MSDOS/MAKEFILE.DOS'\" unpacked with wrong size!
  fi
  # end of './v41/MSDOS/MAKEFILE.DOS'
fi
if test -f './v41/VMS/VMSnotes' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/VMSnotes'\"
else
  echo shar: Extracting \"'./v41/VMS/VMSnotes'\" \(4979 characters\)
  sed "s/^X//" >'./v41/VMS/VMSnotes' <<'END_OF_FILE'
X                     VMS Notes for UnZip 4.1
X                           12 May 1991
X
X
XThe various VMS tweaks to UnZip 4.1 were tested on a VAX 8600 running
XVMS 5.2 and VAX C 3.0.  Older tweaks were also tested on a VAX 11/785.
X
XAmong other things, this system has built into its C run-time library
Xmost of the standard Unix functions; the notable exception is utime().
XDespite this lack, however, UnZip does manage to set the date/time of 
Xeach extracted file.  The compiler also predefines the token "VMS", so 
Xit is not necessary to specify this on the compiler command line.
X
XTo build UnZip, just run the included command file VMS_MAKE.COM (i.e.,
X"@vms_make").  By default, this creates a shareable-image executable,
Xwhich is smaller and (supposedly) loads faster than the normal type
X(that's "loads" the verb, not the adjective...).  It also will be 
Xbetter able to take advantage of any bug fixes or new capabilities 
Xthat DEC might introduce, since the library code isn't built into the 
Xexecutable.  The shared executable is about a quarter the size of the 
Xordinary type.
X
X[Btw, the VMS make utility "MMS" seems not to be compatible enough with
XUnix make to use the same makefile.  Antonio Querubin, Jr., sent along an 
XMMS makefile, but it has a small incompatibility with the current UnZip 
Xdistribution.  If DESCRIP.MMS is included with this package, read the 
Xcomments at the top to see what action is required.]
X
XUnZip is written to return the standard PK-type return codes (or error
Xcodes, or exit codes, or whatever you want to call them).  Unfortunately,
XVMS insists on interpreting the codes in its own lovable way, and this
Xresults in endearing commentary such as "access violation, error mask =
X0005, PC = 00003afc" (or something like that) when you run UnZip with no
Xarguments.  To avoid this I've added a special VMS_return() function which
Xinterprets the error codes and prints a semi-informative message (enclosed
Xin square [] brackets), then exits with a normal error status.  Tastes
Xvary, however, and some people may not like the semi-informative messages
X(I don't, for one).  If you happen to be one of those people, you may
Xdisable the messages by recompiling misc.c with NO_RETURN_CODES defined.
X(This knocks down the executable size by a block or 4, too.)  The syntax 
Xis as follows:
X	cc /def=(NO_RETURN_CODES) misc
X
XTo use UnZip in the normal way, define a symbol "unzip" as follows:
X	unzip :== "$diskname:[directory]unzip.exe"
X(substitute for "diskname" and "directory" as appropriate, and DON'T FORGET
XTHE "$"!  It won't work if you omit that.)  In general it's wise to stick 
Xsuch assignments in your LOGIN.COM file and THEN forget about them.  It is 
Xno longer necessary to worry about the record type of the zipfile...er, 
Xwell, most of the time, anyway (see the special Kermit section below).
X
XHaving done all this you are ready to roll.  Use the unzip command in
Xthe usual way; as with the MS-DOS and Unix versions, this one uses '-'
Xas a switch character.  If nothing much happens when you do a directory
Xlisting, for example, you're probably trying to specify a filename which
Xhas uppercase letters in it...VMS thoughtfully converts everything on the
Xcommand line to lowercase, so even if you type:
X	unzip -v zipfile Makefile
Xwhat you get is:
X	unzip -v zipfile makefile
Xwhich, in my example here, doesn't match the contents of the zipfile.
XThis is relatively easy to circumvent, by enclosing the filespec(s) in 
Xquotes:
X	unzip -tq unzip401 "Makefile" "VMS*" *.c *.h
X[This example also demonstrates the use of wildcards, which act like Unix
Xwildcards, not VMS ones.   In other words, "VMS*" matches files VMSNOTES,
XVMS_MAKE.COM, and VMSSHARE.OPT, whereas the normal VMS behavior would be
Xto match only the first file (since the others have extensions--ordinarily,
Xyou would be required to specify "VMS*.*").]
X
XNote that created files get whatever default permissions you've set, but 
Xcreated directories additionally inherit the (possibly more restrictive) 
Xpermissions of the parent directory.  And, of course, things probably won't 
Xwork too well if you don't have permission to write to whatever directory 
Xinto which you're trying to extract things.  (That made sense; read it 
Xagain if you don't believe me.)
X
XSPECIAL KERMIT NOTES:  Kermit files uploaded with "set file type binary"
Xremain incompatible with UnZip, despite the inclusion of code from Joe
XMeadows' spectacular VMS utility, FILE.  The reason is that the files
Xcreated on the VMS side have "variable length, 510-byte maximum" records,
Xwhich is to say, there's extra junk inside them that shouldn't be there.
XAvoid this problem by uploading with "set file type fixed" and everything
Xshould be hunky-dory.  If you forgot, you can convert the zipfile into
XUnZip-readable form (i.e., "stream-LF" format) with Rahul Dhesi's BILF
Xutility.  A similar utility will be included in future releases of UnZip.
X
XGreg Roelofs,
X often found lurking about Info-ZIP@WSMR-Simtel20.Army.Mil
END_OF_FILE
  if test 4979 -ne `wc -c <'./v41/VMS/VMSnotes'`; then
    echo shar: \"'./v41/VMS/VMSnotes'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/VMSnotes'
fi
if test -f './v41/VMS/vms_attr.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/vms_attr.c'\"
else
  echo shar: Extracting \"'./v41/VMS/vms_attr.c'\" \(8015 characters\)
  sed "s/^X//" >'./v41/VMS/vms_attr.c' <<'END_OF_FILE'
X/* 
X   [VMS_attr.c, based on] FILE.C, a utility to modify file characteristics.
X 
X   Written by Joe Meadows Jr, at the Fred Hutchinson Cancer Research Center
X   BITNET: JOE@FHCRCVAX
X   PHONE: (206) 467-4970
X   [...and stripped to the bone for unzip usage by Greg Roelofs.]
X 
X   There are no restrictions on this code, you may sell it, include it with
X   any commercial package, or feed it to a whale.. However, I would appreciate
X   it if you kept this comment in the source code so that anyone receiving
X   this code knows who to contact in case of problems. Note that I do not
X   demand this condition..
X */
X 
X#include <descrip.h>
X#include <rms.h>
X#include <stdio.h>
X#include <iodef.h>
X#include <atrdef.h> /* this gets created with the c3.0 compiler */
X#include <fibdef.h> /* this gets created with the c3.0 compiler */
X
X#include "fatdef.h"
X#include "fchdef.h"
X#include "fjndef.h"
X 
X#define RTYPE     fat$r_rtype_overlay.fat$r_rtype_bits
X#define RATTRIB   fat$r_rattrib_overlay.fat$r_rattrib_bits
X
Xextern char  zipfn[];	/* GRR unzip:  name of file to be modified */
Xint  old_rtype;		/* save old zipfile attribute so can restore */
X
X/* save...
Xchar *cvt_time();
Xchar *format_uic();
X */
X 
X
X 
Xint change_zipfile_attributes( restore )   /* GRR unzip:  used to be main() */
X  int restore;
X{
X  static struct FAB Fab;
X  static struct NAM Nam;
X  static struct fibdef Fib; /* short fib */
X 
X  static struct dsc$descriptor FibDesc =
X    {sizeof(Fib),DSC$K_DTYPE_Z,DSC$K_CLASS_S,&Fib};
X  static struct dsc$descriptor_s DevDesc =
X    {0,DSC$K_DTYPE_T,DSC$K_CLASS_S,&Nam.nam$t_dvi[1]};
X  static struct fatdef Fat;
X  static union {
X    struct fchdef fch;
X    long int dummy;
X  } uchar;
X  static struct fjndef jnl;
X  static long int Cdate[2],Rdate[2],Edate[2],Bdate[2];
X  static short int revisions;
X  static unsigned long uic;
X  static union {
X    unsigned short int value;
X    struct {
X      unsigned system : 4;
X      unsigned owner : 4;
X      unsigned group : 4;
X      unsigned world : 4;
X    } bits;
X  } prot;
X 
X  static struct atrdef Atr[] = {
X    {sizeof(Fat),ATR$C_RECATTR,&Fat},        /* record attributes */
X    {sizeof(uchar),ATR$C_UCHAR,&uchar},      /* File characteristics */
X    {sizeof(Cdate),ATR$C_CREDATE,&Cdate[0]}, /* Creation date */
X    {sizeof(Rdate),ATR$C_REVDATE,&Rdate[0]}, /* Revision date */
X    {sizeof(Edate),ATR$C_EXPDATE,&Edate[0]}, /* Expiration date */
X    {sizeof(Bdate),ATR$C_BAKDATE,&Bdate[0]}, /* Backup date */
X    {sizeof(revisions),ATR$C_ASCDATES,&revisions}, /* number of revisions */
X    {sizeof(prot),ATR$C_FPRO,&prot},         /* file protection  */
X    {sizeof(uic),ATR$C_UIC,&uic},            /* file owner */
X    {sizeof(jnl),ATR$C_JOURNAL,&jnl},        /* journal flags */
X    {0,0,0}
X  } ;
X 
X  static char EName[NAM$C_MAXRSS];
X  static char RName[NAM$C_MAXRSS];
X  static struct dsc$descriptor_s FileName =
X    {0,DSC$K_DTYPE_T,DSC$K_CLASS_S,0};
X  static struct dsc$descriptor_s string = {0,DSC$K_DTYPE_T,DSC$K_CLASS_S,0};
X  static short int DevChan;
X  static short int iosb[4];
X 
X  static long int i,status;
X/* static char *retval; */
X 
X 
X/*---------------------------------------------------------------------------
X    Initialize attribute blocks, parse filename, resolve any wildcards, and
X    get the file info.
X  ---------------------------------------------------------------------------*/
X 
X    /* initialize RMS structures, we need a NAM to retrieve the FID */
X    Fab = cc$rms_fab;
X    Fab.fab$l_fna = zipfn; /* name of file */
X    Fab.fab$b_fns = strlen(zipfn);
X    Fab.fab$l_nam = &Nam; /* FAB has an associated NAM */
X    Nam = cc$rms_nam;
X    Nam.nam$l_esa = &EName; /* expanded filename */
X    Nam.nam$b_ess = sizeof(EName);
X    Nam.nam$l_rsa = &RName; /* resultant filename */
X    Nam.nam$b_rss = sizeof(RName);
X 
X    /* do $PARSE and $SEARCH here */
X    status = sys$parse(&Fab);
X    if (!(status & 1)) return(status);
X 
X    /* search for the first file.. If none signal error */
X    status = sys$search(&Fab);
X    if (!(status & 1)) return(status);
X
X    while (status & 1) {
X        /* initialize Device name length, note that this points into the NAM
X           to get the device name filled in by the $PARSE, $SEARCH services */
X        DevDesc.dsc$w_length = Nam.nam$t_dvi[0];
X 
X        status = sys$assign(&DevDesc,&DevChan,0,0);
X        if (!(status & 1)) return(status);
X 
X        FileName.dsc$a_pointer = Nam.nam$l_name;
X        FileName.dsc$w_length = Nam.nam$b_name+Nam.nam$b_type+Nam.nam$b_ver;
X 
X        /* Initialize the FIB */
X        for (i=0;i<3;i++)
X            Fib.fib$r_fid_overlay.fib$w_fid[i]=Nam.nam$w_fid[i];
X        for (i=0;i<3;i++)
X            Fib.fib$r_did_overlay.fib$w_did[i]=Nam.nam$w_did[i];
X 
X        /* Use the IO$_ACCESS function to return info about the file */
X        /* Note, used this way, the file is not opened, and the expiration */
X        /* and revision dates are not modified */
X        status = sys$qiow(0,DevChan,IO$_ACCESS,&iosb,0,0,
X                          &FibDesc,&FileName,0,0,&Atr,0);
X        if (!(status & 1)) return(status);
X        status = iosb[0];
X        if (!(status & 1)) return(status);
X
X/* save...
X        if ((Cdate[0]==0) && (Cdate[1]==0))
X            printf("  /NO%s -\n",t_credate);
X        else
X            printf("  /%s=\"%s\" -\n",t_credate,cvt_time(Cdate));
X
X        if ((Rdate[0]==0) && (Rdate[1]==0))
X            printf("  /NO%s",t_revdate);
X        else
X            printf("  /%s=\"%s\"",t_revdate,cvt_time(Rdate));
X */
X
X        if (restore)				/* GRR unzip */
X            Fat.RTYPE.fat$v_rtype = old_rtype;
X        else {
X            old_rtype = Fat.RTYPE.fat$v_rtype;
X            Fat.RTYPE.fat$v_rtype = FAT$C_STREAMLF;   /* Unix I/O loves it */
X        }
X
X/* save...
X        status = cli_present(t_credate);
X        if (status & 1) {
X            status = cli_get_value(t_credate,&retval);
X            bintim(retval,Cdate);
X        }
X        else
X            if ((status == CLI$_NEGATED) || (status == CLI$_LOCNEG)) {
X                Cdate[0]=0;
X                Cdate[1]=0;
X            };
X
X        status = cli_present(t_revdate);
X        if (status & 1) {
X            status = cli_get_value(t_revdate,&retval);
X            bintim(retval,Rdate);
X        }
X        else
X            if ((status == CLI$_NEGATED) || (status == CLI$_LOCNEG)) {
X                Rdate[0]=0;
X                Rdate[1]=0;
X            };
X */
X 
X 
X        /* note, part of the FIB was cleared by earlier QIOW, so reset it */
X        Fib.fib$r_acctl_overlay.fib$l_acctl = FIB$M_NORECORD;
X        for (i=0;i<3;i++)
X            Fib.fib$r_fid_overlay.fib$w_fid[i]=Nam.nam$w_fid[i];
X        for (i=0;i<3;i++)
X            Fib.fib$r_did_overlay.fib$w_did[i]=Nam.nam$w_did[i];
X 
X        /* Use the IO$_MODIFY function to change info about the file */
X        /* Note, used this way, the file is not opened, however this would */
X        /* normally cause the expiration and revision dates to be modified. */
X        /* Using FIB$M_NORECORD prohibits this from happening. */
X        status = sys$qiow(0,DevChan,IO$_MODIFY,&iosb,0,0,
X                          &FibDesc,&FileName,0,0,&Atr,0);
X        if (!(status & 1)) return(status);
X 
X        status = iosb[0];
X        if (!(status & 1)) return(status);
X 
X        status = sys$dassgn(DevChan);
X        if (!(status & 1)) return(status);
X 
X        /* look for next file, if none, no big deal.. */
X        status = sys$search(&Fab);
X    }
X} /* end function change_zipfile_attributes() */
X 
X
X#if 0   /* save for possible later use */ 
X
Xchar *cvt_time(date)
X  long int date[2];
X{
X  static char str[27];
X  static struct dsc$descriptor date_str={26,DSC$K_DTYPE_T,DSC$K_CLASS_S,&str};
X 
X  if ((date[0]==0) && (date[1]==0))
X    return("none");
X 
X  sys$asctim(0,&date_str,date,0);
X  str[26]='\0';
X 
X  return(&str);
X}
X 
Xbintim(time,binval)
X  char *time;
X  long int binval[2];
X{
X  static struct dsc$descriptor date_str={0,DSC$K_DTYPE_T,DSC$K_CLASS_S,0};
X  date_str.dsc$w_length = strlen(time);
X  date_str.dsc$a_pointer = time;
X 
X  sys$bintim(&date_str,binval);
X}
X#endif /* 0 */ 
END_OF_FILE
  if test 8015 -ne `wc -c <'./v41/VMS/vms_attr.c'`; then
    echo shar: \"'./v41/VMS/vms_attr.c'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/vms_attr.c'
fi
if test -f './v41/unreduce.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unreduce.c'\"
else
  echo shar: Extracting \"'./v41/unreduce.c'\" \(5034 characters\)
  sed "s/^X//" >'./v41/unreduce.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  unreduce.c
X
X  The Reducing algorithm is actually a combination of two distinct algorithms.
X  The first algorithm compresses repeated byte sequences, and the second al-
X  gorithm takes the compressed stream from the first algorithm and applies a
X  probabilistic compression method.
X
X  ---------------------------------------------------------------------------*/
X
X
X#include "unzip.h"
X
X
X/**************************************/
X/*  UnReduce Defines, Typedefs, etc.  */
X/**************************************/
X
X#define DLE    144
X
Xtypedef byte f_array[64];       /* for followers[256][64] */
X
Xstatic void LoadFollowers __((void));
X
X
X
X/*******************************/
X/*  UnReduce Global Variables  */
X/*******************************/
X
Xf_array *followers = (f_array *) prefix_of;     /* shared work space */
Xbyte Slen[256];
Xint factor;
X
Xint L_table[] =
X{0, 0x7f, 0x3f, 0x1f, 0x0f};
X
Xint D_shift[] =
X{0, 0x07, 0x06, 0x05, 0x04};
Xint D_mask[] =
X{0, 0x01, 0x03, 0x07, 0x0f};
X
Xint B_table[] =
X{8, 1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5,
X 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6,
X 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
X 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7,
X 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
X 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
X 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
X 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
X 8, 8, 8, 8};
X
X
X
X
X
X/*************************/
X/*  Function unReduce()  */
X/*************************/
X
Xvoid unReduce()
X /* expand probabilistically reduced data */
X{
X    register int lchar;
X    int nchar;
X    int ExState;
X    int V;
X    int Len;
X
X    factor = lrec.compression_method - 1;
X    ExState = 0;
X    lchar = 0;
X    LoadFollowers();
X
X    while (((outpos + outcnt) < ucsize) && (!zipeof)) {
X        if (Slen[lchar] == 0)
X            READBIT(8, nchar)   /* ; */
X        else {
X            READBIT(1, nchar);
X            if (nchar != 0)
X                READBIT(8, nchar)       /* ; */
X            else {
X                int follower;
X                int bitsneeded = B_table[Slen[lchar]];
X                READBIT(bitsneeded, follower);
X                nchar = followers[lchar][follower];
X            }
X        }
X        /* expand the resulting byte */
X        switch (ExState) {
X
X        case 0:
X            if (nchar != DLE)
X                OUTB(nchar)     /*;*/
X            else
X                ExState = 1;
X            break;
X
X        case 1:
X            if (nchar != 0) {
X                V = nchar;
X                Len = V & L_table[factor];
X                if (Len == L_table[factor])
X                    ExState = 2;
X                else
X                    ExState = 3;
X            } else {
X                OUTB(DLE);
X                ExState = 0;
X            }
X            break;
X
X        case 2:{
X                Len += nchar;
X                ExState = 3;
X            }
X            break;
X
X        case 3:{
X                register int i = Len + 3;
X                int offset = (((V >> D_shift[factor]) &
X                               D_mask[factor]) << 8) + nchar + 1;
X                longint op = (outpos + outcnt) - offset;
X
X                /* special case- before start of file */
X                while ((op < 0L) && (i > 0)) {
X                    OUTB(0);
X                    op++;
X                    i--;
X                }
X
X                /* normal copy of data from output buffer */
X                {
X                    register int ix = (int) (op % OUTBUFSIZ);
X
X                    /* do a block memory copy if possible */
X                    if (((ix + i) < OUTBUFSIZ) &&
X                        ((outcnt + i) < OUTBUFSIZ)) {
X                        memcpy(outptr, &outbuf[ix], i);
X                        outptr += i;
X                        outcnt += i;
X                    }
X                    /* otherwise copy byte by byte */
X                    else
X                        while (i--) {
X                            OUTB(outbuf[ix]);
X                            if (++ix >= OUTBUFSIZ)
X                                ix = 0;
X                        }
X                }
X
X                ExState = 0;
X            }
X            break;
X        }
X
X        /* store character for next iteration */
X        lchar = nchar;
X    }
X}
X
X
X
X
X
X/******************************/
X/*  Function LoadFollowers()  */
X/******************************/
X
Xstatic void LoadFollowers()
X{
X    register int x;
X    register int i;
X
X    for (x = 255; x >= 0; x--) {
X        READBIT(6, Slen[x]);
X        for (i = 0; i < Slen[x]; i++) {
X            READBIT(8, followers[x][i]);
X        }
X    }
X}
END_OF_FILE
  if test 5034 -ne `wc -c <'./v41/unreduce.c'`; then
    echo shar: \"'./v41/unreduce.c'\" unpacked with wrong size!
  fi
  # end of './v41/unreduce.c'
fi
if test -f './v41/unshrink.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unshrink.c'\"
else
  echo shar: Extracting \"'./v41/unshrink.c'\" \(4365 characters\)
  sed "s/^X//" >'./v41/unshrink.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  unshrink.c
X
X  Shrinking is a Dynamic Lempel-Ziv-Welch compression algorithm with partial
X  clearing.
X
X  ---------------------------------------------------------------------------*/
X
X
X#include "unzip.h"
X
X
X/*************************************/
X/*  UnShrink Defines, Globals, etc.  */
X/*************************************/
X
X/*      MAX_BITS        13   (in unzip.h; defines size of global work area)  */
X#define INIT_BITS       9
X#define FIRST_ENT       257
X#define CLEAR           256
X#define GetCode(dest)   READBIT(codesize,dest)
X
Xstatic void partial_clear __((void));   /* local prototype */
X
Xint codesize, maxcode, maxcodemax, free_ent;
X
X
X
X
X/*************************/
X/*  Function unShrink()  */
X/*************************/
X
Xvoid unShrink()
X{
X    register int code;
X    register int stackp;
X    int finchar;
X    int oldcode;
X    int incode;
X
X
X    /* decompress the file */
X    codesize = INIT_BITS;
X    maxcode = (1 << codesize) - 1;
X    maxcodemax = HSIZE;         /* (1 << MAX_BITS) */
X    free_ent = FIRST_ENT;
X
X    for (code = maxcodemax; code > 255; code--)
X        prefix_of[code] = -1;
X
X    for (code = 255; code >= 0; code--) {
X        prefix_of[code] = 0;
X        suffix_of[code] = code;
X    }
X
X    GetCode(oldcode);
X    if (zipeof)
X        return;
X    finchar = oldcode;
X
X    OUTB(finchar);
X
X    stackp = HSIZE;
X
X    while (!zipeof) {
X        GetCode(code);
X        if (zipeof)
X            return;
X
X        while (code == CLEAR) {
X            GetCode(code);
X            switch (code) {
X
X            case 1:{
X                    codesize++;
X                    if (codesize == MAX_BITS)
X                        maxcode = maxcodemax;
X                    else
X                        maxcode = (1 << codesize) - 1;
X                }
X                break;
X
X            case 2:
X                partial_clear();
X                break;
X            }
X
X            GetCode(code);
X            if (zipeof)
X                return;
X        }
X
X
X        /* special case for KwKwK string */
X        incode = code;
X        if (prefix_of[code] == -1) {
X            stack[--stackp] = finchar;
X            code = oldcode;
X        }
X        /* generate output characters in reverse order */
X        while (code >= FIRST_ENT) {
X            if (prefix_of[code] == -1) {
X                stack[--stackp] = finchar;
X                code = oldcode;
X            } else {
X                stack[--stackp] = suffix_of[code];
X                code = prefix_of[code];
X            }
X        }
X
X        finchar = suffix_of[code];
X        stack[--stackp] = finchar;
X
X
X        /* and put them out in forward order, block copy */
X        if ((HSIZE - stackp + outcnt) < OUTBUFSIZ) {
X            memcpy(outptr, &stack[stackp], HSIZE - stackp);
X            outptr += HSIZE - stackp;
X            outcnt += HSIZE - stackp;
X            stackp = HSIZE;
X        }
X        /* output byte by byte if we can't go by blocks */
X        else
X            while (stackp < HSIZE)
X                OUTB(stack[stackp++]);
X
X
X        /* generate new entry */
X        code = free_ent;
X        if (code < maxcodemax) {
X            prefix_of[code] = oldcode;
X            suffix_of[code] = finchar;
X
X            do
X                code++;
X            while ((code < maxcodemax) && (prefix_of[code] != -1));
X
X            free_ent = code;
X        }
X        /* remember previous code */
X        oldcode = incode;
X    }
X}
X
X
X/******************************/
X/*  Function partial_clear()  */
X/******************************/
X
Xstatic void partial_clear()
X{
X    register int pr;
X    register int cd;
X
X    /* mark all nodes as potentially unused */
X    for (cd = FIRST_ENT; cd < free_ent; cd++)
X        prefix_of[cd] |= 0x8000;
X
X    /* unmark those that are used by other nodes */
X    for (cd = FIRST_ENT; cd < free_ent; cd++) {
X        pr = prefix_of[cd] & 0x7fff;    /* reference to another node? */
X        if (pr >= FIRST_ENT)    /* flag node as referenced */
X            prefix_of[pr] &= 0x7fff;
X    }
X
X    /* clear the ones that are still marked */
X    for (cd = FIRST_ENT; cd < free_ent; cd++)
X        if ((prefix_of[cd] & 0x8000) != 0)
X            prefix_of[cd] = -1;
X
X    /* find first cleared node as next free_ent */
X    cd = FIRST_ENT;
X    while ((cd < maxcodemax) && (prefix_of[cd] != -1))
X        cd++;
X    free_ent = cd;
X}
END_OF_FILE
  if test 4365 -ne `wc -c <'./v41/unshrink.c'`; then
    echo shar: \"'./v41/unshrink.c'\" unpacked with wrong size!
  fi
  # end of './v41/unshrink.c'
fi
if test -f './v41/unzip.1' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unzip.1'\"
else
  echo shar: Extracting \"'./v41/unzip.1'\" \(2689 characters\)
  sed "s/^X//" >'./v41/unzip.1' <<'END_OF_FILE'
X.TH unzip 1 "UNIX UnZip version 4.1"
X.SH NAME
Xunzip - list/test/extract from a ZIP archive file
X.SH SYNOPSIS
Xunzip [ -xecptlvz[qadoUV] ] file[.zip] [filespec...]
X.SH ARGUMENTS
X.in +12
X.ti -12
Xfile[.zip]  Path of the ZIP archive.  The suffix ``.zip'' is applied
Xif the file specified does not exist.  Note that
Xself-extracting ZIP files are supported; just specify
Xthe ``.exe'' suffix yourself.
X.sp 1
X.ti -12
X[filespec]  An optional list of archive members to be processed.
XExpressions may be used to match multiple members; be sure to quote
Xexpressions that contain characters interpreted by the UNIX shell. See
XDESCRIPTION (below) for more details.
X.SH OPTIONS
X.nf
X-x,-e  extract files in archive (default--i.e., this flag is optional)
X-c     extract files to stdout (``CRT'')
X-p     extract files to stdout and no informational messages (for pipes)
X-t     test archive contents for validity
X-l     list archive contents (short format)
X-v     verbose listing of archive contents
X-z     display only the archive comment
X.fi
X.SH MODIFIERS
X.nf
X-q     perform operations quietly (up to two q's allowed)
X-a     convert to MS-DOS textfile format (CR LF), Mac format (CR),
X         Unix/VMS format (LF), OR from ASCII to EBCDIC, depending on 
X         your system
X-d     recreate directory structure contained in archive
X-o     OK to overwrite files without prompting
X-U     don't map filenames to lowercase for selected (uppercase) OS's
X-V     retain file version numbers
X.fi
X.SH DESCRIPTION
X.B unzip
Xwill list, test, or extract from a ZIP archive, commonly found on MSDOS
Xsystems.
XArchive member extraction is implied by the absence of the -c, -p, -t, 
X-l, -v or -z options.  All archive members are processed unless a
X.B filespec
Xis provided to specify a subset of the archive members.
XThe
X.B filespec
Xis similar to an egrep expression, and may contain:
X.sp 1
X.in +8
X.ti -8
X*       matches a sequence of 0 or more characters
X.ti -8
X?       matches exactly 1 character
X.ti -8
X\\nnn    matches the character having octal code nnn
X.ti -8
X[...]   matches any single character found inside the brackets; ranges
Xare specified by a beginning character, a hyphen, and an ending
Xcharacter.  If a '!' follows the left bracket, then the range
Xof characters matched is complemented with respect to the ASCII
Xcharacter set.
X.SH AUTHORS
X.nf
Xv1.2   3/15/89   Samuel H. Smith
Xv2.x   1989      Many contributors.	
Xv3.0   5/1/90    David Kirschbaum, consolidator, and the Info-ZIP 
X                   workgroup (Info-ZIP@WSMR-SIMTEL20.Army.Mil).
Xv3.1   8/15/90   Same luvable gang.
Xv4.0   12/1/90   Getting more luvable by the day.
Xv4.1   5/12/91   We got too luvable, so we toned it down a bit (for Mom).
X.fi
END_OF_FILE
  if test 2689 -ne `wc -c <'./v41/unzip.1'`; then
    echo shar: \"'./v41/unzip.1'\" unpacked with wrong size!
  fi
  # end of './v41/unzip.1'
fi
if test -f './v41/unzip.man' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unzip.man'\"
else
  echo shar: Extracting \"'./v41/unzip.man'\" \(3250 characters\)
  sed "s/^X//" >'./v41/unzip.man' <<'END_OF_FILE'
X
X
X
Xunzip(1)            UNIX Programmer's Manual             unzip(1)
X
X
X
XNAME
X     unzip - list/test/extract from a ZIP archive file
X
XSYNOPSIS
X     unzip [ -xecptlvz[qadoUV] ] file[.zip] [filespec...]
X
XARGUMENTS
X     file[.zip]  Path of the ZIP archive.  The suffix ``.zip'' is
X                 applied if the file specified does not exist.
X                 Note that self-extracting ZIP files are sup-
X                 ported; just specify the ``.exe'' suffix your-
X                 self.
X
X     [filespec]  An optional list of archive members to be pro-
X                 cessed.  Expressions may be used to match multi-
X                 ple members; be sure to quote expressions that
X                 contain characters interpreted by the UNIX
X                 shell. See DESCRIPTION (below) for more details.
X
XOPTIONS
X     -x,-e  extract files in archive (default--i.e., this flag is optional)
X     -c     extract files to stdout (``CRT'')
X     -p     extract files to stdout and no informational messages (for pipes)
X     -t     test archive contents for validity
X     -l     list archive contents (short format)
X     -v     verbose listing of archive contents
X     -z     display only the archive comment
X
XMODIFIERS
X     -q     perform operations quietly (up to two q's allowed)
X     -a     convert to MS-DOS textfile format (CR LF), Mac format (CR),
X              Unix/VMS format (LF), OR from ASCII to EBCDIC, depending on
X              your system
X     -d     recreate directory structure contained in archive
X     -o     OK to overwrite files without prompting
X     -U     don't map filenames to lowercase for selected (uppercase) OS's
X     -V     retain file version numbers
X
XDESCRIPTION
X     unzip will list, test, or extract from a ZIP archive, com-
X     monly found on MSDOS systems.  Archive member extraction is
X     implied by the absence of the -c, -p, -t, -l, -v or -z
X     options.  All archive members are processed unless a
X     filespec is provided to specify a subset of the archive
X     members.  The filespec is similar to an egrep expression,
X     and may contain:
X
X     *       matches a sequence of 0 or more characters
X     ?       matches exactly 1 character
X     \nnn    matches the character having octal code nnn
X     [...]   matches any single character found inside the brack-
X             ets; ranges are specified by a beginning character,
X
X
X
XPrinted 5/13/91      UNIX UnZip version 4.1                     1
X
X
X
X
X
X
Xunzip(1)            UNIX Programmer's Manual             unzip(1)
X
X
X
X             a hyphen, and an ending character.  If a '!' follows
X             the left bracket, then the range of characters
X             matched is complemented with respect to the ASCII
X             character set.
X
XAUTHORS
X     v1.2   3/15/89   Samuel H. Smith
X     v2.x   1989      Many contributors.
X     v3.0   5/1/90    David Kirschbaum, consolidator, and the Info-ZIP
X                        workgroup (Info-ZIP@WSMR-SIMTEL20.Army.Mil).
X     v3.1   8/15/90   Same luvable gang.
X     v4.0   12/1/90   Getting more luvable by the day.
X     v4.1   5/12/91   We got too luvable, so we toned it down a bit (for Mom).
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
X
XPrinted 5/13/91      UNIX UnZip version 4.1                     2
X
X
X
END_OF_FILE
  if test 3250 -ne `wc -c <'./v41/unzip.man'`; then
    echo shar: \"'./v41/unzip.man'\" unpacked with wrong size!
  fi
  # end of './v41/unzip.man'
fi
if test -f './v41/ziprules.txt' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ziprules.txt'\"
else
  echo shar: Extracting \"'./v41/ziprules.txt'\" \(5218 characters\)
  sed "s/^X//" >'./v41/ziprules.txt' <<'END_OF_FILE'
XSubject: Info-ZIP Rules (No Feelthy ...)
X
XIn discussions with Mark Adler (and others), I realized we in the Info-ZIP
Xcommunity have been evolving a set of rules that maybe oughtta be
Xdocumented, archived, and available to potential contributors.
X
XThe following appear to meet our requirements.  Please observe these
Xrules when submitting source, context diff, or other files to Info-ZIP.
X
X
X1 - "NO FEELTHY TABS"
X
X    Many editors and EMail systems either have no capability to use and/or
Xdisplay the Ascii 9 TAB character correctly, or there are variable tab
Xcolumns, or other horrors.  (My MaxEMail offline email editor for one.)
X
X    Bottom line:  use spaces, not tabs.
X
X    Related utility programs:  Unix and MS-DOS :  expand, unexpand.
XMS-DOS: Buerg's TABS; Toad Hall's TOADSOFT.  And some editors have the
Xconversion built-in.
X
X    Exceptions:  The Unix Makefile.  Some makes seem to require "real"
Xtabs.  If they need it there, fine.  So don't fiddle the Makefile.
X
X
X2 - "NO FEELTHY CRS"
X
X    All source, documentation and other text files shall have Unix style
Xline endings (LF, Ctrl-J), NOT the MS-DOS CR/LF or Mac CR line endings.
X
X    Reason:  "Real programmers" in any environment can convert back and
Xforth between Unix and DOS/Mac style.  MS-DOS Turbo C can use Unix or
XMS-DOS line endings (donno about Mac Turbo C).  Buerg's LIST file display
Xutility for MS-DOS can use Unix or MS-DOS line endings.  Unix utilities
Xlike diff and patch die a horrible death (or produce horrible output) if
Xtarget files have CRs.
X
X    Related utilities:  flip for Unix and MS-DOS.
X
X    Exceptions:  The zip archive README and zip.doc files, which Mark
XAdler wants to leave in MSDOS for "unsophisticated" (read brain-dead) DOS
Xusers.  Also the batch files to compile under MS-DOS (where it requires
Xthe CRs.)
X
X
X3 - "NO FEELTHY HEX"
X
X    We'll use uuencode/uudecode compatible converters to move binary files
Xthrough our 7-bit EMail systems (xxencode on special request).  Uuencoded
Xfiles, if larger than +/- 32Kb, will be broken into smaller (< 32Kb)
Xfiles (via David M. Read's UUXFER utility).
X
X    Reason:  to prevent sounds of gagging mailers from resounding
Xthroughout the land.  To be standard with the Uunet side of the world.
XTo be relatively efficient in the binary->Ascii conversion.  (Yeah, yeah,
XI know, there's better conversions out there.  But not as widely known.)
X
X    Related utilities:  uuencode, uudecode, uuxfer20, quux, others.
XJust make sure they don't leave imbedded or trailing spaces.  (E.g., they
Xshould use the "`" character in place of Ascii 32.)  Else mailers are
Xprone to truncate or whatever.  Message me if you need one.
X
X
X4 - "NO FEELTHY TARS"
X
X    unzip will be available in .tar.Z (16-bit compressed tar), .arc (as
Xavailable on Unix, SIMTEL20, PKPAK, etc., *NOT* the latest proprietary
XSEA version), or .zip format.  (If requesting we EMail you source,
Xspecify desired format.)  zip source will only be distributed in .zip
Xarchives.
X
X    Reason:  For unzip development or use, anyone should have one of the
Xspecified dearchivers.  For zip development or use, you shouldn't be
Xmessing with zip unless you can already unzip.  (This protects the
Xinnocent.)
X
X    Related utilities:  Unix:  arc, tar, compress, zip, unzip.  MS-DOS:
XPKUNPAK, PKUNZIP, PAK, TAR, COMPRESS, and others.
X
X    Exceptions:  EMail me directly for any special circumstances or
Xrequirements (zoo, BinHex, 12-bit compress, etc.)
X
X
X5 - "NO FEELTHY FANCY_NAMES"
X
X    Assume the worst:  that someone on a brain-damaged DOS system has to
Xwork with everything your magic fingers produced.  Keep the file names
Xunimaginative and within MS-DOS limits (e.g., ordinary A..Z, 1..9, "-$_!"
Xtype characters, in the "filename.typ" 8-dot-3 format).  MacUsers, giggle
Xall you want, but no spaces.
X
X    Reason:  Compatibility with different file systems.  MS-DOS is the
Xmost limited.
X
X
X6 - "NO FEELTHY GRAPHICS"
X
X    Do all your editing in a plain-text ASCII editor.  No WordPerfect,
XWord, WordStar document mode, or other word processor files, thenkyew.
XNo desktop publishing.  No TIFFs, no GIFs, no imbedded pictures or dancing
Xladies (too bad, Cave Newt).
X
X    Reason:  Compatibility with different consoles.  My old XT clone is
Xthe most limited!
X
X    Related utilities:  vi, ed, EDLIN, Turbo C editor, UED, EASYEDIT, cat
Xor "COPY CON UNZIP.C"; various word processor -> text conversion utilities.
X
X
X7 - "NO FEELTHY DASHES"
X
X    Don't have repeated dashes (starting at the left margin) in any
Xsource code or patches you try to EMail to me or Info-ZIP.  Instead, be
Xsure to always prefix them with a space, asterisk, comment, whatever, like
Xthis:
X#---------------   or
X/*--------------   or even
X ---------------   (just indented)
X
X    Reason:  Most "undigestify" utilities (that break down newsletters
Xinto their separate messages) use that "--------" (starting at the left
Xmargin) as the symbol that it's hit the end of a message.  I'd rather not
Xhave your C source file broken up into a dozen separate untitled messages
Xin my mail system, thank you.  I'll be going through the unzip source Any
XDay Now and changing anything like that by indenting, prefixing, whatever.
X
X
X*-------------------*
X
XDavid Kirschbaum
XInfo-ZIP Coordinator
END_OF_FILE
  if test 5218 -ne `wc -c <'./v41/ziprules.txt'`; then
    echo shar: \"'./v41/ziprules.txt'\" unpacked with wrong size!
  fi
  # end of './v41/ziprules.txt'
fi
echo shar: End of archive 5 \(of 6\).
cp /dev/null ark5isdone
MISSING=""
for I in 1 2 3 4 5 6 ; do
    if test ! -f ark${I}isdone ; then
	MISSING="${MISSING} ${I}"
    fi
done
if test "${MISSING}" = "" ; then
    echo You have unpacked all 6 archives.
    rm -f ark[1-9]isdone
else
    echo You still must unpack the following archives:
    echo "        " ${MISSING}
fi
exit 0
exit 0 # Just in case...
