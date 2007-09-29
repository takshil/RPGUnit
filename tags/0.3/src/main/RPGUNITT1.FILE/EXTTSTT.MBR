      //
      // Tests EXTTST.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CALLPROC
      /copy RPGUNITY1,EXTTST
      /copy RPGUNITY1,EXTPRC
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     D setup           pr

     D testOneProcOneTestCase...
     D                 pr
     D testOneProcNoTestCase...
     D                 pr
     D testTwoProcsTwoTestCases...
     D                 pr
     D testSetupProc   pr
     D testTearDownProc...
     D                 pr
     D testSetupSuite  pr
     D testTeardownSuite...
     D                 pr
     D testActivateTestSuite...
     D                 pr

     D ET_setUp        pr
     D ET_setUpSuite   pr
     D ET_tearDown     pr
     D ET_tearDownSuite...
     D                 pr
     D ET_testProc_1   pr
     D ET_testProc_2   pr


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D getMockProcNm   pr                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const

     D goToNext        pr
     D  mockProcNmListHandle...
     D                                5a   Const

     D getMockProcCnt  pr            10i 0
     D  mockProcNmListHandle...
     D                                5a   Const

     DtestProcEqual    pr
     D expTestProc                         Const LikeDs(Proc_t)
     D testSuite                           Const LikeDs(TestSuite_t)
     D testIdx                       10i 0 Const

     D return_NOT_A_TEST_1...
     D                 pr                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const

     D return_SETUP_then_TEST_1...
     D                 pr                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const

     D return_TEST_n   pr                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const


      //----------------------------------------------------------------------
      //   Global DS
      //----------------------------------------------------------------------

     D testSuite       ds                  LikeDs(TestSuite_t)

     D mockProcArray   s                   Dim(2) Like(ProcNm_t)
     D mockProcNmList  ds                  LikeDs(ProcNmList_t)

     D pgmStatusDS    sds                  Qualified
     D  lib                          10a   Overlay(pgmStatusDS:81)
     D  pgmNm                        10a   Overlay(pgmStatusDS:334)


      //----------------------------------------------------------------------
      //   Global Variable
      //----------------------------------------------------------------------

     D dummyHandle     s              5a   Inz('dummy')
     D mockProcIdx     s             10i 0
     D mockProcCnt     s             10i 0
       // Expected test procedure.
     D expTestProc     ds                  LikeDs(Proc_t)


      //----------------------------------------------------------------------
      //   Test Definitions
      //----------------------------------------------------------------------

     P setup           b                   Export
     D setup           pi
      /free

        clear expTestProc;

        clear mockProcArray;
        mockProcIdx = 1;
        mockProcCnt = 0;

        mockProcNmList.handle = %addr( dummyHandle );
        mockProcNmList.cnt = %paddr( getMockProcCnt );
        mockProcNmList.getNm = %paddr( getMockProcNm );
        mockProcNmList.goToNext = %paddr( goToNext );

      /end-free
     P                 e


     P testOneProcOneTestCase...
     P                 b                   Export
     D testOneProcOneTestCase...
     D                 pi
      /free

        // Setup.

        mockProcCnt = 1;
        mockProcArray(1) = 'TEST_1';

        // Execution.

        testSuite = getTestSuite( mockProcNmList );

        // Controls.

        iEqual( 1 : testSuite.testCasesCnt );
        aEqual( *blank : testSuite.setUp.procNm );

        expTestProc.procNm = 'TEST_1';
        testProcEqual( expTestProc : testSuite : 1 );

        aEqual( *blank : testSuite.tearDown.procNm );

      /end-free
     P                 e


     P testOneProcNoTestCase...
     P                 b                   Export
     D testOneProcNoTestCase...
     D                 pi
      /free

        mockProcCnt = 1;
        mockProcArray(1) = 'NOT_A_TEST_1';

        testSuite = getTestSuite( mockProcNmList );

        iEqual( 0 : testSuite.testCasesCnt );

      /end-free
     P                 e


     P testTwoProcsTwoTestCases...
     P                 b                   Export
     D testTwoProcsTwoTestCases...
     D                 pi
      /free

        mockProcCnt = 2;
        mockProcArray(1) = 'TEST_1';
        mockProcArray(2) = 'TEST_2';

        testSuite = getTestSuite( mockProcNmList );

        iEqual( 2: testSuite.testCasesCnt );

        expTestProc.procNm = 'TEST_1';
        testProcEqual( expTestProc : testSuite : 1 );

        expTestProc.procNm = 'TEST_2';
        testProcEqual( expTestProc : testSuite : 2 );

      /end-free
     P                 e


     P testSetupProc   b                   Export
     D testSetupProc   pi
      /free

        mockProcCnt = 2;
        mockProcArray(1) = 'SETUP';
        mockProcArray(2) = 'TEST_1';

        testSuite = getTestSuite( mockProcNmList );

        iEqual( 1 : testSuite.testCasesCnt );
        aEqual( 'SETUP' : testSuite.setUp.procNm );

        expTestProc.procNm = 'TEST_1';
        testProcEqual( expTestProc : testSuite : 1 );

      /end-free
     P                 e


     P testTearDownProc...
     P                 b                   Export
     D testTearDownProc...
     D                 pi
      /free

        // Setup.

        mockProcCnt = 2;
        mockProcArray(1) = 'TEARDOWN';
        mockProcArray(2) = 'TEST_1';

        // Execution.

        testSuite = getTestSuite( mockProcNmList );

        // Controls.

        iEqual( 1 : testSuite.testCasesCnt );

        expTestProc.procNm = 'TEST_1';
        testProcEqual( expTestProc : testSuite : 1 );

        aEqual( 'TEARDOWN' : testSuite.tearDown.procNm );

      /end-free
     P                 e


     P testSetupSuite...
     P                 b                   Export
     D testSetupSuite...
     D                 pi
      /free

        // Setup.

        mockProcCnt = 2;
        mockProcArray(1) = 'SETUPSUITE';
        mockProcArray(2) = 'TEST_1';

        // Execution.

        testSuite = getTestSuite( mockProcNmList );

        // Controls.

        iEqual( 1: testSuite.testCasesCnt );
        aEqual( 'SETUPSUITE': testSuite.setupSuite.procNm );
        aEqual( *blank      : testSuite.setup.procNm );

        expTestProc.procNm = 'TEST_1';
        testProcEqual( expTestProc : testSuite : 1 );

      /end-free
     P                 e


     P testTeardownSuite...
     P                 b                   Export
     D testTeardownSuite...
     D                 pi
      /free

        // Setup.

        mockProcCnt = 2;
        mockProcArray(1) = 'TEARDOWNSUITE';
        mockProcArray(2) = 'TEST_1';

        // Execution.

        testSuite = getTestSuite( mockProcNmList );

        // Controls.

        iEqual( 1 : testSuite.testCasesCnt );
        aEqual( *blank          : testSuite.setupSuite.procNm );
        aEqual( *blank          : testSuite.setup.procNm );

        expTestProc.procNm = 'TEST_1';
        testProcEqual( expTestProc : testSuite : 1 );

        aEqual( *blank          : testSuite.teardown.procNm );
        aEqual( 'TEARDOWNSUITE' : testSuite.teardownSuite.procNm );

      /end-free
     P                 e


     P testActivateTestSuite...
     P                 b                   Export
     D testActivateTestSuite...
     D                 pi

     D actMark         s                   Like(ActMark_t)
     D srvPgm          ds                  LikeDs(Object_t)
     D testCase        ds                  Dim(2) LikeDs(Proc_t)

      /free

        // Set up Activation Mark.
        // I use the 'self-shunt' pattern here. The test program tries to activate itself to get its
        // own Activation Mark.

        srvPgm.nm = pgmStatusDS.pgmNm;
        srvPgm.lib = pgmStatusDS.lib;
        actMark = activateSrvPgm( srvPgm );

        // Set up TestSuite.

        testSuite.setUpSuite.procNm = 'ET_SETUPSUITE';
        testSuite.setUp.procNm = 'ET_SETUP';
        testSuite.testCasesCnt = 2;
        testSuite.testList = %addr(testCase);
        testCase(1).procNm = 'ET_TESTPROC_1';
        testCase(2).procNm = 'ET_TESTPROC_2';
        testSuite.tearDown.procNm = 'ET_TEARDOWN';
        testSuite.tearDownSuite.procNm = 'ET_TEARDOWNSUITE';

        // Execution.

        activateTestSuite( testSuite : actMark );

        // Controls.

        assert( testSuite.setUpSuite.procPtr = %paddr( ET_setUpSuite ) :
                'Resolution of ET_setUpSuite failed' );
        assert( testSuite.setUp.procPtr = %paddr( ET_setUp ) :
                'Resolution of ET_setUp failed' );

        expTestProc.procNm = 'ET_TESTPROC_1';
        expTestProc.procPtr = %paddr( ET_testProc_1 );
        testProcEqual( expTestProc : testSuite : 1 );

        expTestProc.procNm = 'ET_TESTPROC_2';
        expTestProc.procPtr = %paddr( ET_testProc_2 );
        testProcEqual( expTestProc : testSuite : 2 );

        assert( testSuite.tearDown.procPtr = %paddr( ET_tearDown ) :
                'Resolution of ET_tearDown failed' );
        assert( testSuite.tearDownSuite.procPtr = %paddr( ET_tearDownSuite ) :
                'Resolution of ET_tearDownSuite failed' );

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Exported Procedure Definitions
      //----------------------------------------------------------------------

     P ET_setUp        b                   Export
     D ET_setUp        pi
     P                 e

     P ET_setUpSuite   b                   Export
     D ET_setUpSuite   pi
     P                 e

     P ET_tearDown     b                   Export
     D ET_tearDown     pi
     P                 e

     P ET_tearDownSuite...
     P                 b                   Export
     D ET_tearDownSuite...
     D                 pi
     P                 e

     P ET_testProc_1   b                   Export
     D ET_testProc_1   pi
     P                 e

     P ET_testProc_2   b                   Export
     D ET_testProc_2   pi
     P                 e


      //----------------------------------------------------------------------
      //   Private Procedure Definitions
      //----------------------------------------------------------------------

       // Mock implementation of mockProcNmList_t.getNm.
     P getMockProcNm   b
     D getMockProcNm   pi                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const
      /free

        assert( 'dummy' = mockProcNmListHandle : 'Wrong ProcNmList handle' );
        return mockProcArray( mockProcIdx );

      /end-free
     P                 e


       // Mock implementation of mockProcNmList_t.goToNext.
     P goToNext        b
     D goToNext        pi
     D  mockProcNmListHandle...
     D                                5a   Const
      /free

        assert( 'dummy' = mockProcNmListHandle : 'Wrong ProcNmList handle' );
        mockProcIdx += 1;

      /end-free
     P                 e


       // Mock implementation of mockProcNmList_t.cnt.
     P getMockProcCnt  b
     D getMockProcCnt  pi            10i 0
     D  mockProcNmListHandle...
     D                                5a   Const
      /free

        assert( 'dummy' = mockProcNmListHandle : 'Wrong ProcNmList handle' );
        return mockProcCnt;

      /end-free
     P                 e


      // High-level assertion.
     PtestProcEqual    b
     DtestProcEqual    pi
       // Expected test procedure.
     D expTestProc                         Const LikeDs(Proc_t)
       // Actual test suite.
     D testSuite                           Const LikeDs(TestSuite_t)
       // Test case index.
     D testIdx                       10i 0 Const

       // Actual test procedure.
     D actTestProc     ds                  LikeDs(Proc_t)

      /free

        actTestProc = getTestProc( testSuite : testIdx );

        aEqual( expTestProc.procNm :  actTestProc.procNm );
        assert( expTestProc.procPtr = actTestProc.procPtr :
                'Wrong test procedure pointer' );

      /end-free
     P                 e


       // Mock implementation of mockProcNmList_t.getNm.
     P return_NOT_A_TEST_1...
     P                 b
     D return_NOT_A_TEST_1...
     D                 pi                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const
      /free

        assert( 'dummy' = mockProcNmListHandle : 'Wrong ProcNmList handle' );
        return 'NOT_A_TEST_1';

      /end-free
     P                 e


       // Mock implementation of mockProcNmList_t.getNm.
     P return_SETUP_then_TEST_1...
     P                 b
     D return_SETUP_then_TEST_1...
     D                 pi                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const
      /free

        assert( 'dummy' = mockProcNmListHandle : 'Wrong ProcNmList handle' );

        select;
          when mockProcIdx = 1;
            return 'SETUP';
          when mockProcIdx = 2;
            return 'TEST_1';
          other;
            fail( 'Unreachable code' );
        endsl;

      /end-free
     P                 e


       // Mock implementation of mockProcNmList_t.getNm.
     P return_TEST_n   b
     D return_TEST_n   pi                  Like(ProcNm_t)
     D  mockProcNmListHandle...
     D                                5a   Const
      /free

        assert( 'dummy' = mockProcNmListHandle : 'Wrong ProcNmList handle' );
        return 'TEST_' + %char( mockProcIdx );

      /end-free
     P                 e

