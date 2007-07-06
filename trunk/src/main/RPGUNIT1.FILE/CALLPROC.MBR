      //
      // Dynamically call a procedure in a service program.
      //

     H NoMain Option(*SrcStmt)

      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,CALLPROC
      /copy RPGUNITY1,RUNNER
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,QLEACTBNDP
      /copy RPGUNITY1,QLEGETEXP
      /copy RPGUNITY1,QLICVTTP
      /copy RPGUNITY1,RSLVSP


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

       // Abstract procedure to dynamically call a procedure.
     D callDynProc     pr                  ExtProc(callDynProc_p)


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Current procedure pointer.
     D callDynProc_p   s               *   ProcPtr


      //----------------------------------------------------------------------
      //   Procedure Definitions
      //----------------------------------------------------------------------

     P activateSrvPgm  b                   Export
       //----------------------------------------------------------------------
       // Get activation mark. See prototype.
       //----------------------------------------------------------------------
     D activateSrvPgm  pi            10i 0
     D  srvPgm                             Value LikeDs(Object_t)

       // Activation mark.
     D actMark         s             10i 0 Inz(0)
       // Authority mask.
     D auth            s              2a   Inz(*LoVal)
       // Objet type as hexadecimal value.
     D hexType         s              2a   Inz(*LoVal)
       // System pointer to a service program.
     D srvPgmSP        s               *   ProcPtr

      /free

        if srvPgm.lib = *blank;
          srvPgm.lib = '*LIBL';
        endif;

        // Get object type as hex value.
        QLICVTTP( '*SYMTOHEX' : '*SRVPGM' : hexType : percolateErrors );

        // Retrieve system pointer.
        monitor;
          srvpgmSP = rslvSP( hexType:
                             srvPgm.nm:
                             srvPgm.lib:
                             auth );
        on-error;
          raiseRUError( 'Failed to retrieve system pointer for '
                            + %trimr(srvPgm.nm)
                            + '.' );
        endmon;

        // Activate service program.
        actMark = QleActBndPgm( srvpgmSP : *omit : *omit : *omit : *omit );

        return actMark;

      /end-free
     P                 e


     P callProcByPtr   b                   Export
     D callProcByPtr   pi
     D  procPtr                        *   Const ProcPtr
      /free

        if procPtr <> *null;
          callDynProc_p = procPtr;
          callDynProc();
        endif;

      /end-free
     P                 e


     P rslvProc        b                   Export
     D rslvProc        pi
     D  proc                               LikeDs(Proc_t)
     D  actMark                            Const Like(ActMark_t)

       // Type of export in a service program.
     D exportType      s             10i 0 Inz(0)
       // One export type is PROCEDURE.
     D PROCEDURE       c                   Const(1)
      /free

        // Get export.
        QleGetExp( actMark :
                   0 :
                   %len(%trimr(proc.procNm)) :
                   %trimr(proc.procNm) :
                   proc.procPtr :
                   exportType :
                   percolateErrors );

        if exportType <> PROCEDURE;
          proc.procPtr = *null;
        endif;

      /end-free
     P                 e

