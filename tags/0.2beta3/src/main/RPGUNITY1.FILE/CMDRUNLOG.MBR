      //
      // Prototypes for RPGUnit command line runner logging facilities.
      //

       // Log the test run completion message.
     D logCompMsg      pr
     D  msg                         256a   Const

       // Log a test error event.
     D logError        pr
     D  testNm                             Const Like(ProcNm_t)
     D  excpMsgInfo                        Const LikeDs(ExcpMsgInfo_t)

       // Log a test failure event.
     D logFailure      pr
     D  testNm                             Const Like(ProcNm_t)
     D  failure                            Const LikeDs(AssertFailEvt_t)

       // Log a raw line (no header, no automatic opening / closing).
     D logRawLine      pr
     D  line                        256a   Value Varying

       // Log a test success event.
     D logSuccess      pr
     D  testNm                             Const Like(ProcNm_t)
     D  assertionCnt                 10i 0 Const

       // Set the logging context.
     D setLogContext   pr
        // Name of the test service program being run.
     D  testPgm                            Const LikeDs(Object_t)

