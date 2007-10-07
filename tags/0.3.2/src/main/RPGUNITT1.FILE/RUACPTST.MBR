      //
      // Acceptance Tests for RPGUnit.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     D setUp           pr

     D testEmptyTest   pr
     D testSuccess     pr
     D testFailures    pr
     D testNonTestProc...
     D                 pr
     D testSetupAndTearDown...
     D                 pr
     D testError       pr
     D testManyTests   pr
     D testStackTrace  pr
     D testMissingObject...
     D                 pr
     D testErrorDuringSetup...
     D                 pr
     D testErrorDuringTearDown...
     D                 pr
     D testNoTestCase  pr
     D testSetupSuiteAndTearDownSuite...
     D                 pr
     D testBigInteger  pr
     D testForceSpoolOnSuccess...
     D                 pr
     D testReverseOrder...
     D                 pr
     D testChooseTest  pr
     D testChooseNonExistingTest...
     D                 pr
     D testTestCreationSuccess...
     D                 pr
     D testErrorInSetUpSuite...
     D                 pr
     D testErrorInTearDownSuite...
     D                 pr
     D testErrorsInBothSetUpSuiteAndTearDownSuite...
     D                 pr


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,QCMDEXC
      /copy RPGUNITY1,JOBLOG
      /copy RPGUNITY1,SPLF
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D run             pr
     D  cmd                       32767a   Const Varying
     D  errorExpected                  n   Const Options(*NoPass)
     D  msgType                      10a   Const Options(*NoPass)
     D  msgTxt                      256a   Options(*NoPass)


      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

       // Constants for the 'run' procedure.
     D errorExpected   c                   Const(*on)
     D noError         c                   Const(*off)


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Message text.
     D msgTxt          s            256a


      //----------------------------------------------------------------------
      //   Test Procedures
      //----------------------------------------------------------------------

     PsetUp            b                   Export
     DsetUp            pi
      /free

        clear msgTxt;

      /end-free
     P                 e


     PtestEmptyTest    b                   Export
     DtestEmptyTest    pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM01) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM01' : noError : '*COMP' : msgTxt );

        aEqual( 'Success. 1 test case, 0 assertion, 0 failure, 0 error.':
                msgTxt );

      /end-free
     P                 e


     PtestSuccess      b                   Export
     DtestSuccess      pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM02) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM02' : noError : '*COMP' : msgTxt );

        aEqual( 'Success. 1 test case, 1 assertion, 0 failure, 0 error.':
                msgTxt );

      /end-free
     P                 e


     PtestFailures     b                   Export
     DtestFailures     pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM03) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM03' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'FAILURE. 2 test cases, 2 assertions, 2 failures, 0 error.':
                msgTxt );

        opnSplf( 'RPGUNIT' : 'TESTPGM03' );
        splfLineStartsWith( '*** Tests from TESTPGM03 ***' );
        splfLineStartsWith( 'TESTFALSE - FAILURE' );
        splfLineStartsWith( 'Expected 5, but was 4.' );
        splfLineStartsWith( '  assert' );
        splfLineStartsWith( '  iEqual' );
        splfLineStartsWith( '  TESTFALSE (TESTPGM03:1300)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'TESTFALSE2 - FAILURE' );
        splfLineStartsWith( 'Expected 6, but was 4.' );
        splfLineStartsWith( '  assert' );
        splfLineStartsWith( '  iEqual' );
        splfLineStartsWith( '  TESTFALSE2 (TESTPGM03:2200)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'FAILURE. 2 test cases, 2 assertions,'
                          + ' 2 failures, 0 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestNonTestProc...
     P                 b                   Export
     DtestNonTestProc...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM04) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM04' : noError : '*COMP' : msgTxt );

        aEqual( 'Success. 2 test cases, 0 assertion, 0 failure, 0 error.':
                msgTxt );

      /end-free
     P                 e


     PtestSetupAndTearDown...
     P                 b                   Export
     DtestSetupAndTearDown...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM05) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM05' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'FAILURE. 2 test cases, 0 assertion, 1 failure, 0 error.':
                msgTxt );

        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test1'        : rcvMsgData('*INFO') );
        aEqual( 'teardown'     : rcvMsgData('*INFO') );
        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test2'        : rcvMsgData('*INFO') );    // Raises a failure.
        aEqual( 'teardown'     : rcvMsgData('*INFO') );    // Call 'teardown' anyway.

      /end-free
     P                 e


     PtestError        b                   Export
     DtestError        pi

     D testStartTime   s               z

      /free

        testStartTime = getFullTimeStamp();
        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM06) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM06' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 1 test case, 0 assertion, 0 failure, 1 error.':
                msgTxt );

        assertJobLogContains( 'MCH1211' : testStartTime );

        opnSplf( 'RPGUNIT' : 'TESTPGM06' );
        splfLineStartsWith( '*** Tests from TESTPGM06 ***' );
        splfLineStartsWith( 'TESTERROR - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  TESTERROR (TESTPGM06:1400)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 1 test case, 0 assertion,'
                          + ' 0 failure, 1 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestManyTests    b                   Export
     DtestManyTests    pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM13) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM13' : noError : '*COMP' : msgTxt );

        aEqual( 'Success. 256 test cases, 0 assertion, 0 failure, 0 error.':
                msgTxt );

      /end-free
     P                 e


     PtestStackTrace   b                   Export
     DtestStackTrace   pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM07) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM07' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'FAILURE. 1 test case, 1 assertion, 1 failure, 0 error.':
                msgTxt );

        opnSplf( 'RPGUNIT' : 'TESTPGM07' );
        splfLineStartsWith( '*** Tests from TESTPGM07 ***' );
        splfLineStartsWith( 'TESTSTACK - FAILURE' );
        splfLineStartsWith( 'Expected 5, but was 4.' );
        splfLineStartsWith( '  assert' );
        splfLineStartsWith( '  iEqual' );
        splfLineStartsWith( '  FAILINGPROC (TESTPGM07:1300)' );
        splfLineStartsWith( '  TESTSTACK (TESTPGM07:2200)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'FAILURE. 1 test case, 1 assertion,'
                          + ' 1 failure, 0 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestMissingObject...
     P                 b                   Export
     DtestMissingObject...
     D                 pi
      /free

        callp(e) run( 'DLTSRVPGM QTEMP/TESTPGM08' );    // No TESTPGM08.

        run( 'RUCALLTST QTEMP/TESTPGM08' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'RPGUnit Error.'
              + ' Error while loading the test suite in QTEMP/TESTPGM08.' :
                msgTxt );

      /end-free
     P                 e


     PtestErrorDuringSetup...
     P                 b                   Export
     DtestErrorDuringSetup...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM09) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM09' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 1 test case, 0 assertion, 0 failure, 1 error.' :
                msgTxt );

        aEqual( 'setup'        : rcvMsgData('*INFO') );    // Error during setup.
              // Test should not be called.
        aEqual( 'teardown'     : rcvMsgData('*INFO') );    // Teardown should be called anyway.

        opnSplf( 'RPGUNIT' : 'TESTPGM09' );
        splfLineStartsWith( '*** Tests from TESTPGM09 ***' );
        splfLineStartsWith( 'TEST - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  SETUP (TESTPGM09:2100)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 1 test case, 0 assertion,'
                          + ' 0 failure, 1 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestErrorDuringTearDown...
     P                 b                   Export
     DtestErrorDuringTearDown...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM10) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM10' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 1 test case, 0 assertion, 0 failure, 1 error.' :
                msgTxt );

        opnSplf( 'RPGUNIT' : 'TESTPGM10' );
        splfLineStartsWith( '*** Tests from TESTPGM10 ***' );
        splfLineStartsWith( 'TEST - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  TEARDOWN (TESTPGM10:1900)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 1 test case, 0 assertion,'
                          + ' 0 failure, 1 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestNoTestCase   b                   Export
     DtestNoTestCase   pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM11) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM11' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'RPGUnit Error.'
              + ' No test case found in service program QTEMP/TESTPGM11.' :
                msgTxt );

      /end-free
     P                 e


     PtestSetupSuiteAndTearDownSuite...
     P                 b                   Export
     DtestSetupSuiteAndTearDownSuite...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM12) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM12' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'FAILURE. 2 test cases, 0 assertion, 1 failure, 0 error.':
                msgTxt );

        aEqual( 'setupSuite'   : rcvMsgData('*INFO') );
        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test1'        : rcvMsgData('*INFO') );
        aEqual( 'teardown'     : rcvMsgData('*INFO') );
        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test2'        : rcvMsgData('*INFO') );    // Raises a failure.
        aEqual( 'teardown'     : rcvMsgData('*INFO') );    // Call 'teardown' anyway.
        aEqual( 'teardownSuite': rcvMsgData('*INFO') );    // Call 'teardownsuite' anyway.

      /end-free
     P                 e


     PtestBigInteger   b                   Export
     DtestBigInteger   pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM14) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM14' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'FAILURE. 2 test cases, 2 assertions, 1 failure, 0 error.' :
                msgTxt );

        opnSplf( 'RPGUNIT' : 'TESTPGM14' );
        splfLineStartsWith( '*** Tests from TESTPGM14 ***' );
        splfLineStartsWith( 'TEST_DIFFERENT - FAILURE' );
        splfLineStartsWith( 'Expected 1234567890123456789012345678901,'
                          + ' but was 123456789012345678901234567890' );
        splfLineStartsWith( '0.' );
        splfLineStartsWith( '  assert' );
        splfLineStartsWith( '  iEqual' );
        splfLineStartsWith( '  TEST_DIFFERENT (TESTPGM14:2800)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'FAILURE. 2 test cases, 2 assertions,'
                          + ' 1 failure, 0 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestForceSpoolOnSuccess...
     P                 b                   Export
     DtestForceSpoolOnSuccess...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM15) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST TSTPGM(QTEMP/TESTPGM15) DETAIL(*ALL)' :
             noError :
             '*COMP' :
             msgTxt );

        aEqual( 'Success. 2 test cases, 3 assertions, 0 failure, 0 error.' :
                msgTxt );

        opnSplf( 'RPGUNIT' : 'TESTPGM15' );
        splfLineStartsWith( '*** Tests from TESTPGM15 ***' );
        splfLineStartsWith( 'TESTTRUE - Success' );
        splfLineStartsWith( '  1 assertions' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'TESTTRUE2 - Success' );
        splfLineStartsWith( '  2 assertions' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'Success. 2 test cases, 3 assertions,'
                          + ' 0 failure, 0 error.' );
        cloSplf();

      /end-free
     P                 e


     P testReverseOrder...
     P                 b                   Export
     D testReverseOrder...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM16) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST TSTPGM(QTEMP/TESTPGM16) ORDER(*REVERSE)' :
             noError :
             '*COMP' :
             msgTxt );

        aEqual( 'Success. 2 test cases, 0 assertion, 0 failure, 0 error.':
                msgTxt );

        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test2'        : rcvMsgData('*INFO') );
        aEqual( 'teardown'     : rcvMsgData('*INFO') );
        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test1'        : rcvMsgData('*INFO') );
        aEqual( 'teardown'     : rcvMsgData('*INFO') );

      /end-free
     P                 e


     PtestChooseTest   b                   Export
     DtestChooseTest   pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM05) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM05 TSTPRC(TEST2)' :
             errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'FAILURE. 1 test case, 0 assertion, 1 failure, 0 error.':
                msgTxt );

        aEqual( 'setup'        : rcvMsgData('*INFO') );
        aEqual( 'test2'        : rcvMsgData('*INFO') );
        aEqual( 'teardown'     : rcvMsgData('*INFO') );

        opnSplf( 'RPGUNIT' : 'TESTPGM05' );
        splfLineStartsWith( '*** Tests from TESTPGM05 ***' );
        splfLineStartsWith( 'TEST2 - FAILURE' );
        splfLineStartsWith( 'test2' );
        splfLineStartsWith( '  TEST2 (TESTPGM05' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'FAILURE. 1 test case, 0 assertion,'
                          + ' 1 failure, 0 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestChooseNonExistingTest...
     P                 b                   Export
     DtestChooseNonExistingTest...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM05) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM05 TSTPRC(NON_EXISTING_TEST)' :
             errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 0 test case, 0 assertion, 0 failure, 1 error.':
                msgTxt );

        opnSplf( 'RPGUNIT' : 'TESTPGM05' );
        splfLineStartsWith( '*** Tests from TESTPGM05 ***' );
        splfLineStartsWith( 'NON_EXISTING_TEST - ERROR' );
        splfLineStartsWith( 'Test procedure not found.' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 0 test case, 0 assertion,'
                          + ' 0 failure, 1 error.' );
        cloSplf();

      /end-free
     P                 e


     PtestTestCreationSuccess...
     P                 b                   Export
     DtestTestCreationSuccess...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM01) SRCFILE(RPGUNITF1)' :
             noError :
             '*COMP' :
             msgTxt );

        aEqual( 'Test program TESTPGM01 created in library QTEMP.' : msgTxt );

      /end-free
     P                 e


     P testErrorInSetUpSuite...
     P                 b                   Export
     D testErrorInSetUpSuite...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM17) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM17' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 0 test case, 0 assertion, 0 failure, 1 error.':
                msgTxt );

        aEqual( 'setupSuite'    : rcvMsgData('*INFO') );    // Error.
        aEqual( 'teardownSuite' : rcvMsgData('*INFO') );    // Call 'teardownSuite' anyway.

        opnSplf( 'RPGUNIT' : 'TESTPGM17' );
        splfLineStartsWith( '*** Tests from TESTPGM17 ***' );
        splfLineStartsWith( 'SETUPSUITE - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  SETUPSUITE (TESTPGM17:2100)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 0 test case, 0 assertion,'
                          + ' 0 failure, 1 error.' );
        cloSplf();

      /end-free
     P                 e


     P testErrorInTearDownSuite...
     P                 b                   Export
     D testErrorInTearDownSuite...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM18) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM18' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 1 test case, 0 assertion, 0 failure, 1 error.':
                msgTxt );

        aEqual( 'setupSuite'    : rcvMsgData('*INFO') );
        aEqual( 'test1'         : rcvMsgData('*INFO') );
        aEqual( 'teardownSuite' : rcvMsgData('*INFO') );    // Error.

        opnSplf( 'RPGUNIT' : 'TESTPGM18' );
        splfLineStartsWith( '*** Tests from TESTPGM18 ***' );
        splfLineStartsWith( 'TEARDOWNSUITE - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  TEARDOWNSUITE (TESTPGM18:3900)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 1 test case, 0 assertion,'
                          + ' 0 failure, 1 error.' );
        cloSplf();

      /end-free
     P                 e


     P testErrorsInBothSetUpSuiteAndTearDownSuite...
     P                 b                   Export
     D testErrorsInBothSetUpSuiteAndTearDownSuite...
     D                 pi
      /free

        run( 'RUCRTTST TSTPGM(QTEMP/TESTPGM19) SRCFILE(RPGUNITF1)' );

        run( 'RUCALLTST QTEMP/TESTPGM19' : errorExpected : '*ESCAPE' : msgTxt );

        aEqual( 'ERROR. 0 test case, 0 assertion, 0 failure, 2 errors.':
                msgTxt );

        aEqual( 'setupSuite'    : rcvMsgData('*INFO') );    // Error.
        aEqual( 'teardownSuite' : rcvMsgData('*INFO') );    // Another error.

        opnSplf( 'RPGUNIT' : 'TESTPGM19' );
        splfLineStartsWith( '*** Tests from TESTPGM19 ***' );
        splfLineStartsWith( 'SETUPSUITE - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  SETUPSUITE (TESTPGM19:2100)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'TEARDOWNSUITE - ERROR' );
        splfLineStartsWith( 'MCH1211 - ' );
        splfLineStartsWith( '  TEARDOWNSUITE (TESTPGM19:4200)' );
        splfLineStartsWith( '-----------------------' );
        splfLineStartsWith( 'ERROR. 0 test case, 0 assertion,'
                          + ' 0 failure, 2 errors.' );
        cloSplf();

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Helper Procedures
      //----------------------------------------------------------------------

     P run             b
     D run             pi
     D  cmd                       32767a   Const Varying
     D  errorExpected                  n   Const Options(*NoPass)
     D  msgType                      10a   Const Options(*NoPass)
     D  msgTxt                      256a   Options(*NoPass)

      /free

        if %parms >= 2 and errorExpected;
          callp(e) qcmdexc( cmd: %len(cmd) );
          assert( %error: 'Expected error missing' );
        else;
          qcmdexc( cmd: %len(cmd) );
        endif;

        if %parms >= 4;
          msgTxt = rcvMsgTxt( msgType );
        endif;

      /end-free
     P                 e
