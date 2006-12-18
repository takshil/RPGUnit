      //
      // Prototypes for CALLPROC.
      //

       // Activate a service program and returns the activation mark.
     D activateSrvPgm  pr            10i 0 ExtProc('activateSrvPgm')
     D  srvPgm                             Value LikeDs(Object_t)

       // Calls a procedure, using its associated pointer.
     D callProcByPtr   pr                  ExtProc('callProcByPtr')
     D  procPtr                        *   Const ProcPtr

       // Resolve a procedure.
       // Fill the procedure pointer, given its name and activation marker.
     D rslvProc        pr                  ExtProc('rslvProc')
     D  proc                               LikeDs(Proc_t)
     D  actMark                            Const Like(ActMark_t)

