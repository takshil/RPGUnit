      //
      // Prototype for QleActBndPgm API.
      //
      // "Activate Bound Program".
      //
      // http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/apis/qleactbp.htm
      //

      // (RETURN) Activation mark.
     DQleActBndPgm     pr            10i 0 ExtProc('QleActBndPgm')
       // (INPUT) Pointer to bound program.
     D srvPgm_p                        *   Const ProcPtr
       // (OUTPUT) Activation mark.
     D actMark                       10i 0 Options(*Omit)
       // (OUTPUT) Activation information.
     D actInfo                       64a   Options(*Omit)
       // (INPUT) Length of activation information.
     D actInfoLen                    10i 0 Const Options(*Omit)
       // (I/O) Error code.
     D errors                     32767a   Options(*VarSize: *Omit) NoOpt

