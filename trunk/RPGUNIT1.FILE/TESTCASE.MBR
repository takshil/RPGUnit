       // Assertion procedure prototypes.

       // aEqual -- Aphanumeric Equality Assertion
       // Assert that two alphanumeric variables are equal.
       //
       // Example:
       //   aEqual( 'John Smith' : name );

     D aEqual          pr                  ExtProc('aEqual')
     D  expected                  32565a   Const
     D  actual                    32565a   Const


       // assert -- General Purpose Assertion
       // Assert that a condition is true. If not, a failure message percolates.
       //
       // Examples:
       //   assert( newTime > oldTime : 'newTime is not larger than oldTime' );
       //   assert( %not eof : 'Missing record in file XXX' );

     D assert          pr                  ExtProc('assert')
     D  condition                      n   Const
     D  msgIfFalse                  256a   Const


       // fail -- Fail Primitive
       // Percolate an RPGUnit failure message.
       //
       // Example:
       //   monitor;
       //     call PGM();
       //     fail( 'PGM should have thrown an exception' );
       //   on-error;
       //     // Exception seen. Success.
       //   endmon;

     D fail            pr                  ExtProc('fail')
     D  msg                         256a   Const


       // iEqual -- Integer Equality Assertion
       //
       // Assert that two integer variables are equal.
       // Example:
       //   iEqual( 1000 : balance );

     D iEqual          pr                  ExtProc('iEqual')
     D  expected                     31s 0 Const
     D  actual                       31s 0 Const


       // Setup utility procedure prototypes.

       // clrpfm -- Clear Physical File
       // Clear the content of a physical file in *CURLIB.

     D clrpfm          pr
        // A file name.
     D  w1fileNm                     10a   Const
        // An (optional) member name.
     D  w1mbrNm                      10a   Const Options(*NoPass)


       // rclactgrp -- Reclaim Activation Group
       //
       // Example:
       //   rclactgrp( '*ELIGIBLE' );

     D rclactgrp       pr
     D  w1actGrpNm                   10a   Const


       // runCmd -- Run CL Command
       //
       // Example:
       //   runCmd( 'ALCOBJ OBJ((*CURLIB/FILE *FILE *EXCL))' );

     D runCmd          pr                  ExtProc('runCmd')
     D  w1cmd                     32702a   Const Varying

