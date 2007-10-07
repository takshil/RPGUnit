      //
      // RPGUnit Data Templates.
      //

       // ILE Activation Mark.
     D ActMark_t       s             10i 0 Based(template)

       // Assertion Failure Event.
     D AssertFailEvt_t...
     D                 ds                  Qualified Based(template)
     D  msg                         256a
     D  callStkEnt                         LikeDs(CallStkEnt_t)
     D                                     Dim(MAX_CALL_STK_SIZE)

       // Call Stack Entry.
     D CallStkEnt_t    ds                  Qualified Based(template)
     D  pgmNm                        10a
     D  modNm                        10a
     D  procNm                      256a
     D  specNb                       10a

       // TODO Deprecate this template in favor of Msg_t.
       // Exception Message Information.
     D ExcpMsgInfo_t   ds                  Qualified Based(template)
     D  msgId                         7a
     D  msg                         256a
        // Sending Program Name.
     D  pgmNm                        12a
        // Sending Procedure Name.
     D  procNm                             Like(ProcNm_t)
        // Sending Statement Number.
     D  sttNb                        10a

       // Program Message.
     D Msg_t           ds                  Qualified Based(template)
     D  id                            7a
     D  txt                         254a   Varying
     D  rplData                     254a   Varying
     D  sender                             LikeDs(MsgSender_t)

       // Program message sender.
     D MsgSender_t     ds                  Qualified Based(template)
     D  pgmNm                        12a
     D  procNm                             Like(ProcNm_t)
     D  sttNb                         6a

       // Object Qualified Name.
     D Object_t        ds                  Qualified Based(template)
     D  nm                           10a
     D  lib                          10a

       // Named callable procedure.
     D Proc_t          ds                  Qualified Based(template)
     D  procNm                             Like(ProcNm_t)
     D  procPtr                        *   ProcPtr

     D ProcNmList_t    ds                  Qualified Based(template)
     D  handle                         *
     D  cnt                            *   ProcPtr
     D  getNm                          *   ProcPtr
     D  goToNext                       *   ProcPtr

     D ProcNm_t        s            256a   Based(template)

       // Qualified Job Name.
     D QlfJobNm_t      ds                  Qualified Based(template)
     D  jobNm                        10a
     D  usrNm                        10a
     D  jobNb                         6a

     D TestResult_t    ds                  Qualified Based(template)
     D  outcome                       1a
     D  details
     D  failure                            LikeDs(AssertFailEvt_t)
     D                                     Overlay(details)
     D  error                              LikeDs(ExcpMsgInfo_t)
     D                                     Overlay(details)

     D TestSuite_t     ds                  Qualified Based(template)
     D  setUpSuite                         LikeDs(Proc_t)
     D  setUp                              LikeDs(Proc_t)
     D  testCasesCnt                 10i 0
     D  testList                       *
     D  tearDown                           LikeDs(Proc_t)
     D  teardownSuite                      LikeDs(Proc_t)

       // User profile name.
     D UsrNm_t         s             10a   Based(template)

     D MAX_CALL_STK_SIZE...
     D                 c                   Const(64)

       // TestResult_t.outcome can have three values.
     D TEST_CASE_SUCCESS...
     D                 c                   Const('S')
     D TEST_CASE_FAILURE...
     D                 c                   Const('F')
     D TEST_CASE_ERROR...
     D                 c                   Const('E')

