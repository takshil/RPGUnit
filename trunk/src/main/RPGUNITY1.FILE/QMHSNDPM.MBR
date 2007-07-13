      //
      // Send Program Message API
      //

     D QMHSNDPM        PR                  ExtPgm('QMHSNDPM')
     D   msgID                        7a   Const
     D   qlfMsgF                     20a   Const
         // TODO Add Options(*VarSize to msgData).
     D   msgData                    256a   Const
     D   msgDataLen                  10i 0 Const
     D   msgType                     10a   Const
     D   callStkEnt                  10a   Const
     D   callStkCnt                  10i 0 Const
     D   msgKey                       4a
     D   error                     1024a   Options(*VarSize) NoOpt


       //----------------------------------------------------------------------
       //   Symbolic Constants
       //----------------------------------------------------------------------

       // Call stack entry:
       // - current call stack entry
     D CUR_CALL_STK_ENT...
     D                 c                   Const('*')
       // - control boundary
     D CONTROL_BOUNDARY...
     D                 c                   Const('*CTLBDY')
