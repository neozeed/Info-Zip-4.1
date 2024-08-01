#! /bin/sh
# into a shell via "sh file" or similar.  To overwrite existing files,
# type "sh file -c".
# The tool that generated this appeared in the comp.sources.unix newsgroup;
# send mail to comp-sources-unix@uunet.uu.net if you want that tool.
# Contents:  ./v41/VMS/fjndef.h ./v41/unzip.c.2 ./v41/unzip.h
# Wrapped by kent@sparky on Sun May 19 19:40:39 1991
PATH=/bin:/usr/bin:/usr/ucb ; export PATH
echo If this archive is complete, you will see the following message:
echo '          "shar: End of archive 2 (of 6)."'
if test -f './v41/VMS/fjndef.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/VMS/fjndef.h'\"
else
  echo shar: Extracting \"'./v41/VMS/fjndef.h'\" \(684 characters\)
  sed "s/^X//" >'./v41/VMS/fjndef.h' <<'END_OF_FILE'
X/* This header file was created by Joe Meadows, and is not copyrighted
X   in any way. No guarantee is made as to the accuracy of the contents
X   of this header file. This header file was last modified on Sep. 22th,
X   1987. (Modified to include this statement) */
X
X#define FJN$M_ONLY_RU 1
X#define FJN$M_RUJNL 2
X#define FJN$M_BIJNL 4
X#define FJN$M_AIJNL 8
X#define FJN$M_ATJNL 16
X#define FJN$M_NEVER_RU 32
X#define FJN$M_JOURNAL_FILE 64
X#define FJN$S_FJNDEF 1
Xstruct fjndef  {
X  unsigned fjn$v_only_ru : 1;
X  unsigned fjn$v_rujnl : 1;
X  unsigned fjn$v_bijnl : 1;
X  unsigned fjn$v_aijnl : 1;
X  unsigned fjn$v_atjnl : 1;
X  unsigned fjn$v_never_ru : 1;
X  unsigned fjn$v_journal_file:1;
X} ;
END_OF_FILE
  if test 684 -ne `wc -c <'./v41/VMS/fjndef.h'`; then
    echo shar: \"'./v41/VMS/fjndef.h'\" unpacked with wrong size!
  fi
  # end of './v41/VMS/fjndef.h'
fi
if test -f './v41/unzip.c.2' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unzip.c.2'\"
else
  echo shar: Extracting \"'./v41/unzip.c.2'\" \(22093 characters\)
  sed "s/^X//" >'./v41/unzip.c.2' <<'END_OF_FILE'
X    less the end-of-central-directory record was on this disk, and we would
X    not have gotten to this routine unless this is also the disk on which
X    the central directory starts.  In practice, this had better be the ONLY
X    disk in the archive, but maybe someday we'll add multi-disk support.
X  ---------------------------------------------------------------------------*/
X
X    members_remaining = ecrec.total_entries_central_dir;
X    while (members_remaining) {
X        j = 0;
X
X        /*
X         * Loop through files in central directory, storing offsets, file
X         * attributes, and case-conversion flags until block size is reached.
X         */
X
X        while (members_remaining && (j < DIR_BLKSIZ)) {
X            --members_remaining;
X
X            if (readbuf(sig, 4) <= 0) {
X                error_in_archive = 51;  /* 51:  unexpected EOF */
X                members_remaining = 0;  /* ...so no more left to do */
X                break;
X            }
X            if (strncmp(sig, CENTRAL_HDR_SIG, 4)) {  /* just to make sure */
X                fprintf(stderr, CentSigMsg, j);  /* sig not found */
X                fprintf(stderr, ReportMsg);   /* report to info-zip */
X                error_in_archive = 3;   /* 3:  error in zipfile */
X                members_remaining = 0;  /* ...so no more left to do */
X                break;
X            }
X            /* (sets lcflag)-------v  */
X            if ((error = process_central_file_header()) != 0) {
X                error_in_archive = error;   /* only 51 (EOF) defined */
X                members_remaining = 0;  /* ...so no more left to do */
X                break;
X            }
X            if ((error = do_string(crec.filename_length, FILENAME)) != 0) {
X                if (error > error_in_archive)
X                    error_in_archive = error;
X                if (error > 1) {  /* fatal:  no more left to do */
X                    fprintf(stderr, FilNamMsg, filename, "central");
X                    members_remaining = 0;
X                    break;
X                }
X            }
X            if ((error = do_string(crec.extra_field_length, SKIP)) != 0) {
X                if (error > error_in_archive)
X                    error_in_archive = error;
X                if (error > 1) {  /* fatal */
X                    fprintf(stderr, ExtFieldMsg, filename, "central");
X                    members_remaining = 0;
X                    break;
X                }
X            }
X            if ((error = do_string(crec.file_comment_length, SKIP)) != 0) {
X                if (error > error_in_archive)
X                    error_in_archive = error;
X                if (error > 1) {  /* fatal */
X                    fprintf(stderr, "\n%s:  bad file comment length\n",
X                            filename);
X                    members_remaining = 0;
X                    break;
X                }
X            }
X            if (process_all_files) {
X                if (crec.general_purpose_bit_flag & 1) {
X                    fprintf(stderr, CryptMsg, filename);  /* encrypted: skip */
X                    error_in_archive = 1;       /* 1:  warning error */
X                } else {
X                    ULONG tmp = ULONG_(crec.external_file_attributes);
X
X                    switch (hostnum) {
X                        case UNIX_:
X                          info[j].f_attr = tmp >> 16;
X                          break;
X                        case DOS_OS2_FAT_:
X                          tmp = (!(tmp & 1)) << 1;   /* read-only bit */
X                          info[j].f_attr = 0444 | tmp<<6 | tmp<<3 | tmp;
X#ifdef UNIX
X                          umask((int)(tmp = umask(0)));
X                          info[j].f_attr &= ~tmp;
X#endif
X                          break;
X                        case MAC_:
X                          tmp &= 1;   /* read-only bit */
X                          info[j].f_attr = tmp;
X                          break;
X                        default:
X                          info[j].f_attr = 0666;
X                          break;
X                    }
X                    info[j].lcflag = lcflag;
X                    info[j++].offset = (longint)
X                        ULONG_(crec.relative_offset_local_header);
X                }
X            } else {
X                fnamev = fnv;   /* don't destroy permanent filename pointer */
X                for (--fnamev; *++fnamev;)
X                    if (match(filename, *fnamev)) {
X                        if (crec.version_needed_to_extract[0] > UNZIP_VERSION) {
X                            fprintf(stderr, "%s:  requires compatibility with\
X version %u.%u to extract\n       (this handles %u.%u)--skipping.\n", filename,
X                                crec.version_needed_to_extract[0] / 10,
X                                crec.version_needed_to_extract[0] % 10,
X                                UNZIP_VERSION / 10, UNZIP_VERSION % 10);
X                            error_in_archive = 1;       /* 1:  warning error */
X                        } else if (crec.general_purpose_bit_flag & 1) {
X                            fprintf(stderr, CryptMsg, filename);  /* encrypt */
X                            error_in_archive = 1;       /* 1:  warning error */
X                        } else {
X                            ULONG tmp = ULONG_(crec.external_file_attributes);
X
X                            switch (hostnum) {
X                                case UNIX_:
X                                  info[j].f_attr = tmp >> 16;
X                                  break;
X                                case DOS_OS2_FAT_:
X                                  tmp = (!(tmp & 1)) << 1;  /* read-only bit */
X                                  info[j].f_attr = 0444 | tmp<<6 | tmp<<3 | tmp;
X#ifdef UNIX
X                                  umask((int)(tmp = umask(0)));
X                                  info[j].f_attr &= ~tmp;
X#endif
X                                  break;
X                                case MAC_:
X                                  tmp &= 1;   /* read-only bit */
X                                  info[j].f_attr = tmp;
X                                  break;
X                                default:
X                                  info[j].f_attr = 0666;
X                                  break;
X                            }
X                            info[j].lcflag = lcflag;
X                            info[j++].offset = (longint)
X                                ULONG_(crec.relative_offset_local_header);
X                        }
X                        break;  /* found match for filename, so stop looping */
X
X                    }   /* end if (match), for-loop (fnamev) */
X            }           /* end if (process_all_files) */
X        }               /* end while-loop (adding files to current block) */
X
X        /* save position in central directory so can come back later */
X        cd_bufstart = cur_zipfile_bufstart;
X        cd_inptr = inptr;
X        cd_incnt = incnt;
X
X        /*
X         * Loop through files in block, extracting or testing each one.
X         */
X
X        for (i = 0; i < j; ++i) {
X            /*
X             * if the target position is not within the current input buffer
X             * (either haven't yet read far enough, or (maybe) skipping back-
X             * ward) skip to the target position and reset readbuf().
X             */
X
X            /* LSEEK(info[i].offset):  */
X            inbuf_offset = info[i].offset % INBUFSIZ;
X            bufstart = info[i].offset - inbuf_offset;
X
X            if (bufstart != cur_zipfile_bufstart) {
X                cur_zipfile_bufstart = lseek(zipfd, bufstart, SEEK_SET);
X                if ((incnt = read(zipfd,inbuf,INBUFSIZ)) <= 0) {
X                    fprintf(stderr, OffsetMsg, filename, "lseek");
X                    error_in_archive = 3;   /* 3:  error in zipfile, but */
X                    continue;               /*  can still do next file   */
X                }
X                inptr = inbuf + inbuf_offset;
X                incnt -= inbuf_offset;
X            } else {
X                incnt += (inptr-inbuf) - inbuf_offset;
X                inptr = inbuf + inbuf_offset;
X            }
X            lcflag = info[i].lcflag;
X            f_attr = info[i].f_attr;
X
X            /* should be in proper position now, so check for sig */
X            if (readbuf(sig, 4) <= 0) {
X                fprintf(stderr, OffsetMsg, filename, "EOF");  /* bad offset */
X                error_in_archive = 3;   /* 3:  error in zipfile */
X                continue;       /* but can still do next one */
X            }
X            if (strncmp(sig, LOCAL_HDR_SIG, 4)) {
X                fprintf(stderr, OffsetMsg, filename,
X                        "can't find local header sig");   /* bad offset */
X                error_in_archive = 3;
X                continue;
X            }
X            if ((error = process_local_file_header()) != 0) {
X                fprintf(stderr, "\n%s:  bad local header\n", filename);
X                error_in_archive = error;       /* only 51 (EOF) defined */
X                continue;       /* can still do next one */
X            }
X            if ((error = do_string(lrec.filename_length, FILENAME)) != 0) {
X                if (error > error_in_archive)
X                    error_in_archive = error;
X                if (error > 1) {
X                    fprintf(stderr, FilNamMsg, filename, "local");
X                    continue;   /* go on to next one */
X                }
X            }
X            if ((error = do_string(lrec.extra_field_length, SKIP)) != 0) {
X                if (error > error_in_archive)
X                    error_in_archive = error;
X                if (error > 1) {
X                    fprintf(stderr, ExtFieldMsg, filename, "local");
X                    continue;   /* go on */
X                }
X            }
X            if ((error = extract_or_test_member()) != 0)
X                if (error > error_in_archive)
X                    error_in_archive = error;       /* ...and keep going */
X
X        }                       /* end for-loop (i:  files in current block) */
X
X        /*
X         * Jump back to where we were in the central directory, then go and do
X         * the next batch of files.
X         */
X
X        cur_zipfile_bufstart = lseek(zipfd, cd_bufstart, SEEK_SET);
X        read(zipfd, inbuf, INBUFSIZ);   /* were already there ==> no error */
X        inptr = cd_inptr;
X        incnt = cd_incnt;
X
X#ifdef TEST
X        printf("\ncd_bufstart = %ld (%.8lXh)\n", cd_bufstart, cd_bufstart);
X        printf("cur_zipfile_bufstart = %ld (%.8lXh)\n", cur_zipfile_bufstart,
X          cur_zipfile_bufstart);
X        printf("inptr-inbuf = %d\n", inptr-inbuf);
X        printf("incnt = %d\n\n", incnt);
X#endif
X
X    }           /* end while-loop (blocks of files in central directory) */
X
X/*---------------------------------------------------------------------------
X    Double check that we're back at the end-of-central-directory record, and
X    print quick summary of results, if we were just testing the archive.  We
X    send the summary to stdout so that people doing the testing in the back-
X    ground and redirecting to a file can just do a "tail" on the output file.
X  ---------------------------------------------------------------------------*/
X
X    readbuf(sig, 4);
X    if (strncmp(sig, END_CENTRAL_SIG, 4)) {     /* just to make sure again */
X        fprintf(stderr, EndSigMsg);  /* didn't find end-of-central-dir sig */
X        fprintf(stderr, ReportMsg);  /* report to info-zip */
X        if (!error_in_archive)       /* don't overwrite stronger error */
X            error_in_archive = 1;    /* 1:  warning error */
X    }
X    if (tflag && (quietflg == 1)) {
X        if (error_in_archive)
X            printf("At least one error was detected in the archive.\n");
X        else if (process_all_files)
X            printf("No errors detected.\n");
X        else
X            printf("No errors detected in the tested files.\n");
X    }
X    return (error_in_archive);
X
X}       /* end function extract_or_test_files() */
X
X
X
X
X
X/**************************************/
X/*  Function extract_or_test_member() */
X/**************************************/
X
Xint extract_or_test_member()
X/* return PK-type error code */
X{
X    int error = 0;
X    UWORD b;
X
X
X
X/*---------------------------------------------------------------------------
X    Initialize variables, buffers, etc.
X  ---------------------------------------------------------------------------*/
X
X    bits_left = 0;
X    bitbuf = 0;
X    outpos = 0L;
X    outcnt = 0;
X    outptr = outbuf;
X    zipeof = 0;
X    crc32val = 0xFFFFFFFFL;
X
X    memset(outbuf, 0, OUTBUFSIZ);
X    if (aflag)                  /* if we have a scratchpad, clear it out */
X        memset(outout, 0, OUTBUFSIZ);
X
X    if (tflag) {
X        if (!quietflg) {
X            fprintf(stdout, "  Testing: %-12s ", filename);
X            fflush(stdout);
X        }
X    } else {
X        if (cflag)              /* output to stdout (copy of it) */
X#ifdef MACOS
X            outfd = 1;
X#else
X            outfd = dup(1);
X#endif
X        else {
X            if ((error = mapped_name()) > 1)  /* member name conversion error */
X                return (2);     /* 2:  (weak) error in zipfile */
X            if (create_output_file())   /* output to file:  read/write perms */
X                return (50);    /* 50:  disk full */
X        }
X    }                           /* endif (!tflag) */
X
X/*---------------------------------------------------------------------------
X    Unpack the file.
X  ---------------------------------------------------------------------------*/
X
X    switch (lrec.compression_method) {
X
X    case STORED:
X        if (!tflag && QCOND) {
X            fprintf(stdout, " Extracting: %-12s ", filename);
X            if (cflag)
X                fprintf(stdout, "\n");
X            fflush(stdout);
X        }
X        while (ReadByte(&b))
X            OUTB(b);
X        break;
X
X    case SHRUNK:
X        if (!tflag && QCOND) {
X            fprintf(stdout, "UnShrinking: %-12s ", filename);
X            if (cflag)
X                fprintf(stdout, "\n");
X            fflush(stdout);
X        }
X        unShrink();
X        break;
X
X    case REDUCED1:
X    case REDUCED2:
X    case REDUCED3:
X    case REDUCED4:
X        if (!tflag && QCOND) {
X            fprintf(stdout, "  Expanding: %-12s ", filename);
X            if (cflag)
X                fprintf(stdout, "\n");
X            fflush(stdout);
X        }
X        unReduce();
X        break;
X
X    case IMPLODED:
X        if (!tflag && QCOND) {
X            fprintf(stdout, "  Exploding: %-12s ", filename);
X            if (cflag)
X                fprintf(stdout, "\n");
X            fflush(stdout);
X        }
X        unImplode();
X        break;
X
X    default:
X        fprintf(stderr, "%s:  unknown compression method\n", filename);
X        /* close and delete file before return?? */
X        return (1);             /* 1:  warning error */
X    }
X
X/*---------------------------------------------------------------------------
X    Write the last partial buffer, if any; set the file date and time; and
X    close the file (not necessarily in that order).  Then make sure CRC came
X    out OK and print result.  [Note:  crc32val must be logical-ANDed with
X    32 bits of 1's, or else machines whose longs are bigger than 32 bits will
X    report bad CRCs (because of the upper bits being filled with 1's instead
X    of 0's).]
X  ---------------------------------------------------------------------------*/
X
X    if (FlushOutput())
X        return (50);            /* 50:  disk full */
X
X    if (!tflag)
X#if defined(VMS) || defined(MTS)/* VMS already set file time; MTS can't */
X        close(outfd);
X#else
X        set_file_time_and_close();
X#endif
X
X    if ((crc32val = ((~crc32val) & 0xFFFFFFFFL)) != ULONG_(lrec.crc32)) {
X        /* if quietflg is set we haven't output the filename yet, do it */
X        if (quietflg)
X            printf("%-12s: ", filename);
X        fprintf(stdout, " Bad CRC %08lx  (should be %08lx)\n", crc32val,
X                ULONG_(lrec.crc32));
X        return (1);             /* 1:  warning error */
X    } else if (tflag) {
X        if (!quietflg)
X            fprintf(stdout, " OK\n");
X    } else {
X        if (QCOND)
X            fprintf(stdout, "\n");
X    }
X
X    return (error);
X
X}       /* end function extract_or_test_member() */
X
X
X
X
X
X/*******************************************/
X/*  Function process_central_file_header() */
X/*******************************************/
X
Xint process_central_file_header()
X/* return PK-type error code */
X{
X#ifdef NOTINT16
X    central_directory_byte_header byterec;
X#endif
X
X
X
X/*---------------------------------------------------------------------------
X    Read the next central directory entry and do any necessary machine-type
X    conversions (byte ordering, structure padding compensation--in the latter
X    case, copy the data from the array into which it was read (byterec) to
X    the usable struct (crec)).
X  ---------------------------------------------------------------------------*/
X
X#ifndef NOTINT16
X    if (readbuf((char *) &crec, CREC_SIZE) <= 0)
X        return (51);
X
X#else  /* NOTINT16 */
X    if (readbuf((char *) byterec, CREC_SIZE) <= 0)
X        return (51);            /* 51:  unexpected EOF */
X
X    crec.version_made_by[0] = byterec[C_VERSION_MADE_BY_0];
X    crec.version_made_by[1] = byterec[C_VERSION_MADE_BY_1];
X    crec.version_needed_to_extract[0] = byterec[C_VERSION_NEEDED_TO_EXTRACT_0];
X    crec.version_needed_to_extract[1] = byterec[C_VERSION_NEEDED_TO_EXTRACT_1];
X
X    crec.general_purpose_bit_flag =
X        makeword(&byterec[C_GENERAL_PURPOSE_BIT_FLAG]);
X    crec.compression_method =
X        makeword(&byterec[C_COMPRESSION_METHOD]);
X    crec.last_mod_file_time =
X        makeword(&byterec[C_LAST_MOD_FILE_TIME]);
X    crec.last_mod_file_date =
X        makeword(&byterec[C_LAST_MOD_FILE_DATE]);
X    crec.crc32 =
X        makelong(&byterec[C_CRC32]);
X    crec.compressed_size =
X        makelong(&byterec[C_COMPRESSED_SIZE]);
X    crec.uncompressed_size =
X        makelong(&byterec[C_UNCOMPRESSED_SIZE]);
X    crec.filename_length =
X        makeword(&byterec[C_FILENAME_LENGTH]);
X    crec.extra_field_length =
X        makeword(&byterec[C_EXTRA_FIELD_LENGTH]);
X    crec.file_comment_length =
X        makeword(&byterec[C_FILE_COMMENT_LENGTH]);
X    crec.disk_number_start =
X        makeword(&byterec[C_DISK_NUMBER_START]);
X    crec.internal_file_attributes =
X        makeword(&byterec[C_INTERNAL_FILE_ATTRIBUTES]);
X    crec.external_file_attributes =
X        makelong(&byterec[C_EXTERNAL_FILE_ATTRIBUTES]); /* LONG, not word! */
X    crec.relative_offset_local_header =
X        makelong(&byterec[C_RELATIVE_OFFSET_LOCAL_HEADER]);
X#endif  /* NOTINT16 */
X
X    hostnum = min(crec.version_made_by[1], NUM_HOSTS);
X/*  extnum = min( crec.version_needed_to_extract[1], NUM_HOSTS ); */
X    methnum = min(crec.compression_method, NUM_METHODS);
X
X/*---------------------------------------------------------------------------
X    Set flag for lowercase conversion of filename, depending on which OS the
X    file is coming from.  This section could be ifdef'd if some people have
X    come to love DOS uppercase filenames under Unix...but really, guys, get
X    a life. :)  NOTE THAT ALL SYSTEM NAMES NOW HAVE TRAILING UNDERSCORES!!!
X    This is to prevent interference with compiler command-line defines such
X    as -DUNIX, for example, which are then used in "#ifdef UNIX" constructs.
X  ---------------------------------------------------------------------------*/
X
X    lcflag = FALSE;
X    if (!Uflag)                 /* as long as user hasn't specified
X                                 * case-preservation */
X        switch (hostnum) {
X        case DOS_OS2_FAT_:
X        case VMS_:
X        case VM_CMS_:           /* all caps? */
X        case CPM_:              /* like DOS, right? */
X/*      case ATARI_:            ??? */
X/*      case Z_SYSTEM_:         ??? */
X/*      case TOPS20_:           (if we had such a thing...) */
X
X            lcflag = TRUE;      /* convert filename to lowercase */
X            break;
X
X        default:                /* AMIGA_, UNIX_, (ATARI_), OS2_HPFS_, */
X            break;              /*   MAC_, (Z_SYSTEM_):  no conversion */
X        }
X
X    return (0);
X
X}       /* end function process_central_file_header() */
X
X
X
X
X
X/*****************************************/
X/*  Function process_local_file_header() */
X/*****************************************/
X
Xint process_local_file_header()
X/* return PK-type error code */
X{
X#ifdef NOTINT16
X    local_byte_header byterec;
X#endif
X
X
X
X/*---------------------------------------------------------------------------
X    Read the next local file header and do any necessary machine-type con-
X    versions (byte ordering, structure padding compensation--in the latter
X    case, copy the data from the array into which it was read (byterec) to
X    the usable struct (lrec)).
X  ---------------------------------------------------------------------------*/
X
X#ifndef NOTINT16
X    if (readbuf((char *) &lrec, LREC_SIZE) <= 0)
X        return (51);
X
X#else /* NOTINT16 */
X    if (readbuf((char *) byterec, LREC_SIZE) <= 0)
X        return (51);            /* 51:  unexpected EOF */
X
X    lrec.version_needed_to_extract[0] = byterec[L_VERSION_NEEDED_TO_EXTRACT_0];
X    lrec.version_needed_to_extract[1] = byterec[L_VERSION_NEEDED_TO_EXTRACT_1];
X
X    lrec.general_purpose_bit_flag = makeword(&byterec[L_GENERAL_PURPOSE_BIT_FLAG]);
X    lrec.compression_method = makeword(&byterec[L_COMPRESSION_METHOD]);
X    lrec.last_mod_file_time = makeword(&byterec[L_LAST_MOD_FILE_TIME]);
X    lrec.last_mod_file_date = makeword(&byterec[L_LAST_MOD_FILE_DATE]);
X    lrec.crc32 = makelong(&byterec[L_CRC32]);
X    lrec.compressed_size = makelong(&byterec[L_COMPRESSED_SIZE]);
X    lrec.uncompressed_size = makelong(&byterec[L_UNCOMPRESSED_SIZE]);
X    lrec.filename_length = makeword(&byterec[L_FILENAME_LENGTH]);
X    lrec.extra_field_length = makeword(&byterec[L_EXTRA_FIELD_LENGTH]);
X#endif  /* NOTINT16 */
X
X    csize = (longint) ULONG_(lrec.compressed_size);
X    ucsize = (longint) ULONG_(lrec.uncompressed_size);
X
X    return (0);                 /* 0:  no error */
X
X}       /* end function process_local_file_header() */
END_OF_FILE
  if test 22093 -ne `wc -c <'./v41/unzip.c.2'`; then
    echo shar: \"'./v41/unzip.c.2'\" unpacked with wrong size!
  fi
  # end of './v41/unzip.c.2'
fi
if test -f './v41/unzip.h' -a "${1}" != "-c" ; then 
  echo shar: Will not clobber existing file \"'./v41/unzip.h'\"
else
  echo shar: Extracting \"'./v41/unzip.h'\" \(28924 characters\)
  sed "s/^X//" >'./v41/unzip.h' <<'END_OF_FILE'
X/*---------------------------------------------------------------------------
X
X  unzip.h
X
X  This header file is used by all of the unzip source files.  Its contents
X  are divided into six more-or-less separate sections:  OS-dependent includes,
X  (mostly) OS-independent defines, typedefs, function prototypes (or "proto-
X  types," in the case of non-ANSI compilers), macros, and global-variable
X  declarations.
X
X  ---------------------------------------------------------------------------*/
X
X
X
X/***************************/
X/*  OS-Dependent Includes  */
X/***************************/
X
X#include <stdio.h>       /* this is your standard header for all C compiles */
X#include <ctype.h>
X#include <errno.h>       /* used in mapped_name() */
X#define DECLARE_ERRNO    /* everybody except MSC 6.0 */
X#ifdef VMS               /* sigh...you just KNEW someone had to break this.  */
X#  include <types.h>     /*  (placed up here instead of in VMS section below */
X#  include <stat.h>      /*   because types.h is used in some other headers) */
X#else  /* almost everybody */
X#  if defined(THINK_C) || defined(MPW) /* for Macs */
X#    include <stddef.h>
X#  else
X#    include <sys/types.h> /* off_t, time_t, dev_t, ... */
X#    include <sys/stat.h>  /* Everybody seems to need this. */
X#  endif
X#endif                   /*   This include file defines
X                          *     #define S_IREAD 0x0100  (owner may read)
X                          *     #define S_IWRITE 0x0080 (owner may write)
X                          *   as used in the creat() standard function.  Must
X                          *   be included AFTER sys/types.h for most systems.
X                          */
X
X
X/*---------------------------------------------------------------------------
X    Next, a word from our Unix (mostly) sponsors:
X  ---------------------------------------------------------------------------*/
X
X#ifdef UNIX               /* On some systems sys/param.h partly duplicates   */
X#  include <sys/param.h>  /*  the contents of sys/types.h, so you don't need */
X                          /*  (and can't use) sys/types.h. (or param.h???)   */
X#  ifndef BSIZE
X#    define BSIZE   DEV_BSIZE   /* assume common for all Unix systems */
X#  endif
X
X#  ifndef BSD
X#    define NO_MKDIR            /* for mapped_name() */
X#    include <time.h>
X     struct tm *gmtime(), *localtime();
X#  else   /* BSD */
X#    include <sys/time.h>
X#    include <sys/timeb.h>
X#  endif
X
X#else   /* !UNIX */
X#  define BSIZE   512           /* disk block size */
X#endif
X
X#if defined(V7) || defined(BSD)
X#  define strchr    index
X#  define strrchr   rindex
X#endif
X
X/*---------------------------------------------------------------------------
X    And now, our MS-DOS and OS/2 corner:
X  ---------------------------------------------------------------------------*/
X
X#ifdef __TURBOC__
X#  define DOS_OS2             /* Turbo C under DOS, MSC under DOS or OS2    */
X#  include <sys/timeb.h>      /* for structure ftime                        */
X#  include <mem.h>            /* for memcpy()                               */
X#else                         /* NOT Turbo C...                             */
X#  ifdef MSDOS                /*   but still MS-DOS, so we'll assume it's   */
X#    ifndef MSC               /*   Microsoft's compiler and fake the ID, if */
X#      define MSC             /*   necessary (it is in 5.0; apparently not  */
X#    endif                    /*   in 5.1 and 6.0)                          */
X#    include <dos.h>          /* _dos_setftime()                            */
X#  endif
X#  ifdef OS2                  /* stuff for DOS and OS/2 family version */
X#    ifndef MSC
X#      define MSC
X#    endif
X#    include <os2.h>          /* DosQFileInfo(), DosSetFileInfo()? */
X#  endif
X#endif
X
X#ifdef MSC                    /* defined for all versions of MSC now         */
X#  define DOS_OS2             /* Turbo C under DOS, MSC under DOS or OS/2    */
X#  ifndef __STDC__            /* MSC 5.0 and 5.1 aren't truly ANSI-standard, */
X#    define __STDC__          /*   but they understand prototypes...so       */
X#  endif                      /*   they're close enough for our purposes     */
X#  if defined(_MSC_VER) && (_MSC_VER >= 600)      /* new with 5.1 or 6.0 ... */
X#    undef DECLARE_ERRNO      /* errno is now a function in a dynamic link   */
X#  endif                      /*   library (or something)--incompatible with */
X#endif                        /*   the usual "extern int errno" declaration  */
X
X#ifdef DOS_OS2                /* defined for both Turbo C, MSC */
X#  include <io.h>             /* lseek(), open(), setftime(), dup(), creat() */
X#endif
X
X/*---------------------------------------------------------------------------
X    Followed by some VMS (mostly) stuff:
X  ---------------------------------------------------------------------------*/
X
X#ifdef VMS
X#  include <time.h>             /* the usual non-BSD time functions */
X#  include <file.h>             /* same things as fcntl.h has */
X#  define UNIX                  /* can share most of same code from now on */
X#  define RETURN   return_VMS   /* VMS interprets return codes incorrectly */
X#else
X#  define RETURN   return       /* only used in main() */
X#  ifdef V7
X#    define O_RDONLY  0
X#    define O_WRONLY  1
X#    define O_RDWR    2
X#  else
X#    ifdef MTS
X#      include <sys/file.h>     /* MTS uses this instead of fcntl.h */
X#    else
X#      include <fcntl.h>
X#    endif
X#  endif
X#endif
X/*
X *   fcntl.h (above):   This include file defines
X *                        #define O_BINARY 0x8000  (no cr-lf translation)
X *                      as used in the open() standard function.
X */
X
X/*---------------------------------------------------------------------------
X    And some Mac stuff for good measure:
X  ---------------------------------------------------------------------------*/
X
X#ifdef THINK_C
X#  define MACOS
X#  define NOTINT16
X#  ifndef __STDC__            /* THINK_C isn't truly ANSI-standard, */
X#    define __STDC__          /*   but it understands prototypes...so */
X#  endif                      /*   it's close enough for our purposes */
X#  include <time.h>
X#  include <unix.h>
X#  include "macstat.h"
X#endif
X#ifdef MPW                    /* not tested yet - should be easy enough tho */
X#  define MACOS
X#  define NOTINT16
X#  include <time.h>
X#  include <fcntl.h>
X#  include "macstat.h"
X#endif
X
X/*---------------------------------------------------------------------------
X    And finally, some random extra stuff:
X  ---------------------------------------------------------------------------*/
X
X#ifdef __STDC__
X#  include <stdlib.h>      /* standard library prototypes, malloc(), etc. */
X#  include <string.h>      /* defines strcpy, strcmp, memcpy, etc. */
X#else
X   char *malloc();
X   char *strchr(), *strrchr();
X   long lseek();
X#endif
X
X
X
X
X
X/*************/
X/*  Defines  */
X/*************/
X
X#define INBUFSIZ          BUFSIZ   /* same as stdio uses */
X#define DIR_BLKSIZ        64       /* number of directory entries per block
X                                    *  (should fit in 4096 bytes, usually) */
X#define FILNAMSIZ         (1025)
X#ifdef MTS
X#  undef FILENAME_MAX              /* the MTS value is too low: use default */
X#endif
X#ifndef FILENAME_MAX               /* make sure FILENAME_MAX always exists  */
X#  define FILENAME_MAX    (FILNAMSIZ - 1)
X#endif
X#ifdef ZIPINFO
X#  define OUTBUFSIZ       BUFSIZ   /* zipinfo needs less than unzip does    */
X#else
X#  define OUTBUFSIZ       0x2000   /* unImplode needs power of 2, >= 0x2000 */
X#endif
X
X#define ZSUFX             ".zip"
X#define CENTRAL_HDR_SIG   "\120\113\001\002"   /* the infamous "PK" */
X#define LOCAL_HDR_SIG     "\120\113\003\004"   /*  signature bytes  */
X#define END_CENTRAL_SIG   "\120\113\005\006"
X
X#define SKIP              0    /* choice of activities for do_string() */
X#define DISPLAY           1
X#define FILENAME          2
X
X#define DOS_OS2_FAT_      0    /* version_made_by codes (central dir) */
X#define AMIGA_            1
X#define VMS_              2    /* MAKE SURE THESE ARE NOT DEFINED ON     */
X#define UNIX_             3    /* THE RESPECTIVE SYSTEMS!!  (Like, for   */
X#define VM_CMS_           4    /* instance, "UNIX":  CFLAGS = -O -DUNIX) */
X#define ATARI_            5
X#define OS2_HPFS_         6
X#define MAC_              7
X#define Z_SYSTEM_         8
X#define CPM_              9
X/* #define TOPS20_   10  (we're going to need this soon...)  */
X#define NUM_HOSTS         10   /* index of last system + 1 */
X
X#define STORED            0    /* compression methods */
X#define SHRUNK            1
X#define REDUCED1          2
X#define REDUCED2          3
X#define REDUCED3          4
X#define REDUCED4          5
X#define IMPLODED          6
X#define NUM_METHODS       7    /* index of last method + 1 */
X/* don't forget to update list_files() appropriately if NUM_METHODS changes */
X
X#ifndef MACOS
X#  define TRUE            1    /* sort of obvious */
X#  define FALSE           0
X#endif
X
X#define UNZIP_VERSION   11     /* compatible with PKUNZIP 1.1 */
X
X#ifndef UNZIP_OS               /* not used yet, but will need for Zip  */
X#  ifdef UNIX                  /* (could be defined in Makefile or...) */
X#    define UNZIP_OS    UNIX_
X#  endif
X#  ifdef DOS_OS2
X#    define UNZIP_OS    DOS_OS2_FAT_
X#  endif
X#  ifdef VMS
X#    define UNZIP_OS    VMS_
X#  endif
X#  ifdef MTS
X#    define UNZIP_OS    UNIX_
X#  endif
X#  ifdef MACOS
X#    define UNZIP_OS    MAC_
X#  endif
X#  ifndef UNZIP_OS             /* still not defined:  default setting */
X#    define UNZIP_OS    UNKNOWN
X#  endif
X#endif
X
X/*---------------------------------------------------------------------------
X    Macros for accessing the ULONG header fields.  When NOTINT16 is *not*
X    defined, these fields are allocated as arrays of char within the structs.
X    This prevents 32-bit compilers from padding the structs so that ULONGs
X    start on 4-byte boundaries (this will not work on machines that can ONLY
X    access ULONGs if they start on 4-byte boundaries).  If NOTINT16 *is*
X    defined, however, the original data are individually copied into working
X    structs consisting of UWORDs and ULONGs (which may therefore be padded
X    arbitrarily), so the ULONGs are accessed normally.
X  ---------------------------------------------------------------------------*/
X
X#ifdef NOTINT16
X#  define ULONG_(X)   X
X#else
X#  define ULONG_(X)   (*((ULONG *) (X)))
X#endif
X
X/*---------------------------------------------------------------------------
X    True sizes of the various headers, as defined by Phil Katz--so it is not
X    likely that these will ever change.  But if they do, make sure both these
X    defines AND the typedefs below get updated accordingly.
X  ---------------------------------------------------------------------------*/
X
X#define LREC_SIZE     26    /* lengths of local file headers, central */
X#define CREC_SIZE     42    /*  directory headers, and the end-of-    */
X#define ECREC_SIZE    18    /*  central-dir record, respectively      */
X
X
X#define MAX_BITS      13                 /* used in unShrink() */
X#define HSIZE         (1 << MAX_BITS)    /* size of global work area */
X
X#define LF   10   /* '\n' on ASCII machines.  Must be 10 due to EBCDIC */
X#define CR   13   /* '\r' on ASCII machines.  Must be 13 due to EBCDIC */
X
X#ifdef EBCDIC
X#  define ascii_to_native(c)   ebcdic[(c)]
X#endif
X
X#ifndef SEEK_SET        /* These should all be declared in stdio.h!  But   */
X#  define SEEK_SET  0   /*  since they're not (in many cases), do so here. */
X#  define SEEK_CUR  1
X#  define SEEK_END  2
X#endif
X
X
X
X
X
X/**************/
X/*  Typedefs  */
X/**************/
X
Xtypedef unsigned char    byte;       /* code assumes UNSIGNED bytes */
Xtypedef long             longint;
Xtypedef unsigned short   UWORD;
Xtypedef unsigned long    ULONG;
Xtypedef char             boolean;
X
X/*---------------------------------------------------------------------------
X    Zipfile layout declarations.  If these headers ever change, make sure the
X    ??REC_SIZE defines (above) change with them!
X  ---------------------------------------------------------------------------*/
X
X#ifdef NOTINT16
X
X   typedef byte   local_byte_header[ LREC_SIZE ];
X#      define L_VERSION_NEEDED_TO_EXTRACT_0     0
X#      define L_VERSION_NEEDED_TO_EXTRACT_1     1
X#      define L_GENERAL_PURPOSE_BIT_FLAG        2
X#      define L_COMPRESSION_METHOD              4
X#      define L_LAST_MOD_FILE_TIME              6
X#      define L_LAST_MOD_FILE_DATE              8
X#      define L_CRC32                           10
X#      define L_COMPRESSED_SIZE                 14
X#      define L_UNCOMPRESSED_SIZE               18
X#      define L_FILENAME_LENGTH                 22
X#      define L_EXTRA_FIELD_LENGTH              24
X
X   typedef byte   central_directory_byte_header[ CREC_SIZE ];
X#      define C_VERSION_MADE_BY_0               0
X#      define C_VERSION_MADE_BY_1               1
X#      define C_VERSION_NEEDED_TO_EXTRACT_0     2
X#      define C_VERSION_NEEDED_TO_EXTRACT_1     3
X#      define C_GENERAL_PURPOSE_BIT_FLAG        4
X#      define C_COMPRESSION_METHOD              6
X#      define C_LAST_MOD_FILE_TIME              8
X#      define C_LAST_MOD_FILE_DATE              10
X#      define C_CRC32                           12
X#      define C_COMPRESSED_SIZE                 16
X#      define C_UNCOMPRESSED_SIZE               20
X#      define C_FILENAME_LENGTH                 24
X#      define C_EXTRA_FIELD_LENGTH              26
X#      define C_FILE_COMMENT_LENGTH             28
X#      define C_DISK_NUMBER_START               30
X#      define C_INTERNAL_FILE_ATTRIBUTES        32
X#      define C_EXTERNAL_FILE_ATTRIBUTES        34
X#      define C_RELATIVE_OFFSET_LOCAL_HEADER    38
X
X   typedef byte   end_central_byte_record[ ECREC_SIZE+4 ];
X/*     define SIGNATURE                         0   space-holder only */
X#      define NUMBER_THIS_DISK                  4
X#      define NUM_DISK_WITH_START_CENTRAL_DIR   6
X#      define NUM_ENTRIES_CENTRL_DIR_THS_DISK   8
X#      define TOTAL_ENTRIES_CENTRAL_DIR         10
X#      define SIZE_CENTRAL_DIRECTORY            12
X#      define OFFSET_START_CENTRAL_DIRECTORY    16
X#      define ZIPFILE_COMMENT_LENGTH            20
X
X
X   typedef struct local_file_header {                 /* LOCAL */
X       byte version_needed_to_extract[2];
X       UWORD general_purpose_bit_flag;
X       UWORD compression_method;
X       UWORD last_mod_file_time;
X       UWORD last_mod_file_date;
X       ULONG crc32;
X       ULONG compressed_size;
X       ULONG uncompressed_size;
X       UWORD filename_length;
X       UWORD extra_field_length;
X   } local_file_header;
X
X   typedef struct central_directory_file_header {     /* CENTRAL */
X       byte version_made_by[2];
X       byte version_needed_to_extract[2];
X       UWORD general_purpose_bit_flag;
X       UWORD compression_method;
X       UWORD last_mod_file_time;
X       UWORD last_mod_file_date;
X       ULONG crc32;
X       ULONG compressed_size;
X       ULONG uncompressed_size;
X       UWORD filename_length;
X       UWORD extra_field_length;
X       UWORD file_comment_length;
X       UWORD disk_number_start;
X       UWORD internal_file_attributes;
X       ULONG external_file_attributes;
X       ULONG relative_offset_local_header;
X   } central_directory_file_header;
X
X   typedef struct end_central_dir_record {            /* END CENTRAL */
X       UWORD number_this_disk;
X       UWORD num_disk_with_start_central_dir;
X       UWORD num_entries_centrl_dir_ths_disk;
X       UWORD total_entries_central_dir;
X       ULONG size_central_directory;
X       ULONG offset_start_central_directory;
X       UWORD zipfile_comment_length;
X   } end_central_dir_record;
X
X
X#else   /* !NOTINT16:  read data directly into the structure we'll be using */
X
X
X   typedef struct local_file_header {                 /* LOCAL */
X       byte version_needed_to_extract[2];
X       UWORD general_purpose_bit_flag;
X       UWORD compression_method;
X       UWORD last_mod_file_time;
X       UWORD last_mod_file_date;
X       byte crc32[4];
X       byte compressed_size[4];
X       byte uncompressed_size[4];
X       UWORD filename_length;
X       UWORD extra_field_length;
X   } local_file_header;
X
X   typedef struct central_directory_file_header {     /* CENTRAL */
X       byte version_made_by[2];
X       byte version_needed_to_extract[2];
X       UWORD general_purpose_bit_flag;
X       UWORD compression_method;
X       UWORD last_mod_file_time;
X       UWORD last_mod_file_date;
X       byte crc32[4];
X       byte compressed_size[4];
X       byte uncompressed_size[4];
X       UWORD filename_length;
X       UWORD extra_field_length;
X       UWORD file_comment_length;
X       UWORD disk_number_start;
X       UWORD internal_file_attributes;
X       byte external_file_attributes[4];
X       byte relative_offset_local_header[4];
X   } central_directory_file_header;
X
X   typedef struct end_central_dir_record {            /* END CENTRAL */
X       byte _sig_[4];  /* space-holder only */
X       UWORD number_this_disk;
X       UWORD num_disk_with_start_central_dir;
X       UWORD num_entries_centrl_dir_ths_disk;
X       UWORD total_entries_central_dir;
X       byte size_central_directory[4];
X       byte offset_start_central_directory[4];
X       UWORD zipfile_comment_length;
X   } end_central_dir_record;
X
X#endif  /* !NOTINT16 */
X
X
X
X
X
X/*************************/
X/*  Function Prototypes  */
X/*************************/
X
X#ifndef __              /* This amusing little construct was swiped without  */
X#  ifdef __STDC__       /*  permission from the fine folks at Cray Research, */
X#    define __(X)   X   /*  Inc.  Should probably give them a call and see   */
X#  else                 /*  if they mind, but....  Then again, I can't think */
X#    define __(X)   ()  /*  of any other way to do this, so maybe it's an    */
X#  endif                /*  algorithm?  Whatever, thanks to CRI.  (Note:     */
X#endif                  /*  keep interior stuff parenthesized.)              */
X/*
X * Toad Hall Note:  Not to worry:  I've seen this somewhere else too,
X * so obviously it's been stolen more than once.
X * That makes it public domain, right?
X */
X
X/*---------------------------------------------------------------------------
X    Functions in nunzip.c:
X  ---------------------------------------------------------------------------*/
X
Xvoid   usage                         __( (void) );
Xint    process_zipfile               __( (void) );
Xint    find_end_central_dir          __( (void) );
Xint    process_end_central_dir       __( (void) );
Xint    list_files                    __( (void) );
Xint    extract_or_test_files         __( (void) );
Xint    extract_or_test_member        __( (void) );
Xint    process_central_file_header   __( (void) );
Xint    process_local_file_header     __( (void) );
X
X/*---------------------------------------------------------------------------
X    Functions in file_io.c:
X  ---------------------------------------------------------------------------*/
X
Xint    change_zipfile_attributes __( (int zip_error) );
Xint    open_input_file           __( (void) );
Xint    readbuf                   __( (char *buf, register unsigned size) );
Xint    create_output_file        __( (void) );
Xint    FillBitBuffer             __( (register int bits) );
Xint    ReadByte                  __( (UWORD *x) );
Xint    FlushOutput               __( (void) );
X/*
X * static int   WriteBuffer       __( (int fd, unsigned char *buf, int len) );
X * static int   dos2unix          __( (unsigned char *buf, int len) );
X */
Xvoid   set_file_time_and_close   __( (void) );
X
X/*---------------------------------------------------------------------------
X    Macintosh file_io functions:
X  ---------------------------------------------------------------------------*/
X
X#ifdef MACOS
Xvoid   macfstest                 __( (int vrefnum, int wd) );
X/*
X * static int   IsHFSDisk        __( (int wAppVRefNum) );
X */
Xint    mkdir                     __( (char *path, int mode) );
Xvoid   SetMacVol                 __( (char *pch, short wVRefNum) );
X#endif
X
X/*---------------------------------------------------------------------------
X    Uncompression functions (all internal compression routines, enclosed in
X    comments below, are prototyped in their respective files and are invisi-
X    ble to external functions):
X  ---------------------------------------------------------------------------*/
X
Xvoid   unImplode                __( (void) );                  /* unimplod.c */
X/*
X * static void   ReadLengths     __( (sf_tree *tree) );
X * static void   SortLengths     __( (sf_tree *tree) );
X * static void   GenerateTrees   __( (sf_tree *tree, sf_node *nodes) );
X * static void   LoadTree        __( (sf_tree *tree, int treesize, sf_node *nodes) );
X * static void   LoadTrees       __( (void) );
X * static void   ReadTree        __( (register sf_node *nodes, int *dest) );
X */
X
Xvoid   unReduce                 __( (void) );                  /* unreduce.c */
X/*
X * static void   LoadFollowers   __( (void) );
X */
X
Xvoid   unShrink                 __( (void) );                  /* unshrink.c */
X/*
X * static void   partial_clear   __( (void) );
X */
X
X/*---------------------------------------------------------------------------
X    Functions in match.c, mapname.c, and misc.c:
X  ---------------------------------------------------------------------------*/
X
Xint       match         __( (char *string, char *pattern) );      /* match.c */
X/*
X * static BOOLEAN   do_list      __( (register char *string, char *pattern) );
X * static void      list_parse   __( (char **patp, char *lowp, char *highp) );
X * static char      nextch       __( (char **patp) );
X */
X
Xint       mapped_name   __( (void) );                           /* mapname.c */
X
Xvoid      UpdateCRC     __( (register unsigned char *s, register int len) );
Xint       do_string     __( (unsigned int len, int option) );      /* misc.c */
XUWORD     makeword      __( (byte *b) );                           /* misc.c */
XULONG     makelong      __( (byte *sig) );                         /* misc.c */
Xvoid      return_VMS    __( (int zip_error) );                     /* misc.c */
X#ifdef ZMEM
X   char   *memset       __( (register char *buf, register char init, register unsigned int len) );
X   char   *memcpy       __( (register char *dst, register char *src, register unsigned int len) );
X#endif      /* These guys MUST be ifdef'd because their definition  */
X            /*  conflicts with the standard one.  Others (makeword, */
X            /*  makelong, return_VMS) don't matter.                 */
X
X
X
X
X
X/************/
X/*  Macros  */
X/************/
X
X#ifndef min    /* MSC defines this in stdlib.h */
X#  define min(a,b)   ((a) < (b) ? (a) : (b))
X#endif
X
X
X#define LSEEK(abs_offset) {longint request=(abs_offset), inbuf_offset=request%INBUFSIZ, bufstart=request-inbuf_offset;\
X   if(bufstart!=cur_zipfile_bufstart) {cur_zipfile_bufstart=lseek(zipfd,bufstart,SEEK_SET);\
X   if((incnt=read(zipfd,inbuf,INBUFSIZ))<=0) return(51); inptr=inbuf+inbuf_offset; incnt-=inbuf_offset;\
X   }else {incnt+=(inptr-inbuf)-inbuf_offset; inptr=inbuf+inbuf_offset; }}
X
X/*
X *  Seek to the block boundary of the block which includes abs_offset,
X *  then read block into input buffer and set pointers appropriately.
X *  If block is already in the buffer, just set the pointers.  This macro
X *  is used by process_end_central_dir (unzip.c) and do_string (misc.c).
X *  A slightly modified version is embedded within extract_or_test_files
X *  (unzip.c).  ReadByte and readbuf (file_io.c) are compatible.
X *
X *  macro LSEEK( abs_offset )
X *    {
X *      longint   request = abs_offset;
X *      longint   inbuf_offset = request % INBUFSIZ;
X *      longint   bufstart = request - inbuf_offset;
X *
X *      if (bufstart != cur_zipfile_bufstart) {
X *          cur_zipfile_bufstart = lseek(zipfd, bufstart, SEEK_SET);
X *          if ((incnt = read(zipfd,inbuf,INBUFSIZ)) <= 0)
X *              return(51);
X *          inptr = inbuf + inbuf_offset;
X *          incnt -= inbuf_offset;
X *      } else {
X *          incnt += (inptr-inbuf) - inbuf_offset;
X *          inptr = inbuf + inbuf_offset;
X *      }
X *    }
X *
X */
X
X
X#define OUTB(intc) { *outptr++=intc; if (++outcnt==OUTBUFSIZ) FlushOutput(); }
X
X/*
X *  macro OUTB(intc)
X *  {
X *      *outptr++=intc;
X *      if (++outcnt==OUTBUFSIZ)
X *          FlushOutput();
X *  }
X *
X */
X
X
X#define READBIT(nbits,zdest) { if (nbits <= bits_left) { zdest = (int)(bitbuf & mask_bits[nbits]); bitbuf >>= nbits; bits_left -= nbits; } else zdest = FillBitBuffer(nbits);}
X
X/*
X * macro READBIT(nbits,zdest)
X *  {
X *      if (nbits <= bits_left) {
X *          zdest = (int)(bitbuf & mask_bits[nbits]);
X *          bitbuf >>= nbits;
X *          bits_left -= nbits;
X *      } else
X *          zdest = FillBitBuffer(nbits);
X *  }
X *
X */
X
X
X#define NUKE_CRs(buf,len) {register int i,j; for (i=j=0; j<len; (buf)[i++]=(buf)[j++]) if ((buf)[j]=='\r') ++j; len=i;}
X
X/*
X *  Remove all the ASCII carriage returns from buffer buf (length len),
X *  shortening as necessary (note that len gets modified in the process,
X *  so it CANNOT be an expression).  This macro is intended to be used
X *  BEFORE A_TO_N(); hence the check for CR instead of '\r'.  NOTE:  The
X *  if-test gets performed one time too many, but it doesn't matter.
X *
X *  macro NUKE_CRs( buf, len )
X *    {
X *      register int   i, j;
X *
X *      for ( i = j = 0  ;  j < len  ;  (buf)[i++] = (buf)[j++] )
X *        if ( (buf)[j] == CR )
X *          ++j;
X *      len = i;
X *    }
X *
X */
X
X
X#define TOLOWER(str1,str2) {char *ps1,*ps2; ps1=(str1)-1; ps2=(str2); while(*++ps1) *ps2++=(isupper(*ps1))?tolower(*ps1):*ps1; *ps2='\0';}
X
X/*
X *  Copy the zero-terminated string in str1 into str2, converting any
X *  uppercase letters to lowercase as we go.  str2 gets zero-terminated
X *  as well, of course.  str1 and str2 may be the same character array.
X *
X *  macro TOLOWER( str1, str2 )
X *    {
X *      register char   *ps1, *ps2;
X *
X *      ps1 = (str1) - 1;
X *      ps2 = (str2);
X *      while ( *++ps1 )
X *        *ps2++ = (isupper(*ps1)) ?  tolower(*ps1)  :  *ps1;
X *      *ps2='\0';
X *    }
X *
X *  NOTES:  This macro makes no assumptions about the characteristics of
X *    the tolower() function or macro (beyond its existence), nor does it
X *    make assumptions about the structure of the character set (i.e., it
X *    should work on EBCDIC machines, too).  The fact that either or both
X *    of isupper() and tolower() may be macros has been taken into account;
X *    watch out for "side effects" (in the C sense) when modifying this
X *    macro.
X */
X
X
X#ifndef ascii_to_native
X
X#  define ascii_to_native(c)   (c)
X#  define A_TO_N(str1)
X
X#else
X
X#  define NATIVE   /* Used in main() for '-a' and '-c'. */
X#  define A_TO_N(str1) { register unsigned char *ps1; for (ps1 = str1; *ps1; ps1++) *ps1 = (ascii_to_native(*ps1)); }
X
X/*
X *   Translate the zero-terminated string in str1 from ASCII to the native
X *   character set. The translation is performed in-place and uses the
X *   ascii_to_native macro to translate each character.
X *
X *   macro A_TO_N( str1 )
X *     {
X *	 register unsigned char *ps1;
X *
X *	 for ( ps1 = str1; *ps1; ps1++ )
X *	   *ps1 = ( ascii_to_native( *ps1 ) );
X *     }
X *
X *   NOTE: Using the ascii_to_native macro means that is it the only part of
X *     unzip which knows which translation table (if any) is actually in use
X *     to produce the native character set. This makes adding new character
X *     set translation tables easy insofar as all that is needed is an
X *     appropriate ascii_to_native macro definition and the translation
X *     table itself. Currently, the only non-ASCII native character set
X *     implemented is EBCDIC but this may not always be so.
X */
X
X#endif
X
X
X
X
X
X/*************/
X/*  Globals  */
X/*************/
X
X   extern int       tflag;
X/* extern int       vflag;    (only used in unzip.c)  */
X   extern int       cflag;
X   extern int       aflag;
X   extern int       dflag;
X   extern int       Uflag;
X   extern int       V_flag;
X#ifdef MACOS
X   extern int       hfsflag;
X#endif
X   extern int       lcflag;
X   extern unsigned  f_attr;
X   extern longint   csize;
X   extern longint   ucsize;
X
X   extern short     prefix_of[];
X#ifdef MACOS
X   extern byte      *suffix_of;
X   extern byte      *stack;
X#else
X   extern byte      suffix_of[];
X   extern byte      stack[];
X#endif
X   extern ULONG     crc32val;
X   extern UWORD     mask_bits[];
X
X   extern byte      *inbuf;
X   extern byte      *inptr;
X   extern int       incnt;
X   extern UWORD     bitbuf;
X   extern int       bits_left;
X   extern boolean   zipeof;
X   extern int       zipfd;
X   extern char      zipfn[];
X   extern local_file_header   lrec;
X   extern struct stat         statbuf;
X   extern longint   cur_zipfile_bufstart;
X
X   extern byte      *outbuf;
X   extern byte      *outptr;
X   extern byte      *outout;
X   extern longint   outpos;
X   extern int       outcnt;
X   extern int       outfd;
X   extern char      filename[];
X
X#ifdef DECLARE_ERRNO
X   extern int       errno;
X#endif
X
X#ifdef EBCDIC
X   extern byte      ebcdic[];
X#endif
END_OF_FILE
  if test 28924 -ne `wc -c <'./v41/unzip.h'`; then
    echo shar: \"'./v41/unzip.h'\" unpacked with wrong size!
  fi
  # end of './v41/unzip.h'
fi
echo shar: End of archive 2 \(of 6\).
cp /dev/null ark2isdone
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
