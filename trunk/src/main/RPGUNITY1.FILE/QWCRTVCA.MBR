
      // Prototype for API QWCRTVCA (Retrieve Current Attributes).

     DQWCRTVCA         pr                  ExtPgm('QWCRTVCA')
     D rawAttribs                 32766a   Options(*VarSize)
     D rawAttribsLen                 10i 0 Const
     D fmtNm                          8a   Const
     D attribCnt                     10i 0 Const
     D attribKeys                    10i 0 Const Dim(255) Options(*VarSize)
     D errors                     32766a   Options(*VarSize) NoOpt

     D dsRTVC0100      ds                  Qualified Based(template)
        // Job attribute entry count.
     D  attribCnt                    10i 0
        // Job attribute entries.
     D  attribEnts                32766a

       // Job attribute entry.
     D dsRTVC0100Ent   ds                   Qualified Based(template)
     D  len                          10i 0
     D  key                          10i 0
     D  dataType                      1a
     D                                3a
     D  dataLen                      10i 0
     D  data                      32766a

       // Attribute Keys:
       // - Current User Profile
     D CUR_USR_NM      c                   CONST(0305)
       // - Output Queue Name
     D OUTQ_NM         c                   Const(1501)
