      //----------------------------------------------------------------------
      //   Exported Procedure Prototypes
      //----------------------------------------------------------------------

       // Receive exception message.
     D rcvExcpMsgInfo  pr                  LikeDs(ExcpMsgInfo_t)
     D                                     ExtProc('rcvExcpMsgInfo')

       // Receive a program message replacement data.
     D rcvMsgData      pr           256a   ExtProc('rcvMsgData')
        // Message type: *ANY, *COMP, *EXCP...
     D  msgType                      10a   Const

       // Receive a program message text.
     D rcvMsgTxt       pr           256a   ExtProc('rcvMsgTxt')
        // Message type: *ANY, *COMP, *EXCP...
     D  msgType                      10a   Const

       // Receive a program message.
     D rcvPgmMsg       pr                  LikeDs(Msg_t)
     D                                     ExtProc('rcvPgmMsg')
        // Message type: *ANY, *COMP, *EXCP...
     D  msgType                      10a   Const
        // If the message was sent to a procedure above in the call stack,
        // indicate how many level above it is.
     D  callStkCnt                   10i 0 Const Options(*NoPass)

       // Resend an escape message that was monitored in a monitor block.
     D resendEscapeMsg...
     D                 pr                  ExtPgm('QMHRSNEM')
     D  msgKey                        4a   Const
     D  errorCode                 32565a   Const Options(*VarSize) NoOpt

       // Send a completion message.
     D sndCompMsg      pr                  ExtProc('sndCompMsg')
     D  msg                         256a   Const

       // Send an escape message...
       // ...to any call stack entry.
     D sndEscapeMsg    pr
     D  msg                         256a   Const
     D  callStkCnt                   10i 0 Const

       // ...to the procedure's caller.
     D sndEscapeMsgToCaller...
     D                 pr                  ExtProc('sndEscapeMsgToCaller')
     D  msg                         256a   Const

       // ...to the call stack entry just above the Control Boundary.
       // Useful to terminate a program.
     D sndEscapeMsgAboveCtlBdy...
     D                 pr                  ExtProc('sndEscapeMsgAboveCtlBdy')
     D  msg                         256a   Const

       // Send an information message.
     D sndInfoMsg      pr                  ExtProc('sndInfoMsg')
     D  msg                         256a   Const

       // Send a status message.
     D sndStsMsg       pr                  ExtProc('sndStsMsg')
     D  msg                         256a   Const


      //----------------------------------------------------------------------
      //   Exported Constants
      //----------------------------------------------------------------------

       // Call stack levels.
     D ONE_CALL_STK_LVL_ABOVE...
     D                 c                   Const(1)
     D TWO_CALL_STK_LVL_ABOVE...
     D                 c                   Const(2)

       // To resend the last new escape message
     D LAST_NEW_ESCAPE_MSG...
     D                 c                   Const(*blank)
