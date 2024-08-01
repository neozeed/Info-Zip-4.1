#! /bin/sh
# into a shell via "sh file" or similar.  To overwrite existing files,
# type "sh file -c".
# The tool that generated this appeared in the comp.sources.unix newsgroup;
# send mail to comp-sources-unix@uunet.uu.net if you want that tool.
# Contents:  ./v41/ATARI_ST/MAKEIT ./v41/ATARI_ST/TCM
#   ./v41/ATARI_ST/UNZIP.PRJ ./v41/MAC/macstat.h ./v41/MSDOS/UNZIP.PRJ
#   ./v41/MSDOS/tcconfig.uue ./v41/OS2/Readme.os2 ./v41/OS2/unzip.def
#   ./v41/VMS/DESCRIP.MMS ./v41/VMS/VMS_MAKE.COM ./v41/VMS/fatdef.h
#   ./v41/VMS/fchdef.h ./v41/unzip41.descr
# Wrapped by kent@sparky on Sun May 19 19:40:39 1991
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
echo If this archive is complete, you will see the following message:
echo '          "shar: End of archive 6 (of 6)."'
if test -f './v41/ATARI_ST/MAKEIT' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/MAKEIT'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/MAKEIT'\" \(373 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/MAKEIT' <<'END_OF_FILE'
Xtcc -DATARI_ST=1 -I=\tc\include unzip.c
Xtcc -DATARI_ST=1 -I=\tc\include file_io.c
Xtcc -DATARI_ST=1 -I=\tc\include mapname.c
Xtcc -DATARI_ST=1 -I=\tc\include match.c
Xtcc -DATARI_ST=1 -I=\tc\include misc.c
Xtcc -DATARI_ST=1 -I=\tc\include unimplod.c
Xtcc -DATARI_ST=1 -I=\tc\include unreduce.c
Xtcc -DATARI_ST=1 -I=\tc\include unshrink.c
Xtlink -O=unzip.prg  -S=4096 -C=tlink.opt
END_OF_FILE
  if test 373 -ne `wc -c <'./v41/ATARI_ST/MAKEIT'`; then
    echo shar: \"'./v41/ATARI_ST/MAKEIT'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/MAKEIT'
fi
if test -f './v41/ATARI_ST/TCM' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/TCM'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/TCM'\" \(50 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/TCM' <<'END_OF_FILE'
Xsetenv PATH=e:\tc,$PATH
Xmake -r -f makefile.st $*
END_OF_FILE
  if test 50 -ne `wc -c <'./v41/ATARI_ST/TCM'`; then
    echo shar: \"'./v41/ATARI_ST/TCM'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/TCM'
fi
if test -f './v41/ATARI_ST/UNZIP.PRJ' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/UNZIP.PRJ'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/UNZIP.PRJ'\" \(367 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/UNZIP.PRJ' <<'END_OF_FILE'
X;>>>>>>> UNZIP.PRJ
X
XUNZIP.PRG
X
X=                  ; list of modules follows...
X
XTCSTART.O          ; startup code
XUNZIP.C
XFILE_IO.C
XMAPNAME.C
XMATCH.C
XMISC.C
XUNIMPLOD.C
XUNREDUCE.C
XUNSHRINK.C
X
XTCSTDLIB.LIB       ; standard library
XTCEXTLIB.LIB       ; extended library
XTCTOSLIB.LIB       ; TOS library
X
X;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
END_OF_FILE
  if test 367 -ne `wc -c <'./v41/ATARI_ST/UNZIP.PRJ'`; then
    echo shar: \"'./v41/ATARI_ST/UNZIP.PRJ'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/UNZIP.PRJ'
fi
if test -f './v41/MAC/macstat.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/MAC/macstat.h'\"
else
  echo shar: Extracting \"'./v41/MAC/macstat.h'\" \(909 characters\)
  sed "s/^X//" >'./v41/MAC/macstat.h' <<'END_OF_FILE'
X/*****************************************************************
X *
X *                stat.h
X *
X *****************************************************************/
X
X#include <time.h>
Xextern stat();
Xtypedef long dev_t;
Xtypedef long ino_t;
Xtypedef long off_t;
X
Xstruct stat {
X    dev_t    st_dev;
X    ino_t    st_ino;
X    unsigned short    st_mode;
X    short    st_nlink;
X    short    st_uid;
X    short    st_gid;
X    dev_t    st_rdev;
X    off_t    st_size;
X    time_t   st_atime, st_mtime, st_ctime;
X    long     st_blksize;
X    long     st_blocks;
X};
X
X#define S_IFMT     0xF000
X#define S_IFIFO    0x1000
X#define S_IFCHR    0x2000
X#define S_IFDIR    0x4000
X#define S_IFBLK    0x6000
X#define S_IFREG    0x8000
X#define S_IFLNK    0xA000
X#define S_IFSOCK   0xC000
X#define S_ISUID    0x800
X#define S_ISGID    0x400
X#define S_ISVTX    0x200
X#define S_IREAD    0x100
X#define S_IWRITE   0x80
X#define S_IEXEC    0x40
END_OF_FILE
  if test 909 -ne `wc -c <'./v41/MAC/macstat.h'`; then
    echo shar: \"'./v41/MAC/macstat.h'\" unpacked with wrong size!
  fi
  # end of './v41/MAC/macstat.h'
fi
if test -f './v41/MSDOS/UNZIP.PRJ' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/MSDOS/UNZIP.PRJ'\"
else
  echo shar: Extracting \"'./v41/MSDOS/UNZIP.PRJ'\" \(159 characters\)
  sed "s/^X//" >'./v41/MSDOS/UNZIP.PRJ' <<'END_OF_FILE'
Xunzip.c		(unzip.h)
Xmisc.c		(unzip.h)
Xmapname.c	(unzip.h)
Xmatch.c		(unzip.h)
Xunshrink.c	(unzip.h)
Xunreduce.c	(unzip.h)
Xunimplod.c	(unzip.h)
Xfile_io.c	(unzip.h)
END_OF_FILE
  if test 159 -ne `wc -c <'./v41/MSDOS/UNZIP.PRJ'`; then
    echo shar: \"'./v41/MSDOS/UNZIP.PRJ'\" unpacked with wrong size!
  fi
  # end of './v41/MSDOS/UNZIP.PRJ'
fi
if test -f './v41/MSDOS/tcconfig.uue' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/MSDOS/tcconfig.uue'\"
else
  echo shar: Extracting \"'./v41/MSDOS/tcconfig.uue'\" \(2360 characters\)
  sed "s/^X//" >'./v41/MSDOS/tcconfig.uue' <<'END_OF_FILE'
Xbegin 640 TCCONFIG.TC
XM5'5R8F\@0R!#;VYF:6=U<F%T:6]N($9I;&4@&@`!#1(7`1H``@$!``(````"
XM``(``0`#``(``@`$``$```4``0``!@`!```(``$``0D``@````T``@`!``X`
XM`@```!$``0`$$@`"````$P`"`!D`%``"``$`%0`"``$`%@`"``(`%P`"````
XM&``"````9``!``%E``$``68``0`!9P`!``%H``$``6D``0`!:@`!``%K``$`
XM`6P``0`!;0`!``%N``$``6\``0`!<``!``%Q``$``7(``0`!<P`!``%T``$`
XM`74``0`!=@`!``%W``$``7@``0`!>0`!``%Z``$``7L``0``?``!``%]``$`
XM`7X``0`!?P`!``&```$``8(``0``A``!``"%``$``<@``0``R0`!``'*``$`
XM`<L``0`!S``!``'-``$``,X``0`!SP`!``#0``$`&=$``0!DT@`!`"#5``$`
XM`-<``0``V``!``#9``$``=H``0`!VP`!``#<``$``-T``0`!W@`!``'?``$`
XM`.```0``X0`!``#B``$``2P!1```````````````````````````````````
XM`````````````````````````````````````````````````````````"T!
XM@`!#.EQ40UQ)3D-,541%````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM`````````````````````````````````````````````````````"X!@`!#
XM.EQ40UQ,24(`````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM`````````````````````````````````````````````````"\!4`!53EI)
XM4"Y04DH`````````````````````````````````````````````````````
XM`````````````````````````````````````````#`!!``S,@``,0$%`#(U
XM````,@$%`#$P,```,P%_````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM```````````T`1X`*@``````````````````````````````````````-0$>
XM`"H``````````````````````````````````````#8!'@`J````````````
XM```````````````````````````W`1X`*@``````````````````````````
XM````````````.`$>`"H``````````````````````````````````````#D!
XM'@`J```````````````````````````````````````Z`1X`*@``````````
XM````````````````````````````.P$>`"H`````````````````````````
XM`````````````#P!'@`J```````````````````````````````````````]
XM`8``````````````````````````````````````````````````````````
XM````````````````````````````````````````````````````````````
XM```````````````````````````````````````````````````````^`00`
XM-````#\!4```0U!)0TLN5$-0````````````````````````````````````
XM`````````````````````````````````````````````````````````$`!
XM1`!#.EQ40P``````````````````````````````````````````````````
XM`````````````````````````````````$$!4`!53EI)4"Y#````````````
XM````````````````````````````````````````````````````````````
X9`````````````````````````/__`@`:````
X`
Xend
END_OF_FILE
  if test 2360 -ne `wc -c <'./v41/MSDOS/tcconfig.uue'`; then
    echo shar: \"'./v41/MSDOS/tcconfig.uue'\" unpacked with wrong size!
  fi
  # end of './v41/MSDOS/tcconfig.uue'
fi
if test -f './v41/OS2/Readme.os2' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/OS2/Readme.os2'\"
else
  echo shar: Extracting \"'./v41/OS2/Readme.os2'\" \(1130 characters\)
  sed "s/^X//" >'./v41/OS2/Readme.os2' <<'END_OF_FILE'
X[Info-ZIP #127]
XDate: Fri, 26 Apr 91 17:42:24 PDT
XFrom: wbonner@yoda.eecs.wsu.edu (Wim Bonner)
XSubject: Makefile Change for OS/2 (and addition of def file)
X
X[makefile changes posted]
X
XThe following are two lines which should be placed in a file called unzip.def
Xfor the make file changes to work correctly.  They could be put in the make
Xfile, and have the make file echo them to unzip.def if the system is being
Xbuilt on OS/2, but that may be more complicated than simply including one
Xmore file.  The description line is optional, but I thought that it might
Xbe useful for something, perhaps a copyright statement?  I think it is what
XWindows uses for descriptions when it searches a dos hard drive for programs
Xto install.  It may be used in the future for OS/2 things, I don't know.
X
Xunzip.def: (The following two lines are for a Module Definition File)
X
XNAME Unzip WINDOWCOMPAT NEWFILES
XDESCRIPTION 'any one line description can be placed here between single quotes'
X-- 
X|  wbonner@yoda.eecs.wsu.edu  | The Loft BBS
X| 27313853@wsuvm1.csc.wsu.edu | (509)335-4339
X|  72561.3135@CompuServe.com  | USR HST Dual Standard HST/V.32
END_OF_FILE
  if test 1130 -ne `wc -c <'./v41/OS2/Readme.os2'`; then
    echo shar: \"'./v41/OS2/Readme.os2'\" unpacked with wrong size!
  fi
  # end of './v41/OS2/Readme.os2'
fi
if test -f './v41/OS2/unzip.def' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/OS2/unzip.def'\"
else
  echo shar: Extracting \"'./v41/OS2/unzip.def'\" \(92 characters\)
  sed "s/^X//" >'./v41/OS2/unzip.def' <<'END_OF_FILE'
XNAME Unzip WINDOWCOMPAT NEWFILES
XDESCRIPTION 'The world-famous unzip utility from Info-ZIP'
END_OF_FILE
  if test 92 -ne `wc -c <'./v41/OS2/unzip.def'`; then
    echo shar: \"'./v41/OS2/unzip.def'\" unpacked with wrong size!
  fi
  # end of './v41/OS2/unzip.def'
fi
if test -f './v41/VMS/DESCRIP.MMS' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/DESCRIP.MMS'\"
else
  echo shar: Extracting \"'./v41/VMS/DESCRIP.MMS'\" \(2209 characters\)
  sed "s/^X//" >'./v41/VMS/DESCRIP.MMS' <<'END_OF_FILE'
X! MMS description file for unzip.
X!
X!   From: AntonioQuerubin, Jr. <QUERUBIN@uhccvx.uhcc.hawaii.edu>
X!   Date: Sun 23 Dec 90 13:49:55-HST
X!
X!   "The following is an MMS description file that works for unzip.  The UNIX 
X!   makefile is much too different to be converted to work also with mms.  MMS 
X!   will search for a file called DESCRIP.MMS before looking for MAKEFILE so 
X!   you should be able to include this in the distribution as descrip.mms to 
X!   avoid confusion."
X
X! To build unzip that uses shared libraries,
X!	mms
X! [For this to work, however, you presently need a separate file called
X!   VMSSHARE.OPT, which is no longer included as a normal part of this pack-
X!   age.  It's trivial to reconstruct, however; it contains the single line:
X!	sys$share:vaxcrtl.exe/shareable
X!   (not including the "! ").  One-time users will find it easier to use
X!   the VMS_MAKE.COM command file; real MMS hacker-types can probably figure
X!   out how to include the sys$share line within this file.  GRR, 1991.2.19]
X
X! To build unzip without shared libraries,
X!	mms noshare
X
X! To delete unnecessary OBJ files,
X!	mms clean
X
X! Toad Hall Note:  Jumping in where mortals fear to tread,
X! I'm attempting to add the vms_attr.c stuff Cave Newt gleefully
X! threw at me (and ran giggling away).
X! Not having the *foggiest* idea about ANYTHING VMS-related ....
X! Just look for the "vms_attr" stuff.
X! David Kirschbaum
X! Toad Hall
X
XCC = cc
XCFLAGS =
XLD = link
XLDFLAGS =
XEXE =
XO = .obj;
XOBJS = unzip$(O), file_io$(O), mapname$(O), match$(O), misc$(O), \
X       unimplod$(O), unreduce$(O), unshrink$(O), vms_attr$(O)
XLDFLAGS2 =
X
Xdefault :	$(OBJS), vmsshare.opt
X	$(LD) $(LDFLAGS) $(OBJS), \
X		vmsshare.opt/options, \
X		sys$library:vaxcrtl.olb/library $(LDFLAGS2)
X
Xnoshare :	$(OBJS)
X	$(LD) $(LDFLAGS) $(OBJS), \
X		sys$library:vaxcrtl.olb/library $(LDFLAGS2)
X
Xclean :
X	delete $(OBJS)	! you may want to change this to 'delete *.obj;*'
X
Xvms_attr$(O):   fatdef.h fchdef.h fjndef.h
Xfile_io$(O) :	file_io.c unzip.h
Xmapname$(O) :	mapname.c unzip.h
Xmatch$(O) :	match.c unzip.h
Xmisc$(O) :	misc.c unzip.h
Xunimplod$(O) :	unimplod.c unzip.h
Xunreduce$(O) :	unreduce.c unzip.h
Xunshrink$(O) :	unshrink.c unzip.h
Xunzip$(O) :	unzip.c unzip.h
END_OF_FILE
  if test 2209 -ne `wc -c <'./v41/VMS/DESCRIP.MMS'`; then
    echo shar: \"'./v41/VMS/DESCRIP.MMS'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/DESCRIP.MMS'
fi
if test -f './v41/VMS/VMS_MAKE.COM' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/VMS_MAKE.COM'\"
else
  echo shar: Extracting \"'./v41/VMS/VMS_MAKE.COM'\" \(340 characters\)
  sed "s/^X//" >'./v41/VMS/VMS_MAKE.COM' <<'END_OF_FILE'
X$ !
X$ !	"Makefile" for VMS version of unzip
X$ !
X$ set verify	! like "echo on", eh?
X$ define lnk$library sys$library:vaxcrtl.olb
X$ cc unzip,file_io,VMS_attr,mapname,match,misc,unimplod,unreduce,unshrink
X$ link unzip,file_io,VMS_attr,mapname,match,misc,unimplod,unreduce,unshrink,sys$input:/opt
Xsys$share:vaxcrtl.exe/shareable
X$ set noverify
END_OF_FILE
  if test 340 -ne `wc -c <'./v41/VMS/VMS_MAKE.COM'`; then
    echo shar: \"'./v41/VMS/VMS_MAKE.COM'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/VMS_MAKE.COM'
fi
if test -f './v41/VMS/fatdef.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/fatdef.h'\"
else
  echo shar: Extracting \"'./v41/VMS/fatdef.h'\" \(2069 characters\)
  sed "s/^X//" >'./v41/VMS/fatdef.h' <<'END_OF_FILE'
X/* This header file was created by Joe Meadows, and is not copyrighted
X   in any way. No guarantee is made as to the accuracy of the contents
X   of this header file. This header file was last modified on Sep. 22th,
X   1987. (Modified to include this statement) */
X#define FAT$K_LENGTH 32
X#define FAT$C_LENGTH 32
X#define FAT$S_FATDEF 32
X
Xstruct fatdef {
X  union  {
X    unsigned char fat$b_rtype;
X    struct  {
X      unsigned fat$v_rtype : 4;
X      unsigned fat$v_fileorg : 4;
X    } fat$r_rtype_bits;
X  } fat$r_rtype_overlay;
X# define FAT$S_RTYPE 4
X# define FAT$V_RTYPE 0
X#   define FAT$C_UNDEFINED 0
X#   define FAT$C_FIXED 1
X#   define FAT$C_VARIABLE 2
X#   define FAT$C_VFC 3
X#   define FAT$C_STREAM 4
X#   define FAT$C_STREAMLF 5
X#   define FAT$C_STREAMCR 6
X# define FAT$S_FILEORG 4
X# define FAT$V_FILEORG 4
X#   define FAT$C_SEQUENTIAL 0
X#   define FAT$C_RELATIVE 1
X#   define FAT$C_INDEXED 2
X#   define FAT$C_DIRECT 3
X  union  {
X    unsigned char fat$b_rattrib;
X    struct  {
X      unsigned fat$v_fortrancc : 1;
X      unsigned fat$v_impliedcc : 1;
X      unsigned fat$v_printcc : 1;
X      unsigned fat$v_nospan : 1;
X    } fat$r_rattrib_bits;
X  } fat$r_rattrib_overlay;
X#   define FAT$V_FORTRANCC 0
X#   define FAT$M_FORTRANCC 1
X#   define FAT$V_IMPLIEDCC 1
X#   define FAT$M_IMPLIEDCC 2
X#   define FAT$V_PRINTCC 2
X#   define FAT$M_PRINTCC 4
X#   define FAT$V_NOSPAN 3
X#   define FAT$M_NOSPAN 8
X  unsigned short int fat$w_rsize;
X  union
X  {
X    unsigned long int fat$l_hiblk;
X    struct
X    {
X      unsigned short int fat$w_hiblkh;
X      unsigned short int fat$w_hiblkl;
X    } fat$r_hiblk_fields;
X  } fat$r_hiblk_overlay;
X  union
X  {
X    unsigned long int fat$l_efblk;
X    struct
X    {
X      unsigned short int fat$w_efblkh;
X      unsigned short int fat$w_efblkl;
X    } fat$r_efblk_fields;
X  } fat$r_efblk_overlay;
X  unsigned short int fat$w_ffbyte;
X  unsigned char fat$b_bktsize;
X  unsigned char fat$b_vfcsize;
X  unsigned short int fat$w_maxrec;
X  unsigned short int fat$w_defext;
X  unsigned short int fat$w_gbc;
X  char fat$fill[8];
X  unsigned short int fat$w_versions;
X};
END_OF_FILE
  if test 2069 -ne `wc -c <'./v41/VMS/fatdef.h'`; then
    echo shar: \"'./v41/VMS/fatdef.h'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/fatdef.h'
fi
if test -f './v41/VMS/fchdef.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/fchdef.h'\"
else
  echo shar: Extracting \"'./v41/VMS/fchdef.h'\" \(1746 characters\)
  sed "s/^X//" >'./v41/VMS/fchdef.h' <<'END_OF_FILE'
X/* This header file was created by Joe Meadows, and is not copyrighted
X   in any way. No guarantee is made as to the accuracy of the contents
X   of this header file. This header file was last modified on Sep. 22th,
X   1987. (Modified to include this statement) */
X
X#define FCH$V_BADACL 0x00B
X#define FCH$M_BADACL (1 << FCH$V_ACL)
X#define FCH$V_BADBLOCK 0x00E
X#define FCH$M_BADBLOCK (1 << FCH$V_BADBLOCK)
X#define FCH$V_CONTIG 0x007
X#define FCH$M_CONTIG (1 << FCH$V_CONTIG)
X#define FCH$V_CONTIGB 0x005
X#define FCH$M_CONTIGB (1 << FCH$V_CONTIGB)
X#define FCH$V_DIRECTORY 0x00D
X#define FCH$M_DIRECTORY (1 << FCH$V_DIRECTORY)
X#define FCH$V_ERASE 0x011
X#define FCH$M_ERASE (1 << FCH$V_ERASE)
X#define FCH$V_LOCKED 0x006
X#define FCH$M_LOCKED (1 << FCH$V_LOCKED)
X#define FCH$V_MARKDEL 0x00F
X#define FCH$M_MARKDEL (1 << FCH$V_MARKDEL)
X#define FCH$V_NOBACKUP 0x001
X#define FCH$M_NOBACKUP (1 << FCH$V_NOBACKUP)
X#define FCH$V_NOCHARGE 0x010
X#define FCH$M_NOCHARGE (1 << FCH$V_NOCHARGE)
X#define FCH$V_READCHECK 0x003
X#define FCH$M_READCHECK (1 << FCH$V_READCHECK)
X#define FCH$V_SPOOL 0x00C
X#define FCH$M_SPOOL (1 << FCH$V_SPOOL)
X#define FCH$V_WRITCHECK 0x004
X#define FCH$M_WRITCHECK (1 << FCH$V_WRITCHECK)
X#define FCH$V_WRITEBACK 0x002
X#define FCH$M_WRITEBACK (1 << FCH$V_WRITEBACK)
X
Xstruct fchdef  {
X  unsigned : 1;
X  unsigned fch$v_nobackup : 1 ;
X  unsigned fch$v_writeback : 1;
X  unsigned fch$v_readcheck : 1;
X  unsigned fch$v_writcheck : 1;
X  unsigned fch$v_contigb : 1;
X  unsigned fch$v_locked : 1;
X  unsigned fch$v_contig : 1;
X  unsigned : 3;
X  unsigned fch$v_badacl : 1;
X  unsigned fch$v_spool : 1;
X  unsigned fch$v_directory : 1;
X  unsigned fch$v_badblock : 1;
X  unsigned fch$v_markdel : 1;
X  unsigned fch$v_nocharge : 1;
X  unsigned fch$v_erase : 1;
X};
END_OF_FILE
  if test 1746 -ne `wc -c <'./v41/VMS/fchdef.h'`; then
    echo shar: \"'./v41/VMS/fchdef.h'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/fchdef.h'
fi
if test -f './v41/unzip41.descr' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unzip41.descr'\"
else
  echo shar: Extracting \"'./v41/unzip41.descr'\" \(2157 characters\)
  sed "s/^X//" >'./v41/unzip41.descr' <<'END_OF_FILE'
XUNZIP41.ZIP	Generic Unix unzip v4.1 for free public distribution
XUNZIP41.ARC	Same as above, but .ARC format
XUNZIP41.TAR-Z	Same as above, but compressed tar format
XUNZ_41P.ZIP	Patches to create v4.1 from v4.07
X
XA public distribution version of the Info-ZIP project's generic
XUnix unzip utility.
X
XThis version of unzip has been ported to a wide array of Unix and
Xother mainframes, minis, and micros (to include MSDOS, Atari ST (kinda),
Xand Macintosh).  Although highly compatible with Phil Katz's PKZIP
Xand PKUNZIP utilities of MSDOS fame, our objective has been one of
Xportability and other-than-MSDOS functionality.
X
XSee the Makefile (or the system-specific archives) for details on
Xhow to compile for your system.
X
XSee unzip.1 or unzip.man for usage.  (No, there isn't a manual per se.
XThere's plenty of space on the Info-ZIP staff for a volunteer!)
X
XIf you confirm a clean compile and execution on a unique system
X(e.g., one different from those in the Makefile), please provide
XInfo-ZIP via E-Mail with details as to your system type, any changes
Xrequired, what Makefile system was used, etc.
X
XIf any changes are made to source, we'd appreciate them (context diff
Xfiles only, please) with explanation as appropriate.
X
XAll E-Mail should go to Info-ZIP@WSMR-SIMTEL20.Army.Mil directly
X(and not to me:  I'm only the Coordinator).  However, if you're
Xrequesting something special (e.g., a copy of the "No Feelthy ..."
Xrules for source and change submission), E-Mail me personally.
X
XInformation on commercial usage, licensing, etc. is NOT available.
XWe at Info-ZIP are currently researching how to best handle this
Xproblem.  (There are potential copyright problems.)  So don't bug us.
XWe have little interest in commercial developers, and by Internet
Xrules, are forbidden to discuss such filthy topics in any case.
X
XIf you'd like to keep up to date with our unzip (and companion zip
Xutility) development, join the ranks of BETA testers, add your own
Xthoughts and contributions, etc., send your request to
X
X Info-ZIP-Request@WSMR-SIMTEL20.Army.Mil
X
Xand Keith Petersen'll add you to the Info-ZIP newsletter mailing list.
X
XDavid Kirschbaum
XInfo-ZIP Coordinator
X
END_OF_FILE
  if test 2157 -ne `wc -c <'./v41/unzip41.descr'`; then
    echo shar: \"'./v41/unzip41.descr'\" unpacked with wrong size!
  fi
  # end of './v41/unzip41.descr'
fi
echo shar: End of archive 6 \(of 6\).
cp /dev/null ark6isdone
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
