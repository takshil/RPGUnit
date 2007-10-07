      //
      // Tests CMDRUN.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      // This module mocks the CMDRUNLOG procedures.
      /copy RPGUNITY1,CMDRUNLOG

      /copy RPGUNITY1,CMDRUN
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     D setUp           pr

       // Test runTests with a one-test test suite, with DETAIL(*BASIC) option.
     D test_runTests_SuccessfulTestWithDetailBasic...
     D                 pr
       // Test runTests with a one-test test suite, with DETAIL(*ALL) option.
     D test_runTests_SuccessfulTestWithDetailAllAndOneAssertion...
     D                 pr
     D test_runTests_SuccessfulTestWithDetailAllAndTwoAssertions...
     D                 pr
       // Test runTests with a two-test test suite, with DETAIL(*ALL) option.
     D test_runTests_TwoSuccessfulTestsWithDetailAll...
     D                 pr
       // Test runTests with a two-test test suite, with ORDER(*REVERSE) option.
     D test_runTests_TwoSuccessfulTestsWithOrderReverse...
     D                 pr
       // Test runTests with TSTPRC option.
     D test_runTests_ChooseOneTestProc...
     D                 pr
       // Test runTests, choosing a non existing TSTPRC option.
     D test_runTests_ChooseNonExistingTestProc...
     D                 pr
       // Test fmtObjNm.
     D test_fmtObjNm   pr
       // Test callWithLogging when the call is successful.
     D test_callWithLogging_withSuccess...
     D                 pr
       // Test callWithLogging when the call raises an error.
     D test_callWithLogging_withError...
     D                 pr
       // Test fmtCompMsg.
     D test_fmtCompMsg...
     D                 pr


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D successful_test_with_one_assertion...
     D                 pr
     D successful_test_with_two_assertions...
     D                 pr
     D proc_with_no_error...
     D                 pr
     D proc_with_error...
     D                 pr


      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

       // TSTPRC option.
     D ALL_PROCS       c                   Const('*ALL')
       // ORDER options.
     D ORDER_API       c                   Const('*API')
     D ORDER_REVERSE   c                   Const('*REVERSE')
       // DETAIL options.
     D DETAIL_BASIC    c                   Const('*BASIC')
     D DETAIL_ALL      c                   Const('*ALL')

       // Dummy test program name.
     D testPgm         c                   Const('MYTSTPGM')


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // In-memory log spool, made of an array and its index.
     D logLine         ds                  Qualified Dim(2)
     D  type                               Like(TestResult_t.outcome)
     D  procNm                             Like(ProcNm_t)
     D  assertionCnt                 10i 0
     D  msg                                Like(ExcpMsgInfo_t.msg)
     D logIdx          s             10i 0

       // An array of test cases, for testing purpose.
     D testCase        ds                  Dim(2) LikeDs(Proc_t)
       // A test suite, for testing purpose.
     D testSuite       ds                  LikeDs(TestSuite_t)

       // Spying flag.
     D procWithNoErrorWasCalled...
     D                 s               n


      //----------------------------------------------------------------------
      //   Test Definitions
      //----------------------------------------------------------------------

     P setUp           b                   Export
     D setUp           pi
      /free

        clear logIdx;
        clear logLine;

        clear testCase;
        clear testSuite;
        testSuite.testList = %addr(testCase);

        clear procWithNoErrorWasCalled;

      /end-free
     P                 e


     P test_runTests_SuccessfulTestWithDetailBasic...
     P                 b                   Export
     D test_runTests_SuccessfulTestWithDetailBasic...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 1;
        testCase(1).procNm = 'successful_test';

        // Execution.

        runTests( testPgm : testSuite : ALL_PROCS : ORDER_API : DETAIL_BASIC );

        // Controls.

        iEqual( 0 : logIdx );

      /end-free
     P                 e


     P test_runTests_SuccessfulTestWithDetailAllAndOneAssertion...
     P                 b                   Export
     D test_runTests_SuccessfulTestWithDetailAllAndOneAssertion...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 1;
        testCase(1).procNm = 'successful_test_with_one_assertion';
        testCase(1).procPtr = %paddr(successful_test_with_one_assertion);

        // Execution.

        runTests( testPgm : testSuite : ALL_PROCS : ORDER_API : DETAIL_ALL );

        // Controls.

        iEqual( 1 : logIdx );
        aEqual( TEST_CASE_SUCCESS : logLine(1).type );
        aEqual( 'successful_test_with_one_assertion' : logLine(1).procNm );
        iEqual( 1 : logLine(1).assertionCnt );

      /end-free
     P                 e


     P test_runTests_SuccessfulTestWithDetailAllAndTwoAssertions...
     P                 b                   Export
     D test_runTests_SuccessfulTestWithDetailAllAndTwoAssertions...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 1;
        testCase(1).procNm = 'successful_test_with_two_assertions';
        testCase(1).procPtr = %paddr(successful_test_with_two_assertions);

        // Execution.

        runTests( testPgm : testSuite : ALL_PROCS : ORDER_API : DETAIL_ALL );

        // Controls.

        iEqual( 1 : logIdx );
        aEqual( 'successful_test_with_two_assertions' : logLine(1).procNm );
        iEqual( 2 : logLine(1).assertionCnt );

      /end-free
     P                 e


     P test_runTests_TwoSuccessfulTestsWithDetailAll...
     P                 b                   Export
     D test_runTests_TwoSuccessfulTestsWithDetailAll...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 2;
        testCase(1).procNm = 'successful_test_1';
        testCase(2).procNm = 'successful_test_2';

        // Execution.

        runTests( testPgm : testSuite : ALL_PROCS : ORDER_API : DETAIL_ALL );

        // Controls.

        iEqual( 2 : logIdx );
        aEqual( 'successful_test_1' : logLine(1).procNm );
        aEqual( 'successful_test_2' : logLine(2).procNm );

      /end-free
     P                 e


     P test_runTests_TwoSuccessfulTestsWithOrderReverse...
     P                 b                   Export
     D test_runTests_TwoSuccessfulTestsWithOrderReverse...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 2;
        testCase(1).procNm = 'successful_test_1';
        testCase(2).procNm = 'successful_test_2';

        // Execution.

        runTests( testPgm :
                  testSuite :
                  ALL_PROCS :
                  ORDER_REVERSE :
                  DETAIL_ALL );

        // Controls.

        iEqual( 2 : logIdx );
        aEqual( 'successful_test_2' : logLine(1).procNm );
        aEqual( 'successful_test_1' : logLine(2).procNm );

      /end-free
     P                 e


     P test_runTests_ChooseOneTestProc...
     P                 b                   Export
     D test_runTests_ChooseOneTestProc...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 2;
        testCase(1).procNm = 'test_1';
        testCase(2).procNm = 'test_2';

        // Execution.

        runTests( testPgm : testSuite : 'test_2' : ORDER_API : DETAIL_ALL );

        // Controls.

        iEqual( 1 : logIdx );
        aEqual( 'test_2' : logLine(1).procNm );

      /end-free
     P                 e


     P test_runTests_ChooseNonExistingTestProc...
     P                 b                   Export
     D test_runTests_ChooseNonExistingTestProc...
     D                 pi
      /free

        // Setup.

        testSuite.testCasesCnt = 1;
        testCase(1).procNm = 'test_1';

        // Execution.

        runTests( testPgm : testSuite : 'test_2' : ORDER_API : DETAIL_ALL );

        // Controls.

        iEqual( 1 : logIdx );
        aEqual( 'test_2' : logLine(1).procNm );
        aEqual( TEST_CASE_ERROR : logLine(1).type );
        aEqual( 'Test procedure not found.' : logLine(1).msg );

      /end-free
     P                 e


     P test_fmtObjNm   b                   Export
     D test_fmtObjNm   pi

     D object          ds                  LikeDs(Object_t)

      /free

        object.nm  = 'MYOBJ';
        object.lib = 'MYLIB';

        aEqual( 'MYLIB/MYOBJ' : fmtObjNm( object ) );
        iEqual( %len( 'MYLIB/MYOBJ' ) : %len( fmtObjNm( object ) ) );

      /end-free
     P                 e


     P test_callWithLogging_withSuccess...
     P                 b                   Export
     D test_callWithLogging_withSuccess...
     D                 pi

     D procWithNoError...
     D                 ds                  LikeDs(Proc_t)

      /free

        procWithNoError.procNm  =        'proc_with_no_error';
        procWithNoError.procPtr = %paddr( proc_with_no_error );

        callWithLogging( procWithNoError );

        assert( procWithNoErrorWasCalled : 'proc_with_no_error not called' );
        iEqual( 0 : logIdx );    // No logging if success.

      /end-free
     P                 e


     P test_callWithLogging_withError...
     P                 b                   Export
     D test_callWithLogging_withError...
     D                 pi

     D procWithError   ds                  LikeDs(Proc_t)

      /free

        procWithError.procNm  =        'proc_with_error';
        procWithError.procPtr = %paddr( proc_with_error );

        monitor;
          callWithLogging( procWithError );
        on-error;
          fail( 'callWithLogging should never raise an error' );
        endmon;

        iEqual( 1 : logIdx );
        aEqual( 'proc_with_error'  : logLine(1).procNm );
        aEqual( TEST_CASE_ERROR    : logLine(1).type );
        aEqual( 'Artificial error' : logLine(1).msg );

      /end-free
     P                 e


     P test_fmtCompMsg...
     P                 b                   Export
     D test_fmtCompMsg...
     D                 pi
      /free

        aEqual( 'Success. 0 test case, 0 assertion, 0 failure, 0 error.' :
                fmtCompMsg( 0 : 0 : 0 : 0 ) );

        aEqual( 'Success. 2 test cases, 0 assertion, 0 failure, 0 error.' :
                fmtCompMsg( 2 : 0 : 0 : 0 ) );

        aEqual( 'Success. 0 test case, 2 assertions, 0 failure, 0 error.' :
                fmtCompMsg( 0 : 2 : 0 : 0 ) );

        aEqual( 'FAILURE. 0 test case, 0 assertion, 2 failures, 0 error.' :
                fmtCompMsg( 0 : 0 : 2 : 0 ) );

        aEqual( 'ERROR. 0 test case, 0 assertion, 0 failure, 2 errors.' :
                fmtCompMsg( 0 : 0 : 0 : 2 ) );

        // Errors have priority over failures.
        aEqual( 'ERROR. 0 test case, 0 assertion, 2 failures, 1 error.' :
                fmtCompMsg( 0 : 0 : 2 : 1 ) );

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Mock Procedures (mocking CMDRUNLOG)
      //----------------------------------------------------------------------

     P logCompMsg      b                   Export
     D logCompMsg      pi
     D  msg                         256a   Const
      /free
        fail( 'Mock logCompMsg not implemented' );
      /end-free
     P                 e


     P logError        b                   Export
     D logError        pi
     D  testNm                             Const Like(ProcNm_t)
     D  excpMsgInfo                        Const LikeDs(ExcpMsgInfo_t)
      /free

        logIdx += 1;
        logLine(logIdx).type = TEST_CASE_ERROR;
        logLine(logIdx).procNm = testNm;
        logLine(logIdx).msg = excpMsgInfo.msg;

      /end-free
     P                 e


     P logFailure      b                   Export
     D logFailure      pi
     D  testNm                             Const Like(ProcNm_t)
     D  failure                            Const LikeDs(AssertFailEvt_t)
      /free
        fail( 'Mock logFailure not implemented' );
      /end-free
     P                 e


     P logSuccess      b                   Export
     D logSuccess      pi
     D  testNm                             Const Like(ProcNm_t)
     D  assertionCnt                 10i 0 Const
      /free

        logIdx += 1;
        logLine(logIdx).type = TEST_CASE_SUCCESS;
        logLine(logIdx).procNm = testNm;
        logLine(logIdx).assertionCnt = assertionCnt;

      /end-free
     P                 e


     P setLogContext   b                   Export
     D setLogContext   pi
     D  testPgm                            Const LikeDs(Object_t)
      /free
        fail( 'Mock setLogContext not implemented' );
      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Support Procedures
      //----------------------------------------------------------------------

       // Dummy procedure with error.
     P proc_with_error...
     P                 b
     D proc_with_error...
     D                 pi
      /free

        sndEscapeMsgToCaller( 'Artificial error' );

      /end-free
     P                 e


       // Dummy procedure with no error.
     P proc_with_no_error...
     P                 b
     D proc_with_no_error...
     D                 pi
      /free

        procWithNoErrorWasCalled = *on;

      /end-free
     P                 e


       // Dummy test procedure.
     P successful_test_with_one_assertion...
     P                 b
     D successful_test_with_one_assertion...
     D                 pi
      /free
        iEqual( 4 : 2+2 );
      /end-free
     P                 e

       // Dummy test procedure.
     P successful_test_with_two_assertions...
     P                 b
     D successful_test_with_two_assertions...
     D                 pi
      /free
        iEqual( 4 : 2+2 );
        iEqual( 4 : 2+2 );
      /end-free
     P                 e

