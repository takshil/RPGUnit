      //
      // RPGUnit command line test runner.
      //

     H Option(*SrcStmt)


       //----------------------------------------------------------------------
       //   Exported Procedures
       //----------------------------------------------------------------------

      /copy RPGUNITY1,CMDRUN


       //----------------------------------------------------------------------
       //   Imported Procedures
       //----------------------------------------------------------------------

      /copy RPGUNITY1,ASSERT
      /copy RPGUNITY1,CALLPROC
      /copy RPGUNITY1,CMDRUNLOG
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,RUNNER


      //----------------------------------------------------------------------
      //   Private Prototypes
      //----------------------------------------------------------------------

       // Assert that at least one test case has run during execution.
     D assertHasRunAtLeastOneTestCase...
     D                 pr
     D  testCasesCnt                 10i 0 Const
     D  testProcToRun                      Const Like(ProcNm_t)

       // Format a word with its counter.
       // (e.g., fmtWordWithCnt( 2 : 'apple' ) = '2 apples' )
     D fmtWordWithCnt  pr           256a   Varying
     D  cnt                          10i 0 Const
     D  word                        256a   Const Varying

       // Handle a test case error.
     D handleError     pr
     D  testNm                             Const Like(ProcNm_t)
     D  excpMsgInfo                        Const LikeDs(ExcpMsgInfo_t)

       // Handle a test case failure.
     D handleFailure   pr
     D  testNm                             Const Like(ProcNm_t)
     D  failure                            Const
     D                                     LikeDs(AssertFailEvt_t)

       // Handle a test case success.
     D handleSuccess   pr
     D  testNm                             Const Like(ProcNm_t)
     D  assertionCnt                 10i 0 Const

       // Set the starting index and the index step to run the test cases.
     D setTestRunOrder...
     D                 pr
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  order                         8a   Const
        // (Output) Starting index.
     D  startIdx                     10i 0
        // (Output) Step from one test index to the next.
     D  step                         10i 0

       // Give a status message to the user.
     D status          pr
     D  pgmNm                              Const Like(Object_t.nm)
     D  testNm                       64a   Const Varying


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Test case suite.
     D testSuite       ds                  LikeDs(TestSuite_t)

       // Completion message.
     D msg             s            256a

       // Test event counters.
     D assertCnt       s             10i 0
     D errorCnt        s             10i 0
     D failureCnt      s             10i 0
     D testCasesCnt    s             10i 0


       //----------------------------------------------------------------------
       //   Main Procedure
       //----------------------------------------------------------------------

     D cmdRun          pi
     D  testPgm                            Const LikeDs(Object_t)
     D  testProc                     32a   Const
     D  order                         8a   Const
     D  detail                        6a   Const

      /free

        setLogContext( testPgm );

        monitor;
          testSuite = loadTestSuite( testPgm );
        on-error;
          raiseRUError( 'Error while loading the test suite in '
                      + fmtObjNm(testPgm) + '.' );
        endmon;

        if testSuite.testCasesCnt = 0;
          raiseRUError( 'No test case found in service program '
                      + fmtObjNm(testPgm) + '.' );
        endif;

        callWithLogging( testSuite.setUpSuite );

        if errorCnt = 0;
          runTests( testPgm.nm : testSuite : testProc : order : detail );
        endif;

        callWithLogging( testSuite.tearDownSuite );

        monitor;
          rclTestSuite( testSuite );
        on-error;
          raiseRUError( 'Failed to reclaim the test suite''s resources.' );
        endmon;

        assertCnt = getAssertCalled();

        msg = fmtCompMsg( testCasesCnt:
                          assertCnt:
                          failureCnt:
                          errorCnt );

        logCompMsg(msg);

        if failureCnt = 0 and errorCnt = 0;
          sndCompMsg( msg );
        else;
          sndEscapeMsgAboveCtlBdy( msg );
        endif;

        *inlr = *on;

      /end-free


       //----------------------------------------------------------------------
       //   Procedures
       //----------------------------------------------------------------------

     P assertHasRunAtLeastOneTestCase...
     P                 b
     D assertHasRunAtLeastOneTestCase...
     D                 pi
     D  testCasesCnt                 10i 0 Const
     D  testProcToRun                      Const Like(ProcNm_t)

     D excpMsgInfo     ds                  LikeDs(ExcpMsgInfo_t)

      /free

        if testCasesCnt = 0;
          excpMsgInfo.msgId = *blank;
          excpMsgInfo.msg   = 'Test procedure not found.';
          handleError( testProcToRun : excpMsgInfo );
        endif;

      /end-free
     P                 e


     P callWithLogging...
     P                 b                   Export
     D callWithLogging...
     D                 pi
     D  proc                               Const LikeDs(Proc_t)
      /free

        monitor;
          callProcByPtr( proc.procPtr );
        on-error;
          handleError( proc.procNm : rcvExcpMsgInfo() );
        endmon;

      /end-free
     P callWithLogging...
     P                 e


     P fmtCompMsg      b                   Export
       //----------------------------------------------------------------------
       // Format a test run completion message. See prototype.
       //----------------------------------------------------------------------
     D fmtCompMsg      pi           256a   Varying
     D  testCaseCnt                  10i 0 Const
     D  assertCnt                    10i 0 Const
     D  failureCnt                   10i 0 Const
     D  errorCnt                     10i 0 Const

     D msg             s            256a   Varying

      /free

        select;
          when errorCnt <> 0;
            msg = 'ERROR';
          when failureCnt <> 0;
            msg = 'FAILURE';
          other;
            msg = 'Success';
        endsl;

        msg += '. ';
        msg += fmtWordWithCnt( testCaseCnt : 'test case' ) + ', ';
        msg += fmtWordWithCnt( assertCnt   : 'assertion' ) + ', ';
        msg += fmtWordWithCnt( failureCnt  : 'failure'   ) + ', ';
        msg += fmtWordWithCnt( errorCnt    : 'error'     ) + '.';

        return msg;

      /end-free
     P fmtCompMsg      e


     P fmtObjNm        b                   Export
     D fmtObjNm        pi            21a   Varying
     D  obj                                Const LikeDs(Object_t)
      /free

        return %trimr(obj.lib) + '/' + %trimr(obj.nm);

      /end-free
     P fmtObjNm        e


     P fmtWordWithCnt  b
     D fmtWordWithCnt  pi           256a   Varying
     D  cnt                          10i 0 Const
     D  word                        256a   Const Varying
      /free

        if cnt < 2;
          return %char(cnt) + ' ' + word;
        else;
          return %char(cnt) + ' ' + word + 's';
        endif;

      /end-free
     P fmtWordWithCnt  e


     P handleError     b
       //----------------------------------------------------------------------
       // Handle a test error event. See prototype.
       //----------------------------------------------------------------------
     D handleError     pi
     D  testNm                             Const Like(ProcNm_t)
     D  excpMsgInfo                        Const LikeDs(ExcpMsgInfo_t)
      /free

        errorCnt += 1;
        logError( testNm : excpMsgInfo );

      /end-free
     P                 e


     P handleFailure   b
       //----------------------------------------------------------------------
       // Handle a test failure event. See prototype.
       //----------------------------------------------------------------------
     D handleFailure   pi
     D  testNm                             Const Like(ProcNm_t)
     D  failure                            Const
     D                                     LikeDs(AssertFailEvt_t)
      /free

        failureCnt += 1;
        logFailure( testNm : failure );

      /end-free
     P                 e


     P handleSuccess   b
       //----------------------------------------------------------------------
       // Handle a test success event. See prototype.
       //----------------------------------------------------------------------
     D handleSuccess   pi
     D  testNm                             Const Like(ProcNm_t)
     D  assertionCnt                 10i 0 Const
      /free

        logSuccess( testNm : assertionCnt );

      /end-free
     P                 e


     P runTests        b                   Export
       //----------------------------------------------------------------------
       // Run the tests in a test suite. See prototype.
       //----------------------------------------------------------------------
     D runTests        pi
     D  testPgmNm                          Const Like(Object_t.nm)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testProcToRun                      Const Like(ProcNm_t)
     D  order                         8a   Const
     D  detail                        6a   Const

     D step            s             10i 0
     D testIdx         s             10i 0
     D testNm          s                   Like(ProcNm_t)
     D testResult      ds                  LikeDs(TestResult_t)
     D assertionCntBeforeRun...
     D                 s             10i 0
     D assertionCntAfterRun...
     D                 s             10i 0

      /free

        testCasesCnt = 0;
        setTestRunOrder( testSuite : order : testIdx : step );

        dow 1 <= testIdx and testIdx <= testSuite.testCasesCnt;
          testNm = getTestNm( testSuite : testIdx );

          if testProcToRun = '*ALL' or testProcToRun = testNm;
            testCasesCnt += 1;
            assertionCntBeforeRun = getAssertCalled();
            status( testPgmNm : testNm );
            testResult = runTest( testSuite : testIdx );
            assertionCntAfterRun = getAssertCalled();

            select;
              when testResult.outcome= TEST_CASE_SUCCESS;
                if detail = '*ALL';
                  handleSuccess( testNm :
                                 assertionCntAfterRun - assertionCntBeforeRun );
                endif;
              when testResult.outcome = TEST_CASE_FAILURE;
                handleFailure( testNm : testResult.failure );
              when testResult.outcome = TEST_CASE_ERROR;
                handleError( testNm : testResult.error );
            endsl;

          endif;

          testIdx += step;
        enddo;

        assertHasRunAtLeastOneTestCase( testCasesCnt : testProcToRun );

      /end-free
     P                 e


     P setTestRunOrder...
     P                 b
     D setTestRunOrder...
     D                 pi
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  order                         8a   Const
     D  startIdx                     10i 0
     D  step                         10i 0

     D firstTestIdx    s             10i 0
     D lastTestIdx     s             10i 0
     D increasingOrder...
     D                 c                   const(1)
     D decreasingOrder...
     D                 c                   const(-1)

      /free

        firstTestIdx = 1;
        lastTestIdx  = testSuite.testCasesCnt;

        if order = '*REVERSE';
          startIdx = lastTestIdx;
          step = decreasingOrder;
        else;
          startIdx = firstTestIdx;
          step = increasingOrder;
        endif;

      /end-free
     P                 e


     P status          b
     D status          pi
     D  testPgmNm                          Const Like(Object_t.nm)
     D  testNm                       64a   Const Varying
      /free

        sndStsMsg( 'Running ' + %trimr(testPgmNm) + ' - ' + testNm );

      /end-free
     P status          e
