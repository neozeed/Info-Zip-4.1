#! /bin/sh
# This is a shell archive.  Remove anything before this line, then feed it
# into a shell via "sh file" or similar.  To overwrite existing files,
# type "sh file -c".
# The tool that generated this appeared in the comp.sources.unix newsgroup;
# send mail to comp-sources-unix@uunet.uu.net if you want that tool.
# Contents:  MANIFEST . ./v41 ./v41/ATARI_ST ./v41/ATARI_ST/MAKEFILE.ST
#   ./v41/MAC ./v41/MAC/macstat.c ./v41/MSDOS ./v41/OS2 ./v41/VMS
#   ./v41/unzip.c.1
# Wrapped by kent@sparky on Sun May 19 19:40:38 1991
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
echo If this archive is complete, you will see the following message:
echo '          "shar: End of archive 1 (of 6)."'
if test -f 'MANIFEST' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'MANIFEST'\"
else
  echo shar: Extracting \"'MANIFEST'\" \(1735 characters\)
  sed "s/^X//" >'MANIFEST' <<'END_OF_FILE'
X   File Name		Archive #	Description
X----------------------------------------------------------
XMANIFEST                   1	This shipping list
X.                          1	
X./v41                      1	
X./v41/ATARI_ST             1	Atari ST-peculiar files 
X./v41/ATARI_ST/MAKEFILE.ST  1	
X./v41/ATARI_ST/MAKEIT      6	(for Turbo C)
X./v41/ATARI_ST/README.ST   5	
X./v41/ATARI_ST/TCM         6	
X./v41/ATARI_ST/TLINK.OPT   5	
X./v41/ATARI_ST/UNZIP.PRJ   6	
X./v41/ATARI_ST/tc_cfg.uue  5	Uuencoded binary file
X./v41/History.41           4	Development history
X./v41/MAC                  1	Macintosh-peculiar files
X./v41/MAC/macfile.c        5	
X./v41/MAC/macstat.c        1	
X./v41/MAC/macstat.h        6	
X./v41/MSDOS                1	MSDOS-peculiar files
X./v41/MSDOS/MAKEFILE.DOS   5	
X./v41/MSDOS/UNZIP.PRJ      6	
X./v41/MSDOS/tcconfig.uue   6	Uuencoded binary file
X./v41/Makefile             4	
X./v41/OS2                  1	OS2-peculiar files
X./v41/OS2/Readme.os2       6	
X./v41/OS2/unzip.def        6	
X./v41/VMS                  1	VMS-peculiar files
X./v41/VMS/DESCRIP.MMS      6	
X./v41/VMS/VMS_MAKE.COM     6	
X./v41/VMS/VMSnotes         5	
X./v41/VMS/fatdef.h         6	
X./v41/VMS/fchdef.h         6	
X./v41/VMS/fjndef.h         2	
X./v41/VMS/vms_attr.c       5	
X./v41/file_io.c            3	
X./v41/mapname.c            4	
X./v41/match.c              4	
X./v41/misc.c               3	
X./v41/unimplod.c           3	
X./v41/unreduce.c           5	
X./v41/unshrink.c           5	
X./v41/unzip.1              5	
X./v41/unzip.c.1            1	unzip.c, part 1
X./v41/unzip.c.2            2	unzip.c, part 2
X./v41/unzip.h              2	
X./v41/unzip.man            5	
X./v41/unzip41.descr        6	Description
X./v41/ziprules.txt         5	Rules for contributors
END_OF_FILE
  if test 1735 -ne `wc -c <'MANIFEST'`; then
    echo shar: \"'MANIFEST'\" unpacked with wrong size!
  fi
  # end of 'MANIFEST'
fi
if test ! -d './v41' ; then
    echo shar: Creating directory \"'./v41'\"
    mkdir './v41'
fi
if test ! -d './v41/ATARI_ST' ; then
    echo shar: Creating directory \"'./v41/ATARI_ST'\"
    mkdir './v41/ATARI_ST'
fi
if test -f './v41/ATARI_ST/MAKEFILE.ST' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/ATARI_ST/MAKEFILE.ST'\"
else
  echo shar: Extracting \"'./v41/ATARI_ST/MAKEFILE.ST'\" \(1093 characters\)
  sed "s/^X//" >'./v41/ATARI_ST/MAKEFILE.ST' <<'END_OF_FILE'
X#  Makefile.st	Makefile for UnZip 4.0,
X#  using Turbo C 2.0 for the Atari ST and
X#  make from the Mark Williams C 3.9 (sorry for that mixture)
X#
X
X# UPPERCASE file names facilitate TD's understanding of modules.
X.SUFFIXES: .o .O .c .C .s
X
XDISK	= E:
X#####################
X# MACRO DEFINITIONS #
X#####################
X
XCC	= tcc
X#CFLAGS	= -DATARI_ST=1 -Y -I=$(DISK)\tc\include
XCFLAGS	= -DATARI_ST=1 -I=$(DISK)\tc\include
X#LFLAGS	= -L -Y
XLFLAGS	=
XLIB	= $(DISK)\tc\lib
XLD	= tlink
X
XOBJS = unzip.o file_io.o mapname.o match.o misc.o\
X       unimplod.o unreduce.o unshrink.o
X
X
X###############################################
X# BASIC COMPILE INSTRUCTIONS AND DEPENDENCIES #
X###############################################
X
XALL	: unzip.prg
X	echo done
X
Xunzip.o:      unzip.c unzip.h
X
Xfile_io.o:    file_io.c unzip.h
X
Xmapname.o:    mapname.c unzip.h
X
Xmatch.o:      match.c unzip.h
X
Xmisc.o:       misc.c unzip.h
X
Xunimplod.o:   unimplod.c unzip.h
X
Xunreduce.o:   unreduce.c unzip.h
X
Xunshrink.o:   unshrink.c unzip.h
X
Xunzip.prg:     $(OBJS)
X	tlink -O=$@ $(LFLAGS) -S=4096 -C=tlink.opt
X
X.c.o:
X	tcc $(CFLAGS) $<
X
END_OF_FILE
  if test 1093 -ne `wc -c <'./v41/ATARI_ST/MAKEFILE.ST'`; then
    echo shar: \"'./v41/ATARI_ST/MAKEFILE.ST'\" unpacked with wrong size!
  fi
  # end of './v41/ATARI_ST/MAKEFILE.ST'
fi
if test ! -d './v41/MAC' ; then
    echo shar: Creating directory \"'./v41/MAC'\"
    mkdir './v41/MAC'
fi
if test -f './v41/MAC/macstat.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/MAC/macstat.c'\"
else
  echo shar: Extracting \"'./v41/MAC/macstat.c'\" \(5947 characters\)
  sed "s/^X//" >'./v41/MAC/macstat.c' <<'END_OF_FILE'
X#ifdef THINK_C
X#define MACOS
X#include    <FileMgr.h>
X#include    <HFS.h>
X#include    <pascal.h>
X#endif
X#ifdef MPW
X#define MACOS
X#include    <Files.h>
X#include    <Errors.h>
X#define FSFCBLen    (*(short *)0x3F6)
X#define hFileInfo   hfileInfo
X#define CtoPstr c2pstr
X#define PtoCstr p2cstr
X#endif
X
X#ifdef MACOS
X#include    <string.h>
X#include    "macstat.h"
Xint stat(char *path, struct stat *buf);
X
X/* assume that the path will contain a Mac-type pathname, i.e. ':'s, etc. */
Xint stat(path, buf)
Xchar *path;
Xstruct stat *buf;
X{
X    char    temp[256];
X    short   curVolume;
X    long    curDir;
X    short   fIsHFS = false;
X    OSErr   err;
X
X    if (buf == (struct stat *)0L || path == (char *)0L) {
X        SysBeep(1);
X        return -1;
X    }
X    
X    if (path[0] == '\0' || strlen(path)>255) {
X        return -1;
X    }
X
X    if (GetVol((StringPtr)&temp[0], &curVolume) != noErr) {
X        SysBeep(1);
X        return -1;
X    }
X    
X    /* get info about the specified volume */
X    if (FSFCBLen > 0)   /* HFS Disk? */
X    {
X        WDPBRec wdpb;
X        HParamBlockRec    hpbr;
X        Str255 st;
X
X        wdpb.ioCompletion = 0;
X        wdpb.ioNamePtr = temp;
X        err = PBHGetVol(&wdpb, 0);
X        if (err == noErr)
X        {
X            hpbr.volumeParam.ioCompletion = 0;
X            hpbr.volumeParam.ioNamePtr = st;
X            hpbr.volumeParam.ioVRefNum = wdpb.ioVRefNum;
X            hpbr.volumeParam.ioVolIndex = 0;
X            err = PBHGetVInfo(&hpbr, 0);
X
X            if (err == noErr && hpbr.volumeParam.ioVFSID == 0
X                && hpbr.volumeParam.ioVSigWord == 0x4244) {
X                    fIsHFS = true;
X            }
X        }
X    }
X
X
X    /* number of links, at least in System 6.0x, 0 */
X    buf->st_nlink = 0;
X    /* user id */
X    buf->st_uid = 0;
X    /* group id */
X    buf->st_gid = 0;
X
X    if (fIsHFS == true)   /* HFS? */
X    {
X        CInfoPBRec  cPB;
X        HParamBlockRec  wPB;
X        
X        wPB.wdParam.ioCompletion = (ProcPtr)0L;
X        wPB.wdParam.ioNamePtr = (StringPtr)temp;
X        err = PBHGetVol((WDPBPtr)&wPB, false);
X        if (err != noErr) {
X            SysBeep(1);
X            return -1;
X        }
X
X        curVolume = wPB.wdParam.ioWDVRefNum;
X        buf->st_dev = curDir = wPB.wdParam.ioWDDirID;
X        
X        /* get information about file */
X        cPB.hFileInfo.ioCompletion = (ProcPtr)0L;
X        CtoPstr(path);
X        strncpy(temp,path, path[0]+1);
X        PtoCstr(path);
X        cPB.hFileInfo.ioNamePtr = (StringPtr)temp;
X        cPB.hFileInfo.ioVRefNum = 0;
X        cPB.hFileInfo.ioDirID = 0;
X        cPB.hFileInfo.ioFDirIndex = 0;
X        
X        err = PBGetCatInfo(&cPB, false); 
X        
X        if (err != noErr) {
X            if (err != fnfErr) {
X                SysBeep(1);
X            }
X            return -1;
X        }
X        
X        /* Type of file: directory or regular file */
X        buf->st_mode = (cPB.hFileInfo.ioFlAttrib & ioDirMask) ? S_IFDIR : S_IFREG;
X        
X        /* last access time, modification time and creation time(?) */
X        buf->st_atime = buf->st_mtime = cPB.hFileInfo.ioFlMdDat;
X        buf->st_ctime = cPB.hFileInfo.ioFlCrDat;
X        /* inode number */
X        buf->st_ino = cPB.hFileInfo.ioDirID + ((long)curVolume)<<16;
X        /* size of file - use only the data fork */
X        buf->st_size = cPB.hFileInfo.ioFlLgLen;
X        /* size of disk block */
X        if (cPB.hFileInfo.ioFlClpSiz == 0) {
X            HParamBlockRec hPB;
X            
X            hPB.volumeParam.ioCompletion = (ProcPtr)0L;
X            hPB.volumeParam.ioNamePtr = (StringPtr)temp;
X            hPB.volumeParam.ioVRefNum = 0;
X            hPB.volumeParam.ioVolIndex = 0;
X            
X            err = PBHGetVInfo(&hPB, false);
X            
X            if (err != noErr) {
X                SysBeep(1);
X                return -1;
X            }
X            
X            buf->st_blksize = hPB.volumeParam.ioVClpSiz;
X        }
X        else
X            buf->st_blksize = cPB.hFileInfo.ioFlClpSiz;
X    
X        buf->st_blocks = cPB.hFileInfo.ioFlPyLen/ buf->st_blksize;
X    }
X    else    /* MFS? */
X    {
X        ParamBlockRec   pPB;
X        
X        buf->st_dev = 0;
X        
X        CtoPstr(path);
X        strncpy(temp, path, path[0]+1);
X        PtoCstr(path);
X        pPB.fileParam.ioCompletion = (ProcPtr)0;
X        pPB.fileParam.ioNamePtr = (StringPtr)temp;
X        pPB.fileParam.ioVRefNum = curVolume;
X        pPB.fileParam.ioFVersNum = 0;
X        pPB.fileParam.ioFDirIndex = 0;
X        
X        err = PBGetFInfo(&pPB, false);   
X        
X        if (err != noErr) {
X            SysBeep(1);
X            return -1;
X        }
X        
X        /* Type of file: either directory or regular file */
X        buf->st_mode = (pPB.fileParam.ioFlAttrib & ioDirMask) ? S_IFDIR : S_IFREG;
X        
X        /* last access time, modification time and creation time(?) */
X        buf->st_atime = buf->st_mtime = pPB.fileParam.ioFlMdDat;
X        buf->st_ctime = pPB.fileParam.ioFlCrDat;
X        /* inode number */
X        buf->st_ino = pPB.fileParam.ioFlNum + ((long)curVolume)<<16;
X        /* size of file - use only the data fork */
X        buf->st_size = pPB.fileParam.ioFlLgLen;
X        /* size of disk block */
X        {
X            ParamBlockRec hPB;
X            
X            hPB.volumeParam.ioCompletion = (ProcPtr)0;
X            hPB.volumeParam.ioNamePtr = (StringPtr)temp;
X            hPB.volumeParam.ioVRefNum = curVolume;
X            hPB.volumeParam.ioVolIndex = 0;
X            
X            err = PBGetVInfo(&hPB, false);
X            
X            if (err != noErr) {
X                SysBeep(1);
X                return -1;
X            }
X            
X            buf->st_blksize = hPB.volumeParam.ioVClpSiz;
X        }
X    
X        /* number of disk blocks used by file - includes resource fork */
X        buf->st_blocks = pPB.fileParam.ioFlPyLen/ buf->st_blksize +
X                            pPB.fileParam.ioFlRPyLen/buf->st_blksize;
X    }
X
X    return 0;
X}
X#else
X#error 1
X#endif
END_OF_FILE
  if test 5947 -ne `wc -c <'./v41/MAC/macstat.c'`; then
    echo shar: \"'./v41/MAC/macstat.c'\" unpacked with wrong size!
  fi
  # end of './v41/MAC/macstat.c'
fi
if test ! -d './v41/MSDOS' ; then
    echo shar: Creating directory \"'./v41/MSDOS'\"
    mkdir './v41/MSDOS'
fi
if test ! -d './v41/OS2' ; then
    echo shar: Creating directory \"'./v41/OS2'\"
    mkdir './v41/OS2'
fi
if test ! -d './v41/VMS' ; then
    echo shar: Creating directory \"'./v41/VMS'\"
    mkdir './v41/VMS'
fi
if test -f './v41/unzip.c.1' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unzip.c.1'\"
else
  echo shar: Extracting \"'./v41/unzip.c.1'\" \(38155 characters\)
  sed "s/^X//" >'./v41/unzip.c.1' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  unzip.c
X
X  This is nearly a complete rewrite of unzip.c, mainly to allow access to
X  zipfiles via the central directory (and hence to the OS bytes, so we can
X  make intelligent decisions about what to do with the extracted files).
X  Based on unzip.c 3.15+ and zipinfo.c 0.90.
X
X  ---------------------------------------------------------------------------
X
X  To compile (partial instructions):
X
X     under Unix (cc):  make <system name>
X       (type "make" for list of valid names, or read Makefile for details)
X
X     under MS-DOS (TurboC):  make -fMAKEFILE.DOS  for command line compiles
X       (or use the integrated environment and the included files TCCONFIG.TC
X        and UNZIP.PRJ.  Tweak for your environment.)
X
X     under MS-DOS (MSC):  make MAKEFILE.DOS
X       (or use Makefile if you have MSC 6.0:  "nmake msc_dos")
X
X     under OS/2 (MSC):  make MAKEFILE.DOS   (edit appropriately)
X       (or use Makefile if you have MSC 6.0:  "nmake msc_os2")
X
X     under Atari OS:  Any Day Now.
X
X     under VMS:  DEFINE LNK$LIBRARY SYS$LIBRARY:VAXCRTL.OLB   (see VMSNOTES)
X                 CC UNZIP,FILE_IO,MAPNAME,MATCH,...,UNSHRINK
X                 LINK UNZIP,FILE_IO,MAPNAME,MATCH,...,UNSHRINK
X                 UNZIP :== $DISKNAME:[DIRECTORY]UNZIP.EXE
X
X     under Macintosh OS:   Double click on unzip.mac.  Press <Command>-M
X
X  ---------------------------------------------------------------------------
X
X  Version:  unzip41.arc/unzip41.tar.Z for Unix, VMS, OS/2, MS-DOS & Mac
X  Source:   wsmr-simtel20.army.mil (192.88.110.20) in pd1:[misc.unix]
X            wuarchive.wustl.edu (128.252.135.4) in /mirrors/misc/unix
X  Source:   wsmr-simtel20.army.mil (26.2.0.74) in pd1:[misc.unix]
X
X  ---------------------------------------------------------------------------
X
X  Copyright, originally from version 1.2 (?):
X
X     * Copyright 1989 Samuel H. Smith;  All rights reserved
X     *
X     * Do not distribute modified versions without my permission.
X     * Do not remove or alter this notice or any other copyright notice.
X     * If you use this in your own program you must distribute source code.
X     * Do not use any of this in a commercial product.
X
X  ---------------------------------------------------------------------------
X
X  Comments from unzip.c, version 3.11:
X
X     * UnZip - A simple zipfile extract utility
X     *
X     * Compile-time definitions:
X     * See the Makefile for details, explanations, and all the current
X     * system makerules.
X     *
X     * If you have to add a new one for YOUR system, please forward the new
X     * Makefile context diff to kirsch%maxemail@uunet.uu.net for distribution.
X     * Be SURE to give FULL details on your system (hardware, OS, versions,
X     * processor, whatever) that made it unique.
X     *
X     * REVISION HISTORY : See History.41 (or whatever current version is)
X
X  To join Info-ZIP, send a message to Info-ZIP-Request@WSMR-Simtel20.Army.Mil
X
X  ---------------------------------------------------------------------------*/
X
X
X
X
X
X#include "unzip.h"              /* includes, defines, and macros */
X
X#define VERSION  "v4.1 of 5-13-91"
X#define PAKFIX   /* temporary solution to PAK-created zipfiles */
X
X
X
X
X
X/**********************/
X/*  Global Variables */
X/**********************/
X
Xint tflag;              /* -t: test */
Xint vflag;              /* -v: view directory (only used in unzip.c) */
Xint cflag;              /* -c: output to stdout */
Xint aflag;              /* -a: do ascii to ebcdic translation OR CR-LF */
X                        /*     to CR or LF conversion of extracted files */
Xint dflag;              /* -d: create containing directories */
Xint Uflag;              /* -U: leave filenames in upper or mixed case */
Xint V_flag;             /* -V: don't strip VMS version numbers */
Xint quietflg;           /* -q: produce a lot less output */
Xint do_all;             /* -o: OK to overwrite files without prompting */
Xint zflag;              /* -z: Display only the archive comment */
X
Xint lcflag;             /* convert filename to lowercase */
Xunsigned f_attr;        /* file attributes (permissions) */
Xlongint csize;          /* used by list_files(), ReadByte(): must be signed */
Xlongint ucsize;         /* used by list_files(), unReduce(), unImplode() */
X
X/*---------------------------------------------------------------------------
X    unShrink/unReduce/unImplode working storage:
X  ---------------------------------------------------------------------------*/
X
X/* prefix_of (for unShrink) is biggest storage area, esp. on Crays...space */
X/*  is shared by lit_nodes (unImplode) and followers (unReduce) */
X
Xshort prefix_of[HSIZE + 1];     /* (8193 * sizeof(short)) */
X#ifdef MACOS
Xbyte *suffix_of;
Xbyte *stack;
X#else
Xbyte suffix_of[HSIZE + 1];      /* also s-f length_nodes (smaller) */
Xbyte stack[HSIZE + 1];          /* also s-f distance_nodes (smaller) */
X#endif
X
XULONG crc32val;
X
XUWORD mask_bits[] =
X{0, 0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
X    0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff};
X
X/*---------------------------------------------------------------------------
X    Input file variables:
X  ---------------------------------------------------------------------------*/
X
Xbyte *inbuf, *inptr;    /* input buffer (any size is legal) and pointer */
Xint incnt;
X
XUWORD bitbuf;
Xint bits_left;
Xboolean zipeof;
X
Xint zipfd;                      /* zipfile file handle */
Xchar zipfn[FILNAMSIZ];
X
Xlocal_file_header lrec;
Xstruct stat statbuf;            /* used by main(), mapped_name() */
X
Xlongint cur_zipfile_bufstart;   /* extract_or_test_files, readbuf, ReadByte */
X
X/*---------------------------------------------------------------------------
X    Output stream variables:
X  ---------------------------------------------------------------------------*/
X
Xbyte *outbuf;                   /* buffer for rle look-back */
Xbyte *outptr;
Xbyte *outout;                   /* scratch pad for ASCII-native trans */
Xlongint outpos;                 /* absolute position in outfile */
Xint outcnt;                     /* current position in outbuf */
X
Xint outfd;
Xchar filename[FILNAMSIZ];
X
X/*---------------------------------------------------------------------------
X    unzip.c static global variables (visible only within this file):
X  ---------------------------------------------------------------------------*/
X
Xstatic char *fnames[2] =
X{"*", NULL};                    /* default filenames vector */
Xstatic char **fnv = &fnames[0];
Xstatic char sig[5];
Xstatic byte *hold;
Xstatic int process_all_files;
Xstatic longint ziplen;
Xstatic UWORD hostnum;
Xstatic UWORD methnum;
X/* static UWORD extnum; */
Xstatic central_directory_file_header crec;
Xstatic end_central_dir_record ecrec;
X
X/*---------------------------------------------------------------------------
X    unzip.c repeated error messages (we use all of these at least twice ==>
X    worth it to centralize to keep executable small):
X  ---------------------------------------------------------------------------*/
X
Xstatic char *CryptMsg =
X  "%s:  encrypted (can't do yet)--skipping.\n";
Xstatic char *FilNamMsg =
X  "\n%s:  bad filename length (%s)\n";
Xstatic char *ExtFieldMsg =
X  "\n%s:  bad extra field length (%s)\n";
Xstatic char *OffsetMsg =
X  "\n%s:  bad zipfile offset (%s)\n";
Xstatic char *EndSigMsg =
X  "\nwarning:  didn't find end-of-central-dir signature at end of central dir.\n";
Xstatic char *CentSigMsg =
X  "\nerror:  expected central file header signature not found (file #%u).\n";
Xstatic char *ReportMsg =
X  "        (please report to info-zip@wsmr-simtel20.army.mil)\n";
X
X/* (original) Bill Davidsen version */
X#define QCOND    (!quietflg)    /* -xq[q] kill "extracting: ..." msgs */
X#define QCOND2   (which_hdr)    /* file comments with -v, -vq, -vqq */
X
X
X
X
X/*****************/
X/*  Main program */
X/*****************/
X
Xmain(argc, argv)        /* return PK-type error code (except under VMS) */
Xint argc;
Xchar *argv[];
X{
X    char *s;
X    int c, print_usage=TRUE;
X
X
X
X#ifdef MACOS
X#ifdef THINK_C
X    #include <console.h>
X    #include <StdFilePkg.h>
X    typedef struct sf_node {        /* node in a true shannon-fano tree */
X        UWORD left;                 /* 0 means leaf node */
X        UWORD right;                /*   or value if leaf node */
X    } sf_node;
X    static char *argstr[30], args[30*64];
X 
X    extern sf_node *lit_nodes, *length_nodes, *distance_nodes;
X 
X    Point   p;
X    SFTypeList  sfT;
X    int a;
X    EventRecord theEvent;
X    short   eMask;
X    SFReply  fileRep;
X
X    suffix_of = (byte *)calloc(HSIZE+1, sizeof(byte));
X    stack = (byte *)calloc(HSIZE+1, sizeof(byte));
X    length_nodes = (sf_node *) suffix_of;  /* 2*LENVALS nodes */
X    distance_nodes = (sf_node *) stack;    /* 2*DISTVALS nodes */
X   
X    for (a=0; a<30; a+=1)
X    {
X        argstr[a] = &args[a*64];
X    }
Xstart:
X    tflag = vflag=cflag=aflag=dflag=Uflag=quietflg=lcflag=zflag = 0;
X    argc = ccommand(&argv);
X    SetPt(&p, 40,40);
X
X    SFGetFile(p, "\pSpecify ZIP file:", 0L, -1, sfT, 0L, &fileRep);
X    if (!fileRep.good)
X        exit(1);
X    macfstest(fileRep.vRefNum, true);
X    SetMacVol(NULL, fileRep.vRefNum);
X    for (a=1; a<argc; a+=1)
X    {
X        if (argv[a][0] == '-')
X        {
X            BlockMove(argv[a], argstr[a], (strlen(argv[a])>63) ? 64 : strlen(argv[a])+1);
X        }
X        else
X            break;
X    }
X    PtoCstr((char *)fileRep.fName);
X    strcpy(argstr[a], fileRep.fName);
X    for (;a<argc; a+=1)
X    {
X        BlockMove(argv[a], argstr[a+1], (strlen(argv[a])>63) ? 64 : strlen(argv[a])+1);
X    }
X    argc+=1;
X    argv = argstr;
X
X#endif /* THINK_C */
X#endif /* MACOS */
X
X/*---------------------------------------------------------------------------
X    Debugging info for checking on structure padding:
X  ---------------------------------------------------------------------------*/
X
X#ifdef DEBUG_STRUC
X    printf("local_file_header size: %X\n",
X           sizeof(struct local_file_header));
X    printf("local_byte_header size: %X\n",
X           sizeof(struct local_byte_header));
X    printf("actual size of local headers: %X\n", LREC_SIZE);
X
X    printf("central directory header size: %X\n",
X           sizeof(struct central_directory_file_header));
X    printf("central directory byte header size: %X\n",
X           sizeof(struct central_directory_byte_header));
X    printf("actual size of central dir headers: %X\n", CREC_SIZE);
X
X    printf("end central dir record size: %X\n",
X           sizeof(struct end_central_dir_record));
X    printf("end central dir byte record size: %X\n",
X           sizeof(struct end_central_byte_record));
X    printf("actual size of end-central-dir record: %X\n", ECREC_SIZE);
X#endif
X
X#ifndef KNOW_IT_WORKS  /* define this to save space, if things already work */
X#ifndef DOS_OS2        /* already works (no RISCy OS/2's yet...) */
X#ifndef NOTINT16       /* whole point is to see if this NEEDS defining */
X    {
X        int error=0;
X        long testsig;
X        static char *mach_type[3] = {"big-endian",
X          "structure-padding", "big-endian and structure-padding"};
X        strcpy((char *)&testsig,"012");
X        if (testsig != 0x00323130)
X            error = 1;
X        if (sizeof(central_directory_file_header) != CREC_SIZE)
X            error += 2;
X        if (error--)
X            fprintf(stderr, "It appears that your machine is %s.  If errors\n\
Xoccur, please try recompiling with \"NOTINT16\" defined (read the\n\
XMakefile, or try \"make hp\").\n\n", mach_type[error]);
X    }
X#endif /* !NOTINT16 */
X#endif /* !DOS_OS2 */
X#endif /* !KNOW_IT_WORKS */
X
X/*---------------------------------------------------------------------------
X    Rip through any command-line options lurking about...
X  ---------------------------------------------------------------------------*/
X
X    while (--argc > 0 && (*++argv)[0] == '-') {
X        s = argv[0] + 1;
X        while ((c = *s++) != 0) {    /* "!= 0":  prevent Turbo C warning */
X            switch (c) {
X            case ('x'): /* just ignore -x, -e options (extract) */
X            case ('e'):
X                break;
X            case ('q'):
X                ++quietflg;
X                break;
X            case ('t'):
X                ++tflag;
X                break;
X            case ('v'):
X                ++vflag;
X                /* fall thru */
X            case ('l'):
X                ++vflag;
X                break;
X            case ('p'):
X                ++cflag;
X#ifdef NATIVE
X                ++aflag;
X#endif
X                quietflg += 2;
X                break;
X            case ('c'):
X                ++cflag;
X#ifdef NATIVE
X                ++aflag;        /* this is so you can read it on the screen */
X#endif
X                break;
X            case ('a'):
X                ++aflag;
X                break;
X#ifdef VMS
X            case ('u'): /* switches converted to l.c. unless quoted */
X#endif
X            case ('U'): /* "uppercase flag" (i.e., don't convert) */
X                ++Uflag;
X                break;
X            case ('V'): /* Version flag:  retain VMS/DEC-20 file versions */
X                ++V_flag;
X                break;
X            case ('d'): /* create parent dirs flag */
X#ifdef MACOS
X                if (hfsflag == true)
X#endif
X                ++dflag;
X                break;
X            case ('o'): /* OK to overwrite files without prompting */
X                ++do_all;
X                break;
X            case ('z'): /* Display only the archive commentp */
X                ++zflag;
X                break;
X            default:
X                if (print_usage) {
X                    usage();
X                    print_usage = FALSE;
X                }
X                break;
X            }
X        }
X    }
X
X/*---------------------------------------------------------------------------
X    Make sure we aren't trying to do too many things here.  [This seems like
X    kind of a brute-force way to do things; but aside from that, isn't the
X    -a option useful when listing the directory (i.e., for reading zipfile
X    comments)?  It's a modifier, not an action in and of itself, so perhaps
X    it should not be included in the test--certainly, in the case of zipfile
X    testing, it can just be ignored.]
X  ---------------------------------------------------------------------------*/
X
X    if ((tflag && vflag) || (tflag && cflag) || (vflag && cflag) ||
X        (tflag && aflag) || (aflag && vflag)) {
X        fprintf(stderr, "only one of -t, -c, -a, or -v\n");
X        RETURN(10);             /* 10:  bad or illegal parameters specified */
X    }
X    if (quietflg && zflag)
X        quietflg = 0;
X    if (argc-- == 0) {
X        if (print_usage)
X            usage();
X        RETURN(10);             /* 10:  bad or illegal parameters specified */
X    }
X/*---------------------------------------------------------------------------
X    Now get the zipfile name from the command line and see if it exists as a
X    regular (non-directory) file.  If not, append the ".zip" suffix.  We don't
X    immediately check to see if this results in a good name, but we will do so
X    later.  In the meantime, see if there are any member filespecs on the com-
X    mand line, and if so, set the filename pointer to point at them.
X  ---------------------------------------------------------------------------*/
X
X    strcpy(zipfn, *argv++);
X    if (stat(zipfn, &statbuf) || (statbuf.st_mode & S_IFMT) == S_IFDIR)
X        strcat(zipfn, ZSUFX);
X
X    if (stat(zipfn, &statbuf)) {/* try again */
X        fprintf(stderr, "error:  can't find zipfile [ %s ]\n", zipfn);
X        RETURN(9);              /* 9:  file not found */
X    } else
X        ziplen = statbuf.st_size;
X
X    if (argc != 0) {
X        fnv = argv;
X        process_all_files = FALSE;
X    } else
X        process_all_files = TRUE;       /* for speed */
X
X/*---------------------------------------------------------------------------
X    Okey dokey, we have everything we need to get started.  Let's roll.
X  ---------------------------------------------------------------------------*/
X
X    inbuf = (byte *) (malloc(INBUFSIZ + 4));    /* 4 extra for hold[] (below) */
X    outbuf = (byte *) (malloc(OUTBUFSIZ + 1));  /* 1 extra for string termin. */
X    if (aflag)                  /* if need an ascebc scratch, */
X        outout = (byte *) (malloc(OUTBUFSIZ));
X    else                        /*  allocate it... */
X        outout = outbuf;        /*  else just point to outbuf */
X
X    if ((inbuf == NULL) || (outbuf == NULL) || (outout == NULL)) {
X        fprintf(stderr, "error:  can't allocate unzip buffers\n");
X        RETURN(4);              /* 4-8:  insufficient memory */
X    }
X    hold = &inbuf[INBUFSIZ];    /* to check for boundary-spanning signatures */
X
X#ifdef THINK_C
X    if (!process_zipfile())
X        goto start;
X#else
X    RETURN(process_zipfile());  /* keep passing errors back... */
X#endif
X
X}       /* end main() */
X
X
X
X
X
X/*********************/
X/*  Function usage() */
X/*********************/
X
Xvoid usage()
X{
X#ifdef NATIVE
X    char *astring = "-a     convert ASCII to native character set";
X#else
X#ifdef MACOS
X    char *astring = "-a     convert to Mac textfile format (CR LF => CR)";
X#else
X#ifdef DOS_OS2
X    char *astring = "-a     convert to DOS & OS/2 textfile format (LF => CR LF)";
X#else
X    char *astring = "-a     convert to Unix/VMS textfile format (CR LF => LF)";
X#endif /* ?DOS_OS2 */
X#endif /* ?MACOS */
X#endif /* ?NATIVE */
X
X
X    fprintf(stderr, "UnZip:  Zipfile Extract %s;  (C) 1989 Samuel H. Smith\n",
X                 VERSION);
X    fprintf(stderr, "Courtesy of:  S.H.Smith  and  The Tool Shop BBS,  \
X(602) 279-2673.\n\n");
X    fprintf(stderr, "Versions 3.0 and later brought to you by the fine folks \
Xat Info-ZIP\n");
X    fprintf(stderr, "(Info-ZIP@WSMR-Simtel20.Army.Mil)\n\n");
X    fprintf(stderr, "Usage:  unzip [ -xecptlvz[qadoUV] ] file[.zip] [filespec...]\n\
X  -x,-e  extract files in archive (default--i.e., this flag is optional)\n\
X  -c     extract files to stdout (\"CRT\")\n\
X  -p     extract files to stdout and no informational messages (for pipes)\n\
X  -t     test files\n\
X  -l     list files (short format)\n\
X  -v     verbose listing of files\n");
X    fprintf(stderr, "\
X  -z     display only the archive comment\n\
X  -q     perform operations quietly (up to two q's allowed)\n\
X  %s\n\
X  -d     include directory structure when extracting/listing\n\
X  -o     OK to overwrite files without prompting\n\
X  -U     don't map filenames to lowercase for selected (uppercase) OS's\n\
X  -V     retain file version numbers\n", astring);
X
X#ifdef VMS
X    fprintf(stderr, "Remember that non-lowercase filespecs must be quoted in \
XVMS (e.g., \"Makefile\").\n");
X#endif
X
X}       /* end function usage() */
X
X
X
X
X
X/*******************************/
X/*  Function process_zipfile() */
X/*******************************/
X
Xint process_zipfile()
X/* return PK-type error code */
X{
X    int error=0, error_in_archive;
X
X
X
X/*---------------------------------------------------------------------------
X    Open the zipfile for reading and in BINARY mode to prevent CR/LF trans-
X    lation, which would corrupt the bitstreams.  Then find and process the
X    central directory; list, extract or test member files as instructed; and
X    close the zipfile.
X  ---------------------------------------------------------------------------*/
X
X#ifdef VMS
X    change_zipfile_attributes(0);
X#endif
X    if (open_input_file())      /* this should never happen, given the */
X        return (9);             /*   stat() test in main(), but... */
X
X    if (find_end_central_dir()) /* not found; nothing to do */
X        return (2);             /* 2:  error in zipfile */
X
X#ifdef TEST
X    printf("\n  found end-of-central-dir signature at offset %ld (%.8lXh)\n",
X      cur_zipfile_bufstart+(inptr-inbuf), cur_zipfile_bufstart+(inptr-inbuf) );
X    printf("    from beginning of file; offset %d (%.4Xh) within block\n",
X      inptr-inbuf, inptr-inbuf);
X#endif
X
X    if ((error_in_archive = process_end_central_dir()) > 1)
X        return (error_in_archive);
X
X    if (zflag)
X        return (0);
X
X#ifndef PAKFIX
X    if (ecrec.number_this_disk == 0) {
X#else /* PAKFIX */
X    if (ecrec.number_this_disk == 0  ||  (error = (ecrec.number_this_disk == 1
X        && ecrec.num_disk_with_start_central_dir == 1))) {
X
X        if (error) {
X            fprintf(stderr,
X     "\n     Warning:  zipfile claims to be disk 2 of a two-part archive;\n\
X     attempting to process anyway.  If no further errors occur, this\n\
X     archive was probably created by PAK v2.5 or earlier.  This bug\n\
X     has been reported to NoGate and should be fixed by mid-April 1991.\n\n");
X            error_in_archive = 1;  /* 1:  warning */
X        }
X#endif /* ?PAKFIX */
X        if (vflag)
X            error = list_files();       /* LIST 'EM */
X        else
X            error = extract_or_test_files();    /* EXTRACT OR TEST 'EM */
X        if (error > error_in_archive)   /* don't overwrite stronger error */
X            error_in_archive = error;   /*  with (for example) a warning */
X    } else {
X        fprintf(stderr, "\nerror:  zipfile is part of multi-disk archive \
X(sorry, no can do).\n");
X        fprintf(stderr, ReportMsg);   /* report to info-zip */
X        error_in_archive = 11;  /* 11:  no files found */
X    }
X
X    close(zipfd);
X#ifdef VMS
X    change_zipfile_attributes(1);
X#endif
X    return (error_in_archive);
X
X}       /* end function process_zipfile() */
X
X
X
X
X
X/************************************/
X/*  Function find_end_central_dir() */
X/************************************/
X
Xint find_end_central_dir()
X/* return 0 if found, 1 otherwise */
X{
X    int i, numblks;
X    longint tail_len;
X
X
X
X/*---------------------------------------------------------------------------
X    Treat case of short zipfile separately.
X  ---------------------------------------------------------------------------*/
X
X    if (ziplen <= INBUFSIZ) {
X        lseek(zipfd, 0L, SEEK_SET);
X        if ((incnt = read(zipfd,inbuf,(unsigned int)ziplen)) == ziplen)
X
X            /* 'P' must be at least 22 bytes from end of zipfile */
X            for ( inptr = inbuf+ziplen-22  ;  inptr >= inbuf  ;  --inptr )
X                if ( (ascii_to_native(*inptr) == 'P')  &&
X                      !strncmp((char *)inptr, END_CENTRAL_SIG, 4) ) {
X                    incnt -= inptr - inbuf;
X                    return(0);  /* found it! */
X                }               /* ...otherwise fall through & fail */
X
X/*---------------------------------------------------------------------------
X    Zipfile is longer than INBUFSIZ:  may need to loop.  Start with short
X    block at end of zipfile (if not TOO short).
X  ---------------------------------------------------------------------------*/
X
X    } else {
X        if ((tail_len = ziplen % INBUFSIZ) > ECREC_SIZE) {
X            cur_zipfile_bufstart = lseek(zipfd, ziplen-tail_len, SEEK_SET);
X            if ((incnt = read(zipfd,inbuf,(unsigned int)tail_len)) != tail_len)
X                goto fail;      /* shut up, it's expedient. */
X
X            /* 'P' must be at least 22 bytes from end of zipfile */
X            for ( inptr = inbuf+tail_len-22  ;  inptr >= inbuf  ;  --inptr )
X                if ( (ascii_to_native(*inptr) == 'P')  &&
X                      !strncmp((char *)inptr, END_CENTRAL_SIG, 4) ) {
X                    incnt -= inptr - inbuf;
X                    return(0);  /* found it! */
X                }               /* ...otherwise search next block */
X            strncpy((char *)hold, (char *)inbuf, 3);    /* sig may span block
X                                                           boundary */
X
X        } else {
X            cur_zipfile_bufstart = ziplen - tail_len;
X        }
X
X        /*
X         * Loop through blocks of zipfile data, starting at the end and going
X         * toward the beginning.  Need only check last 65557 bytes of zipfile:
X         * comment may be up to 65535 bytes long, end-of-central-directory rec-
X         * ord is 18 bytes (shouldn't hardcode this number, but what the hell:
X         * already did so above (22=18+4)), and sig itself is 4 bytes.
X         */
X
X        /*          ==amt to search==   ==done==   ==rounding==     =blksiz= */
X        numblks = ( min(ziplen,65557) - tail_len + (INBUFSIZ-1) ) / INBUFSIZ;
X
X        for ( i = 1  ;  i <= numblks  ;  ++i ) {
X            cur_zipfile_bufstart -= INBUFSIZ;
X            lseek(zipfd, cur_zipfile_bufstart, SEEK_SET);
X            if ((incnt = read(zipfd,inbuf,INBUFSIZ)) != INBUFSIZ)
X                break;          /* fall through and fail */
X
X            for ( inptr = inbuf+INBUFSIZ-1  ;  inptr >= inbuf  ;  --inptr )
X                if ( (ascii_to_native(*inptr) == 'P')  &&
X                      !strncmp((char *)inptr, END_CENTRAL_SIG, 4) ) {
X                    incnt -= inptr - inbuf;
X                    return(0);  /* found it! */
X                }
X            strncpy((char *)hold, (char *)inbuf, 3);    /* sig may span block
X                                                           boundary */
X        }
X
X    } /* end if (ziplen > INBUFSIZ) */
X
X/*---------------------------------------------------------------------------
X    Searched through whole region where signature should be without finding
X    it.  Print informational message and die a horrible death.
X  ---------------------------------------------------------------------------*/
X
Xfail:
X
X    fprintf(stderr, "\nFile:  %s\n\n\
X     End-of-central-directory signature not found.  Either this file is not\n\
X     a zipfile, or it constitutes one disk of a multi-part archive.  In the\n\
X     latter case the central directory and zipfile comment will be found on\n\
X     the last disk(s) of this archive.\n", zipfn);
X    return(1);
X
X}       /* end function find_end_central_dir() */
X
X
X
X
X
X/***************************************/
X/*  Function process_end_central_dir() */
X/***************************************/
X
Xint process_end_central_dir()
X/* return PK-type error code */
X{
X#ifdef NOTINT16
X    end_central_byte_record byterec;
X#endif
X    int error=0;
X
X
X
X/*---------------------------------------------------------------------------
X    Read the end-of-central-directory record and do any necessary machine-
X    type conversions (byte ordering, structure padding compensation).
X  ---------------------------------------------------------------------------*/
X
X#ifndef NOTINT16
X    if (readbuf((char *) &ecrec, ECREC_SIZE+4) <= 0)
X        return (51);            /* 51:  unexpected EOF */
X
X#else  /* NOTINT16:  read data into character array, then copy to struct */
X    if (readbuf((char *) byterec, ECREC_SIZE+4) <= 0)
X        return (51);
X
X    ecrec.number_this_disk =
X        makeword(&byterec[NUMBER_THIS_DISK]);
X    ecrec.num_disk_with_start_central_dir =
X        makeword(&byterec[NUM_DISK_WITH_START_CENTRAL_DIR]);
X    ecrec.num_entries_centrl_dir_ths_disk =
X        makeword(&byterec[NUM_ENTRIES_CENTRL_DIR_THS_DISK]);
X    ecrec.total_entries_central_dir =
X        makeword(&byterec[TOTAL_ENTRIES_CENTRAL_DIR]);
X    ecrec.size_central_directory =
X        makelong(&byterec[SIZE_CENTRAL_DIRECTORY]);
X    ecrec.offset_start_central_directory =
X        makelong(&byterec[OFFSET_START_CENTRAL_DIRECTORY]);
X    ecrec.zipfile_comment_length =
X        makeword(&byterec[ZIPFILE_COMMENT_LENGTH]);
X#endif  /* NOTINT16 */
X
X/*---------------------------------------------------------------------------
X    Get the zipfile comment, if any, and print it out.  (Comment may be up
X    to 64KB long.  May the fleas of a thousand camels infest the armpits of
X    anyone who actually takes advantage of this fact.)  Then position the
X    file pointer to the beginning of the central directory and fill buffer.
X  ---------------------------------------------------------------------------*/
X
X    if (ecrec.zipfile_comment_length && !quietflg) {
X        if (!zflag)
X          printf("[%s] comment:  ", zipfn);
X        if (do_string(ecrec.zipfile_comment_length,DISPLAY)) {
X            fprintf(stderr, "\nwarning:  zipfile comment truncated\n");
X            error = 1;          /* 1:  warning error */
X        }
X        if (!zflag)
X          printf("\n\n");
X    }
X    LSEEK( ULONG_(ecrec.offset_start_central_directory) )
X
X    return (error);
X
X}       /* end function process_end_central_dir() */
X
X
X
X
X
X/**************************/
X/*  Function list_files() */
X/**************************/
X
Xint list_files()
X/* return PK-type error code */
X{
X    char **fnamev;
X    int do_this_file = FALSE, ratio, error, error_in_archive = 0;
X    int which_hdr = (vflag > 1);
X    UWORD j, yr, mo, dy, hh, mm, members = 0;
X    ULONG tot_csize = 0L, tot_ucsize = 0L;
X    static char *method[NUM_METHODS + 1] =
X    {"Stored", "Shrunk", "Reduce1", "Reduce2",
X     "Reduce3", "Reduce4", "Implode", "Unknown"};
X    static char *Headers[][2] =
X    {
X        {" Length    Date    Time    Name",
X         " ------    ----    ----    ----"},
X        {" Length  Method   Size  Ratio   Date    Time   CRC-32     Name",
X         " ------  ------   ----  -----   ----    ----   ------     ----"}};
X
X
X
X/*---------------------------------------------------------------------------
X    Unlike extract_or_test_files(), this routine confines itself to the cen-
X    tral directory.  Thus its structure is somewhat simpler, since we can do
X    just a single loop through the entire directory, listing files as we go.
X
X    So to start off, print the heading line and then begin main loop through
X    the central directory.  The results will look vaguely like the following:
X
X  Length  Method   Size  Ratio   Date    Time   CRC-32     Name ("^" ==> case
X  ------  ------   ----  -----   ----    ----   ------     ----   conversion)
X   44004  Implode  13041  71%  11-02-89  19:34  8b4207f7   Makefile.UNIX
X    3438  Shrunk    2209  36%  09-15-90  14:07  a2394fd8  ^dos-file.ext
X  ---------------------------------------------------------------------------*/
X
X    if (quietflg < 2)
X        if (Uflag)
X            printf("%s\n%s\n", Headers[which_hdr][0], Headers[which_hdr][1]);
X        else
X            printf("%s (\"^\" ==> case\n%s   conversion)\n", 
X              Headers[which_hdr][0], Headers[which_hdr][1]);
X
X    for (j = 0; j < ecrec.total_entries_central_dir; ++j) {
X
X        if (readbuf(sig, 4) <= 0)
X            return (51);        /* 51:  unexpected EOF */
X        if (strncmp(sig, CENTRAL_HDR_SIG, 4)) {  /* just to make sure */
X            fprintf(stderr, CentSigMsg, j);  /* sig not found */
X            fprintf(stderr, ReportMsg);   /* report to info-zip */
X            return (3);         /* 3:  error in zipfile */
X        }
X        if ((error = process_central_file_header()) != 0)  /* (sets lcflag) */
X            return (error);     /* only 51 (EOF) defined */
X
X        /*
X         * We could DISPLAY the filename instead of storing (and possibly trun-
X         * cating, in the case of a very long name) and printing it, but that
X         * has the disadvantage of not allowing case conversion--and it's nice
X         * to be able to see in the listing precisely how you have to type each
X         * filename in order for unzip to consider it a match.  Speaking of
X         * which, if member names were specified on the command line, check in
X         * with match() to see if the current file is one of them, and make a
X         * note of it if it is.
X         */
X
X        if ((error = do_string(crec.filename_length, FILENAME)) != 0) {
X            error_in_archive = error;  /* (uses lcflag)---^   */
X            if (error > 1)      /* fatal:  can't continue */
X                return (error);
X        }
X        if ((error = do_string(crec.extra_field_length, SKIP)) != 0) {
X            error_in_archive = error;   /* might be just warning */
X            if (error > 1)      /* fatal */
X                return (error);
X        }
X        if (!process_all_files) {   /* check if specified on command line */
X            do_this_file = FALSE;
X            fnamev = fnv;       /* don't destroy permanent filename ptr */
X            for (--fnamev; *++fnamev;)
X                if (match(filename, *fnamev)) {
X                    do_this_file = TRUE;
X                    break;      /* found match, so stop looping */
X                }
X        }
X        /*
X         * If current file was specified on command line, or if no names were
X         * specified, do the listing for this file.  Otherwise, get rid of the
X         * file comment and go back for the next file.
X         */
X
X        if (process_all_files || do_this_file) {
X
X            yr = (((crec.last_mod_file_date >> 9) & 0x7f) + 80) % 100;
X            mo = (crec.last_mod_file_date >> 5) & 0x0f;
X            dy = crec.last_mod_file_date & 0x1f;
X            hh = (crec.last_mod_file_time >> 11) & 0x1f;
X            mm = (crec.last_mod_file_time >> 5) & 0x3f;
X
X            csize = (longint) ULONG_(crec.compressed_size);
X            ucsize = (longint) ULONG_(crec.uncompressed_size);
X            if (crec.general_purpose_bit_flag & 1)
X                csize -= 12;    /* if encrypted, don't count encrypt hdr */
X
X            ratio = (ucsize == 0) ? 0 :   /* .zip can have 0-length members */
X                ((ucsize > 2000000) ?     /* risk signed overflow if mult. */
X                (int) ((ucsize-csize) / (ucsize/1000L)) + 5 :   /* big */
X                (int) ((1000L*(ucsize-csize)) / ucsize) + 5);   /* small */
X
X            switch (which_hdr) {
X            case 0:             /* short form */
X                printf("%7ld  %02u-%02u-%02u  %02u:%02u  %c%s\n",
X                       ucsize, mo, dy, yr, hh, mm, (lcflag?'^':' '), filename);
X                break;
X            case 1:             /* verbose */
X                printf(
X                  "%7ld  %-7s%7ld %3d%%  %02u-%02u-%02u  %02u:%02u  %08lx  %c%s\n",
X                  ucsize, method[methnum], csize, ratio/10, mo, dy, yr, hh, mm,
X                  ULONG_(crec.crc32), (lcflag?'^':' '), filename);
X            }
X
X            error = do_string(crec.file_comment_length, (QCOND2 ? DISPLAY : SKIP));
X            if (error) {
X                error_in_archive = error;  /* might be just warning */
X                if (error > 1)  /* fatal */
X                    return (error);
X            }
X            tot_ucsize += (ULONG) ucsize;
X            tot_csize += (ULONG) csize;
X            ++members;
X
X        } else {        /* not listing this file */
X            if ((error = do_string(crec.file_comment_length, SKIP)) != 0) {
X              error_in_archive = error;   /* might be warning */
X              if (error > 1)      /* fatal */
X                  return (error);
X            }
X        }
X    }                   /* end for-loop (j: files in central directory) */
X
X/*---------------------------------------------------------------------------
X    Print footer line and totals (compressed size, uncompressed size, number
X    of members in zipfile).
X  ---------------------------------------------------------------------------*/
X
X    ratio = (tot_ucsize == 0) ? 
X        0 : ((tot_ucsize > 4000000) ?    /* risk unsigned overflow if mult. */
X        (int) ((tot_ucsize - tot_csize) / (tot_ucsize/1000L)) + 5 :
X        (int) ((tot_ucsize - tot_csize) * 1000L / tot_ucsize) + 5);
X
X    if (quietflg < 2) {
X        switch (which_hdr) {
X        case 0:         /* short */
X            printf("%s\n%7lu                    %-7u\n",
X                   " ------                    -------",
X                   tot_ucsize, members);
X            break;
X        case 1:         /* verbose */
X            printf(
X              "%s\n%7lu         %7lu %3d%%                              %-7u\n",
X              " ------          ------  ---                              -------",
X              tot_ucsize, tot_csize, ratio / 10, members);
X        }
X    }
X/*---------------------------------------------------------------------------
X    Double check that we're back at the end-of-central-directory record.
X  ---------------------------------------------------------------------------*/
X
X    readbuf(sig, 4);
X    if (strncmp(sig, END_CENTRAL_SIG, 4)) {     /* just to make sure again */
X        fprintf(stderr, EndSigMsg);  /* didn't find end-of-central-dir sig */
X        fprintf(stderr, ReportMsg);  /* report to info-zip */
X        error_in_archive = 1;        /* 1:  warning error */
X    }
X    return (error_in_archive);
X
X}       /* end function list_files() */
X
X
X
X
X
X/*************************************/
X/*  Function extract_or_test_files() */
X/*************************************/
X
Xint extract_or_test_files()
X/* return PK-type error code */
X{
X    char **fnamev;
X    byte *cd_inptr;
X    int cd_incnt, error, error_in_archive = 0;
X    UWORD i, j, members_remaining;
X    longint cd_bufstart, bufstart, inbuf_offset;
X    struct min_info {
X        unsigned f_attr;
X        longint offset;
X        int lcflag;
X    } info[DIR_BLKSIZ];
X
X
X
X/*---------------------------------------------------------------------------
X    The basic idea of this function is as follows.  Since the central di-
X    rectory lies at the end of the zipfile and the member files lie at the
X    beginning or middle or wherever, it is not very desirable to simply
X    read a central directory entry, jump to the member and extract it, and
X    then jump back to the central directory.  In the case of a large zipfile
X    this would lead to a whole lot of disk-grinding, especially if each mem-
X    ber file is small.  Instead, we read from the central directory the per-
X    tinent information for a block of files, then go extract/test the whole
X    block.  Thus this routine contains two small(er) loops within a very
X    large outer loop:  the first of the small ones reads a block of files
X    from the central directory; the second extracts or tests each file; and
X    the outer one loops over blocks.  There's some file-pointer positioning
X    stuff in between, but that's about it.  Btw, it's because of this jump-
X    ing around that we can afford to be lenient if an error occurs in one of
X    the member files:  we should still be able to go find the other members,
X    since we know the offset of each from the beginning of the zipfile.
X
X    Begin main loop over blocks of member files.  We know the entire central
X    directory is on this disk:  we would not have any of this information un-
END_OF_FILE
  if test 38155 -ne `wc -c <'./v41/unzip.c.1'`; then
    echo shar: \"'./v41/unzip.c.1'\" unpacked with wrong size!
  fi
  # end of './v41/unzip.c.1'
fi
echo shar: End of archive 1 \(of 6\).
cp /dev/null ark1isdone
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
