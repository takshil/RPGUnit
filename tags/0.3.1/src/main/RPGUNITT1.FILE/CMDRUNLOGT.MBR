      //
      // Tests CMDRUNLOG.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CMDRUNLOG
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE

      // CMDRUNPRTY is imported to mock module CMDRUNPRT. That way, we can
      // test what would have been printed in the spool file, without
      // involving the spool file API.
      /copy RPGUNITY1,CMDRUNPRT


      //----------------------------------------------------------------------
      //   Test Case Prototypes
      //----------------------------------------------------------------------

     D setUp           pr
     D tearDown        pr

     D testLogSuccessWith1Assertion...
     D                 pr
     D testLogSuccessWith2Assertions...
     D                 pr
     D testLog2Successes...
     D                 pr
     D testLogFailureWithoutSpecNb...
     D                 pr
     D testLogErrorWithoutMsgId...
     D                 pr
     D testLogErrorWithoutExcpInfoOrigin...
     D                 pr
     D testLogCompMsg  pr
     D testLogRawLine  pr
     D testLogRawLineWithWrapping...
     D                 pr


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // The mock log lines and state.
     D logIdx          s             10i 0
     D logLine         s             80a   Dim(10)
     D logWasOpened    s               n
     D logWasClosed    s               n
       // The (dummy) service program containing the tests.
     D testSrvPgm      ds                  LikeDs(Object_t)
       // The (dummy) test case name.
     D testNm          s                   Like(ProcNm_t)


      //----------------------------------------------------------------------
      //   Test Definitions
      //----------------------------------------------------------------------

     P setUp           b                   Export
     D setUp           pi
      /free

        clear logIdx;
        clear logLine;
        clear logWasOpened;
        clear logWasClosed;
        clear testSrvPgm;
        clear testNm;

        testSrvPgm.nm = 'MY_SRVPGM';
        setLogContext( testSrvPgm );

      /end-free
     P                 e


     P tearDown        b                   Export
     D tearDown        pi
      /free

        logCompMsg( *blank );    // Close log in all cases.

      /end-free
     P                 e


     P testLogSuccessWith1Assertion...
     P                 b                   Export
     D testLogSuccessWith1Assertion...
     D                 pi

     D oneAssertion    c                   Const(1)

      /free

        // Setup.

        testNm = 'successful_test_with_one_assertion';

        // Execution.

        logSuccess( testNm : oneAssertion );

        // Controls.

        assert( logWasOpened : 'Log was not opened' );
        aEqual( '*** Tests from MY_SRVPGM ***            ' : logLine(1) );
        aEqual( 'successful_test_with_one_assertion - Suc' : logLine(2) );
        aEqual( 'cess                                    ' : logLine(3) );
        aEqual( '  1 assertions                          ' : logLine(4) );
        aEqual( '-----------------------                 ' : logLine(5) );
        iEqual( 5 : logIdx );

      /end-free
     P                 e


     P testLogSuccessWith2Assertions...
     P                 b                   Export
     D testLogSuccessWith2Assertions...
     D                 pi

     D twoAssertions   c                   Const(2)

      /free

        // Setup.

        testNm = 'successful_test_with_two_assertions';

        // Execution.

        logSuccess( testNm : twoAssertions );

        // Controls.

        aEqual( '*** Tests from MY_SRVPGM ***            ' : logLine(1) );
        aEqual( 'successful_test_with_two_assertions - Su' : logLine(2) );
        aEqual( 'ccess                                   ' : logLine(3) );
        aEqual( '  2 assertions                          ' : logLine(4) );
        aEqual( '-----------------------                 ' : logLine(5) );
        iEqual( 5 : logIdx );

      /end-free
     P                 e


     P testLog2Successes...
     P                 b                   Export
     D testLog2Successes...
     D                 pi

     D testNm2         s                   Like(TestNm)

      /free

        // Setup.

        testNm  = 'successful_test_1';
        testNm2 = 'successful_test_2';

        // Execution.

        logSuccess( testNm  : 0 );
        logSuccess( testNm2 : 0 );

        // Controls.

        aEqual( '*** Tests from MY_SRVPGM ***                ' : logLine(1) );
        aEqual( 'successful_test_1 - Success                 ' : logLine(2) );
        aEqual( '  0 assertions                              ' : logLine(3) );
        aEqual( '-----------------------                     ' : logLine(4) );
        aEqual( 'successful_test_2 - Success                 ' : logLine(5) );
        aEqual( '  0 assertions                              ' : logLine(6) );
        aEqual( '-----------------------                     ' : logLine(7) );
        iEqual( 7 : logIdx );

      /end-free
     P                 e


     P testLogFailureWithoutSpecNb...
     P                 b                   Export
     D testLogFailureWithoutSpecNb...
     D                 pi

     D failure         ds                  LikeDs(AssertFailEvt_t)

      /free

        // Setup.

        testNm = 'failure_without_spec_nb';
        failure.callStkEnt(1).pgmNm = 'MY_SRVPGM';
        failure.callStkEnt(1).modNm = 'MY_SRVPGM';
        failure.callStkEnt(1).procNm = testNm;
        failure.callStkEnt(1).specNb = *blank;

        // Execution.

        logFailure( testNm : failure );

        // Controls.

        assert( logWasOpened : 'Log was not opened' );
        aEqual( '*** Tests from MY_SRVPGM ***             ' : logLine(1) );
        aEqual( 'failure_without_spec_nb - FAILURE        ' : logLine(2) );
        aEqual( '  failure_without_spec_nb (MY_SRVPGM:*N) ' : logLine(3) );
        aEqual( '-----------------------                  ' : logLine(4) );
        iEqual( 4 : logIdx );

      /end-free
     P                 e


     P testLogErrorWithoutMsgId...
     P                 b                   Export
     D testLogErrorWithoutMsgId...
     D                 pi

     D excpMsgInfo     ds                  LikeDs(ExcpMsgInfo_t)

      /free

        // Setup.

        testNm = 'error_with_missing_msg_id';
        excpMsgInfo.msgId = *blank;
        excpMsgInfo.msg = 'Error message.';
        excpMsgInfo.pgmNm = 'ERRORPGM';
        excpMsgInfo.procNm = 'error_proc';
        excpMsgInfo.sttNb = '1000';

        // Execution.

        logError( testNm : excpMsgInfo );

        // Controls.

        assert( logWasOpened : 'Log was not opened' );
        aEqual( '*** Tests from MY_SRVPGM ***      ' : logLine(1) );
        aEqual( 'error_with_missing_msg_id - ERROR ' : logLine(2) );
        aEqual( 'Error message.                    ' : logLine(3) );
        aEqual( '  error_proc (ERRORPGM:1000)      ' : logLine(4) );
        aEqual( '-----------------------           ' : logLine(5) );
        iEqual( 5 : logIdx );

      /end-free
     P                 e


     P testLogErrorWithoutExcpInfoOrigin...
     P                 b                   Export
     D testLogErrorWithoutExcpInfoOrigin...
     D                 pi

     D excpMsgInfo     ds                  LikeDs(ExcpMsgInfo_t)

      /free

        // Setup.

        testNm = 'error_without_origin_info';
        excpMsgInfo.msgId = 'CPF1234';
        excpMsgInfo.msg = 'Error message.';
        excpMsgInfo.pgmNm = *blank;
        excpMsgInfo.procNm = *blank;
        excpMsgInfo.sttNb = *blank;

        // Execution.

        logError( testNm : excpMsgInfo );

        // Controls.

        aEqual( '*** Tests from MY_SRVPGM ***      ' : logLine(1) );
        aEqual( 'error_without_origin_info - ERROR ' : logLine(2) );
        aEqual( 'CPF1234 - Error message.          ' : logLine(3) );
        aEqual( '-----------------------           ' : logLine(4) );
        iEqual( 4 : logIdx );

      /end-free
     P                 e


     P testLogCompMsg  b                   Export
     D testLogCompMsg  pi
      /free

        // Execution.

        logCompMsg( 'Completion message' );

        // Controls.

        assert( logWasOpened : 'Log was not opened' );
        aEqual( '*** Tests from MY_SRVPGM ***      ' : logLine(1) );
        aEqual( 'Completion message                ' : logLine(2) );
        iEqual( 2 : logIdx );
        assert( logWasClosed : 'Log was not closed' );

      /end-free
     P                 e


     P testLogRawLine  b                   Export
     D testLogRawLine  pi
      /free

        // Execution.

        logRawLine( 'A short text' );

        // Controls.

        aEqual( 'A short text                      ' : logLine(1) );
        iEqual( 1 : logIdx );

      /end-free
     P                 e


     P testLogRawLineWithWrapping...
     P                 b                   Export
     D testLogRawLineWithWrapping...
     D                 pi

     D longText        s            256a

      /free

        // Setup.

                 //          111111111122222222223333333333444444444455
                 // 123456789012345678901234567890123456789012345678901
        longText = 'A very very very very very very very very long text';

        // Execution.

        logRawLine( longText );

        // Controls.

              //          1111111111222222222233333333334
              // 1234567890123456789012345678901234567890
        aEqual( 'A very very very very very very very ver' : logLine(1) );
        aEqual( 'y long text' : logLine(2) );
        iEqual( 2 : logIdx );

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Support Procedures
      //----------------------------------------------------------------------

       // Procedure to mock module CMDRUNPRT.
     P clsPrt          b                   Export
     D clsPrt          pi
      /free

        logWasClosed = *on;

      /end-free
     P                 e


       // Procedure to mock module CMDRUNPRT.
     P getPrtWidth     b                   Export
     D getPrtWidth     pi            10i 0
      /free

        return 40;

      /end-free
     P                 e


       // Procedure to mock module CMDRUNPRT.
     P opnPrt          b                   Export
     D opnPrt          pi
     D  testPgmNm                          Const Like(Object_t.nm)
      /free

        logWasOpened = *on;
        aEqual( 'MY_SRVPGM' : testPgmNm );

      /end-free
     P                 e


       // Procedure to mock module CMDRUNPRT.
     P prtLine         b                   Export
     D prtLine         pi
     D  line                         80a   Const
      /free

        logIdx += 1;
        logLine( logIdx ) = line;

      /end-free
     P                 e


