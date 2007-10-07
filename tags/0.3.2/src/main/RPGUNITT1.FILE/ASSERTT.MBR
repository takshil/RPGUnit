      //
      // Unit tests for ASSERT.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     D testFailShouldRiseAboveAnEnclosingMonitorBlock...
     D                 pr
     D testHelloEqualsHello...
     D                 pr
     D testGoodByeIsNotHello...
     D                 pr
     D testTwoAndTwoEqualsFour...
     D                 pr
     D testTwoAndTwoIsNotEqualToFive...
     D                 pr
     D testAssertCount...
     D                 pr
     D testAssertWithFailure...
     D                 pr
     D testAssertWithSuccess...
     D                 pr
     D testBigIntegerEquality...
     D                 pr


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,ASSERT
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D callFailInAMonitorBlock...
     D                 pr              n


      //----------------------------------------------------------------------
      //   Test Procedures
      //----------------------------------------------------------------------

     P testFailShouldRiseAboveAnEnclosingMonitorBlock...
     P                 b                   Export
     D testFailShouldRiseAboveAnEnclosingMonitorBlock...
     D                 pi

     D excpWasCaught   s               n   Inz(*off)
     D success         s               n   Inz(*off)

      /free

        monitor;
          excpWasCaught = callFailInAMonitorBlock();
        on-error;
          success = *on;
        endmon;

        select;
          when success;
            // Success.
          when excpWasCaught;
            fail( 'The failure exception'
                + ' should not be caught by the monitor block' );
          other;
            fail( 'fail() should have raised an exception' );
        endsl;

      /end-free
     P testFailShouldRiseAboveAnEnclosingMonitorBlock...
     P                 e


     PtestTwoAndTwoEqualsFour...
     P                 b                   Export
     DtestTwoAndTwoEqualsFour...
     D                 pi
      /free

        // Execution.

        iEqual(4: 2 + 2);

        // Controls.

        // No exception message => OK.

        aEqual( *blank : getAssertFailEvt() );

      /end-free
     P                 e


     PtestTwoAndTwoIsNotEqualToFive...
     P                 b                   Export
     DtestTwoAndTwoIsNotEqualToFive...
     D                 pi

     D excpWasSeen     s               n
     D assertFailEvt   ds                  LikeDs(AssertFailEvt_t)

      /free

        // Execution.

        monitor;
          iEqual(5: 2 + 2);
          excpWasSeen = *off;

        on-error;
          excpWasSeen = *on;
        endmon;

        // Controls.

        assertFailEvt = getAssertFailEvt();

        assert( excpWasSeen :
                'iEqual(5: 2 + 2) should have raised an error message.' );

        aEqual( 'Expected 5, but was 4.' : assertFailEvt.msg );

        // TODO Simplify all these tests about the stack trace by testing getCallStack independently

        aEqual( 'RUTESTCASE' : assertFailEvt.callStkEnt(1).pgmNm );
        aEqual( 'ASSERT'     : assertFailEvt.callStkEnt(1).modNm );
        aEqual( 'assert'     : assertFailEvt.callStkEnt(1).procNm );
        aEqual( '0000008500' : assertFailEvt.callStkEnt(1).specNb );

        aEqual( 'RUTESTCASE' : assertFailEvt.callStkEnt(2).pgmNm );
        aEqual( 'ASSERT'     : assertFailEvt.callStkEnt(2).modNm );
        aEqual( 'iEqual'     : assertFailEvt.callStkEnt(2).procNm );

        aEqual( 'ASSERTT'    : assertFailEvt.callStkEnt(3).pgmNm );
        aEqual( 'ASSERTT'    : assertFailEvt.callStkEnt(3).modNm );
        aEqual( 'TESTTWOANDTWOISNOTEQUALTOFIVE' :
                               assertFailEvt.callStkEnt(3).procNm );

      /end-free
     P                 e


     PtestHelloEqualsHello...
     P                 b                   Export
     DtestHelloEqualsHello...
     D                 pi
      /free

        // Execution.

        aEqual( 'Hello' : 'Hello' );

        // Control.

        // No exception message => OK.

        aEqual( *blank : getAssertFailEvt() );

      /end-free
     P                 e


     PtestGoodByeIsNotHello...
     P                 b                   Export
     DtestGoodByeIsNotHello...
     D                 pi

     D excpWasSeen     s               n
     D assertFailEvt   ds                  LikeDs(AssertFailEvt_t)

      /free

        // Execution.

        monitor;
          aEqual( 'Hello' : 'Good bye' );
          excpWasSeen = *off;

        on-error;
          excpWasSeen = *on;
        endmon;

        // Controls.

        assertFailEvt = getAssertFailEvt();

        assert( excpWasSeen :
                'aEqual( Hello : Good bye )'
              + ' should have raised an error message.' );

        aEqual( 'Expected ''Hello'', but was ''Good bye''.' :
                assertFailEvt.msg );

        aEqual( 'RUTESTCASE' : assertFailEvt.callStkEnt(1).pgmNm );
        aEqual( 'ASSERT'     : assertFailEvt.callStkEnt(1).modNm );
        aEqual( 'assert'     : assertFailEvt.callStkEnt(1).procNm );

        aEqual( 'RUTESTCASE' : assertFailEvt.callStkEnt(2).pgmNm );
        aEqual( 'ASSERT'     : assertFailEvt.callStkEnt(2).modNm );
        aEqual( 'aEqual'     : assertFailEvt.callStkEnt(2).procNm );

        aEqual( 'ASSERTT'    : assertFailEvt.callStkEnt(3).pgmNm );
        aEqual( 'ASSERTT'    : assertFailEvt.callStkEnt(3).modNm );
        aEqual( 'TESTGOODBYEISNOTHELLO' :
                               assertFailEvt.callStkEnt(3).procNm );

      /end-free
     P                 e


     PtestAssertCount...
     P                 b                   Export
     DtestAssertCount...
     D                 pi

     D assertCallCntAtBeg...
     D                 s             10i 0
     D assertCallCnt   s             10i 0 Dim(4)
      /free

        // Setup.

        assertCallCntAtBeg = getAssertCalled();

        // Execution.

        assert( *on: *blank );
        assertCallCnt(1) = getAssertCalled();

        iEqual( 4: 2+2 );
        assertCallCnt(2) = getAssertCalled();

        aEqual( 'Hello': 'Hello' );
        assertCallCnt(3) = getAssertCalled();

        callp(e) assert( *off : *blank );
        assertCallCnt(4) = getAssertCalled();

        // Controls.

        iEqual( assertCallCntAtBeg + 1 : assertCallCnt(1) );
        iEqual( assertCallCntAtBeg + 2 : assertCallCnt(2) );
        iEqual( assertCallCntAtBeg + 3 : assertCallCnt(3) );
        iEqual( assertCallCntAtBeg + 4 : assertCallCnt(4) );

      /end-free
     P                 e


     PtestAssertWithSuccess...
     P                 b                   Export
     DtestAssertWithSuccess...
     D                 pi
      /free

        // Execution.

        assert( *on : 'Should not raise an error' );

        // Controls.

        // No exception message => OK.

        aEqual( *blank : getAssertFailEvt() );

      /end-free
     P                 e


     PtestAssertWithFailure...
     P                 b                   Export
     DtestAssertWithFailure...
     D                 pi

     D assertFailEvt   ds                  LikeDs(AssertFailEvt_t)

      /free

        // Execution.

        monitor;
          assert( *off : 'Failure message.' );
          fail( 'assert( *off : ...) should have raised an error.' );

        on-error;
          // Success. Failure exception was seen.
        endmon;

        // Controls.

        assertFailEvt = getAssertFailEvt();

        aEqual( 'Failure message.' : assertFailEvt.msg );

        aEqual( 'RUTESTCASE' : assertFailEvt.callStkEnt(1).pgmNm );
        aEqual( 'ASSERT'     : assertFailEvt.callStkEnt(1).modNm );
        aEqual( 'assert'     : assertFailEvt.callStkEnt(1).procNm );
        aEqual( '0000008500' : assertFailEvt.callStkEnt(1).specNb );

        aEqual( 'ASSERTT'    : assertFailEvt.callStkEnt(2).pgmNm );
        aEqual( 'ASSERTT'    : assertFailEvt.callStkEnt(2).modNm );
        aEqual( 'TESTASSERTWITHFAILURE'
                             : assertFailEvt.callStkEnt(2).procNm );

      /end-free
     P                 e


     PtestBigIntegerEquality...
     P                 b                   Export
     DtestBigIntegerEquality...
     D                 pi
      /free

             // 0000000001111111111222222222233
             // 1234567890123456789012345678901
        iEqual( 9999999999999999999999999999999 :
                9999999999999999999999999999999 );

        // Control.

        // No exception message => OK.

        aEqual( *blank : getAssertFailEvt() );

      /end-free
     P                 e

      //----------------------------------------------------------------------
      //   Helper Procedures
      //----------------------------------------------------------------------

     P callFailInAMonitorBlock...
     P                 b
     D callFailInAMonitorBlock...
     D                 pi              n
      /free

          monitor;
            fail( 'Failure message' );
            return *off;
          on-error;
            return *on;
          endmon;

      /end-free
     P                 e
