       //----------------------------------------------------------------------
       // Assertion procedure definitions.
       //----------------------------------------------------------------------

     H NoMain Option(*SrcStmt)


       //----------------------------------------------------------------------
       //   IMPORTS
       //----------------------------------------------------------------------

      /copy RPGUNITY1,ASSERT
      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,QWVRCSTK
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


       //----------------------------------------------------------------------
       //   PRIVATE PROTOTYPES
       //----------------------------------------------------------------------

     D getCallStk      pr                  LikeDs(CallStkEnt_t)
     D                                     Dim(MAX_CALL_STK_SIZE)


       //----------------------------------------------------------------------
       //   CONSTANTS
       //----------------------------------------------------------------------

      // Quote (') symbol.
     D quote           c                   Const('''')


       //----------------------------------------------------------------------
       //   GLOBAL VARIABLES
       //----------------------------------------------------------------------

       // Number of assertions called.
     D assertCalled    s             10i 0

       // Latest assertion failure event information. Can be blank if no
       //  assertion failure event since last assertion.
     D assertFailEvt   ds                  LikeDs(AssertFailEvt_t)


       //----------------------------------------------------------------------
       //   PROCEDURES
       //----------------------------------------------------------------------

     P aEqual          b                   Export
       //----------------------------------------------------------------------
       // Assert equality between two alphanumeric variables.
       //----------------------------------------------------------------------
     D aEqual          pi
     D  expected                  32565a   Const
     D  actual                    32565a   Const

     D msg             s            256a

      /free

        msg = 'Expected ' + quote + %trimr(expected) + quote + ','
            + ' but was ' + quote + %trimr(actual  ) + quote + '.';
        assert( expected = actual : msg);

      /end-free
     P aEqual          e


     P assert          b                   Export
       //----------------------------------------------------------------------
       // Asserts that a condition is true. See prototype.
       //----------------------------------------------------------------------
     D assert          pi
     D  condition                      n   Const
     D  msgIfFalse                  256a   Const
      /free

        assertCalled += 1;
        clrAssertFailEvt();

        if not condition;
          fail( msgIfFalse );
        endif;

      /end-free
     P assert          e


     P clrAssertFailEvt...
     P                 b                   Export
       //----------------------------------------------------------------------
       // Clear the latest assertion failure event.
       //----------------------------------------------------------------------
     D clrAssertFailEvt...
     D                 pi
      /free

        assertFailEvt = *blank;

      /end-free
     P                 e


     P fail            b                   Export
       //----------------------------------------------------------------------
       // Signals a test failure et stops the test.
       //----------------------------------------------------------------------
     D fail            pi
     D  msg                         256a   Const
      /free

        assertFailEvt.msg = msg;
        assertFailEvt.callStkEnt = getCallStk();

        sndEscapeMsg( msg : TWO_CALL_STK_LVL_ABOVE );

      /end-free
     P fail            e


     P getAssertCalled...
     P                 b                   Export
       //----------------------------------------------------------------------
       // Returns the number of time assertions were called. See prototype.
       //----------------------------------------------------------------------
     D getAssertCalled...
     D                 pi            10i 0
      /free

        return assertCalled;

      /end-free
     P getAssertCalled...
     P                 e

     P getAssertFailEvt...
     P                 b                   Export
       //----------------------------------------------------------------------
       // Return information about the latest assertion failure event.
       //----------------------------------------------------------------------
     D getAssertFailEvt...
     D                 pi
     D                                     LikeDs(AssertFailEvt_t)
      /free

        return assertFailEvt;

      /end-free
     P                 e


     P getCallStk      b                   Export
       //----------------------------------------------------------------------
       //
       //----------------------------------------------------------------------
     D getCallStk      pi                  LikeDs(CallStkEnt_t)
     D                                     Dim(MAX_CALL_STK_SIZE)

       // Call stack entries.
     D callStkEnt      ds                  LikeDs(CallStkEnt_t)
     D                                     Dim(MAX_CALL_STK_SIZE)
       // Job id.
     D jobIdInfo       ds                  LikeDs(dsJIDF0100)
       // Call stack info header.
     D hdr             ds                  LikeDs(dsCSTK0100Hdr)
     D                                     Based(hdr_p)
     D hdr_p           s               *
       // Call stack info entry.
     D ent             ds                  LikeDs(dsCSTK0100Ent)
     D                                     Based(ent_p)
     D ent_p           s               *
       // Big buffer to receive call stack info.
     D rawCallStk      s           5000a
       // Statement Id.
     D sttId           s             10a   Based(sttId_p)
     D sttId_p         s               *
       // Procedure name buffer.
     D procNmBuffer_p  s               *
     D procNmBuffer    s            256a   Based(procNmBuffer_p)
       // Index.
     D i               s             10i 0

      /free

        jobIdInfo.jobNm = '*';
        jobIdInfo.usrNm = *blank;
        jobIdInfo.jobNb = *blank;
        jobIdInfo.intJobId = *blank;
        jobIdInfo.reserved = *loval;
        jobIdInfo.threadInd = 1;
        jobIdInfo.threadId  = *loval;

        QWVRCSTK( rawCallStk :
                  %size(rawCallStk) :
                  'CSTK0100' :
                  jobIdInfo :
                  'JIDF0100' :
                  percolateErrors );

        hdr_p = %addr(rawCallStk);
        ent_p = hdr_p + hdr.callStkOff;

        // TODO Refactor the following piece of code.
        // Skip the first call stack entry (this procedure).
        ent_p += ent.len;
        // Skip the next call stack entry (the fail procedure).
        ent_p += ent.len;

        for i = 1 to (hdr.nbCallStkEntRtn - 2);    // TODO : min(header.nbCallStkEntRtn,MAX_CALL_STK

          callStkEnt(i).pgmNm = ent.pgmNm;
          callStkEnt(i).modNm = ent.modNm;

          if ent.procNmLen <> 0;
            procNmBuffer_p = ent_p + ent.dsplToProcNm;
            callStkEnt(i).procNm = %subst( procNmBuffer: 1: ent.procNmLen );
          else;
            callStkEnt(i).procNm = *blank;
          endif;

          if ent.nbSttId > 0;
            sttId_p = ent_p + ent.dsplToSttId;
            callStkEnt(i).specNb = sttId;
          else;
            callStkEnt(i).specNb = *blank;
          endif;

          ent_p += ent.len;

        endfor;

        return callStkEnt;

      /end-free
     P getCallStk      e


     P iEqual          b                   Export
       //----------------------------------------------------------------------
       // Assert equality between two integers.
       //----------------------------------------------------------------------
     D iEqual          pi
     D  expected                     31s 0 Const
     D  actual                       31s 0 Const

     D msg             s            256a

      /free

        msg = 'Expected ' + %char(expected) + ','
            + ' but was ' + %char(actual  ) + '.';

        assert( expected = actual : msg);

      /end-free
     P iEqual          e
