      //
      // Extracts tests.
      //

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,EXTTST
      /copy RPGUNITY1,RUNNER


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CALLPROC
      /copy RPGUNITY1,EXTPRC
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D cnt             pr            10i 0 ExtProc(cnt_p)
     D  procNmListHandle...
     D                                 *   Const

     D getNm           pr                  Like(ProcNm_t) ExtProc(getNm_p)
     D  procNmListHandle...
     D                                 *   Const

     D getTestCasePtr  pr              *
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const

     D goToNext        pr                  ExtProc(goToNext_p)
     D  procNmListHandle...
     D                                 *   Const

     D hasSameBeginning...
     D                 pr              n
     D  longString                         Const Like(ProcNm_t)
     D  shortString                        Const Like(ProcNm_t)

     D isTest          pr              n
     D  nm                                 Const Like(ProcNm_t)


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Procedure pointers for ProcNmList_t.
     D cnt_p           s               *   ProcPtr
     D getNm_p         s               *   ProcPtr
     D goToNext_p      s               *   ProcPtr


      //----------------------------------------------------------------------
      //   Procedure Definitions
      //----------------------------------------------------------------------

     P activateTestSuite...
     P                 b                   Export
     D activateTestSuite...
     D                 pi
     D  testSuite                          LikeDs(TestSuite_t)
     D  actMark                            Const Like(ActMark_t)

     D testCase        ds                  LikeDs(Proc_t) Based(testCase_p)
     D testCase_p      s               *
     D testIdx         s             10i 0

      /free

        rslvProc( testSuite.setUpSuite : actMark );
        rslvProc( testSuite.setUp      : actMark );

        for testIdx = 1 to testSuite.testCasesCnt;
          testCase_p = getTestCasePtr( testSuite : testIdx );
          rslvProc( testCase : actMark );
        endfor;

        rslvProc( testSuite.tearDown      : actMark );
        rslvProc( testSuite.tearDownSuite : actMark );

      /end-free
     P                 e


     P getTestCasePtr  b
     D getTestCasePtr  pi              *
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const
      /free

        return testSuite.testList + %size( Proc_t ) * ( testIdx - 1 );

      /end-free
     P                 e


     P getTestNm       b                   Export
     D getTestNm       pi                  Like(ProcNm_t)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const

     D testProc        ds                  LikeDs(Proc_t)

      /free

        testProc = getTestProc( testSuite : testIdx );
        return testProc.procNm;

      /end-free
     P                 e


     P getTestProc     b                   Export
     D getTestProc     pi                  LikeDs(Proc_t)
     D  testSuite                          Const LikeDs(TestSuite_t)
     D  testIdx                      10i 0 Const

     D testCase        ds                  LikeDs(Proc_t) Based(testCase_p)
     D testCase_p      s               *

      /free

        testCase_p = getTestCasePtr( testSuite : testIdx );
        return testCase;

      /end-free
     P                 e


     P getTestSuite    b                   Export
     D getTestSuite    pi                  LikeDs(TestSuite_t)
     D  procNmList                         Const LikeDs(ProcNmList_t)

     D testSuite       ds                  LikeDs(TestSuite_t)
     D testCase        ds                  LikeDs(Proc_t)
     D                                     Based(testCase_p)
     D testCase_p      s               *

     D privateData     s               *   Based(procNmList.handle)
     D procCnt         s             10i 0
     D procIdx         s             10i 0
     D procNm          s                   Like(ProcNm_t)

      /free

        cnt_p      = procNmList.cnt;
        getNm_p    = procNmList.getNm;
        goToNext_p = procNmList.goToNext;

        procCnt = cnt( privateData );

        clear testSuite;
        testSuite.testList = %alloc( procCnt * %size( Proc_t ) );

        for procIdx = 1 to procCnt;
          procNm = getNm( privateData );
          select;
            when isTest( procNm );
              testSuite.testCasesCnt += 1;
              testCase_p = getTestCasePtr( testSuite :
                                           testSuite.testCasesCnt );
              testCase.procNm = procNm;
            when procNm = 'SETUPSUITE';
              testSuite.setUpSuite.procNm = procNm;
            when procNm = 'SETUP';
              testSuite.setUp.procNm = procNm;
            when procNm = 'TEARDOWN';
              testSuite.tearDown.procNm = procNm;
            when procNm = 'TEARDOWNSUITE';
              testSuite.tearDownSuite.procNm = procNm;
          endsl;
          goToNext( privateData );
        endfor;

        return testSuite;

      /end-free
     P                 e


     P isTest          b
     D isTest          pi              n
     D  nm                                 Const Like(ProcNm_t)

     D testPrefix      c                   Const('TEST')
     D nmPrefix        s                   Like(ProcNm_t)

      /free

        return hasSameBeginning( nm: testPrefix );

      /end-free
     P isTest          e


     P hasSameBeginning...
     P                 b
     D hasSameBeginning...
     D                 pi              n
     D  longString                         Const Like(ProcNm_t)
     D  shortString                        Const Like(ProcNm_t)

     D longStringBeginning...
     D                 s                   Like(ProcNm_t)
     D shortStringLen  s             10i 0

      /free

        shortStringLen = %len(%trimr(shortString));
        longStringBeginning = %subst( longString: 1: shortStringLen );
        return ( longStringBeginning = shortString );

      /end-free
     P hasSameBeginning...
     P                 e

