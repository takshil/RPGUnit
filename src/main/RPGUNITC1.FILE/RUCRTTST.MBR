             CMD        PROMPT('RPGUnit v0.3.2 - Create Test')

             PARM       PROMPT('Test program') KWD(TSTPGM) TYPE(PGM) MIN(1)
 PGM:        QUAL       TYPE(*NAME) LEN(10)
             QUAL       PROMPT('Library') TYPE(*NAME) LEN(10) DFT(*CURLIB) SPCVAL(*CURLIB)

             PARM       PROMPT('Source file') KWD(SRCFILE) TYPE(FILE)
 FILE:       QUAL       TYPE(*NAME) LEN(10) DFT(QRPGLESRC)
             QUAL       PROMPT('Library') TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL(*LIBL *CURLIB)

             PARM       KWD(COPTION) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*SRCSTMT) VALUES(*NOSRCSTMT *SRCSTMT +
                          *NODEBUGIO *SHOWCPY) MAX(3) +
                          PROMPT('Compile options')
             PARM       KWD(DBGVIEW) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*LIST) VALUES(*STMT *SOURCE *LIST +
                          *COPY *ALL *NONE) PROMPT('Debugging views')

             PARM       KWD(BNDSRVPGM) TYPE(BNDSRVPGM) PROMPT('Bind service program') MAX(3)
 BNDSRVPGM:  QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL(*NONE)
             QUAL       TYPE(*NAME) LEN(10) SPCVAL(*LIBL) PROMPT('Library')

             PARM       KWD(BNDDIR) TYPE(BNDDIR) PROMPT('Binding directory') MAX(3)
 BNDDIR:     QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL(*NONE)
             QUAL       TYPE(*NAME) LEN(10) SPCVAL(*LIBL *CURLIB) PROMPT('Library')

             PARM       KWD(BOPTION) TYPE(*CHAR) LEN(10) PROMPT('Binding options') RSTD(*YES) +
                          VALUES(*DUPPROC *DUPVAR) MAX(2)
