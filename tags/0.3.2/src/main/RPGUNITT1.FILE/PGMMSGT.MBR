      //
      // Tests PGMMSG.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     D test_rcvExcpMsgInfo...
     D                 pr
     D test_sndEscapeMsgToCaller...
     D                 pr
     D test_resendEscapeMsg...
     D                 pr


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D callSndEscapeMsgToCaller...
     D                 pr
     D monitorEscapeMsgAndResendIt...
     D                 pr
     D procWithError   pr            10i 0


      //----------------------------------------------------------------------
      //   Test Procedure Definitions
      //----------------------------------------------------------------------

     P test_rcvExcpMsgInfo...
     P                 b                   Export
     D test_rcvExcpMsgInfo...
     D                 pi

     D excpMsgInfo     ds                  LikeDs(ExcpMsgInfo_t)

      /free

        monitor;
          procWithError();
          fail( 'procWithError() did not raise an error.' );

        on-error;
          // Success.
        endmon;

        excpMsgInfo = rcvExcpMsgInfo();

        aEqual( 'MCH1211': excpMsgInfo.msgId );
        assert( excpMsgInfo.msg <> *blank : 'Exception message not retrieved' );
            // We should be checking the message content, but I do not know how to
            // do that, since it depends on the locale.
        aEqual( 'PGMMSGT': excpMsgInfo.pgmNm );
        aEqual( 'PROCWITHERROR': excpMsgInfo.procNm );
        aEqual( '16500': excpMsgInfo.sttNb );

      /end-free
     P                 e


     P test_sndEscapeMsgToCaller...
     P                 b                   Export
     D test_sndEscapeMsgToCaller...
     D                 pi

     D excpMsgInfo     ds                  LikeDs(ExcpMsgInfo_t)

      /free

        monitor;
          callSndEscapeMsgToCaller();
          fail( 'sndEscapeMsgToCaller() did not raise an exception.' );

        on-error;
          // Success.
        endmon;

        excpMsgInfo = rcvExcpMsgInfo();

        aEqual( 'Dummy error message' : excpMsgInfo.msg );

      /end-free
     P test_sndEscapeMsgToCaller...
     P                 e


     P test_resendEscapeMsg...
     P                 b                   Export
     D test_resendEscapeMsg...
     D                 pi

     D resentMsgSeen   s               n
     D msg             ds                  LikeDs(Msg_t)

      /free

        monitor;
          monitorEscapeMsgAndResendIt();
          resentMsgSeen = *off;
        on-error;
          resentMsgSeen = *on;
        endmon;

        assert( resentMsgSeen : 'Resent msg not seen' );
        msg = rcvPgmMsg( '*ESCAPE' );
        aEqual( 'MCH1211' : msg.id );

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Helper Procedures Definitions
      //----------------------------------------------------------------------

     P callSndEscapeMsgToCaller...
     P                 b
     D callSndEscapeMsgToCaller...
     D                 pi
      /free

        sndEscapeMsgToCaller( 'Dummy error message' );

      /end-free
     P callSndEscapeMsgToCaller...
     P                 e


     P monitorEscapeMsgAndResendIt...
     P                 b
     D monitorEscapeMsgAndResendIt...
     D                 pi
      /free

        monitor;
          procWithError();
        on-error;
          resendEscapeMsg( LAST_NEW_ESCAPE_MSG : percolateErrors );
        endmon;

      /end-free
     P                 e


     P procWithError   b
     D procWithError   pi            10i 0
     D  zero           s             10i 0 Inz(0)
      /free

        return (1 / zero);

      /end-free
     P procWithError   e
