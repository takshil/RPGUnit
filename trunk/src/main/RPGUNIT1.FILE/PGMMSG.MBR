      //
      // Extracts message info.
      //

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,PGMMSG


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,QMHRCVPM
      /copy RPGUNITY1,QMHSNDPM
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Procedure Definitions
      //----------------------------------------------------------------------

     P rcvExcpMsgInfo  b                   Export
     D rcvExcpMsgInfo  pi                  LikeDs(ExcpMsgInfo_t)

     D  msg            ds                  LikeDs(Msg_t)
     D  excpMsgInfo    ds                  LikeDs(ExcpMsgInfo_t)

      /free

        msg = rcvPgmMsg( '*EXCP' : ONE_CALL_STK_LVL_ABOVE );

        excpMsgInfo.msgId  = msg.id;
        excpMsgInfo.msg    = msg.txt;
        excpMsgInfo.pgmNm  = msg.sender.pgmNm;
        excpMsgInfo.procNm = msg.sender.procNm;
        excpMsgInfo.sttNb  = msg.sender.sttNb;

        return excpMsgInfo;

      /end-free
     P rcvExcpMsgInfo  e


     P rcvMsgData      b                   Export
     D rcvMsgData      pi           256a
     D msgType                       10a   Const

     D msg             ds                  LikeDs(Msg_t)

      /free

        msg = rcvPgmMsg( msgType : ONE_CALL_STK_LVL_ABOVE );
        return msg.rplData;

      /end-free
     P rcvMsgData      e


     P rcvMsgTxt       b                   Export
     D rcvMsgTxt       pi           256a
     D msgType                       10a   Const

     D msg             ds                  LikeDs(Msg_t)

      /free

        msg = rcvPgmMsg( msgType : ONE_CALL_STK_LVL_ABOVE );
        return msg.txt;

      /end-free
     P rcvMsgTxt       e


     P rcvPgmMsg       b                   Export
     D rcvPgmMsg       pi                  LikeDs(Msg_t)
     D  msgType                      10a   Const
     D  callStkCnt                   10i 0 Const Options(*NoPass)

       // Safe value for the NoPass parameter callStkCnt.
     D safeCallStkCnt  s                   Like(callStkCnt)
       // Buffer for message info.
     D rawMsgBuf       s          32767a
     D rawMsgHdr       ds                  LikeDs(RCVM0300Hdr)
     D                                     Based(rawMsgHdr_p)
     D rawMsgHdr_p     s               *
       // Position in buffer (starting at 1).
     D bufPos          s             10i 0
       // Buffer for message sender info.
     D senderInfo      ds                  LikeDs(RCVM0300Sender)
     D                                     Based(senderInfo_p)
     D senderInfo_p    s               *
       // The received message.
     D msg             ds                  LikeDs(Msg_t)

      /free

        if %parms() > 1;
          safeCallStkCnt = callStkCnt;
        else;
          safeCallStkCnt = 0;
        endif;

        QMHRCVPM( rawMsgBuf :
                  %size(rawMsgBuf) :
                  ALL_MSG_INFO_WITH_SENDER_INFO :
                  THIS_CALL_STK_ENT :
                  ONE_CALL_STK_LVL_ABOVE + safeCallStkCnt :
                  msgType :
                  NO_MSG_KEY :
                  NO_WAIT :
                  MARK_AS_OLD :
                  percolateErrors );

        rawMsgHdr_p = %addr( rawMsgBuf );

        if (rawMsgHdr.bytesA = 0);
          sndEscapeMsgToCaller( %trim(msgType) + ' message not found' );
        endif;

        msg.id = rawMsgHdr.msgId;

        bufPos = %size(rawMsgHdr) + 1;
        msg.rplData = %subst( rawMsgBuf :
                              bufPos :
                              rawMsgHdr.rplDataLenR );

        bufPos += rawMsgHdr.rplDataLenR;
        msg.txt = %subst( rawMsgBuf :
                          bufPos :
                          rawMsgHdr.msgLenR );

        bufPos += rawMsgHdr.msgLenR;
        bufPos += rawMsgHdr.msgHlpLenR;
        senderInfo_p = %addr(rawMsgBuf) + bufPos - 1;
        msg.sender.pgmNm  = senderInfo.sndPgmNm;
        msg.sender.procNm = senderInfo.sndProcNm;
        msg.sender.sttNb  = senderInfo.sndPgmSttNb;

        return msg;

      /end-free
     P rcvPgmMsg       e


     P sndCompMsg      b                   Export
       //----------------------------------------------------------------------
       // Send a completion message. See prototype.
       //----------------------------------------------------------------------
     D sndCompMsg      pi
     D  msg                         256a   Const

       // The message reference key.
     D msgKey          s              4a

      /free

        QMHSNDPM( 'CPF9897' :
                  'QCPFMSG   *LIBL' :
                  %trimr(msg) :
                  %len(%trimr(msg)) :
                  '*COMP' :
                  CONTROL_BOUNDARY :
                  ONE_CALL_STK_LVL_ABOVE :
                  msgKey :
                  percolateErrors );

      /end-free
     P sndCompMsg      e


     P sndEscapeMsg    b                   Export
     D sndEscapeMsg    pi
     D  msg                         256a   Const
     D  callStkCnt                   10i 0 Const

       // The message reference key.
     D msgKey          s              4a

      /free

        QMHSNDPM( 'CPF9897' :
                  'QCPFMSG   *LIBL' :
                  %trimr(msg) :
                  %len(%trimr(msg)) :
                  '*ESCAPE' :
                  CUR_CALL_STK_ENT :
                  ONE_CALL_STK_LVL_ABOVE + callStkCnt :
                  msgKey :
                  percolateErrors );

      /end-free
     P sndEscapeMsg    e


     P sndEscapeMsgToCaller...
     P                 b                   Export
     D sndEscapeMsgToCaller...
     D                 pi
     D  msg                         256a   Const
      /free

        sndEscapeMsg( msg : TWO_CALL_STK_LVL_ABOVE );

      /end-free
     P sndEscapeMsgToCaller...
     P                 e


     P sndEscapeMsgAboveCtlBdy...
     P                 b                   Export
     D sndEscapeMsgAboveCtlBdy...
     D                 pi
     D  msg                         256a   Const

       // The message reference key.
     D msgKey          s              4a

      /free

        QMHSNDPM( 'CPF9897' :
                  'QCPFMSG   *LIBL' :
                  %trimr(msg) :
                  %len(%trimr(msg)) :
                  '*ESCAPE' :
                  CONTROL_BOUNDARY :
                  ONE_CALL_STK_LVL_ABOVE :
                  msgKey :
                  percolateErrors );

      /end-free
     P sndEscapeMsgAboveCtlBdy...
     P                 e


     P sndInfoMsg      b                   Export
       //----------------------------------------------------------------------
       // Send an information message. See prototype.
       //----------------------------------------------------------------------
     D sndInfoMsg      pi
     D  msg                         256a   Const

       // The message reference key.
     D msgKey          s              4a

      /free

        QMHSNDPM( *blank :    // TODO Create generic identifier.
                  'QCPFMSG   *LIBL' :
                  %trimr(msg) :
                  %len(%trimr(msg)) :
                  '*INFO' :
                  CUR_CALL_STK_ENT :
                  ONE_CALL_STK_LVL_ABOVE :
                  msgKey :
                  percolateErrors );

      /end-free
     P sndInfoMsg      e


     P sndStsMsg       b                   Export
     D sndStsMsg       pi
     D  msg                         256a   Const

       // The message reference key.
     D msgKey          s              4a

      /free

        QMHSNDPM( 'CPF9897' :
                  'QCPFMSG   *LIBL' :
                  %trimr(msg) :
                  %len(%trimr(msg)) :
                  '*STATUS' :
                  '*EXT' :
                  *zero :
                  msgKey :
                  percolateErrors );

      /end-free
     P sndStsMsg       e
