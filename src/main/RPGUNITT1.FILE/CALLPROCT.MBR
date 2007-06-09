      //
      // Unit tests for CALLPROC.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     DtestCallProcByPtr...
     D                 pr
     DtestCallProcByPtr_NullPtr...
     D                 pr


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CALLPROC
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D mockProc        pr


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

     D mockProcWasCalled...
     D                 s               n


      //----------------------------------------------------------------------
      //   Test Procedures
      //----------------------------------------------------------------------

     PtestCallProcByPtr...
     P                 b                   Export
     DtestCallProcByPtr...
     D                 pi
      /free

        mockProcWasCalled = *off;

        callProcByPtr( %paddr( mockProc ) );

        assert( mockProcWasCalled : 'mockProc not called' );

      /end-free
     P                 e


     PtestCallProcByPtr_NullPtr...
     P                 b                   Export
     DtestCallProcByPtr_NullPtr...
     D                 pi
      /free

        monitor;
          callProcByPtr( *null );
        on-error;
          fail( 'callProcByPtr(*null) should not raise an error' );
        endmon;

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     P mockProc        b
     D mockProc        pi
      /free

        mockProcWasCalled = *on;

      /end-free
     P                 e

