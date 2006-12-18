      //
      // Main prototypes for RURUNNER service program.
      // These prototypes are meant to be used by all test runners.
      //

       // Get a test case's name.
     D getTestNm       pr                  ExtProc('getTestNm')
     D                                     Like(ProcNm_t)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const

       // Load and activate a test suite.
     D loadTestSuite   pr                  ExtProc('loadTestSuite')
     D                                     LikeDs(TestSuite_t)
     D  srvPgm                             Const LikeDs(Object_t)

       // Raise an RPGUnit error.
     D raiseRUError    pr                  ExtProc('raiseRUError')
     D  msg                         256a   Const Varying

       // Reclaim a test suite's allocated ressources.
     D rclTestSuite    pr                  ExtProc('rclTestSuite')
     D  testSuite                          LikeDs(TestSuite_t)

     D runTest         pr                  ExtProc('runTest')
     D                                     LikeDs(TestResult_t)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const

