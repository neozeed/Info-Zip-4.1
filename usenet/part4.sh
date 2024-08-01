#! /bin/sh
# into a shell via "sh file" or similar.  To overwrite existing files,
# type "sh file -c".
# The tool that generated this appeared in the comp.sources.unix newsgroup;
# send mail to comp-sources-unix@uunet.uu.net if you want that tool.
# Contents:  ./v41/History.41 ./v41/Makefile ./v41/mapname.c
#   ./v41/match.c
# Wrapped by kent@sparky on Sun May 19 19:40:39 1991
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
echo If this archive is complete, you will see the following message:
echo '          "shar: End of archive 4 (of 6)."'
if test -f './v41/History.41' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/History.41'\"
else
  echo shar: Extracting \"'./v41/History.41'\" \(16045 characters\)
  sed "s/^X//" >'./v41/History.41' <<'END_OF_FILE'
Xunzip version 4.1, 13 May 91
X
X- Cave Newt, Info-ZIP #139
XThese are the minor things I found:
X   (1) the do-nothing file_io.c umask patch got included by mistake
X   (2) those same two lines in unzip.c are shifted over again (somebody's
X        patch program REALLY doesn't like those lines...they're full of
X        feelthy tabs, which may have something to do with it)
X   (3) the man page wasn't quite updated to reflect the -z and -o options
X   (4) the Makefile now has two msc_os2 targets
X
XI've fixed (1) through (3) in this patch.  None of them actually has any
Ximpact on the code--(2) is obviously cosmetic, and (1) is effectively so,
Xalthough it's potentially dangerous.  For the man page I just updated the
Xnroff source (unzip.1); unzip.man can be regenerated.  In addition to in-
Xcluding "o" and "z" in the synopsis and adding the -z description, I also
Xfigured I might as well put in the "4.1" comments, so I did that.
X[Affected file_io.c, unzip.c, unzip.1]
X
X- Jim Dumser, Info-ZIP #140, 7 May 91
XFirst is my "proposed" umask patch, after which I conceded to Greg's
Xfix.  It was still included, and altho it doesn't hurt anybody, it
Xreally shouldn't be in there.  [NOP, fixed by Cave Newt's patch above.]
X
XSecond is something that will hurt people.  There were 2 msc_os2 targets
Xin the Makefile.  I picked the one that was submitted last (and for
Xwhich the .def file was included), and removed the other.
X[Affected Makefile]
X
X-Cave Newt, 8 May 91 (private message, not in Info-ZIP)
XYes, it's YAVU (Yet Another VMS Update).  I edited the VMSNOTES file
Xa little bit to reflect what I've lately figured out about the "variable
Xlength, 510 byte max" format, and I undid the interior vmsattr.zip file
Xsince there wasn't much need for it as a separate sub-sub-archive.  No
Xbig changes, but we may as well get ready for the release.
X[New VMS.zip]
X
X- Cave Newt, 10 May 91 (private message, not in Info-ZIP)
XFirst of all, one last (?) change to the man page:  I forgot to update
Xthe info for the -a switch, and it still contained your old e-mail
Xaddress.  Good thing you ignored my impatient nagging, huh? :-)  Patch 
Xbelow to the patch I already sent you...
X[Affected unzip.1]
X
XAnd from the Coordinator:
XWe're going public with this one, folks.  History, here we come!
X
X================
X
Xv4.07 BETA, 4 May 91
X
X- (That's "05-04-91" in feelthy civilian format)
X
X- Starting with v4.06 source, patched in the v4.06a stuff
X  (see UNZ_406A.ZIP patch file)
X
X- Wim Bonner's OS2 Makefile patch (for long file names)
X  and an "unzip.def" file.  (MAKEFILE.127)
X- Cave Newt: fix for Makefile's pyramid target (MAKEFILE.406)
X- Mark Adler's minor diffs to make it compile cleaner and smaller
X  on the NeXT (plus trimmed out some feelthy tabs).  (UNZIP.125)
X
X- The Great Umask Wars commence, with Bo Kullmar, Cave Newt,
X  and Jim Dumser all contributing to the Infamous Info-ZIP MindFog.
X  (It all worked out in the end .. kinda ..)
X  UNZIP_C.128: Bo's first shots at Fort Sumpter; UNZIP_C.129: Cave
X  Newt throws in a few curves.
X
X- Bo Kullmar adds a -z option to only display the archive comment.
X  He also notices the Infamous 8192 bug (an extra LF is inserted
X  after every 8192 byte in the do_string function.
X  (UNZIP_C.132)
X
X- Info-ZIP Coordinator prepares lengthy curses for anyone preparing
X  to write 8192-byte-long archive comments.  (Private files)
X
X- Jim Dumser then leaps into the -z conflict.  He also discovers
X  who's sneaking in feelthy tabs to our source!
X  He then coins the famous phrase:
X  "needs to be applied either before Bo's patch ("A -z option to unzip",
X  91.129) or after my patch ("Re:  A -z option to unzip", 91.130).
X  Actually, because the 91.129 patch does more than just add the COMMENT
X  option, you really need to apply both Bo's and mine, then apply this."
X  (Which *almost* invokes Info-ZIP Coordinator's curses.)
X  (UNZIP_C.133, UNZIP_C.134)
X
X- Jim Dumser, returning to the Umask Front, discovers there *ain't*
X  no feelthy umask() in Turbo C!  And MSC fakes it.  umask()-related
X  code is #ifdef'ed for Unix systems only.  (DUMSER.407)
X- Cave Newt chucks a grenade into umask() with yet more #ifdefs.
X  (407.MSG)
X- Jim Dumser pretends to clear up the confusion.  Contributes a stupendous
X  diff or two just to be sure I got it all.  Bo Kullmar throws in one
X  of them too.  Looks like I got it all.
X
X================
X
Xv4.06a, late April 91
X
X - unzip Makefile:  fix for pyramid target from Cave Newt.
X   Somebody switched "make" with "$MAKE" or some such.
X
X- Makefile Change for OS/2 (and addition of def file)
X  (Wim Bonner).  Tweak to the msc_os2 system of the Makefile,
X  plus a wee little def file for OS/2.
X
X- Unzip 4.06 diffs for the NeXT (Mark Adler)
X  "Here are some very minor diffs for Unzip 4.06 to make it compile cleaner
X  and smaller on the NeXT.  (By the way, there were feelthy tabs in unzip.c,
X  unzip.h, and a few other non-source files.)"
X
X================
X
X4.06, 25 April 1991
X
X- Minor patches to Makefile (Jim Dumser, Info-ZIP #096
X- And then a BIG change to Makefile: a "generic" Makefile
X  From Cave Newt (Info-ZIP #099)
X- Case-conversion-info patch from Cave Newt (Info-ZIP #098):
X  "Unzip does 'smart' lowercasing of filenames in zipfiles,
X  a feature I like a lot (that's why I put it in :-).  But zip
X  doesn't do any conversions, and it's easy to forget sometimes
X  that all the names in a zipfile are really uppercase.  This is
X  a PROPOSED patch that lets you know when case-conversion has
X  occurred in unzip."
X  Well, the Newt proposed .. and nobody screamed .. so it becomes
X  gospel.
X- VMS file attribute patch (Cave Newt, Info-ZIP #098):
X  Wee little patches to the unix code, and some new files in the
X  VMS.zip file.
X- Wim Bonner, Info-ZIP #100, reported a "missing semicolon" error
X  with MSC 6.0 and OS/2:
X  "The problem is that there are a set of local variables declared in
X  conditional defines, and they are after some code has already appeared
X  in the subroutine.
X  "If the conditional block is moved before the small amount of code, the
X  file compiles OK."
X  Fixed.
X- Jim Dumser (Info-ZIP #???, 26 Mar), further patching Cave Newt's
X  file attributes patch with more of his own.
X- Info-ZIP #106:  Patched to solve problem with truncated comments.
X- Added "-o" and "-n" patches by Gene McManus (Info-ZIP #106),
X  to permit overwriting output files without prompting.
X  These switches do virtually the same thing (so I don't know why
X  he did them both) .. and the patches kinda conflict .. but I made
X  it fit.
X- Mac diffs from Johnny Lee (Info-ZIP #115):
X  "Catching up with the permissions changes. Since I don't have any
X  AppleShare docs handy, this patch only determines if a file
X  is read-only or not."
X- Cave Newt (Info-ZIP #120) fixes the -a switch usage screen.
X- Cave Newt (Info-ZIP #121) *really* fixes the truncated zip comment
X  (superseding my fix in #106).
X
XArchive still includes the MAC, VMS, and ATARI-specific code in
Xtheir own separate .ZIPs.
X
XLast patches before public v4.10 release (I hope)
X
XDavid Kirschbaum
XInfo-ZIP Coordinator
X
X================
X
X4.05, 19 Mar 91
X
X[We're going to use Greg Roelof's version, since his is probably the
Xmost complete.  From the header of his message: ]
X
XHere's the package, in two parts.  The zipfile is basically complete, 
Xexcept that it doesn't have a History.405 file or an unzip405.descr
Xfile.  I've grouped the non-Unix-OS stuff into four sub-zipfiles inside
Xthe main one:  one each for Atari ST, Mac, MS-DOS, and VMS.  This keeps
Xthings a little cleaner and prevents collisions between the Atari Turbo
Xmakefiles and the MS-DOS ones.  You can take them out for the beta
Xversion if you want, but they aren't really all that big.  Note that
Xthe Mac and Atari binaries are NOT included; the little zipfiles only
Xcontain extra source files, notes, and makefile stuff.
X
XNow, a complete list of the changes to 4.05 from 4.04:
X
X  Missing 4.04 patches:
X	- Antoine's FILENAME_MAX fix
X        - size-of-encrypted-member (negative size factors) fix
X	- Bo's missing <sys/timeb.h> for BSD moved into unzip.h
X
X  Bug fixes:
X	- setting the time on stdout
X	- listing of three digits of 21st century years instead of two
X	- multiple usage screens for non-existent switches (e.g., unzip -XY)
X	- [VMS] inability to set file dates when extracting directory trees
X	- [VMS] choke-and-die on multiple-dot filenames (now converted to '_')
X
X  New features:
X	- BIG Mac attack from Johnny Lee
X	- (correct) handling of file permissions, both Unix zip and PKZIP
X	- new -V option to retain version numbers from VMS-created zipfiles
X	- ifdef'd code to deal with PAK bug ("on" for now)
X	- detection of big-endian and/or struct-padding behavior, and noti-
X	   fication to user to recompile if necessary
X
X  New Makefile targets:
X	- msc_os2 from Wim Bonner
X	- sequent from Phil Howard
X	- ultrix split into ultrix_vax and ultrix_risc
X	- dec5820 commented out (ultrix_risc system)
X	- renames:  diab -> dnix; cray_scc -> cray
X
X
XNOT included in this release are the Atari patches; partly this is because
Xthe majority of them had nothing to do with Atari at all and should have
Xbeen posted to the group, and partly it is because the remaining ones, which
XDID have to do with Atari, largely consisted of the removal of all the non-
XAtari operating systems (like Unix, DOS, VMS; Mac didn't exist at the time).
X
XAlso not included are (1) the proposed "generic"/"generic2" makefile targets
X(still waiting for some Info-ZIP feedback); (2) the ultimate VMS file-type
Xfix on which I've been working (close, still waiting on someone); and (3) a 
Xnew case-conversion-warning patch I'll post shortly to see what folks think.
X(Oh, and the two 4.05 description files I mentioned above.)
X
XI don't *think* I missed any unzip patches that have been posted, but people
Xshould check carefully to see if their favorite one is in here.  Also, the
XMac patches collided rather violently with my own, so folks should keep their
Xeyes peeled.  I tried to hand-tweak everything, but patch may have snuck one
Xor two into a slightly wrong place.  No crashes yet on MY system...
X
XFinally, with the exception of the PAK-fix, I think I've removed everything
Xthat hasn't been posted in one way or another (i.e., my own little tweaks).
XSo this should be a nice, clean release, which should in turn make everyone
Xvery happy.
X
XGreg
X
X================
X
Xv4.04, 22 Feb 91
X
X- Makefile:
X  From: Michael Regoli <mr@ogre.cica.indiana.edu>
X  It looks as if "make" is not defined for the IBM RT.  
X  We need a MAKE macro definition on or about line 67:
X  (And he sent a context diff.  Applied.)
X
X  From: bkahn@archive.webo.dg.com (Bruce Kahn)
X  I just got a copy of 4.03 from the archives and it seems that my little
X  addition to the Makefile from 3.1x to support Data General AViiONs was
X  lost.  Im enclosing a diff -c on the 'current' 4.03 makefile to add this
X  back in.
X  (Applied after slight editing.)
X
X  And someone said Suns needed "-DBSD" on their make line (maybe
X  Josh? Bo Kullmar?).  Anyway, Suns are now broken out onto their own line
X  (basically "_16", plus "-DBSD").
X
X- file_io.c (The date/time problem, fixed by Bo Kullmar): 
X  Lots of changes (confusing), so you'd want the original message
X  and patch if you want details.  Usually named file_io.404.
X  Bo's patch forgot one thing: a reference to /sys/timeb.h for BSD systems.
X  (diff included and applied)
X
X- New VMS files from Cave Newt (entirely replacing old ones, and one
X  VMSSHARE.OPT or some such deleted entirely).
X
X- unzip.c
X
X  From: Cave Newt <roelofs@amelia.nas.nasa.gov>
X  Subject: Compression ratio calculation bug
X
X  Ah, yes, the old negative-ratio bug.  Below is a patch to fix this;
X  here's the explanation:
X  [explanation deleted, patch applied.]
X
X================
X
X
Xv4.03, 8 Dec 90
X
X- Changes to VMSNOTES.
X- Patched via Newt's "even more stupendous(ly long) 4.03 patches"
X- Entirely new unzip.c and unzip.h
X- misc.c, mapname.c and file_io.c patched via patch.403
X- Fixes are for VMS: reversion to block-boundary seeks while
X  retaining the random-access behavior that gives (n)unzip its speed.
X- Routines to find end-of-central-directory sig rewritten and
X  streamlined into a single function.
X- New LSEEK macro added.
X[Full details for all this horridness are in the unz403_p patch archive.]
X 
X- Fix involving making the filename longer
X- fixing a leap-year bug (2000 IS a leap year).
X- Consolidated more repeated error strings (unzip.c)
X- Removed an unused macro (UPDCRC32).
X
X================
X
Xv4.02, 6 Dec 90
X
X- Per Cave Newt's request, changed nunzip's in VMS_MAKE.COM
X  to unzip.
X
X- mapname.c :  History of changes removed.
X
X- Many changes, patches in Cave Newt's big unzip_c.401, unz402_p.zip,
X  to include more extensive explanation and comments.
X
X- Bug in unzip.c related to encryption:
X  Mark and Newt were getting "bus errors" (sic) when unzip tried to test
X  or unzip an encrypted file. (Probably array overruns)
X  Solution:  check general purpose bit flag to see if file is encrypted.
X  If so, skip it (with regretful message).
X  Later we may decrypt (Mark offers his routine).
X
X- -t option change:
X  The -t option in 4.01 currently prints both the individual file "OKs"
X  and a summary; this is redundant.  So now -t just prints the "OKs"
X  (like the old versions), -tq just prints the summary, and -tqq
X  doesn't print anything at all.
X
X- Misc indentation corrected.
X
X- man page changed:
X  Separated the modifier options into their own little heading.
X  Expanded the -a explanation to include EBCDIC, since that's why it was
X  originally done in the first place.
X  Added 3.1 to the list at the bottom.
X
X- Minor centralization of repeated error message strings.
X
X================
X
Xv4.01, 4 Dec 90:
X
X1 - From Down Under:
XFrom: aas@cc.uq.oz.au
X
XThe makefile.msc as it stands more or less works for TurboC 2.0,
Xso makefile.tc is probably redundant.  However, TurboC throws what
Xwe colloquially call a `wobbly' over one line in file_io.c: where
X`>> (space) =' is used instead of the ANSI `>>=' construct.  The
Xfix is easy (appended).
X
X[Makefile.msc patched to include both Turbo C and MSC compiles,
X renamed to MAKEFILE.DOS.  Actually, it's for OS/2 also.
X Works just fine for Turbo C v2.0, can't test the others.
X Removed MAKEFILE.TC.
X]
X
XAnd the file_io.c patch was a one-liner at line 312 /318:
X!     bitbuf >> = bits;
Xchanged to:
X!     bitbuf >>= bits;
X
X================
X
X2 - From: Cave Newt <roelofs@amelia.nas.nasa.gov>
X    (details in unzip400.msg, unz401_p.zip)
X
X- a patch to 3.99 which you missed and I forgot about:  the name[STRSIZ]
X  one in mapname.c.
X  [Extracted to mapname.pch, mapname.c patched.]
X
X- indent11 (AKA "Mr. Mangler") likes tabs, which is going to play hell 
X  with patches.
X
X  [I'm using indent11 with the "-kr" settings.
X   And all source will be archived with NO tabs.
X   Except for the stupid makefiles, however
X  ]
X
X- "makefile.msc" should have been uppercase.
X  [It's MAKEFILE.DOS now because of TC/MSC/OS2 integration.]
X
X- man page still says "3.1" at the top and has a weird (old)
X  e-mail address for you at the bottom.
X  [unzip.1 edited to reflect "4.0".]
X
X- Comments at the top of unzip.c say "unzip40.tar.Z" rather than
X  "unzip400".
X  [Fixed]
X
X================
XFinal 4.01 Toad Hall Note:
X- Compiling in Turbo C integrated environment (e.g., using the .PRJ
X  file) produced an UNZIP.EXE a couple hundred bytes smaller than the
X  one compiled via tcc and the MAKEFILE.DOS.  Obviously I've forgotten
X  a switch somewhere, or my default tcc settings are slightly off.
X  So if you want the absolute smallest, suggest integrated compile.
X- No more stupid mixing of Unix and DOS text files.  EVERYTHING's gonna
X  have (1) no tabs and (2) Unix LF line endings.  If you're gonna work
X  in DOS, you'd better have FLIP or TOADCRLF or some such to convert
X  these Unix files.
X  We'll still indicate DOS files vs. Unix files via name case (e.g.,
X  DOS files'll be all uppercase).  Of course, the VMS files are ALSO
X  uppercase (meant to ask you about that, Cave Newt), but that's ok.
X  For the DENSA members, anything starting with VMS is NOT DOS, ok?
X================
END_OF_FILE
  if test 16045 -ne `wc -c <'./v41/History.41'`; then
    echo shar: \"'./v41/History.41'\" unpacked with wrong size!
  fi
  # end of './v41/History.41'
fi
if test -f './v41/Makefile' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/Makefile'\"
else
  echo shar: Extracting \"'./v41/Makefile'\" \(14794 characters\)
  sed "s/^X//" >'./v41/Makefile' <<'END_OF_FILE'
X# Makefile for unzip
X#
X# ******** INSTRUCTIONS (such as they are) ********
X#
X# "make vax"	-- makes unzip on a VAX 11-780 BSD 4.3 in current directory
X#		   (or a SysV VAX, or an 8600 running Ultrix, or...)
X# "make"	-- uses environment variable SYSTEM to set the type
X#		   system to compile for.  This doesn't work for some
X#		   particularly brain-damaged versions of make (VAX BSD,
X#		   Gould, and SCO Unix are in this group).
X# "make wombat" -- Chokes and dies if you haven't added the specifics
X#		   for your Wombat 68000 (or whatever) to the systems list.
X#
X# CFLAGS are flags for the C compiler.  LDFLAGS are flags for the loader.
X# LDFLAGS2 are more flags for the loader, if they need to be at the end
X# of the line instead of at the beginning.
X#
X# My host (a VAX 11-780 running BSD 4.3) is hereafter referred to as
X# "my host."
X#
X# My host's /usr/include/sys/param.h defines BSD for me.
X# You may have to add "-DBSD" to the list of CFLAGS for your system.
X#
X# You MAY need to define "-DNOTINT16" if the program produces CRC errors
X# during a "-t" run or extraction (this involves structure alignment/padding);
X# you MUST define it if your machine is "big-endian" (i.e., it orders bytes
X# in Motorola fashion rather than Intel fashion).  The latter case is charac-
X# terized by errors of the form "some-kind-of-header signature not found.
X# Please report to Info-ZIP." OR a silent do-nothing return with an exit code
X# of 51 (EOF).  It should always be safe to define NOTINT16, but it does add
X# some overhead, so first try compiling without it and see what happens.
X# If death and destruction ensue, it's probably better to go ahead and use
X# NOTINT16.
X#
X# Some versions of make do not define the macro "$(MAKE)" (my host did not).
X# The makefile should now handle such systems correctly, more or less; the
X# possible exception to this is if you've used a make command-line option
X# (for example, the one which displays the commands which WOULD be executed,
X# but doesn't actually execute them).  It probably needs some more tinkering.
X# If things still don't work, use "make" instead of "$(MAKE)" in your system's
X# makerule.  Or try adding the following line to your .login file:
X#   setenv MAKE "make"
X# (It didn't help on my host.)
X#
X# memcpy and memset are provided for those systems that don't have them;
X# they're found in misc.c and will be used if -DZMEM is included in the list
X# of CFLAGS.  These days ALMOST all systems have them (they're mandated by
X# ANSI), but older systems might be lacking.  And at least ONE machine's
X# version results in some serious performance degradation...
X#
X# To test your nice new unzip, insure your zip file includes some LARGE
X# members.  Many systems ran just fine with zip file members < 512 bytes
X# but failed with larger ones.  Members which are "shrunk" rather than
X# "imploded" have also caused many problems in the past, so try to test a
X# zipfile which contains some of both.  And it's quite possible that this
X# program has NEVER been tested on a "reduced" file, so keep your eyes
X# open.  (They're probably mythical, though.)
X
X#####################
X# MACRO DEFINITIONS #
X#####################
X
X# Defaults most systems use
XCC = cc
XCFLAGS = -O -DUNIX
XLD = cc
XLDFLAGS = -o unzip
XEXE =
XO = .o
XOBJS = unzip$O file_io$O mapname$O match$O misc$O\
X       unimplod$O unreduce$O unshrink$O
X
XSHELL = /bin/sh
X
X# list of supported systems in this version
XSYSTEMS1 = 386i 3Bx amdahl apollo aviion convex cray cray_cc
XSYSTEMS2 = dnix encore generic generic2 gould hp mips msc_dos
XSYSTEMS3 = msc_os2 next pyramid rtaix sco sco_dos sequent sgi
XSYSTEMS4 = stellar sun tahoe ultrix_risc ultrix_vax vax wombat
X# SYSTEMS5 =
X
X####################
X# DEFAULT HANDLING #
X####################
X
X# The below will try to use your shell variable "SYSTEM" as the type system
X# to use (e.g., if you type "make" with no parameters at the command line).
X# The test for $(MAKE) is necessary for VAX BSD make (and Gould, apparently),
X# as is the "goober" (else stupid makes see an "else ;" statement, which they
X# don't like).  "goober" must then be made into a valid target for machines
X# which DO define MAKE properly (and have SYSTEM set).  Quel kludge, non?
X# And to top it all off, it appears that the VAX, at least, can't pick SYSTEM
X# out of the environment either (which, I suppose, should not be surprising).
X# [Btw, if the empty "goober" target causes someone else's make to barf, just
X# add an "@echo > /dev/null" command (or whatever).  Works OK on the Amdahl
X# and Crays, though.]
X
Xdefault:
X	@if test -z "$(MAKE)"; then\
X		if test -z "$(SYSTEM)";\
X		then make ERROR;\
X		else make $(SYSTEM) MAKE="make";\
X		fi;\
X	else\
X		if test -z "$(SYSTEM)";\
X		then $(MAKE) ERROR;\
X		else $(MAKE) $(SYSTEM) goober;\
X		fi;\
X	fi
X
Xgoober:
X
XERROR:
X	@echo
X	@echo\
X "  If you're not sure about the characteristics of your system, try typing"
X	@echo\
X '  "make generic".  If the compiler barfs and says something unpleasant about'
X	@echo\
X '  "timezone redefined," try typing "make clean" followed by "make generic2".'
X	@echo\
X '  One of these actions should produce a working copy of unzip on most Unix'
X	@echo\
X '  systems.  If you know a bit more about the machine on which you work, you'
X	@echo\
X '  might try "make list" for a list of the specific systems supported herein.'
X	@echo\
X '  And as a last resort, feel free to read the numerous comments within the'
X	@echo\
X '  Makefile itself.  Have an excruciatingly pleasant day.'
X	@echo
X
Xlist:
X	@echo
X	@echo\
X 'Type "make <system>", where <system> is one of the following:'
X	@echo
X	@echo  "	$(SYSTEMS1)"
X	@echo  "	$(SYSTEMS2)"
X	@echo  "	$(SYSTEMS3)"
X	@echo  "	$(SYSTEMS4)"
X#	@echo  "	$(SYSTEMS5)"
X	@echo
X	@echo\
X 'Otherwise set the shell variable SYSTEM to one of these and just type "make".'
X	@echo\
X 'For further (very useful) information, please read the comments in Makefile.'
X	@echo
X
X
X###############################################
X# BASIC COMPILE INSTRUCTIONS AND DEPENDENCIES #
X###############################################
X
X.c$O :
X	$(CC) -c $(CFLAGS) $*.c
X
Xunzip$(EXE):	$(OBJS)
X	$(LD) $(LDFLAGS) $(OBJS) $(LDFLAGS2)
X
Xfile_io$O:      file_io.c unzip.h
Xmapname$O:      mapname.c unzip.h
Xmatch$O:        match.c unzip.h
Xmisc$O:         misc.c unzip.h
Xunimplod$O:     unimplod.c unzip.h
Xunreduce$O:     unreduce.c unzip.h
Xunshrink$O:     unshrink.c unzip.h
Xunzip$O:        unzip.c unzip.h
X
Xclean:
X	rm -f $(OBJS) unzip$(EXE)
X
X# Zipinfo section commented out because it's no longer compatible with
X# the current unzip.h (I think).  Will be updated one of these days...
X#
X# zipinfo:	zipinfo.c unzip.h
X#	$(CC) $(CFLAGS) -DNOTINT16 zipinfo.c -o zipinfo
X
X
X################################
X# INDIVIDUAL MACHINE MAKERULES #
X################################
X
X# these are the makerules for various systems
X# TABS ARE REQUIRED FOR SOME VERSIONS OF make!
X
X
X# ---------------------------------------------------------------------------
X#   Generic targets (can't assume make utility groks "$(MAKE)")
X# ---------------------------------------------------------------------------
X
Xgeneric:	# first try for unknown systems:  hope make is called "make"...
X	make unzip CFLAGS="$(CFLAGS) -DNOTINT16"
X
Xgeneric2:	# second try for unknown systems:  keep hoping...
X	make unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DBSD"
X
X# ---------------------------------------------------------------------------
X#   "Normal" (i.e., PC-like) group (no #defines):
X# ---------------------------------------------------------------------------
X
X386i:		unzip	# sun386i, SunOS 4.0.2 ["sun:" works, too, but bigger]
Xencore:		unzip	# Multimax
Xsco:		unzip	# Xenix/386 (tested on 2.3.1); SCO Unix 3.2.0.
Xultrix_vax:	unzip	# VAXen running Ultrix (just 4.0?); not RISC machines
Xvax:		unzip	# general-purpose VAX target (not counting VMS)
X
X# ---------------------------------------------------------------------------
X#   NOTINT16 (structure-padding and/or big-endian) group:
X# ---------------------------------------------------------------------------
X
X3Bx:		_16	# AT&T 3B2/1000-80; should work on any WE32XXX machine
Xamdahl:		_16	# Amdahl (IBM) mainframe, UTS (SysV) 1.2.4 and 2.0.1
Xapollo:		_16	# Apollo Domain/OS machines
Xaviion:         _16     # Data General AViiONs, DG/UX 4.3x
Xconvex:		_16	# C200/C400
Xcray_cc:	_16	# Cray-2 and Y-MP, using old-style compiler
X#dec5820:	_16	# DEC 5820 (RISC), Test version of Ultrix v4.0
Xdnix:		_16	# 680X0, DIAB dnix 5.2/5.3 (a Swedish System V clone)
Xgould:		_16	# Gould PN9000 running UTX/32 2.1Bu01
Xhp:		_16	# HP 9000 series (68020), 4.3BSD or HP-UX A.B3.10 Ver D
Xmips:		_16	# MIPS M120-5(?), SysV R3 [error in sys/param.h file?]
X#next:		_16	# 68030 BSD 4.3+Mach
Xrtaix:		_16	# IBM RT 6150 under AIX 2.2.1
Xstellar:	_16	# gs-2000
Xtahoe:		_16	# tahoe (CCI Power6/32), 4.3BSD
X
X_16:
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16"
X
X# ---------------------------------------------------------------------------
X#   NOTINT16 + BSD (for timezone structs) group:
X# ---------------------------------------------------------------------------
X
Xsun:		_16bsd	# Sun 4/110, SunOS 4.0.3c; Sun 3 (68020), SunOS 4.0.3
Xultrix_risc:	_16bsd	# DEC 58x0 (MIPS guts), DECstation 2100; Ultrix v4.1
X
X_16bsd:
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DBSD"
X
X# ---------------------------------------------------------------------------
X#   "Unique" group (require non-standard options):
X# ---------------------------------------------------------------------------
X
X# Sequent Symmetry is a 386 but needs -DZMEM
X# This should also work on Balance but I can't test it just yet.
X
Xsequent:	# Sequent w/Dynix
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16 -DBSD -DZMEM"
X
X# I have finished porting unzip 3.0 to the Pyramid 90X under OSX4.1.
X# The biggest problem was the default structure alignment yielding two
X# extra bytes.  The compiler has the -q option to pack structures, and
X# this was all that was needed.  To avoid needing ZMEMS we could compile in
X# the att universe, but it runs slower!
X
Xpyramid:	# Pyramid 90X, probably all, under >= OSx4.1, BSD universe
X	make unzip CFLAGS="$(CFLAGS) -q -DBSD -DNOTINT16 -DZMEM"
X
X# I successfully compiled and tested the unzip program (v30) for the
X# Silicon Graphics environment (Personal Iris 4D20/G with IRIX v3.2.2)
X#
X#  Valter V. Cavecchia          | Bitnet:       cavecchi@itncisca
X#  Centro di Fisica del C.N.R.  | Internet:     root@itnsg1.cineca.it
X#  I-38050 Povo (TN) - Italy    | Decnet:       itnvax::cavecchia (37.65)
X
Xsgi:		# Silicon Graphics (tested on Personal Iris 4D20)
X	$(MAKE) unzip \
X	CFLAGS="$(CFLAGS) -I/usr/include/bsd -DBSD -DNOTINT16" \
X	LDFLAGS="-lbsd $(LDFLAGS)"
X
X# Cray-2 and Y-MP, running Unicos 5.1.10 or 6.0 (SysV + BSD enhancements)
X# and Standard (ANSI) C compiler 1.5 or 2.0.1.
X
Xcray:
X	$(MAKE) unzip CC="scc" LD="scc" CFLAGS="$(CFLAGS) -DNOTINT16"
X
X# SCO cross compile from unix to DOS. Tested with Xenix/386 and
X# OpenDeskTop. Should work with xenix/286 as well. (davidsen)
X# Note that you *must* remove the unix objects and executable
X# before doing this!
X
Xsco_dos:
X	$(MAKE) unzip CFLAGS="-O -dos -M0" LDFLAGS="-dos" \
X		LDFLAGS2="-o unzip.exe"
X
X# PCs (IBM-type), running MS-DOS, Microsoft C 6.00 and NMAKE.  Can't use the
X# SYSTEM environment variable; that requires processing the "default:" target,
X# which expands to some 200+ characters--well over DOS's 128-character limit.
X# "nmake msc_dos" works fine, aside from an annoying message, "temporary file
X# e:\ln023193 has been created."  I have no idea how to suppress this, but it
X# appears to be benign (comes from the link phase; the file is always deleted).
X# The environment variable FP should be set to something appropriate if your 
X# library uses other than the default floating-point routines; for example, 
X# SET FP=-FPi87 .  "msc_dos:" does NOT work with Dennis Vadura's dmake (dmake 
X# doesn't seem to understand quotes, and it wants SHELL=$(COMSPEC).  NMAKE 
X# ignores SHELL altogether.)  This target assumes the small-model library and 
X# an 80286 or better.  At present, everything fits within the 128-character 
X# command-line limit.  (Barely.)
X
Xmsc_dos:
X	$(MAKE) -nologo unzip.exe CFLAGS="-Ox -nologo $(FP) -G2" CC=cl\
X	LD=link EXE=.exe O=.obj LDFLAGS="/noi /nol" LDFLAGS2=",unzip;"
X
X# I do not believe that OS/2 has the 128 character command line limitation, 
X# so when I have more time to get to know how nmake really works, I may figure 
X# out how to set the makefile so that it works like most of the other things 
X# in unix.  The main things I had to change were adding the define -DOS2 and 
X# the C flag -Lp.  It still looks for the default named libraries, and not 
X# the protected-mode names, but I am sure most people dealing with OS/2 know
X# how to type slibcep when it says it can't find slibce.
X
Xmsc_os2:
X	$(MAKE) -nologo unzip.exe CFLAGS="-Ox -nologo $(FP) -G2 -DOS2 -Lp"\
X	CC=cl LD=link EXE=.exe O=.obj LDFLAGS="/noi /nol"\
X	LDFLAGS2=",unzip,,,unzip.def;"
X
X# NeXT 2.x: make the executable smaller.
Xnext:
X	$(MAKE) unzip CFLAGS="$(CFLAGS) -DNOTINT16" LDFLAGS2="-object -s"
X
X# I didn't do this.  I swear.  No, really.
X
Xwombat:		# Wombat 68000 (or whatever)
X	@echo
X	@echo  '	Ha ha!  Just kidding.'
X	@echo
X
X################
X# ATTRIBUTIONS #
X################
X
X# Thanks to the following people for their help in testing and/or porting
X# to various machines:
X#
X#  386i:	Richard Stephen, stephen@corp.telecom.co.nz
X#  3Bx:		Bob Kemp, hrrca!bobc@cbnewse.att.com
X#  amdahl:	Kim DeVaughn, ked01@juts.ccc.amdahl.com
X#  apollo:	Tim Geibelhaus
X#  aviion:	Bruce Kahn, bkahn@archive.webo.dg.com
X#  cray:	Greg Roelofs, roelofs@amelia.nas.nasa.gov
X#  dec5820:	"Moby" Dick O'Connor, djo7613@u.washington.edu
X#  dnix:	Bo Kullmar, bk@kullmar.se
X#  gould:	Onno van der Linden, linden@fwi.uva.nl
X#  hp:		Randy McCaskile, rmccask@seas.gwu.edu (HP-UX)
X#   		Gershon Elber, gershon@cs.utah.edu (HP BSD 4.3)
X#  mips:	Peter Jones, jones@mips1.uqam.ca
X#  msc_dos:	Greg Roelofs
X#  msc_os2:	Wim Bonner, wbonner@yoda.eecs.wsu.edu
X#  next:	Mark Adler, madler@piglet.caltech.edu
X#  pyramid:	James Dugal, jpd@usl.edu
X#  rtaix:	Erik-Jan Vens
X#  sco:		Onno van der Linden (SCO Unix 3.2.0)
X#   		Bill Davidsen, davidsen@crdos1.crd.ge.com (Xenix/386)
X#  sco_dos:	Bill Davidsen
X#  sequent:	Phil Howard, phil@ux1.cso.uiuc.edu
X#  sgi:		Valter V. Cavecchia (see comments for addresses)
X#  sun:		Onno van der Linden (Sun 4)
X#  tahoe:	Mark Edwards, mce%sdcc10@ucsd.edu
X#  ultrix_vax:	Greg Flint, afc@klaatu.cc.purdue.edu
X#  ultrix_risc:	Michael Graff, explorer@iastate.edu
X#  vax:		Forrest Gehrke, feg@dodger.att.com (SysV)
X#		David Kirschbaum, kirsch@usasoc.soc.mil (BSD 4.3)
X#		Jim Steiner, steiner@pica.army.mil (8600+Ultrix)
X#  wombat:	Joe Isuzu, joe@trustme.isuzu.com
X
X# SCO unix 3.2.0:
X# Don't use -Ox with cc (derived from Microsoft 5.1), there is
X# a bug in the loop optimization, which causes bad CRC's
X#
X# Onno van der Linden
END_OF_FILE
  if test 14794 -ne `wc -c <'./v41/Makefile'`; then
    echo shar: \"'./v41/Makefile'\" unpacked with wrong size!
  fi
  # end of './v41/Makefile'
fi
if test -f './v41/mapname.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/mapname.c'\"
else
  echo shar: Extracting \"'./v41/mapname.c'\" \(12601 characters\)
  sed "s/^X//" >'./v41/mapname.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  mapname.c
X
X  This routine changes DEC-20, VAX/VMS, and DOS-style filenames into normal
X  Unix names (and vice versa, in some cases); it also creates any necessary 
X  directories, if the -d switch was specified.
X
X  ---------------------------------------------------------------------------
X
X  Action:  renames argument files as follows:
X
X     strips Unix and PKZIP DOS path name from front (up to rightmost '/') if
X       present.
X     strips DEC device:, node:: names from front (up to rightmost ':') if
X       present.  (This also takes care of any DOS drive: artifacts.)
X     strips DEC-20 <directory> or VMS [directory] name if present.
X     strips DEC-20 version number from end (everything after 2nd dot) if
X       present.
X     strips VMS generation number from end (everything after ';') if present,
X       unless "-V" switch specified.
X     honors DEC-20 CTRL-V quote for special characters.
X     discards unquoted unprintable characters.
X     [VMS] converts Unix-style pathnames to VMS style.
X
X     Returns 0 if no error, 1 if filename truncated, 2 for any other error.
X
X  ---------------------------------------------------------------------------
X
X  Author:  David Kirschbaum, 25 Apr 90
X     (Based on good old xxu.c by Frank da Cruz, CUCCA)
X     Subsequent tweaks by Bill Davidsen, James Dugal, Larry Jones,
X     Mark Edwards, Greg Roelofs, Antoine Verheijen.
X
X  ---------------------------------------------------------------------------
X
X  Dot notes:
X
X     - Unix allows multiple dots in directory names; MS-DOS and OS/2 FAT
X       allow one; VMS does not allow any.  Things are almost as bad with
X       regular filenames (VMS allows a single dot but TOPS-20 allows two,
X       if you count the one in front of the version number).  As of v4.04,
X       mapname converts directory-name dots to underscores on VMS, but it
X       otherwise leaves the dots alone.  Since it is now possible to create
X       zipfiles under Unix, this whole routine pretty much needs to be
X       rewritten (different rules for each output OS and for different 
X       parts of the path name).
X     - If each zip program stores local-format names (like the coming VMS
X       one will), it would probably be best to convert to an intermediate 
X       format first (assuming we're not extracting under the same OS as
X       that under which the zipfile was created), then from that to the 
X       current operating system's format.
X
X  ------------------------------------------------------------------------- */
X
X
X#include "unzip.h"
X
X
X/********************/
X/*  Mapname Defines */
X/********************/
X
X#ifdef VMS
X#define PERMS   0
X#else
X#define PERMS   0777
X#endif
X
X#ifndef NO_MKDIR
X#ifdef DOS_OS2
X#if (_MSC_VER >= 600)           /* have special MSC mkdir prototype */
X#include <direct.h>
X#else                           /* own prototype because dir.h conflicts?? */
Xint mkdir(const char *path);
X#endif                          /* !(MSC 6.0 or later) */
X#define MKDIR(path,mode)   mkdir(path)
X#else                           /* !DOS_OS2 */
X#define MKDIR(path,mode)   mkdir(path,mode)
X#endif
X#endif                          /* !NO_MKDIR */
X
X/***************************/
X/*  Function mapped_name() */
X/***************************/
X
Xmapped_name()
X{
X#ifdef NO_MKDIR
X    char command[FILNAMSIZ+40]; /* buffer for system() call */
X#endif
X#ifdef VMS
X    int stat_val;               /* temp. holder for stat() return value */
X    char *dp, *xp;              /* ptrs to directory name */
X#endif
X    char name[FILNAMSIZ];       /* file name buffer */
X    char *pp, *cp, *cdp;        /* character pointers */
X    char delim = '\0';          /* Directory Delimiter */
X    int dc = 0;                 /* Counters */
X    int quote = FALSE;          /* Flags */
X    int indir = FALSE;
X    int done = FALSE;
X    register int workch;        /* hold the character being tested */
X
X
X
X/*---------------------------------------------------------------------------
X    Initialize various pointers and counters and stuff.
X  ---------------------------------------------------------------------------*/
X
X#ifdef MAP_DEBUG
X    fprintf(stderr, "%s ", filename);   /* echo name of this file */
X#endif
X    pp = name;                  /* Point to translation buffer */
X    *name = '\0';               /* Initialize buffer */
X
X    if (dflag) {                /* -d => retain directory structure */
X        cdp = (char *) malloc(strlen(filename) + 3);  /* place for */
X        if (cdp == NULL) {      /*   holding directory name */
X            fprintf(stderr, "malloc failed in conversion of [%s]\n", filename);
X            return (2);
X        }
X#ifdef VMS
X        *cdp++ = '[';
X        xp = cdp;               /* always points to last non-NULL char */
X        *cdp++ = '.';
X#endif
X#ifdef MACOS
X        *cdp = ':';             /* the Mac uses ':' as a directory separator */
X        cdp[1] = '\0';
X#else
X        *cdp = '\0';
X#endif
X    }
X    dc = 0;                     /* Filename dot counter */
X
X/*---------------------------------------------------------------------------
X    Begin main loop through characters in filename.
X  ---------------------------------------------------------------------------*/
X
X    for (cp = filename; (workch = *cp++) != 0  &&  !done;) {
X
X        if (quote) {            /* If this char quoted... */
X            *pp++ = workch;     /*  include it literally. */
X            quote = FALSE;
X        } else if (indir) {     /* If in directory name... */
X            if (workch == delim)
X                indir = FALSE;  /*  look for end delimiter. */
X        } else
X            switch (workch) {
X            case '<':           /* Discard DEC-20 directory name */
X                indir = TRUE;
X                delim = '>';
X                break;
X            case '[':           /* Discard VMS directory name */
X                indir = TRUE;
X                delim = ']';
X                break;
X            case '/':           /* Discard Unix path name... */
X            case '\\':          /*  or MS-DOS path name...
X                                 *  UNLESS -d flag was given. */
X                /*
X                 * Special processing case:  if -d flag was specified on
X                 * command line, create any necessary directories included
X                 * in the pathname.  Creation of directories is straight-
X                 * forward on BSD and MS-DOS machines but requires use of
X                 * the system() command on SysV systems (or any others which
X                 * don't have mkdir()).  The stat() check is necessary with
X                 * MSC because it doesn't have an EEXIST errno, and it saves
X                 * the overhead of multiple system() calls on SysV machines.
X                 */
X
X                if (dflag) {
X                    *pp = '\0';
X#ifdef VMS
X                    dp = name;
X                    while (*++xp = *dp++)   /* copy name to cdp, while */
X                        if (*xp == '.')     /*   changing all dots... */
X                            *xp = '_';      /*   ...to underscores */
X                    strcpy(xp, ".dir");    /* add extension for stat check */
X                    stat_val = stat(cdp, &statbuf);
X                    *xp = '\0';         /* remove extension for all else */
X                    if (stat_val) {     /* doesn't exist, so create */
X#else
X                    strcat(cdp, name);
X                    if (stat(cdp, &statbuf)) {  /* doesn't exist, so create */
X#endif
X#ifdef NO_MKDIR
X                        sprintf(command, "IFS=\" \t\n\" /bin/mkdir %s 2>/dev/null", cdp);
X                        if (system(command)) {
X#else
X                        if (MKDIR(cdp, PERMS) == -1) {
X#endif
X                            perror(cdp);
X                            free(cdp);
X                            fprintf(stderr, "Unable to process [%s]\n", filename);
X                            return (2);
X                        }
X                    } else if (!(statbuf.st_mode & S_IFDIR)) {
X                        fprintf(stderr, "%s:  exists but is not a directory\n",
X                                cdp);
X                        free(cdp);
X                        fprintf(stderr, "unable to process [%s]\n", filename);
X                        return (2);
X                    }
X#ifdef VMS
X                    *xp = '/';  /* for now... (mkdir()) */
X#else /* !VMS */
X#ifdef MACOS
X                    strcat(cdp, ":");
X#else /* !MACOS */
X                    strcat(cdp, "/");
X#endif /* ?MACOS */
X#endif /* ?VMS */
X                }               /***** FALL THROUGH to ':' case  **** */
X            case ':':           /* Discard DEC dev: or node:: name */
X                pp = name;
X                break;
X            case '.':                   /* DEC-20 generation number
X                                         * or MS-DOS type */
X#ifdef NUKE_DOTS
X                if (++dc == 1)          /* Keep first dot */
X                    *pp++ = workch;
X#else
X                ++dc;                   /* Not used, but what the hell. */
X                *pp++ = workch;
X#endif
X                break;
X            case ';':                   /* VMS generation or DEC-20 attrib */
X                if (V_flag)             /* If requested, save VMS ";##" */
X                    *pp++ = workch;     /*  version info; else discard */
X                else                    /*  everything starting with */
X                    done = TRUE;        /*  semicolon.  (Worry about */
X                break;                  /*  DEC-20 later.) */
X            case '\026':                /* Control-V quote for special chars */
X                quote = TRUE;           /* Set flag for next time. */
X                break;
X            default:                    /* some other char */
X                if (isdigit(workch))    /* '0'..'9' */
X                    *pp++ = workch;     /* accept them, no tests */
X                else {
X                    if (workch == ' ')  /* change blanks to underscore */
X                        *pp++ = '_';
X                    else if (isprint(workch))   /* Other printable, just keep */
X                        *pp++ = workch;
X                }
X            }                   /* switch */
X    }                           /* for loop */
X    *pp = '\0';                 /* Done with name, terminate it */
X
X/*---------------------------------------------------------------------------
X    We COULD check for existing names right now, create a "unique" name, etc.
X    However, since other unzips don't do that...we won't bother.  Maybe an-
X    other day, ne?  If this went bad, the name'll either be nulled out (in
X    which case we'll return non-0) or following procedures won't be able to
X    create the extracted file, and other error msgs will result.
X  ---------------------------------------------------------------------------*/
X
X    if (*name == '\0') {
X        fprintf(stderr, "conversion of [%s] failed\n", filename);
X        return (2);
X    }
X    if (dflag) {
X#ifdef VMS
X        *xp++ = ']';            /* proper end-of-dir-name delimiter */
X        if (xp == cdp) {        /* no path-name stuff, so... */
X            strcpy(filename, name);  /* copy file name into global */
X            cdp -= 2;           /*   prepare to free malloc'd space */
X        } else {                /* we've added path-name stuff... */
X            *xp = '\0';         /*   so terminate... */
X            dp = cdp;           /*   and convert to VMS subdir separators:  */
X            while (*++dp)       /*   (skip first char:  better not be "/") */
X                if (*dp == '/') /*   change all slashes */
X                    *dp = '.';  /*     to dots */
X            cdp -= 2;           /*   include leading bracket and dot */
X            strcpy(filename, cdp);   /* copy VMS-style path name into global */
X            strcat(filename, name);  /* concatenate file name to global */
X        }
X#else
X        strcpy(filename, cdp);  /* Either "" or slash-terminated path */
X        strcat(filename, name); /* append file name to path name */
X#endif
X        free(cdp);
X    } else
X        strcpy(filename, name); /* copy converted name into global */
X
X#if FILENAME_MAX < (FILNAMSIZ - 1)
X    /*
X     * Check the length of the file name and truncate if necessary.
X     */
X    if (FILENAME_MAX < strlen(filename)) {
X        fprintf(stderr, "warning:  filename too long--truncating.\n");
X        filename[FILENAME_MAX] = '\0';
X        fprintf(stderr, "[ %s ]\n", filename);
X        return (1);             /* 1:  warning error */
X    }
X#endif
X
X    return (0);
X}
END_OF_FILE
  if test 12601 -ne `wc -c <'./v41/mapname.c'`; then
    echo shar: \"'./v41/mapname.c'\" unpacked with wrong size!
  fi
  # end of './v41/mapname.c'
fi
if test -f './v41/match.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/match.c'\"
else
  echo shar: Extracting \"'./v41/match.c'\" \(5358 characters\)
  sed "s/^X//" >'./v41/match.c' <<'END_OF_FILE'
X/*--------------------------------------------------------------------------
X
X  match.c
X
X  The match() routine recursively compares a string to a "pattern" (regular
X  expression), returning TRUE if a match is found or FALSE if not.  This
X  version is specifically for use with unzip.c:  it leaves the case (upper,
X  lower, or mixed) of the string alone, but converts any uppercase characters
X  in the pattern to lowercase if indicated by the global variable lcflag
X  (which is to say, string is assumed to have been converted to lowercase
X  already, if such was necessary).
X
X  --------------------------------------------------------------------------
X
X  Revision history:
X
X     Original Author:  Thom Henderson
X     Original System V port:  Mike Stump
X
X     03/22/87  C. Seaman      enhancements, bug fixes, cleanup
X     11/13/89  C. Mascott     adapted for use with unzip
X     01/25/90  J. Cowan       made case-insensitive (only for smart toupper())
X     03/17/90  D. Kirschbaum  prototypes, other tweaks for Turbo C
X     05/18/90  M. O'Carroll   DOS and OS/2 family version
X     09/20/90  G. Roelofs     modified for lcflag, moved stuff to header file
X
X  --------------------------------------------------------------------------
X
X  Copyright, originally from arcmatch.c, version 1.1 (?):
X
X     * ARC - Archive utility - ARCMATCH
X     *
X     * Version 2.17, created on 12/17/85) at 20:32:18
X     *
X     * (C) COPYRIGHT 1985 by System Enhancement Associates; ALL RIGHTS RESERVED
X
X  --------------------------------------------------------------------------*/
X
X
X#include "unzip.h"
X
X
X/*******************/
X/*  Match Defines  */
X/*******************/
X
X#define ASTERISK        '*'     /* The '*' metacharacter */
X#define QUESTION        '?'     /* The '?' metacharacter */
X#define BACK_SLASH      '\\'    /* The '\' metacharacter */
X#define LEFT_BRACKET    '['     /* The '[' metacharacter */
X#define RIGHT_BRACKET   ']'     /* The ']' metacharacter */
X#define EOS             '\000'  /* end-of-string */
X
X#define IS_OCTAL(ch)    (ch >= '0' && ch <= '7')
X
X
X
X/********************/
X/*  Match Typedefs  */
X/********************/
X
Xtypedef short int INT;
Xtypedef short int BOOLEAN;
X
X
X
X/*************************************/
X/*  Match Local Function Prototypes  */
X/*************************************/
X
Xstatic BOOLEAN do_list __((register char *string, char *pattern));
Xstatic void list_parse __((char **patp, char *lowp, char *highp));
Xstatic char nextch __((char **patp));
X
X
X
X
X
X/**********************/
X/*  Function match()  */
X/**********************/
X
Xint match(string, pattern)
Xchar *string;
Xchar *pattern;
X{
X    register int ismatch;
X
X    ismatch = FALSE;
X    switch (*pattern) {
X    case ASTERISK:
X        pattern++;
X        do {
X            ismatch = match(string, pattern);
X        }
X        while (!ismatch && *string++ != EOS);
X        break;
X    case QUESTION:
X        if (*string != EOS)
X            ismatch = match(++string, ++pattern);
X        break;
X    case EOS:
X        if (*string == EOS)
X            ismatch = TRUE;
X        break;
X    case LEFT_BRACKET:
X        if (*string != EOS)
X            ismatch = do_list(string, pattern);
X        break;
X    case BACK_SLASH:
X        pattern++;
X    default:
X        if (*string == ((lcflag && isupper(*pattern)) ? tolower(*pattern) : *pattern)) {
X            string++;
X            pattern++;
X            ismatch = match(string, pattern);
X        } else
X            ismatch = FALSE;
X        break;
X    }
X    return (ismatch);
X}
X
X
X
X
X
X/************************/
X/*  Function do_list()  */
X/************************/
X
Xstatic BOOLEAN do_list(string, pattern)
Xregister char *string;
Xchar *pattern;
X{
X    register BOOLEAN ismatch;
X    register BOOLEAN if_found;
X    register BOOLEAN if_not_found;
X    auto char lower;
X    auto char upper;
X
X    pattern++;
X    if (*pattern == '!') {
X        if_found = FALSE;
X        if_not_found = TRUE;
X        pattern++;
X    } else {
X        if_found = TRUE;
X        if_not_found = FALSE;
X    }
X    ismatch = if_not_found;
X    while (*pattern != ']' && *pattern != EOS) {
X        list_parse(&pattern, &lower, &upper);
X        if (*string >= lower && *string <= upper) {
X            ismatch = if_found;
X            while (*pattern != ']' && *pattern != EOS)
X                pattern++;
X        }
X    }
X
X    if (*pattern++ != ']') {
X        printf("Character class error\n");
X        exit(1);
X    } else if (ismatch)
X        ismatch = match(++string, pattern);
X
X    return (ismatch);
X}
X
X
X
X
X
X/***************************/
X/*  Function list_parse()  */
X/***************************/
X
Xstatic void list_parse(patp, lowp, highp)
Xchar **patp;
Xchar *lowp;
Xchar *highp;
X{
X    *lowp = nextch(patp);
X    if (**patp == '-') {
X        (*patp)++;
X        *highp = nextch(patp);
X    } else
X        *highp = *lowp;
X}
X
X
X
X
X
X/***********************/
X/*  Function nextch()  */
X/***********************/
X
Xstatic char nextch(patp)
Xchar **patp;
X{
X    register char ch;
X    register char chsum;
X    register INT count;
X
X    ch = *(*patp)++;
X    if (ch == '\\') {
X        ch = *(*patp)++;
X        if (IS_OCTAL(ch)) {
X            chsum = 0;
X            for (count = 0; count < 3 && IS_OCTAL(ch); count++) {
X                chsum *= 8;
X                chsum += ch - '0';
X                ch = *(*patp)++;
X            }
X            (*patp)--;
X            ch = chsum;
X        }
X    }
X    return (ch);
X}
END_OF_FILE
  if test 5358 -ne `wc -c <'./v41/match.c'`; then
    echo shar: \"'./v41/match.c'\" unpacked with wrong size!
  fi
  # end of './v41/match.c'
fi
echo shar: End of archive 4 \(of 6\).
cp /dev/null ark4isdone
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
