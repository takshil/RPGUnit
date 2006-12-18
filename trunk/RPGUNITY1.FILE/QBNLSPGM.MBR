
       // List ILE service program information API
     D QBNLSPGM        pr                  ExtPgm('QBNLSPGM')
     D   usrSpc                      20a   Const
     D   fmt                          8a   Const
     D   srvPgm                      20a   Const
     D   errors                   32766a   Options(*VarSize) NoOpt

       // Structure of an entry in a QBNLSPGM list.
     D dsSPGL0610      ds                  Qualified Based(template)
        // Size of this entry. Each entry has a different size.
     D  size                         10i 0
     D  srvPgm                       20a
     D  ccsid                        10i 0
        // Memory offset to reach the procedure name.
     D  procNmOff                    10i 0
        // Longueur du nom de la procedure.
     D  procNmSize                   10i 0

