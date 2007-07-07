      //
      // Command Line Runner logging facilities.
      //

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Exports
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CMDRUNLOG


      //----------------------------------------------------------------------
      //   Imports
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CMDRUNPRT
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

       // Log a header message.
     D logHdr          pr
        // Name of the service program containing the tests.
     D  srvPgm                             Const LikeDs(Object_t)


      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

     D indent          c                   Const('  ')
     D separator       c                   Const(' - ')
     D lineSeparator   c                   Const('-----------------------')


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Was the spool file header already printed?
     D hdrWasPrinted   s               n
       // Test service program being run.
     D srvPgm          ds                  LikeDs(Object_t)


      //----------------------------------------------------------------------
      //   Procedures
      //----------------------------------------------------------------------

     P logCompMsg      b                   Export
       //----------------------------------------------------------------------
       // Log the completion message. See prototype.
       //----------------------------------------------------------------------
     D logCompMsg      pi
     D  msg                         256a   Const
      /free

        logHdr( srvPgm );
        logRawLine( msg );
        clsPrt();
        clear hdrWasPrinted;

      /end-free
     P                 e


     P logError        b                   Export
       //----------------------------------------------------------------------
       // Log an error event. See prototype.
       //----------------------------------------------------------------------
     D logError        pi
     D  testNm                             Const Like(ProcNm_t)
     D  excpMsgInfo                        Const LikeDs(ExcpMsgInfo_t)

     D line            s            256a   Varying
      /free

        logHdr( srvPgm );

        prtLine( %trimr(testNm) + separator + 'ERROR' );

        line = '';
        if excpMsgInfo.msgId <> *blank;
          line += excpMsgInfo.msgId;
          line += separator;
        endif;
        line += excpMsgInfo.msg;
        logRawLine( line );

        if ( excpMsgInfo.procNm <> *blank and
             excpMsgInfo.pgmNm  <> *blank and
             excpMsgInfo.sttNb  <> *blank );
          line = indent
               + %trimr(excpMsgInfo.procNm)
               + ' ('
               + %trimr(excpMsgInfo.pgmNm)
               + ':'
               + %trimr(excpMsgInfo.sttNb)
               + ')';
          logRawLine( line );
        endif;

        prtLine( lineSeparator );

      /end-free
     P                 e


     P logFailure      b                   Export
       //----------------------------------------------------------------------
       // Log a failure event. See prototype.
       //----------------------------------------------------------------------
     D logFailure      pi
     D  testNm                             Const Like(ProcNm_t)
     D  failure                            Const
     D                                     LikeDs(AssertFailEvt_t)

       // Index.
     D i               s             10i 0
       // Specification number. Special value '*N' if not available.
     D specNb          s              5a   Varying

     D line            s            256a   Varying
      /free

        logHdr( srvPgm );

        logRawLine( %trimr(testNm) + separator + 'FAILURE' );
        logRawLine( failure.msg );

        for i = 1 to %elem( failure.callStkEnt );

          if failure.callStkEnt(i).pgmNm = *blank
          or failure.callStkEnt(i).pgmNm = 'RURUNNER';    // TODO Hardcoded.
            leave;
          endif;

          monitor;
            specNb = %char(%int(failure.callStkEnt(i).specNb));
          on-error;
            specNb = '*N';
          endmon;

          line = indent
               + %trim(failure.callStkEnt(i).procNm)
               + ' ('
               + %trim(failure.callStkEnt(i).pgmNm)
               + ':'
               + specNb
               + ')';
          logRawLine( line );

        endfor;

        prtLine( lineSeparator );

      /end-free
     P                 e


     P logHdr          b
     D logHdr          pi
     D  srvPgm                             Const LikeDs(Object_t)
      /free

        if not hdrWasPrinted;
          opnPrt( srvPgm );
          logRawLine( '*** Tests from ' + %trim(srvPgm.nm) + ' ***' );
          hdrWasPrinted = *on;
        endif;

      /end-free
     P                 e


     P logRawLine      b                   Export
     D logRawLine      pi
     D  line                        256a   Value Varying

       // Printing area width (in characters).
     D prtWidth        s             10i 0

      /free

        if line = *blank;    // Do not log blank lines.
          return;
        endif;

        line = %trimr(line);

        prtWidth = getPrtWidth();

        dow %len(line) > prtWidth;
          prtLine( %subst( line : 1 : prtWidth ) );
          line = %subst( line : prtWidth+1 );
        enddo;

        prtLine( line );

      /end-free
     P                 e


     P logSuccess      b                   Export
     D logSuccess      pi
     D  testNm                             Const Like(ProcNm_t)
     D  assertionCnt                 10i 0 Const
      /free

        logHdr( srvPgm );

        logRawLine( %trimr(testNm) + ' - Success' );
        logRawLine( indent + %char(assertionCnt) + ' assertions' );
        logRawLine( lineSeparator );

      /end-free
     P                 e


     P setLogContext   b                   Export
     D setLogContext   pi
     D  testPgm                            Const LikeDs(Object_t)
      /free

        srvPgm = testPgm;

      /end-free
     P                 e

