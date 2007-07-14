      //
      // Prototypes for RPGUnit command line runner.
      //

       // Call a named procedure, logging any error with CMDLOG.
     D callWithLogging...
     D                 pr
     D  proc                               Const LikeDs(Proc_t)

       // The entry point of RUCMDRUN. Parameters are provided by RUCALLTST command.
     D cmdRun          pr
     D  testPgm                            Const LikeDs(Object_t)
     D  testProc                     32a   Const
     D  order                         8a   Const
     D  detail                        6a   Const

       // Returns a formatted test run completion message.
     D fmtCompMsg      pr           256a   Varying
     D  testCaseCnt                  10i 0 Const
     D  assertCnt                    10i 0 Const
     D  failureCnt                   10i 0 Const
     D  errorCnt                     10i 0 Const

       // Return a user-friendly-formated qualified object name.
     D fmtObjNm        pr            21a   Varying
     D  obj                                Const LikeDs(Object_t)

       // Run the test cases in a test suite.
     D runTests        pr
     D  testPgmNm                          Const Like(Object_t.nm)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testProcToRun                      Const Like(ProcNm_t)
     D  order                         8a   Const
     D  detail                        6a   Const

