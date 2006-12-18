      //
      // Prototypes for EXTPRC.
      //

       // Count the number of procedures in a ProcList.
     D cntProc         pr            10i 0 ExtProc('cntProc')
     D  procList                           Const LikeDs(ProcList_t)

     D loadProcList    pr                  LikeDs(ProcList_t)
     D                                     ExtProc('loadProcList')
     D  srvPgm                             Const LikeDs(Object_t)

       // Adapt a ProcList (i.e., a list of procedures in a user space) to the ProcNmList interface.
       // It is just an adapter. The underlying data is not copied.
     D getProcNmList   pr                  LikeDs(ProcNmList_t)
     D                                     ExtProc('getProcNmList')
     D  procList                           LikeDs(ProcList_t)

     D getProcNm       pr                  Like(ProcNm_t)
     D                                     ExtProc('getProcNm')
     D  procList                           Const LikeDs(ProcList_t)

     D goToNextProc    pr                  ExtProc('goToNextProc')
        // [Update] Procedure list.
     D  procList                           LikeDs(ProcList_t)


       //----------------------------------------------------------------------
       //   Templates
       //----------------------------------------------------------------------

     D ProcList_t      ds                  Qualified Based(template)
     D  hdr                            *
     D  current                        *

