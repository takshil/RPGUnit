      //
      // Run tests.
      //

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,RUNNER
      /copy RPGUNITY1,RUN


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,ASSERT
      /copy RPGUNITY1,CALLPROC
      /copy RPGUNITY1,EXTPRC
      /copy RPGUNITY1,EXTTST
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Procedure Definitions
      //----------------------------------------------------------------------

     P loadTestSuite   b                   Export
       //----------------------------------------------------------------------
       // Load a test suite. See prototype.
       //----------------------------------------------------------------------
     D loadTestSuite   pi                  LikeDs(TestSuite_t)
     D  srvPgm                             Const LikeDs(Object_t)

     D procList        ds                  LikeDs(ProcList_t)
     D procNmList      ds                  LikeDs(ProcNmList_t)
     D testSuite       ds                  LikeDs(TestSuite_t)
     D actMark         s                   Like(ActMark_t)

      /free

        procList   = loadProcList( srvPgm );
        procNmList = getProcNmList( procList );
        testSuite  = getTestSuite( procNmList );

        actMark = activateSrvPgm( srvPgm );
        activateTestSuite( testSuite : actMark );

        return testSuite;

      /end-free
     P                 e


     P raiseRUError    b                   Export
       //----------------------------------------------------------------------
       // Raise an RPGUnit error. See prototype.
       //----------------------------------------------------------------------
     D raiseRUError    pi
     D  msg                         256a   Const Varying
      /free

        sndEscapeMsgAboveCtlBdy( 'RPGUnit Error. ' + msg );

      /end-free
     P raiseRUError    e


     P rclTestSuite    b                   Export
       //----------------------------------------------------------------------
       // Reclaim a test suite's allocated ressources. See prototype.
       //----------------------------------------------------------------------
     D rclTestSuite    pi
     D  testSuite                          LikeDs(TestSuite_t)
      /free

        dealloc(n) testSuite.testList;

      /end-free
     P                 e


     P runTest         b                   Export
       //----------------------------------------------------------------------
       // Run a test case in a test suite. See prototype.
       //----------------------------------------------------------------------
     D runTest         pi                  LikeDs(TestResult_t)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const

     D testCase        ds                  LikeDs(Proc_t)

      /free

        testCase = getTestProc( testSuite : testIdx );

        return runTestProc( testCase.procPtr :
                            testSuite.setUp.procPtr :
                            testSuite.tearDown.procPtr );

      /end-free
     P                 e


     P runTestProc     b                   Export
       //----------------------------------------------------------------------
       // Run a test case. See prototype.
       //----------------------------------------------------------------------
     D runTestProc     pi                  LikeDs(TestResult_t)
     D  testProc                       *   Const ProcPtr
     D  setUp                          *   Const ProcPtr
     D  tearDown                       *   Const ProcPtr

     D failureEvt      ds                  LikeDs(AssertFailEvt_t)
     D result          ds                  LikeDs(TestResult_t)
      /free

        clrAssertFailEvt();
        result.outcome = TEST_CASE_SUCCESS;

        if setUp <> *null;

          monitor;
            callProcByPtr( setUp );
          on-error;
            result.outcome = TEST_CASE_ERROR;
            result.error = rcvExcpMsgInfo();
          endmon;

        endif;

        if result.outcome = TEST_CASE_SUCCESS;

          monitor;
            callProcByPtr( testProc );
          on-error;
            failureEvt = getAssertFailEvt();
            if failureEvt = *blank;
              result.outcome = TEST_CASE_ERROR;
              result.error = rcvExcpMsgInfo();
            else;
              result.outcome = TEST_CASE_FAILURE;
              result.failure = failureEvt;
            endif;
          endmon;

        endif;

        if tearDown <> *null;

          monitor;
            callProcByPtr( tearDown );
          on-error;
            result.outcome = TEST_CASE_ERROR;
            result.error = rcvExcpMsgInfo();
          endmon;

        endif;

        return result;

      /end-free
     P                 e

