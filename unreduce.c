/*---------------------------------------------------------------------------

  unreduce.c

  The Reducing algorithm is actually a combination of two distinct algorithms.
  The first algorithm compresses repeated byte sequences, and the second al-
  gorithm takes the compressed stream from the first algorithm and applies a
  probabilistic compression method.

  ---------------------------------------------------------------------------*/


#include "unzip.h"


/**************************************/
/*  UnReduce Defines, Typedefs, etc.  */
/**************************************/

#define DLE    144

typedef byte f_array[64];       /* for followers[256][64] */

static void LoadFollowers __((void));



/*******************************/
/*  UnReduce Global Variables  */
/*******************************/

f_array *followers = (f_array *) prefix_of;     /* shared work space */
byte Slen[256];
int factor;

int L_table[] =
{0, 0x7f, 0x3f, 0x1f, 0x0f};

int D_shift[] =
{0, 0x07, 0x06, 0x05, 0x04};
int D_mask[] =
{0, 0x01, 0x03, 0x07, 0x0f};

int B_table[] =
{8, 1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5,
 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6,
 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7,
 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
 8, 8, 8, 8};





/*************************/
/*  Function unReduce()  */
/*************************/

void unReduce()
 /* expand probabilistically reduced data */
{
    register int lchar;
    int nchar;
    int ExState;
    int V;
    int Len;

    factor = lrec.compression_method - 1;
    ExState = 0;
    lchar = 0;
    LoadFollowers();

    while (((outpos + outcnt) < ucsize) && (!zipeof)) {
        if (Slen[lchar] == 0)
            READBIT(8, nchar)   /* ; */
        else {
            READBIT(1, nchar);
            if (nchar != 0)
                READBIT(8, nchar)       /* ; */
            else {
                int follower;
                int bitsneeded = B_table[Slen[lchar]];
                READBIT(bitsneeded, follower);
                nchar = followers[lchar][follower];
            }
        }
        /* expand the resulting byte */
        switch (ExState) {

        case 0:
            if (nchar != DLE)
                OUTB(nchar)     /*;*/
            else
                ExState = 1;
            break;

        case 1:
            if (nchar != 0) {
                V = nchar;
                Len = V & L_table[factor];
                if (Len == L_table[factor])
                    ExState = 2;
                else
                    ExState = 3;
            } else {
                OUTB(DLE);
                ExState = 0;
            }
            break;

        case 2:{
                Len += nchar;
                ExState = 3;
            }
            break;

        case 3:{
                register int i = Len + 3;
                int offset = (((V >> D_shift[factor]) &
                               D_mask[factor]) << 8) + nchar + 1;
                longint op = (outpos + outcnt) - offset;

                /* special case- before start of file */
                while ((op < 0L) && (i > 0)) {
                    OUTB(0);
                    op++;
                    i--;
                }

                /* normal copy of data from output buffer */
                {
                    register int ix = (int) (op % OUTBUFSIZ);

                    /* do a block memory copy if possible */
                    if (((ix + i) < OUTBUFSIZ) &&
                        ((outcnt + i) < OUTBUFSIZ)) {
                        memcpy(outptr, &outbuf[ix], i);
                        outptr += i;
                        outcnt += i;
                    }
                    /* otherwise copy byte by byte */
                    else
                        while (i--) {
                            OUTB(outbuf[ix]);
                            if (++ix >= OUTBUFSIZ)
                                ix = 0;
                        }
                }

                ExState = 0;
            }
            break;
        }

        /* store character for next iteration */
        lchar = nchar;
    }
}





/******************************/
/*  Function LoadFollowers()  */
/******************************/

static void LoadFollowers()
{
    register int x;
    register int i;

    for (x = 255; x >= 0; x--) {
        READBIT(6, Slen[x]);
        for (i = 0; i < Slen[x]; i++) {
            READBIT(8, followers[x][i]);
        }
    }
}
