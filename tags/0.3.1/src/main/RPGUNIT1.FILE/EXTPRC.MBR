      //
      // Extract exported procedures from a service program.
      //

     H NoMain Option(*SrcStmt)


       //----------------------------------------------------------------------
       //   Public Procedure Prototypes
       //----------------------------------------------------------------------

      /copy RPGUNITY1,EXTPRC
      /copy RPGUNITY1,TEMPLATES


       //----------------------------------------------------------------------
       //   Private Procedure Prototypes
       //----------------------------------------------------------------------

       // Retrieve Procedure Info.
       // Stores procedure info in a user space.
     D rtvProcInfo     pr
        // Service program to analyze.
     D  srvPgm                             Value LikeDs(Object_t)
        // Qualified user space name.
     D  usrSpc                             Const LikeDs(Object_t)


       //----------------------------------------------------------------------
       //   Imported Procedures
       //----------------------------------------------------------------------

      /copy RPGUNITY1,APILIST
      /copy RPGUNITY1,QBNLSPGM
      /copy RPGUNITY1,USRSPC


       //----------------------------------------------------------------------
       //   Global DS
       //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE


       //----------------------------------------------------------------------
       //   Procedures Definition
       //----------------------------------------------------------------------

     P cntProc         b                   Export
       //----------------------------------------------------------------------
       // Counts the number of procedure in the liste. See prototype.
       //----------------------------------------------------------------------
     D cntProc         pi            10i 0
     D  procList                           Const LikeDs(ProcList_t)

       // Procedure list header.
     D procListHdr     ds                  LikeDs(ListHdr_t)
     D                                     Based(procList.hdr)

      /free

        return procListHdr.entCnt;

      /end-free
     P cntProc         e


     P loadProcList    b                   Export
       //----------------------------------------------------------------------
       // Returns a list of the procedures. See prototype.
       //----------------------------------------------------------------------
     D loadProcList    pi                  LikeDs(ProcList_t)
     D  srvPgm                             Const LikeDs(Object_t)

       // List header structure.
     D listHdr         ds                  LikeDs(ListHdr_t)
     D                                     Based(procList.hdr)
       // Extracted procedure list.
     D procList        ds                  LikeDs(ProcList_t)
       // Qualified name of the user space that stores the proc info.
     D usrSpc          ds                  LikeDs(Object_t)

      /free

        usrSpc.nm  = 'RUPROCLIST';
        usrSpc.lib = 'QTEMP';

        procList.hdr = crtUsrSpc( usrSpc: 'RPGUnit - Procedure list.');
        rtvProcInfo( srvPgm: usrSpc );

        procList.current = procList.hdr + listHdr.listOff;

        return procList;

      /end-free
     P                 e


     P getProcNmList   b                   Export
       //----------------------------------------------------------------------
       // Adapts a ProcList_t interface into a ProcNmList_t. See prototype.
       //----------------------------------------------------------------------
     D getProcNmList   pi                  LikeDs(ProcNmList_t)
     D  procList                           LikeDs(ProcList_t)

     D procNmList      ds                  LikeDs(ProcNmList_t)

      /free

        procNmList.handle   = %addr( procList );
        procNmList.cnt      = %paddr( cntProc );
        procNmList.getNm    = %paddr( getProcNm );
        procNmList.goToNext = %paddr( goToNextProc );

        return procNmList;

      /end-free
     P                 e


     P getProcNm       b                   Export
       //----------------------------------------------------------------------
       // Returns the current procedure name. See prototype.
       //----------------------------------------------------------------------
     D getProcNm       pi                  Like(ProcNm_t)
     D  procList                           Const LikeDs(ProcList_t)

       // Procedure description.
     D procDesc        ds                  LikeDs(dsSPGL0610)
     D                                     Based(procList.current)
       // A buffer and its pointer to access the procedure name.
     D procNmBuffer    s            256a   Based(procNm_p)
     D procNm_p        s               *
       // The procedure name, to be returned.
     D procNm          s                   Like(ProcNm_t)

      /free

        procNm_p = procList.hdr + procDesc.procNmOff;
        procNm = %subst(procNmBuffer: 1: procDesc.procNmSize);

        return procNm;

      /end-free
     P getProcNm       e


     P goToNextProc    b                   Export
       //----------------------------------------------------------------------
       // Go to the next procedure info entry. See prototype.
       //----------------------------------------------------------------------
     D goToNextProc    pi
     D  procList                            LikeDs(ProcList_t)

     D procDesc        ds                  LikeDs(dsSPGL0610)
     D                                     Based(procList.current)

      /free

        procList.current += procDesc.size;

      /end-free
     P goToNextProc    e


     P rtvProcInfo     b
       //----------------------------------------------------------------------
       // Stores procedure info in a user space. See prototype.
       //----------------------------------------------------------------------
     D rtvProcInfo     pi
     D  srvPgm                             Value LikeDs(Object_t)
     D  usrSpc                             Const LikeDs(Object_t)

      /free

        if srvPgm.lib = *blank;
          srvPgm.lib = '*LIBL';
        endif;

        QBNLSPGM( usrSpc :
                  'SPGL0610' :
                  srvPgm :
                  percolateErrors );

      /end-free
     P rtvProcInfo     e
