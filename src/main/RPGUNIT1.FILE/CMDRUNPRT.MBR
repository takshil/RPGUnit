      //
      // Command Line Runner Printing Facilities.
      //
      // Design choice: this program should not contain any logic, because it is not tested.
      //

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Files
      //----------------------------------------------------------------------

     FQSYSPRT   o    f   80        printer OFLIND(*INOF) UsrOpn


      //----------------------------------------------------------------------
      //   Exports
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CMDRUNPRT
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Imports
      //----------------------------------------------------------------------

      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Line for printing in log.
     D logLine         s             80a

     OQSYSPRT   e            ExcpLine    1
     O                       logLine             80


      //----------------------------------------------------------------------
      //   Procedures
      //----------------------------------------------------------------------

     P clsPrt          b                   Export
       //----------------------------------------------------------------------
       // Close the printer file. See prototype.
       //----------------------------------------------------------------------
     D clsPrt          pi
      /free

        close QSYSPRT;
        runCmd( 'DLTOVR FILE(QSYSPRT)' );

      /end-free
     P                 e


     P getPrtWidth     b                   Export
     D getPrtWidth     pi            10i 0
      /free

        return %len( logLine );

      /end-free
     P                 e


     P opnPrt          b                   Export
     D opnPrt          pi
     D  testPgmNm                          Const Like(Object_t.nm)
      /free

        runCmd( 'OVRPRTF FILE(QSYSPRT) '
             + 'USRDTA(' + testPgmNm + ') '
             + 'SPLFNAME(RPGUNIT)' );
        open QSYSPRT;

      /end-free
     P opnPrt          e


     P prtLine         b                   Export
       //----------------------------------------------------------------------
       // Print a line. See prototype.
       //----------------------------------------------------------------------
     D prtLine         pi
     D  line                         80a   Const
      /free

        logLine = line;
        except ExcpLine;

      /end-free
     P                 e


