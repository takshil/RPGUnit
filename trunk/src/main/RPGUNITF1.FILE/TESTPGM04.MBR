
     h NoMain Option(*SrcStmt: *NoDebugIo)

      /copy RPGUNIT1,TESTCASE

     Dtest1            pr
     Dtest2            pr
     Dnot_a_test       pr

     Ptest1            b                   Export
     Dtest1            pi
     Ptest1            e

     Ptest2            b                   Export
     Dtest2            pi
     Ptest2            e

     Pnot_a_test       b                   Export
     Dnot_a_test       pi
      /free

        fail('not_a_test should not be called.');

      /end-free
     Pnot_a_test       e

