       //----------------------------------------------------------------------
       // Setup Utility Procedures Definitions.
       //----------------------------------------------------------------------

     H NoMain Option(*SrcStmt)


       //----------------------------------------------------------------------
       //   IMPORTS
       //----------------------------------------------------------------------

      /copy RPGUNITY1,QCMDEXC
      /copy RPGUNIT1,TESTCASE


       //----------------------------------------------------------------------
       //   CONSTANTS
       //----------------------------------------------------------------------

       //----------------------------------------------------------------------
       //   GLOBAL VARIABLES
       //----------------------------------------------------------------------

       //----------------------------------------------------------------------
       //   PROCEDURES
       //----------------------------------------------------------------------

       //--------------------------------------------------------------------
       //        Clear File
       //--------------------------------------------------------------------
     P clrpfm          b                   Export

     D clrpfm          pi
     D  w1fileNm                     10a   Const
     D  w1mbrNm                      10a   Const Options(*NoPass)

     D w1cmd           s          32702a   Varying

      /free

        if %parms = 1;
          runCmd( 'CLRPFM FILE(*CURLIB/' + %trim(w1fileNm) + ')' );
        else;
          runCmd( 'CLRPFM FILE(*CURLIB/' + %trim(w1fileNm) + ')'
                + ' MBR(' + %trim(w1mbrNm) + ')' );
        endif;

      /end-free
     P clrpfm          e


       //--------------------------------------------------------------------
       //        Reclaim Activation Group
       //--------------------------------------------------------------------
     P rclactgrp       b                   Export
     D rclactgrp       pi
     D  w1actGrpNm                   10a   Const

     D w1cmd           s          32702a   Varying

      /free

        runCmd( 'RCLACTGRP ' + %trim(w1actGrpNm) );

      /end-free
     P rclactgrp       e


       //--------------------------------------------------------------------
       //        Run Command
       //--------------------------------------------------------------------
     P runCmd          b                   Export
     D runCmd          pi
     D  w1cmd                     32702a   Const Varying
      /free

        qcmdexc( w1cmd : %len(w1cmd) );

      /end-free
     P runCmd          e

