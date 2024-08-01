#! /bin/sh
# into a shell via "sh file" or similar.  To overwrite existing files,
# type "sh file -c".
# The tool that generated this appeared in the comp.sources.unix newsgroup;
# send mail to comp-sources-unix@uunet.uu.net if you want that tool.
# Contents:  ./v41/file_io.c ./v41/misc.c ./v41/unimplod.c
# Wrapped by kent@sparky on Sun May 19 19:40:39 1991
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
echo If this archive is complete, you will see the following message:
echo '          "shar: End of archive 3 (of 6)."'
if test -f './v41/file_io.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/file_io.c'\"
else
  echo shar: Extracting \"'./v41/file_io.c'\" \(23959 characters\)
  sed "s/^X//" >'./v41/file_io.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  file_io.c
X
X  This file contains routines for doing direct input/output, file-related
X  sorts of things.
X
X  ---------------------------------------------------------------------------*/
X
X
X#include "unzip.h"
X
X
X/************************************/
X/*  File_IO Includes, Defines, etc. */
X/************************************/
X
X#ifdef VMS
X#include <rms.h>                /* RMS prototypes, error codes, etc. */
X#include <ssdef.h>              /* system services error codes */
X#include <descrip.h>            /* "descriptor" format stuff */
X#endif
X
Xstatic int WriteBuffer __((int fd, unsigned char *buf, int len));
Xstatic int dos2unix __((unsigned char *buf, int len));
X
Xint CR_flag = 0;        /* when last char of buffer == CR (for dos2unix()) */
X
X
X
X
X
X/*******************************/
X/*  Function open_input_file() */
X/*******************************/
X
Xint open_input_file()
X{                               /* return non-0 if open failed */
X    /*
X     *  open the zipfile for reading and in BINARY mode to prevent cr/lf
X     *  translation, which would corrupt the bitstreams
X     */
X
X#ifndef UNIX
X    zipfd = open(zipfn, O_RDONLY | O_BINARY);
X#else
X    zipfd = open(zipfn, O_RDONLY);
X#endif
X    if (zipfd < 1) {
X        fprintf(stderr, "error:  can't open zipfile [ %s ]\n", zipfn);
X        return (1);
X    }
X    return 0;
X}
X
X
X
X
X
X/************************/
X/*  Function readbuf()  */
X/************************/
X
Xint readbuf(buf, size)
Xchar *buf;
Xregister unsigned size;
X{                               /* return number of bytes read into buf */
X    register int count;
X    int n;
X
X    n = size;
X    while (size) {
X        if (incnt == 0) {
X            if ((incnt = read(zipfd, inbuf, INBUFSIZ)) <= 0)
X                return (n-size);
X            /* buffer ALWAYS starts on a block boundary:  */
X            cur_zipfile_bufstart += INBUFSIZ;
X            inptr = inbuf;
X        }
X        count = min(size, incnt);
X        memcpy(buf, inptr, count);
X        buf += count;
X        inptr += count;
X        incnt -= count;
X        size -= count;
X    }
X    return (n);
X}
X
X
X
X
X
X#ifdef VMS
X
X/**********************************/
X/*  Function create_output_file() */
X/**********************************/
X
Xint create_output_file()
X{                               /* return non-0 if sys$create failed */
X    /*
X     * VMS VERSION (generic version is below)
X     *
X     * Create the output file and set its date/time using VMS Record Management
X     * Services From Hell.  Then reopen for appending with normal Unix/C-type
X     * I/O functions.  This is the EASY way to set the file date/time under VMS.
X     */
X    int ierr, yr, mo, dy, hh, mm, ss;
X    char timbuf[24];            /* length = first entry in "stupid" + 1 */
X    struct FAB fileblk;
X    struct XABDAT dattim;
X    static char *month[] =
X    {"JAN", "FEB", "MAR", "APR", "MAY", "JUN",
X     "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
X/*  fixed-length string descriptor (why not just a pointer to timbuf? sigh.) */
X    struct dsc$descriptor stupid =
X    {23, DSC$K_DTYPE_T, DSC$K_CLASS_S, timbuf};
X
X
X
X/*---------------------------------------------------------------------------
X    First initialize the necessary RMS and date/time variables.  "FAB" stands
X    for "file attribute block," "XAB" for "extended attribute block."  Files
X    under VMS are usually in "variable-length records" format with "carriage-
X    return carriage control" (at least for text files).  Unfortunately, some-
X    where along the line extra "carriage returns" (i.e., line feed characters)
X    get stuck in files which are opened in the variable format.  This may be
X    a VMS problem, an RMS problem, or a Unix/C I/O problem, but every 8192
X    characters of text file is followed by a spurious LF, and more often than
X    that for binary files.  So we use the stream-LF format instead (which is
X    what the Unix/C I/O routines do by default).  EDT complains about such
X    files but goes ahead and edits them; TPU (Adam, Eve) and vi don't seem
X    to care at all.
X  ---------------------------------------------------------------------------*/
X
X    yr = ((lrec.last_mod_file_date >> 9) & 0x7f) + 1980; /* dissect date */
X    mo = ((lrec.last_mod_file_date >> 5) & 0x0f) - 1;
X    dy = (lrec.last_mod_file_date & 0x1f);
X    hh = (lrec.last_mod_file_time >> 11) & 0x1f;        /* dissect time */
X    mm = (lrec.last_mod_file_time >> 5) & 0x3f;
X    ss = (lrec.last_mod_file_time & 0x1f) * 2;
X
X    fileblk = cc$rms_fab;               /* fill FAB with default values */
X    fileblk.fab$l_fna = filename;       /* l_fna, b_fns are the only re- */
X    fileblk.fab$b_fns = strlen(filename); /*  quired user-supplied fields */
X    fileblk.fab$b_rfm = FAB$C_STMLF;    /* stream-LF record format */
X    fileblk.fab$b_rat = FAB$M_CR;       /* carriage-return carriage ctrl */
X    /*                      ^^^^ *NOT* V_CR!!!     */
X    fileblk.fab$l_xab = &dattim;        /* chain XAB to FAB */
X    dattim = cc$rms_xabdat;             /* fill XAB with default values */
X
X    CR_flag = 0;                /* Hack to get CR at end of buffer working
X                                   (dos2unix) */
X
X/*---------------------------------------------------------------------------
X    Next convert date into an ASCII string, then use a VMS service to con-
X    vert the string into internal time format.  Obviously this is a bit of a
X    kludge, but I have absolutely NO intention of figuring out how to convert
X    MS-DOS time into tenths of microseconds elapsed since freaking 17 Novem-
X    ber 1858!!  Particularly since DEC doesn't even have a native 64-bit data
X    type.  Bleah.
X  ---------------------------------------------------------------------------*/
X
X    sprintf(timbuf, "%02d-%3s-%04d %02d:%02d:%02d.00", dy, month[mo], yr,
X            hh, mm, ss);
X
X/*  "xab$q_cdt" is the XAB field which holds the file's creation date/time */
X    sys$bintim(&stupid, &dattim.xab$q_cdt);
X
X/*---------------------------------------------------------------------------
X    Next create the file under RMS.  If sys$create chokes with an error of
X    RMS$_SYN (syntax error), it's probably because a Unix-style directory was
X    specified, so try to create the file again using the regular creat() func-
X    tion (date/time won't be set properly in this case, obviously).
X  ---------------------------------------------------------------------------*/
X
X    if ((ierr = sys$create(&fileblk)) != RMS$_NORMAL)
X        if (ierr == RMS$_SYN) { /* try Unix/C create:  0 = default perms */
X            outfd = creat(filename, 0, "rfm=stmlf", "rat=cr");
X            if (outfd < 1) {
X                fprintf(stderr, "Can't create output file:  %s\n", filename);
X                return (1);
X            } else {
X                return (0);
X            }
X        } else {                /* probably access violation */
X            fprintf(stderr, "Can't create output file:  %s\n", filename);
X            return (1);
X        }
X
X/*---------------------------------------------------------------------------
X    Finally, close the file under RMS and reopen with Unix/C open() function.
X  ---------------------------------------------------------------------------*/
X
X    sys$close(&fileblk);
X    outfd = open(filename, O_RDWR);
X
X    return (0);
X}
X
X
X
X
X
X#else                           /* !VMS */
X
X/**********************************/
X/*  Function create_output_file() */
X/**********************************/
X
Xint create_output_file()
X{                               /* return non-0 if creat failed */
X    /*
X     * GENERIC VERSION (special VMS version is above)
X     *
X     * Create the output file with default permissions.
X     */
X    extern int do_all;
X    char answerbuf[10];
X    UWORD holder;
X
X
X
X    CR_flag = 0;                /* Hack to get CR at end of buffer working. */
X
X    /*
X     * check if the file exists, unless do_all
X     */
X    if (!do_all) {
X        outfd = open(filename, 0);
X        if (outfd >= 0) {       /* first close it, before you forget! */
X            close(outfd);
X
X            /* ask the user before blowing it away */
X            fprintf(stderr, "replace %s, y-yes, n-no, a-all: ", filename);
X            fgets(answerbuf, 9, stdin);
X
X            switch (answerbuf[0]) {
X            case 'y':
X            case 'Y':
X                break;
X            case 'a':
X            case 'A':
X                do_all = 1;
X                break;
X            case 'n':
X            case 'N':
X            default:
X                while (ReadByte(&holder));
X                return 1;       /* it's done! */
X            }
X        }
X    }
X#ifndef UNIX
X    outfd = creat(filename, (S_IWRITE | S_IREAD) & f_attr);
X#else
X    {
X      int mask;
X      mask = umask(0);
X      outfd = creat(filename, 0777 & f_attr);
X      umask(mask);
X    }
X#endif
X
X    if (outfd < 1) {
X        fprintf(stderr, "Can't create output: %s\n", filename);
X        return 1;
X    }
X    /*
X     * close the newly created file and reopen it in BINARY mode to
X     * disable all CR/LF translations
X     */
X#ifndef UNIX
X#ifdef THINK_C
X    /*
X     * THINKC's stdio routines have the horrible habit of
X     * making any file you open look like generic files
X     * this code tells the OS that it's a text file
X     */
X    if (aflag) {
X        fileParam pb;
X        OSErr err;
X
X        CtoPstr(filename);
X        pb.ioNamePtr = filename;
X        pb.ioVRefNum = 0;
X        pb.ioFVersNum = 0;
X        pb.ioFDirIndex = 0;
X        err = PBGetFInfo(&pb,0);
X        if (err == noErr) {
X            pb.ioFlFndrInfo.fdCreator = '????';
X            pb.ioFlFndrInfo.fdType = 'TEXT';
X            err = PBSetFInfo(&pb, 0);
X        }
X        PtoCstr(filename);
X    }
X#endif
X    if (!aflag) {
X        close(outfd);
X        outfd = open(filename, O_RDWR | O_BINARY);
X    }
X#endif
X    return 0;
X}
X
X#endif                          /* !VMS */
X
X
X
X
X
X/*****************************/
X/*  Function FillBitBuffer() */
X/*****************************/
X
Xint FillBitBuffer(bits)
Xregister int bits;
X{
X    /*
X     * Get the bits that are left and read the next UWORD.  This
X     * function is only used by the READBIT macro (which is used
X     * by all of the uncompression routines).
X     */
X    register int result = bitbuf;
X    UWORD temp;
X    int sbits = bits_left;
X
X
X    bits -= bits_left;
X
X    /* read next UWORD of input */
X    bits_left = ReadByte(&bitbuf);
X    bits_left += ReadByte(&temp);
X
X    bitbuf |= (temp << 8);
X    if (bits_left == 0)
X        zipeof = 1;
X
X    /* get the remaining bits */
X    result = result | (int) ((bitbuf & mask_bits[bits]) << sbits);
X    bitbuf >>= bits;
X    bits_left -= bits;
X    return result;
X}
X
X
X
X
X
X/************************/
X/*  Function ReadByte() */
X/************************/
X
Xint ReadByte(x)
XUWORD *x;
X{
X    /*
X     * read a byte; return 8 if byte available, 0 if not
X     */
X
X
X    if (csize-- <= 0)
X        return 0;
X
X    if (incnt == 0) {
X        if ((incnt = read(zipfd, inbuf, INBUFSIZ)) <= 0)
X            return 0;
X        /* buffer ALWAYS starts on a block boundary:  */
X        cur_zipfile_bufstart += INBUFSIZ;
X        inptr = inbuf;
X    }
X    *x = *inptr++;
X    --incnt;
X    return 8;
X}
X
X
X
X#ifdef FLUSH_AND_WRITE
X/***************************/
X/*  Function FlushOutput() */
X/***************************/
X
Xint FlushOutput()
X{                               /* return PK-type error code */
X    /* flush contents of output buffer */
X    /*
X     * This combined version doesn't work, and I sure can't see why not...
X     * probably something stupid, but how much can you screw up in 6 lines???
X     * [optimization problem??]
X     */
X    int len;
X
X
X    if (outcnt) {
X        UpdateCRC(outbuf, outcnt);
X
X        if (!tflag) {
X            if (aflag)
X                len = dos2unix(outbuf, outcnt);
X            if (write(outfd, outout, len) != len) {
X                fprintf(stderr, "Fatal write error.\n");
X                return (50);    /* 50:  disk full */
X            }
X        }
X        outpos += outcnt;
X        outcnt = 0;
X        outptr = outbuf;
X    }
X    return (0);                 /* 0:  no error */
X}
X
X#else                           /* separate flush and write routines */
X/***************************/
X/*  Function FlushOutput() */
X/***************************/
X
Xint FlushOutput()
X{                               /* return PK-type error code */
X    /* flush contents of output buffer */
X    if (outcnt) {
X        UpdateCRC(outbuf, outcnt);
X
X        if (!tflag && WriteBuffer(outfd, outbuf, outcnt))
X            return (50);        /* 50:  disk full */
X
X        outpos += outcnt;
X        outcnt = 0;
X        outptr = outbuf;
X    }
X    return (0);                 /* 0:  no error */
X}
X
X/***************************/
X/*  Function WriteBuffer() */
X/***************************/
X
Xstatic int WriteBuffer(fd, buf, len)    /* return 0 if successful, 1 if not */
Xint fd;
Xunsigned char *buf;
Xint len;
X{
X    if (aflag)
X        len = dos2unix(buf, len);
X    if (write(fd, outout, len) != len) {
X#ifdef DOS_OS2
X        if (!cflag) {           /* ^Z treated as EOF, removed with -c */
X#endif
X            fprintf(stderr, "Fatal write error.\n");
X            return (1);         /* FAILED */
X#ifdef DOS_OS2
X        }
X#endif
X    }
X    return (0);
X}
X
X#endif
X
X
X
X
X/************************/
X/*  Function dos2unix() */
X/************************/
X
Xstatic int dos2unix(buf, len)
Xunsigned char *buf;
Xint len;
X{
X    int new_len;
X    int i;
X    unsigned char *walker;
X
X    new_len = len;
X    walker = outout;
X#ifdef MACOS
X    /*
X     * Mac wants to strip LFs instead CRs from CRLF pairs
X     */
X    if (CR_flag && *buf == LF) {
X        buf++;
X        new_len--;
X        len--;
X        CR_flag = buf[len] == CR;
X    }
X    else
X        CR_flag = buf[len - 1] == CR;
X    for (i = 0; i < len; i += 1) {
X        *walker++ = ascii_to_native(*buf);
X        if (*buf == LF) walker[-1] = CR;
X        if (*buf++ == CR && *buf == LF) {
X            new_len--;
X            buf++;
X            i++;
X        }
X    }
X#else
X    if (CR_flag && *buf != LF)
X        *walker++ = ascii_to_native(CR);
X    CR_flag = buf[len - 1] == CR;
X    for (i = 0; i < len; i += 1) {
X        *walker++ = ascii_to_native(*buf);
X        if (*buf++ == CR && *buf == LF) {
X            new_len--;
X            walker[-1] = ascii_to_native(*buf++);
X            i++;
X        }
X    }
X    /*
X     * If the last character is a CR, then "ignore it" for now...
X     */
X    if (walker[-1] == ascii_to_native(CR))
X        new_len--;
X#endif
X    return new_len;
X}
X
X
X
X
X
X#ifdef DOS_OS2
X
X/***************************************/
X/*  Function set_file_time_and_close() */
X/***************************************/
X
Xvoid set_file_time_and_close()
X /*
X  * MS-DOS AND OS/2 VERSION (Mac, Unix versions are below)
X  *
X  * Set the output file date/time stamp according to information from the
X  * zipfile directory record for this member, then close the file.  This
X  * is optional and can be deleted if your compiler does not easily support
X  * setftime().
X  */
X{
X/*---------------------------------------------------------------------------
X    Allocate local variables needed by OS/2 and Turbo C.  [OK, OK, so it's
X    a bogus comment...but this routine was getting way too cluttered and
X    needed some visual separators.  Bleah.]
X  ---------------------------------------------------------------------------*/
X
X#ifdef OS2              /* (assuming only MSC or MSC-compatible compilers
X                         * for this part) */
X
X    union {
X        FDATE fd;               /* system file date record */
X        UWORD zdate;            /* date word */
X    } ud;
X
X    union {
X        FTIME ft;               /* system file time record */
X        UWORD ztime;            /* time word */
X    } ut;
X
X    FILESTATUS fs;
X
X#else                           /* !OS2 */
X#ifdef __TURBOC__
X
X    union {
X        struct ftime ft;        /* system file time record */
X        struct {
X            UWORD ztime;        /* date and time words */
X            UWORD zdate;        /* .. same format as in .ZIP file */
X        } zt;
X    } td;
X
X#endif                          /* __TURBOC__ */
X#endif                          /* !OS2 */
X
X    /*
X     * Do not attempt to set the time stamp on standard output
X     */
X    if (cflag) {
X        close(outfd);
X        return;
X    }
X
X
X/*---------------------------------------------------------------------------
X    Copy and/or convert time and date variables, if necessary; then set the
X    file time/date.
X  ---------------------------------------------------------------------------*/
X
X#ifdef OS2
X
X    DosQFileInfo(outfd, 1, &fs, sizeof(fs));
X    ud.zdate = lrec.last_mod_file_date;
X    fs.fdateLastWrite = ud.fd;
X    ut.ztime = lrec.last_mod_file_time;
X    fs.ftimeLastWrite = ut.ft;
X    DosSetFileInfo(outfd, 1, &fs, sizeof(fs));
X
X#else                           /* !OS2 */
X#ifdef __TURBOC__
X
X    td.zt.ztime = lrec.last_mod_file_time;
X    td.zt.zdate = lrec.last_mod_file_date;
X    setftime(outfd, &td.ft);
X
X#else                           /* !__TURBOC__:  MSC MS-DOS */
X
X    _dos_setftime(outfd, lrec.last_mod_file_date, lrec.last_mod_file_time);
X
X#endif                          /* !__TURBOC__ */
X#endif                          /* !OS2 */
X
X/*---------------------------------------------------------------------------
X    And finally we can close the file...at least everybody agrees on how to
X    do *this*.  I think...
X  ---------------------------------------------------------------------------*/
X
X    close(outfd);
X}
X
X
X
X
X
X#else                           /* !DOS_OS2 ... */
X#ifndef VMS                     /* && !VMS (already done) ... */
X#ifndef MTS                     /* && !MTS (can't do):  Mac or UNIX */
X#ifdef MACOS                    /* Mac first */
X
X/***************************************/
X/*  Function set_file_time_and_close() */
X/***************************************/
X
Xvoid set_file_time_and_close()
X /*
X  * MAC VERSION
X  *
X  * First close the output file, then set its date/time stamp according
X  * to information from the zipfile directory record for this file.  [So
X  * technically this should be called "close_file_and_set_time()", but
X  * this way we can use the same prototype for either case, without extra
X  * #ifdefs.  So there.]
X  */
X{
X    long m_time;
X    DateTimeRec dtr;
X    ParamBlockRec pbr;
X    OSErr err;
X
X    if (outfd != 1)
X    {
X        close(outfd);
X
X        /*
X         * Macintosh bases all file modification times on the number of seconds
X         * elapsed since Jan 1, 1904, 00:00:00.  Therefore, to maintain
X         * compatibility with MS-DOS archives, which date from Jan 1, 1980,
X         * with NO relation to GMT, the following conversions must be made:
X         *      the Year (yr) must be incremented by 1980;
X         *      and converted to seconds using the Mac routine Date2Secs(),
X         *      almost similar in complexity to the Unix version :-)
X         *                                     J. Lee
X         */
X
X        dtr.year = (((lrec.last_mod_file_date >> 9) & 0x7f) + 1980); /* dissect date */
X        dtr.month = ((lrec.last_mod_file_date >> 5) & 0x0f);
X        dtr.day = (lrec.last_mod_file_date & 0x1f);
X
X        dtr.hour = ((lrec.last_mod_file_time >> 11) & 0x1f);      /* dissect time */
X        dtr.minute = ((lrec.last_mod_file_time >> 5) & 0x3f);
X        dtr.second = ((lrec.last_mod_file_time & 0x1f) * 2);
X        Date2Secs(&dtr, &m_time);
X        CtoPstr(filename);
X        pbr.fileParam.ioNamePtr = filename;
X        pbr.fileParam.ioVRefNum = pbr.fileParam.ioFVersNum = pbr.fileParam.ioFDirIndex = 0;
X        err = PBGetFInfo(&pbr, 0L);
X        pbr.fileParam.ioFlMdDat = pbr.fileParam.ioFlCrDat = m_time;
X        if (err == noErr) {
X            err = PBSetFInfo(&pbr, 0L);
X        }
X        if (err != noErr) {
X            printf("Error, can't set the time for %s\n",filename);
X        }
X
X        /* set read-only perms if needed */
X        if (err != noErr && f_attr != 0) {
X            err = SetFLock(filename, 0);
X        }
X        PtoCstr(filename);
X    }
X}
X
X
X
X
X
X#else                           /* !MACOS:  only one left is UNIX */
X
X/***************************************/
X/*  Function set_file_time_and_close() */
X/***************************************/
X
Xvoid set_file_time_and_close()
X /*
X  * UNIX VERSION (MS-DOS & OS/2, Mac versions are above)
X  *
X  * First close the output file, then set its date/time stamp according
X  * to information from the zipfile directory record for this file.  [So
X  * technically this should be called "close_file_and_set_time()", but
X  * this way we can use the same prototype for either case, without extra
X  * #ifdefs.  So there.]
X  */
X{
X    long m_time;
X    int yr, mo, dy, hh, mm, ss, leap, days = 0;
X    struct utimbuf {
X      time_t atime;             /* New access time */
X      time_t mtime;             /* New modification time */
X    } tp;
X#ifdef BSD
X    static struct timeb tbp;
X#else
X    extern long timezone;
X#endif
X
X
X    close(outfd);
X
X    if (cflag)                  /* can't set time on stdout */
X        return;
X
X    /*
X     * These date conversions look a little weird, so I'll explain.
X     * UNIX bases all file modification times on the number of seconds
X     * elapsed since Jan 1, 1970, 00:00:00 GMT.  Therefore, to maintain
X     * compatibility with MS-DOS archives, which date from Jan 1, 1980,
X     * with NO relation to GMT, the following conversions must be made:
X     *      the Year (yr) must be incremented by 10;
X     *      the Date (dy) must be decremented by 1;
X     *      and the whole mess must be adjusted by TWO factors:
X     *          relationship to GMT (ie.,Pacific Time adds 8 hrs.),
X     *          and whether or not it is Daylight Savings Time.
X     * Also, the usual conversions must take place to account for leap years,
X     * etc.
X     *                                     C. Seaman
X     */
X
X    yr = (((lrec.last_mod_file_date >> 9) & 0x7f) + 10); /* dissect date */
X    mo = ((lrec.last_mod_file_date >> 5) & 0x0f);
X    dy = ((lrec.last_mod_file_date & 0x1f) - 1);
X
X    hh = ((lrec.last_mod_file_time >> 11) & 0x1f);      /* dissect time */
X    mm = ((lrec.last_mod_file_time >> 5) & 0x3f);
X    ss = ((lrec.last_mod_file_time & 0x1f) * 2);
X
X    /* leap = # of leap years from 1970 up to but not including
X       the current year */
X
X    leap = ((yr + 1969) / 4);   /* Leap year base factor */
X
X    /* How many days from 1970 to this year? */
X    days = (yr * 365) + (leap - 492);
X
X    switch (mo) {               /* calculate expired days this year */
X    case 12:
X        days += 30;
X    case 11:
X        days += 31;
X    case 10:
X        days += 30;
X    case 9:
X        days += 31;
X    case 8:
X        days += 31;
X    case 7:
X        days += 30;
X    case 6:
X        days += 31;
X    case 5:
X        days += 30;
X    case 4:
X        days += 31;
X    case 3:
X        days += 28;             /* account for leap years (2000 IS one) */
X        if (((yr + 1970) % 4 == 0) && (yr + 1970) != 2100)  /* OK thru 2199 */
X            ++days;
X    case 2:
X        days += 31;
X    }
X
X    /* convert date & time to seconds relative to 00:00:00, 01/01/1970 */
X    m_time = ((days + dy) * 86400) + (hh * 3600) + (mm * 60) + ss;
X
X#ifdef BSD
X   ftime(&tbp);
X   m_time += tbp.timezone * 60L;
X#else                                   /* !BSD */
X    tzset();                            /* Set `timezone'. */
X    m_time += timezone;                 /* account for timezone differences */
X#endif
X
X    if (localtime(&m_time)->tm_isdst)
X        m_time -= 60L * 60L;            /* Adjust for daylight savings time */
X
X    /* set the time stamp on the file */
X    
X    tp.mtime = m_time;                  /* Set modification time */
X    tp.atime = m_time;                  /* Set access time */
X
X    if (utime(filename, &tp))
X        fprintf(stderr, "Error, can't set the time for %s\n",filename);
X}
X
X#endif                          /* ?MACOS */
X#endif                          /* ?MTS */
X#endif                          /* ?VMS */
X#endif                          /* ?DOS_OS2 */
END_OF_FILE
  if test 23959 -ne `wc -c <'./v41/file_io.c'`; then
    echo shar: \"'./v41/file_io.c'\" unpacked with wrong size!
  fi
  # end of './v41/file_io.c'
fi
if test -f './v41/misc.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/misc.c'\"
else
  echo shar: Extracting \"'./v41/misc.c'\" \(17338 characters\)
  sed "s/^X//" >'./v41/misc.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  misc.c
X
X  This file contains a number of useful but not particularly closely related
X  functions; their main claim to fame is that they don't change much, so
X  this file should rarely need to be recompiled.  The CRC-32 stuff is from
X  crc32.c; do_string() is from nunzip.c; a_to_e() is from ascebc.c; makeword/
X  makelong() are from unzip.c; and memset() and memcpy() are from zmemset.c
X  and zmemcpy.c, respectively.  Lumped together here to cut down on the size
X  of unzip.c and the number of associated files floating around.
X
X  ---------------------------------------------------------------------------
X
X  Contributions by C. Mascott, Allan Bjorklund, Bill Davidsen, Bo Kullmar,
X  Warner Losh, Greg Roelofs, Larry Jones, Mark Edwards, Antoine Verheijen,
X  and probably many others.
X
X  ---------------------------------------------------------------------------
X
X  Copyright, applying to UpdateCRC() and crc_32_tab[]:
X
X     COPYRIGHT (C) 1986 Gary S. Brown.  You may use this program, or code
X     or tables extracted from it, as desired without restriction.
X
X  ---------------------------------------------------------------------------*/
X
X
X#include "unzip.h"
X
X
X
X/**************************/
X/*  Function UpdateCRC()  */
X/**************************/
X
X /*--------------------------------------------------------------------
X
X   First, the polynomial itself and its table of feedback terms.  The
X   polynomial is
X   X^32+X^26+X^23+X^22+X^16+X^12+X^11+X^10+X^8+X^7+X^5+X^4+X^2+X^1+X^0
X
X   Note that we take it "backwards" and put the highest-order term in
X   the lowest-order bit.  The X^32 term is "implied"; the LSB is the
X   X^31 term, etc.  The X^0 term (usually shown as "+1") results in
X   the MSB being 1.
X
X   Note that the usual hardware shift register implementation, which
X   is what we're using (we're merely optimizing it by doing eight-bit
X   chunks at a time) shifts bits into the lowest-order term.  In our
X   implementation, that means shifting towards the right.  Why do we
X   do it this way?  Because the calculated CRC must be transmitted in
X   order from highest-order term to lowest-order term.  UARTs transmit
X   characters in order from LSB to MSB.  By storing the CRC this way,
X   we hand it to the UART in the order low-byte to high-byte; the UART
X   sends each low-bit to hight-bit; and the result is transmission bit
X   by bit from highest- to lowest-order term without requiring any bit
X   shuffling on our part.  Reception works similarly.
X
X   The feedback terms table consists of 256, 32-bit entries.  Notes:
X
X       The table can be generated at runtime if desired; code to do so
X       is shown later.  It might not be obvious, but the feedback
X       terms simply represent the results of eight shift/xor opera-
X       tions for all combinations of data and CRC register values.
X
X       The values must be right-shifted by eight bits by the "updcrc"
X       logic; the shift must be unsigned (bring in zeroes).  On some
X       hardware you could probably optimize the shift in assembler by
X       using byte-swap instructions.
X       polynomial $edb88320
X
X   --------------------------------------------------------------------*/
X
XULONG crc_32_tab[] =
X{
X    0x00000000L, 0x77073096L, 0xee0e612cL, 0x990951baL, 0x076dc419L,
X    0x706af48fL, 0xe963a535L, 0x9e6495a3L, 0x0edb8832L, 0x79dcb8a4L,
X    0xe0d5e91eL, 0x97d2d988L, 0x09b64c2bL, 0x7eb17cbdL, 0xe7b82d07L,
X    0x90bf1d91L, 0x1db71064L, 0x6ab020f2L, 0xf3b97148L, 0x84be41deL,
X    0x1adad47dL, 0x6ddde4ebL, 0xf4d4b551L, 0x83d385c7L, 0x136c9856L,
X    0x646ba8c0L, 0xfd62f97aL, 0x8a65c9ecL, 0x14015c4fL, 0x63066cd9L,
X    0xfa0f3d63L, 0x8d080df5L, 0x3b6e20c8L, 0x4c69105eL, 0xd56041e4L,
X    0xa2677172L, 0x3c03e4d1L, 0x4b04d447L, 0xd20d85fdL, 0xa50ab56bL,
X    0x35b5a8faL, 0x42b2986cL, 0xdbbbc9d6L, 0xacbcf940L, 0x32d86ce3L,
X    0x45df5c75L, 0xdcd60dcfL, 0xabd13d59L, 0x26d930acL, 0x51de003aL,
X    0xc8d75180L, 0xbfd06116L, 0x21b4f4b5L, 0x56b3c423L, 0xcfba9599L,
X    0xb8bda50fL, 0x2802b89eL, 0x5f058808L, 0xc60cd9b2L, 0xb10be924L,
X    0x2f6f7c87L, 0x58684c11L, 0xc1611dabL, 0xb6662d3dL, 0x76dc4190L,
X    0x01db7106L, 0x98d220bcL, 0xefd5102aL, 0x71b18589L, 0x06b6b51fL,
X    0x9fbfe4a5L, 0xe8b8d433L, 0x7807c9a2L, 0x0f00f934L, 0x9609a88eL,
X    0xe10e9818L, 0x7f6a0dbbL, 0x086d3d2dL, 0x91646c97L, 0xe6635c01L,
X    0x6b6b51f4L, 0x1c6c6162L, 0x856530d8L, 0xf262004eL, 0x6c0695edL,
X    0x1b01a57bL, 0x8208f4c1L, 0xf50fc457L, 0x65b0d9c6L, 0x12b7e950L,
X    0x8bbeb8eaL, 0xfcb9887cL, 0x62dd1ddfL, 0x15da2d49L, 0x8cd37cf3L,
X    0xfbd44c65L, 0x4db26158L, 0x3ab551ceL, 0xa3bc0074L, 0xd4bb30e2L,
X    0x4adfa541L, 0x3dd895d7L, 0xa4d1c46dL, 0xd3d6f4fbL, 0x4369e96aL,
X    0x346ed9fcL, 0xad678846L, 0xda60b8d0L, 0x44042d73L, 0x33031de5L,
X    0xaa0a4c5fL, 0xdd0d7cc9L, 0x5005713cL, 0x270241aaL, 0xbe0b1010L,
X    0xc90c2086L, 0x5768b525L, 0x206f85b3L, 0xb966d409L, 0xce61e49fL,
X    0x5edef90eL, 0x29d9c998L, 0xb0d09822L, 0xc7d7a8b4L, 0x59b33d17L,
X    0x2eb40d81L, 0xb7bd5c3bL, 0xc0ba6cadL, 0xedb88320L, 0x9abfb3b6L,
X    0x03b6e20cL, 0x74b1d29aL, 0xead54739L, 0x9dd277afL, 0x04db2615L,
X    0x73dc1683L, 0xe3630b12L, 0x94643b84L, 0x0d6d6a3eL, 0x7a6a5aa8L,
X    0xe40ecf0bL, 0x9309ff9dL, 0x0a00ae27L, 0x7d079eb1L, 0xf00f9344L,
X    0x8708a3d2L, 0x1e01f268L, 0x6906c2feL, 0xf762575dL, 0x806567cbL,
X    0x196c3671L, 0x6e6b06e7L, 0xfed41b76L, 0x89d32be0L, 0x10da7a5aL,
X    0x67dd4accL, 0xf9b9df6fL, 0x8ebeeff9L, 0x17b7be43L, 0x60b08ed5L,
X    0xd6d6a3e8L, 0xa1d1937eL, 0x38d8c2c4L, 0x4fdff252L, 0xd1bb67f1L,
X    0xa6bc5767L, 0x3fb506ddL, 0x48b2364bL, 0xd80d2bdaL, 0xaf0a1b4cL,
X    0x36034af6L, 0x41047a60L, 0xdf60efc3L, 0xa867df55L, 0x316e8eefL,
X    0x4669be79L, 0xcb61b38cL, 0xbc66831aL, 0x256fd2a0L, 0x5268e236L,
X    0xcc0c7795L, 0xbb0b4703L, 0x220216b9L, 0x5505262fL, 0xc5ba3bbeL,
X    0xb2bd0b28L, 0x2bb45a92L, 0x5cb36a04L, 0xc2d7ffa7L, 0xb5d0cf31L,
X    0x2cd99e8bL, 0x5bdeae1dL, 0x9b64c2b0L, 0xec63f226L, 0x756aa39cL,
X    0x026d930aL, 0x9c0906a9L, 0xeb0e363fL, 0x72076785L, 0x05005713L,
X    0x95bf4a82L, 0xe2b87a14L, 0x7bb12baeL, 0x0cb61b38L, 0x92d28e9bL,
X    0xe5d5be0dL, 0x7cdcefb7L, 0x0bdbdf21L, 0x86d3d2d4L, 0xf1d4e242L,
X    0x68ddb3f8L, 0x1fda836eL, 0x81be16cdL, 0xf6b9265bL, 0x6fb077e1L,
X    0x18b74777L, 0x88085ae6L, 0xff0f6a70L, 0x66063bcaL, 0x11010b5cL,
X    0x8f659effL, 0xf862ae69L, 0x616bffd3L, 0x166ccf45L, 0xa00ae278L,
X    0xd70dd2eeL, 0x4e048354L, 0x3903b3c2L, 0xa7672661L, 0xd06016f7L,
X    0x4969474dL, 0x3e6e77dbL, 0xaed16a4aL, 0xd9d65adcL, 0x40df0b66L,
X    0x37d83bf0L, 0xa9bcae53L, 0xdebb9ec5L, 0x47b2cf7fL, 0x30b5ffe9L,
X    0xbdbdf21cL, 0xcabac28aL, 0x53b39330L, 0x24b4a3a6L, 0xbad03605L,
X    0xcdd70693L, 0x54de5729L, 0x23d967bfL, 0xb3667a2eL, 0xc4614ab8L,
X    0x5d681b02L, 0x2a6f2b94L, 0xb40bbe37L, 0xc30c8ea1L, 0x5a05df1bL,
X    0x2d02ef8dL
X};
X
X
Xvoid UpdateCRC(s, len)
Xregister byte *s;
Xregister int len;
X /* update running CRC calculation with contents of a buffer */
X{
X    register ULONG crcval = crc32val;
X
X
X    while (len--)
X        crcval = crc_32_tab[((byte) crcval ^ (*s++)) & 0xff] ^ (crcval >> 8);
X    crc32val = crcval;
X}
X
X
X
X
X
X/**************************/
X/*  Function do_string()  */
X/**************************/
X
Xint do_string(len, option)      /* return PK-type error code */
Xunsigned int len;               /* without prototype, UWORD converted to this */
Xint option;
X{
X    int block_length, error = 0;
X    UWORD comment_bytes_left, extra_len;
X
X
X
X/*---------------------------------------------------------------------------
X    This function processes arbitrary-length (well, usually) strings.  Three
X    options are allowed:  SKIP, wherein the string is skipped pretty logical,
X    eh?); DISPLAY, wherein the string is printed to standard output after un-
X    dergoing any necessary or unnecessary character conversions; and FILENAME,
X    wherein the string is put into the filename[] array after undergoing ap-
X    propriate conversions (including case-conversion, if that is indicated:
X    see the global variable lcflag).  The latter option should be OK, since
X    filename is now dimensioned at FILENAME_MAX (1024).
X
X    The string, by the way, is assumed to start at the current file-pointer
X    position; its length is given by len.  So start off by checking length
X    of string:  if zero, we're already set.
X  ---------------------------------------------------------------------------*/
X
X    if (!len)
X        return (0);             /* 0:  no error */
X
X    switch (option) {
X
X    /*
X     * First case:  print string on standard output.  First set loop vari-
X     * ables, then loop through the comment in chunks of OUTBUFSIZ bytes,
X     * converting formats and printing as we go.  The second half of the
X     * loop conditional was added because the file might be truncated, in
X     * which case comment_bytes_left will remain at some non-zero value for
X     * all time.  outbuf is used as a scratch buffer because it is avail-
X     * able (we should be either before or in between any file processing).
X     * [The typecast in front of the min() macro was added because of the
X     * new promotion rules under ANSI C; readbuf() wants an int, but min()
X     * returns a signed long, if I understand things correctly.  The proto-
X     * type should handle it, but just in case...]
X     */
X
X    case DISPLAY:
X        comment_bytes_left = len;
X        block_length = OUTBUFSIZ;    /* for the while statement, first time */
X        while (comment_bytes_left > 0 && block_length > 0) {
X            if ((block_length = readbuf((char *) outbuf,
X                         (int) min(OUTBUFSIZ, comment_bytes_left))) <= 0)
X                return (51);    /* 51:  unexpected EOF */
X            comment_bytes_left -= block_length;
X            NUKE_CRs(outbuf, block_length);     /* (modifies block_length) */
X
X            /*  this is why we allocated an extra byte for outbuf: */
X            outbuf[block_length] = '\0';        /* terminate w/zero:  ASCIIZ */
X
X            A_TO_N(outbuf);     /* translate string to native */
X
X            printf("%s", outbuf);
X        }
X        printf("\n", outbuf);   /* assume no newline at end */
X        break;
X
X    /*
X     * Second case:  read string into filename[] array.  The filename should
X     * never ever be longer than FILNAMSIZ (1024), but for now we'll check,
X     * just to be sure.
X     */
X
X    case FILENAME:
X        extra_len = 0;
X        if (len >= FILNAMSIZ) {
X            fprintf(stderr, "warning:  filename too long--truncating.\n");
X            error = 1;          /* 1:  warning error */
X            extra_len = len - FILNAMSIZ + 1;
X            len = FILNAMSIZ - 1;
X        }
X        if (readbuf(filename, len) <= 0)
X            return (51);        /* 51:  unexpected EOF */
X        filename[len] = '\0';   /* terminate w/zero:  ASCIIZ */
X
X        A_TO_N(filename);       /* translate string to native */
X
X        if (lcflag)
X            TOLOWER(filename, filename);        /* replace with lowercase fn. */
X
X        if (!extra_len)         /* we're done here */
X            break;
X
X        /*
X         * We truncated the filename, so print what's left and then fall
X         * through to the SKIP routine.
X         */
X        fprintf(stderr, "[ %s ]\n", filename);
X        len = extra_len;
X        /*  FALL THROUGH...  */
X
X    /*
X     * Third case:  skip string, adjusting readbuf's internal variables
X     * as necessary (and possibly skipping to and reading a new block of
X     * data).
X     */
X
X    case SKIP:
X        LSEEK(cur_zipfile_bufstart + (inptr-inbuf) + len)
X        break;
X
X    }                           /* end switch (option) */
X
X    return (error);
X
X}                               /* end function do_string() */
X
X
X
X
X
X#ifdef EBCDIC
X
X/*
X * This is the MTS ASCII->EBCDIC translation table. It provides a 1-1
X * translation from ISO 8859/1 8-bit ASCII to IBM Code Page 37 EBCDIC.
X */
X
Xunsigned char ebcdic[] =
X{
X    0x00, 0x01, 0x02, 0x03, 0x37, 0x2d, 0x2e, 0x2f, 0x16, 0x05, 0x25, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
X    0x10, 0x11, 0x12, 0x13, 0x3c, 0x3d, 0x32, 0x26, 0x18, 0x19, 0x3f, 0x27, 0x1c, 0x1d, 0x1e, 0x1f,
X    0x40, 0x5a, 0x7f, 0x7b, 0x5b, 0x6c, 0x50, 0x7d, 0x4d, 0x5d, 0x5c, 0x4e, 0x6b, 0x60, 0x4b, 0x61,
X    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0x7a, 0x5e, 0x4c, 0x7e, 0x6e, 0x6f,
X    0x7c, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6,
X    0xd7, 0xd8, 0xd9, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8, 0xe9, 0xba, 0xe0, 0xbb, 0xb0, 0x6d,
X    0x79, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96,
X    0x97, 0x98, 0x99, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xc0, 0x4f, 0xd0, 0xa1, 0x07,
X    0x20, 0x21, 0x22, 0x23, 0x24, 0x15, 0x06, 0x17, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x09, 0x0a, 0x1b,
X    0x30, 0x31, 0x1a, 0x33, 0x34, 0x35, 0x36, 0x08, 0x38, 0x39, 0x3a, 0x3b, 0x04, 0x14, 0x3e, 0xff,
X    0x41, 0xaa, 0x4a, 0xb1, 0x9f, 0xb2, 0x6a, 0xb5, 0xbd, 0xb4, 0x9a, 0x8a, 0x5f, 0xca, 0xaf, 0xbc,
X    0x90, 0x8f, 0xea, 0xfa, 0xbe, 0xa0, 0xb6, 0xb3, 0x9d, 0xda, 0x9b, 0x8b, 0xb7, 0xb8, 0xb9, 0xab,
X    0x64, 0x65, 0x62, 0x66, 0x63, 0x67, 0x9e, 0x68, 0x74, 0x71, 0x72, 0x73, 0x78, 0x75, 0x76, 0x77,
X    0xac, 0x69, 0xed, 0xee, 0xeb, 0xef, 0xec, 0xbf, 0x80, 0xfd, 0xfe, 0xfb, 0xfc, 0xad, 0xae, 0x59,
X    0x44, 0x45, 0x42, 0x46, 0x43, 0x47, 0x9c, 0x48, 0x54, 0x51, 0x52, 0x53, 0x58, 0x55, 0x56, 0x57,
X    0x8c, 0x49, 0xcd, 0xce, 0xcb, 0xcf, 0xcc, 0xe1, 0x70, 0xdd, 0xde, 0xdb, 0xdc, 0x8d, 0x8e, 0xdf
X};
X
X#endif                          /* EBCDIC */
X
X
X
X
X
X#ifdef NOTINT16
X
X/*************************/
X/*  Function makeword()  */
X/*************************/
X
XUWORD makeword(b)
Xbyte *b;
X /*
X  * Convert Intel style 'short' integer to non-Intel non-16-bit
X  * host format.  This routine also takes care of byte-ordering.
X  */
X{
X/*
X    return  ( ((UWORD)(b[1]) << 8)  |  (UWORD)(b[0]) );
X */
X    return ((b[1] << 8) | b[0]);
X}
X
X
X
X
X
X/*************************/
X/*  Function makelong()  */
X/*************************/
X
XULONG makelong(sig)
Xbyte *sig;
X /*
X  * Convert intel style 'long' variable to non-Intel non-16-bit
X  * host format.  This routine also takes care of byte-ordering.
X  */
X{
X    return (((ULONG) sig[3]) << 24)
X        + (((ULONG) sig[2]) << 16)
X        + (((ULONG) sig[1]) << 8)
X        + ((ULONG) sig[0]);
X}
X
X#endif                          /* !NOTINT16 */
X
X
X
X
X
X#ifdef VMS
X
X/***************************/
X/*  Function return_VMS()  */
X/***************************/
X
Xvoid return_VMS(zip_error)
Xint zip_error;
X{
X/*---------------------------------------------------------------------------
X    Do our own, explicit processing of error codes and print message, since
X    VMS misinterprets return codes as rather obnoxious system errors ("access
X    violation," for example).
X  ---------------------------------------------------------------------------*/
X
X#ifndef NO_RETURN_CODES         /* can compile without messages if want */
X    switch (zip_error) {
X
X    case 0:
X        break;                  /* life is fine... */
X    case 1:
X        fprintf(stderr, "\n[return-code 1:  warning error \
X(e.g., failed CRC or unknown compression method)]\n");
X        break;
X    case 2:
X    case 3:
X        fprintf(stderr, "\n[return-code %d:  error in zipfile \
X(e.g., can't find local file header sig)]\n",
X                zip_error);
X        break;
X    case 4:
X    case 5:
X    case 6:
X    case 7:
X    case 8:
X        fprintf(stderr, "\n[return-code %d:  insufficient memory]\n",
X                zip_error);
X        break;
X    case 9:
X        fprintf(stderr, "\n[return-code 9:  zipfile not found]\n");
X        break;
X    case 10:                    /* this is the one that gives "access violation," I think */
X        fprintf(stderr, "\n[return-code 10:  bad or illegal parameters \
Xspecified on command line]\n");
X        break;
X    case 11:                    /* I'm not sure this one is implemented, but maybe soon? */
X        fprintf(stderr, "\n[return-code 11:  no files found to \
Xextract/view/etc.]\n");
X        break;
X    case 50:
X        fprintf(stderr, "\n[return-code 50:  disk full \
X(or otherwise unable to open output file)]\n");
X        break;
X    case 51:
X        fprintf(stderr, "\n[return-code 51:  unexpected EOF in zipfile \
X(i.e., truncated)]\n");
X        break;
X    default:
X        fprintf(stderr, "\n[return-code %d:  unknown return-code \
X(who put this one in?  Wasn't me...)]\n",
X                zip_error);
X        break;
X    }
X#endif                          /* NO_RETURN_CODES */
X
X    exit(0);                    /* everything okey-dokey as far as VMS concerned */
X}
X
X#endif                          /* VMS */
X
X
X
X
X
X#ifdef ZMEM                     /* memset, memcpy for systems without them */
X
X/************************/
X/*  Function zmemset()  */
X/************************/
X
Xchar *memset(buf, init, len)
Xregister char *buf, init;       /* buffer loc and initializer */
Xregister unsigned int len;      /* length of the buffer */
X{
X    char *start;
X
X    start = buf;
X    while (len--)
X        *(buf++) = init;
X    return (start);
X}
X
X
X
X
X
X/************************/
X/*  Function zmemcpy()  */
X/************************/
X
Xchar *memcpy(dst, src, len)
Xregister char *dst, *src;
Xregister unsigned int len;
X{
X    char *start;
X
X    start = dst;
X    while (len-- > 0)
X        *dst++ = *src++;
X    return (start);
X}
X
X#endif                          /* ZMEM */
END_OF_FILE
  if test 17338 -ne `wc -c <'./v41/misc.c'`; then
    echo shar: \"'./v41/misc.c'\" unpacked with wrong size!
  fi
  # end of './v41/misc.c'
fi
if test -f './v41/unimplod.c' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unimplod.c'\"
else
  echo shar: Extracting \"'./v41/unimplod.c'\" \(9186 characters\)
  sed "s/^X//" >'./v41/unimplod.c' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  unimplod.c
X
X  The Imploding algorithm is actually a combination of two distinct algor-
X  ithms.  The first algorithm compresses repeated byte sequences using a
X  sliding dictionary.  The second algorithm is used to compress the encoding
X  of the sliding dictionary ouput, using multiple Shannon-Fano trees.
X
X  ---------------------------------------------------------------------------*/
X
X
X#include "unzip.h"
X
X
X/***********************/
X/*  UnImplode Defines */
X/***********************/
X
X#define LITVALS     256
X#define DISTVALS    64
X#define LENVALS     64
X#define MAXSF       LITVALS
X
X
X
X/************************/
X/*  UnImplode Typedefs */
X/************************/
X
Xtypedef struct sf_entry {
X    byte Value;
X    byte BitLength;
X} sf_entry;
X
Xtypedef struct sf_tree {        /* a shannon-fano "tree" (table) */
X    sf_entry entry[MAXSF];
X    int entries;
X    int MaxLength;
X} sf_tree;
X
Xtypedef struct sf_node {        /* node in a true shannon-fano tree */
X    UWORD left;                 /* 0 means leaf node */
X    UWORD right;                /*   or value if leaf node */
X} sf_node;
X
X
X
X/********************************/
X/*  UnImplode Global Variables */
X/********************************/
X
X/* s-f storage is shared with that used by other comp. methods */
X
Xsf_tree lit_tree;
Xsf_tree length_tree;
Xsf_tree distance_tree;
Xsf_node *lit_nodes = (sf_node *) prefix_of;     /* 2*LITVALS nodes */
X#ifdef MACOS
Xsf_node *length_nodes ;  /* 2*LENVALS nodes */
Xsf_node *distance_nodes ;    /* 2*DISTVALS nodes */
X#else
Xsf_node *length_nodes = (sf_node *) suffix_of;  /* 2*LENVALS nodes */
Xsf_node *distance_nodes = (sf_node *) stack;    /* 2*DISTVALS nodes */
X#endif
Xboolean lit_tree_present;
Xboolean eightK_dictionary;
Xint minimum_match_length;
Xint dict_bits;
X
X
X
X/*****************************************/
X/*  UnImplode Local Function Prototypes */
X/*****************************************/
X
Xstatic void LoadTrees __((void));
Xstatic void LoadTree __((sf_tree * tree, int treesize, sf_node * nodes));
Xstatic void ReadLengths __((sf_tree * tree));
Xstatic void SortLengths __((sf_tree * tree));
Xstatic void GenerateTrees __((sf_tree * tree, sf_node * nodes));
Xstatic void ReadTree __((register sf_node * nodes, int *dest));
X
X
X
X
X
X/**************************/
X/*  Function unImplode() */
X/**************************/
X
Xvoid unImplode()
X /* expand imploded data */
X{
X    register int srcix;
X    register int Length;
X    register int limit;
X    int lout;
X    int Distance;
X
X    LoadTrees();
X
X#ifdef DEBUG
X    printf("\n");
X#endif
X    while ((!zipeof) && ((outpos + outcnt) < ucsize)) {
X        READBIT(1, lout);
X
X        if (lout != 0) {        /* encoded data is literal data */
X            if (lit_tree_present) {     /* use Literal Shannon-Fano tree */
X                ReadTree(lit_nodes, &lout);
X#ifdef DEBUG
X                printf("lit=%d\n", lout);
X#endif
X            } else
X                READBIT(8, lout);
X
X            OUTB(lout);
X        } else {                /* encoded data is sliding dictionary match */
X            READBIT(dict_bits, Distance);
X
X            ReadTree(distance_nodes, &lout);
X#ifdef DEBUG
X            printf("d=%5d (%2d,%3d)", (lout << dict_bits) | Distance, lout,
X                   Distance);
X#endif
X            Distance |= (lout << dict_bits);
X            /* using the Distance Shannon-Fano tree, read and decode the
X               upper 6 bits of the Distance value */
X
X            ReadTree(length_nodes, &lout);
X            Length = lout;
X#ifdef DEBUG
X            printf("\tl=%3d\n", Length);
X#endif
X            /* using the Length Shannon-Fano tree, read and decode the
X               Length value */
X
X            if (Length == 63) {
X                READBIT(8, lout);
X                Length += lout;
X            }
X            Length += minimum_match_length;
X
X            /* move backwards Distance+1 bytes in the output stream, and copy
X              Length characters from this position to the output stream.
X              (if this position is before the start of the output stream,
X              then assume that all the data before the start of the output
X              stream is filled with zeros.  Requires initializing outbuf
X              for each file.) */
X
X            srcix = (outcnt - (Distance + 1)) & (OUTBUFSIZ - 1);
X            limit = OUTBUFSIZ - Length;
X            if ((srcix <= limit) && (outcnt < limit)) {
X                outcnt += Length;
X                while (Length--)
X                    *outptr++ = outbuf[srcix++];
X            } else {
X                while (Length--) {
X                    OUTB(outbuf[srcix++]);
X                    srcix &= OUTBUFSIZ - 1;
X                }
X            }
X        }
X    }
X}
X
X
X
X
X
X/**************************/
X/*  Function LoadTrees() */
X/**************************/
X
Xstatic void LoadTrees()
X{
X    eightK_dictionary = (lrec.general_purpose_bit_flag & 0x02) != 0;    /* bit 1 */
X    lit_tree_present = (lrec.general_purpose_bit_flag & 0x04) != 0;     /* bit 2 */
X
X    if (eightK_dictionary)
X        dict_bits = 7;
X    else
X        dict_bits = 6;
X
X    if (lit_tree_present) {
X        minimum_match_length = 3;
X        LoadTree(&lit_tree, 256, lit_nodes);
X    } else
X        minimum_match_length = 2;
X
X    LoadTree(&length_tree, 64, length_nodes);
X    LoadTree(&distance_tree, 64, distance_nodes);
X}
X
X
X
X
X
X/*************************/
X/*  Function LoadTree() */
X/*************************/
X
Xstatic void LoadTree(tree, treesize, nodes)
Xsf_tree *tree;
Xint treesize;
Xsf_node *nodes;
X /* allocate and load a shannon-fano tree from the compressed file */
X{
X    tree->entries = treesize;
X    ReadLengths(tree);
X    SortLengths(tree);
X    GenerateTrees(tree, nodes);
X}
X
X
X
X
X
X/****************************/
X/*  Function ReadLengths() */
X/****************************/
X
Xstatic void ReadLengths(tree)
Xsf_tree *tree;
X{
X    int treeBytes;
X    int i;
X    int num, len;
X
X    /* get number of bytes in compressed tree */
X    READBIT(8, treeBytes);
X    treeBytes++;
X    i = 0;
X
X    tree->MaxLength = 0;
X
X/* High 4 bits: Number of values at this bit length + 1. (1 - 16)
X * Low  4 bits: Bit Length needed to represent value + 1. (1 - 16)
X */
X    while (treeBytes > 0) {
X        READBIT(4, len);
X        len++;
X        READBIT(4, num);
X        num++;
X
X        while (num > 0) {
X            if (len > tree->MaxLength)
X                tree->MaxLength = len;
X            tree->entry[i].BitLength = len;
X            tree->entry[i].Value = i;
X            i++;
X            num--;
X        }
X
X        treeBytes--;
X    }
X}
X
X
X
X
X
X/****************************/
X/*  Function SortLengths() */
X/****************************/
X
Xstatic void SortLengths(tree)
Xsf_tree *tree;
X /* Sort the Bit Lengths in ascending order, while retaining the order
X   of the original lengths stored in the file */
X{
X    register sf_entry *ejm1;    /* entry[j - 1] */
X    register int j;
X    register sf_entry *entry;
X    register int i;
X    sf_entry tmp;
X    int entries;
X    unsigned a, b;
X
X    entry = &tree->entry[0];
X    entries = tree->entries;
X
X    for (i = 0; ++i < entries;) {
X        tmp = entry[i];
X        b = tmp.BitLength;
X        j = i;
X        while ((j > 0)
X               && ((a = (ejm1 = &entry[j - 1])->BitLength) >= b)) {
X            if ((a == b) && (ejm1->Value <= tmp.Value))
X                break;
X            *(ejm1 + 1) = *ejm1;/* entry[j] = entry[j - 1] */
X            --j;
X        }
X        entry[j] = tmp;
X    }
X}
X
X
X
X
X
X/******************************/
X/*  Function GenerateTrees() */
X/******************************/
X
Xstatic void GenerateTrees(tree, nodes)
Xsf_tree *tree;
Xsf_node *nodes;
X /* Generate the Shannon-Fano trees */
X{
X    int codelen, i, j, lvlstart, next, parents;
X
X    i = tree->entries - 1;      /* either 255 or 63 */
X    lvlstart = next = 1;
X
X    /* believe it or not, there may be a 1-bit code */
X
X    for (codelen = tree->MaxLength; codelen >= 1; --codelen) {
X
X        /* create leaf nodes at level <codelen> */
X
X        while ((i >= 0) && (tree->entry[i].BitLength == codelen)) {
X            nodes[next].left = 0;
X            nodes[next].right = tree->entry[i].Value;
X            ++next;
X            --i;
X        }
X
X        /* create parent nodes for all nodes at level <codelen>,
X           but don't create the root node here */
X
X        parents = next;
X        if (codelen > 1) {
X            for (j = lvlstart; j <= parents - 2; j += 2) {
X                nodes[next].left = j;
X                nodes[next].right = j + 1;
X                ++next;
X            }
X        }
X        lvlstart = parents;
X    }
X
X    /* create root node */
X
X    nodes[0].left = next - 2;
X    nodes[0].right = next - 1;
X}
X
X
X
X
X
X/************************/
X/*  Function ReadTree() */
X/************************/
X
X#ifndef ASM
X
Xstatic void ReadTree(nodes, dest)
Xregister sf_node *nodes;
Xint *dest;
X /* read next byte using a shannon-fano tree */
X{
X    register int cur;
X    register int left;
X    UWORD b;
X
X    for (cur = 0;;) {
X        if ((left = nodes[cur].left) == 0) {
X            *dest = nodes[cur].right;
X            return;
X        }
X        READBIT(1, b);
X        cur = (b ? nodes[cur].right : left);
X    }
X}
X
X#endif                          /* !ASM */
END_OF_FILE
  if test 9186 -ne `wc -c <'./v41/unimplod.c'`; then
    echo shar: \"'./v41/unimplod.c'\" unpacked with wrong size!
  fi
  # end of './v41/unimplod.c'
fi
echo shar: End of archive 3 \(of 6\).
cp /dev/null ark3isdone
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
