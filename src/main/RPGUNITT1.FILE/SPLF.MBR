      //
      // Spool file test helper.
      //

     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,SPLF


      //----------------------------------------------------------------------
      //   Private Procedures
      //----------------------------------------------------------------------

     D bufEqual        pr              *
     D  expBuf                      256a   Const Varying
     D  actBuf_p                       *   Const

     D findInSpool     pr              *
     D  charToFind                    1a   Const
     D  startPos                       *   Const
     D  endPos                         *   Const

     D rtvJobUsrNm     pr                  Like(UsrNm_t)

     D rtvLatestSplf   pr                  LikeDs(SplfId_t)
     D  usrNm                              Const Like(UsrNm_t)
     D  usrData                      10a   Const

     D rtvSplfHdl      pr            10i 0
     D  splfNm                       10a   Const
     D  usrData                      10a   Const


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,QGYCLST
      /copy RPGUNITY1,QGYGTLE
      /copy RPGUNITY1,QGYOLSPL
      /copy RPGUNITY1,OPNLIST
      /copy RPGUNITY1,QSPCLOSP
      /copy RPGUNITY1,QSPGETSP
      /copy RPGUNITY1,QSPOPNSP
      /copy RPGUNITY1,QWCRTVCA
      /copy RPGUNITY1,TEMPLATES
      /copy RPGUNITY1,USRSPC
      /copy RPGUNIT1,TESTCASE


      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

       // SNA Character String (in spool files).
       // - New Line
     D NL              c                   Const(x'15')


      //----------------------------------------------------------------------
      //   Templates
      //----------------------------------------------------------------------

     D SplfId_t        ds                  Qualified Based(template)
     D  qlfJobNm                           LikeDs(QlfJobNm_t)
     D  nm                           10a
     D  nb                           10i 0


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // Spool file.
     D splf            ds                  Qualified
         // - Handle
     D   hdl                         10i 0
         // - Print Data User Space Current Position Pointer
     D   bufPos_p                      *
         // - Print Data User Space End Pointer
     D   usrSpcEnd_p                   *


      //----------------------------------------------------------------------
      //   Procedure Definition
      //----------------------------------------------------------------------

     PbufEqual         b
     DbufEqual         pi              *
     D expBuf                       256a   Const Varying
     D actBuf_p                        *   Const

       // Actual buffer contents.
     D actBuf          s            256a   Based(actBuf_p)

      /free

        aEqual( expBuf :
                %subst( actBuf : 1 : %len(expBuf) ) );

        return actBuf_p + %len(expBuf);

      /end-free
     P                 e


     PcloSplf          b                   Export
     DcloSplf          pi
      /free

        QSPCLOSP( splf.hdl : percolateErrors );
        clear splf;

      /end-free
     P                 e


     PfindInSpool      b
     DfindInSpool      pi              *
     D charToFind                     1a   Const
     D startPos                        *   Const
     D endPos                          *   Const

       // Character at current position.
     D currentChar_p   s               *
     D currentChar     s              1a   Based(currentChar_p)

      /free

        currentChar_p = startPos;

        dow currentChar_p <= endPos;
          if currentChar = charToFind;
            return currentChar_p;
          endif;
          currentChar_p += 1;
        enddo;

        fail( 'Character "' + charToFind + '" not found in buffer' );

      /end-free
     P                 e


     P opnSplf         b                   Export
     D opnSplf         pi
     D  splfNm                       10a   Const
     D  usrData                      10a   Const

       // QSPGETSP API: Reading an entire spooled file.
     D READ_ENTIRE_SPLF...
     D                 c                   Const(-1)
       // QSP API generic header.
     D qspGenHdr_p     s               *
     D qspGenHdr       ds                  LikeDs(qspGenHdr_t)
     D                                     Based(qspGenHdr_p)
       // User Space to store spool contents.
     D usrSpcNm        ds                  LikeDs(Object_t)

      /free

        clear splf;
        splf.hdl = rtvSplfHdl( splfNm : usrData );

        usrSpcNm.nm  = 'RUSPOOL';
        usrSpcNm.lib = 'QTEMP';

        qspGenHdr_p = crtUsrSpc( usrSpcNm :
                                 'RPGUnit - SelfTest - Spool File Contents.' );

        QSPGETSP( splf.hdl :
                  usrSpcNm :
                  'SPFR0300' :
                  READ_ENTIRE_SPLF :
                  '*ERROR' :
                  percolateErrors );

        aEqual( 'C' : qspGenHdr.compInd );

        splf.bufPos_p    = qspGenHdr_p + qspGenHdr.firstBufOff;
        splf.usrSpcEnd_p = qspGenHdr_p + qspGenHdr.usrSpcSizeUsed;

      /end-free
     P                 e


     PrtvJobUsrNm      b
     DrtvJobUsrNm      pi            10a

       // Job attributes.
     D jobAttribs      ds                  LikeDs(dsRTVC0100)
       // Job attribute keys.
     D attribKeys      s             10i 0 Dim(1)
       // Current user profile name job attribute entry.
     D usrNmEnt        ds                  LikeDs(dsRTVC0100Ent)

      /free

        attribKeys(1) = CUR_USR_NM;

        QWCRTVCA( jobAttribs :
                  %size(jobAttribs) :
                  'RTVC0100' :
                  %elem(attribKeys) :
                  attribKeys :
                  percolateErrors );

        if (jobAttribs.attribCnt <> 1);
          fail( 'QWCRTVCA returned an unexpected number of job attributes' );
        endif;

        usrNmEnt = jobAttribs.attribEnts;

        if (usrNmEnt.key <> CUR_USR_NM) or
           (usrNmEnt.dataType <> 'C') or
           (usrNmEnt.dataLen <> 10);
          fail( 'QWCRTVA returned an unexpected attribute format' );
        endif;

        return usrNmEnt.data;

      /end-free
     P                 e


     P rtvLatestSplf   b
     D rtvLatestSplf   pi                  LikeDs(SplfId_t)
     D  usrNm                              Const Like(UsrNm_t)
     D  usrData                      10a   Const

       // Retrieve only one record.
     D ONE_RECORD      c                   Const(1)
       // Retrieve spool files from all jobs.
     D ALL_JOBS        c                   Const(*blank)
       // Do not retrieve any record.
     D NO_RETRIEVAL    c                   Const(*zero)
       // The entire list is build synchronously.
     D BUILD_ENTIRE_LIST_SYNCHRONOUSLY...
     D                 c                   Const(-1)
       // Latest spool file id.
     D latestSplfId    ds                  LikeDs(SplfId_t)
       // Latest spool file info from QGYOLSPL API.
     D latestSplfInfo  ds                  LikeDs(dsOSPL0300)
       // Open list information for QGYOLSPL API.
     D listInfo        ds                  LikeDs(dsOpnList)
       // Open list handle.
     D opnListHdl      s                   Like(dsOpnList.rqsHdl)
       // Last spool file record index.
     D lastRcdIdx      s             10i 0
       // Spool file sorting information.
     D sortInfo        ds                  LikeDs(SortInfo_t)
       // Spool file filtering information, according to OSPF0100 format.
     D filterInfo      ds                  Qualified
     D  usrNmCnt                     10i 0 Inz(1)
     D   usrNm                       10a
     D                                2a   Inz(x'00')
     D  outqNmCnt                    10i 0 Inz(1)
     D   outqNm                      10a   Inz('*ALL')
     D   outqLibNm                   10a   Inz(*blank)
     D  formType                     10a   Inz('*ALL')
     D  usrData                      10a
     D  statusCnt                    10i 0 Inz(1)
     D   splfStatus                  10a   Inz('*READY')
     D                                2a   Inz(x'00')
     D  deviceNmCnt                  10i 0 Inz(1)
     D   deviceNm                    10a   Inz('*ALL')
     D                                2a   Inz(x'00')

      /free

        filterInfo.usrNm   = usrNm;
        filterInfo.usrData = usrData;

        sortInfo = *allx'00';

        QGYOLSPL( latestSplfInfo :
                  NO_RETRIEVAL :
                  listInfo :
                  BUILD_ENTIRE_LIST_SYNCHRONOUSLY :
                  sortInfo :
                  filterInfo :
                  ALL_JOBS :
                  'OSPL0300' :
                  percolateErrors );

        if ( listInfo.retRcdCnt <> 0 );
          fail( 'QGYOLSPL unexpectedly returned a record' );
        endif;

        if ( listInfo.infoCompInd <> 'C' );
          fail( 'QGYOLSPL could not retrieve complete info. ' +
                'Indicator=' + listInfo.infoCompInd );
        endif;

        if ( listInfo.firstRcdIdx <> 0 );
          fail( 'QGYOLSPL unexpectedly returned a first record' );
        endif;

        assert( listInfo.totalRcdCnt > 0 :
                'No spool file found for user ' + %trimr(usrNm)
                + ' and user data ' + %trimr(usrData) );

        opnListHdl = listInfo.rqsHdl;
        lastRcdIdx = listInfo.totalRcdCnt;

        QGYGTLE( latestSplfInfo :
                 %size(latestSplfInfo) :
                 opnListHdl :
                 listInfo :
                 ONE_RECORD :
                 lastRcdIdx :
                 percolateErrors );

        QGYCLST( listInfo.rqsHdl : percolateErrors );

        latestSplfId.qlfJobNm.jobNm = latestSplfInfo.jobNm;
        latestSplfId.qlfJobNm.usrNm = latestSplfInfo.usrNm;
        latestSplfId.qlfJobNm.jobNb = latestSplfInfo.jobNb;
        latestSplfId.nm             = latestSplfInfo.splfNm;
        latestSplfId.nb             = latestSplfInfo.splfNb;

        return latestSplfId;

      /end-free
     P                 e


     P rtvSplfHdl      b
     D rtvSplfHdl      pi            10i 0
     D  splfNm                       10a   Const
     D  usrData                      10a   Const

       // Latest spool file handle.
     D latestSplfHdl   s             10i 0
       // Latest spool file id.
     D latestSplfId    ds                  LikeDs(SplfId_t)
       // Current user profile name.
     D curUsrNm        s                   Like(UsrNm_t)

      /free

        // A simple QSPOPNSP( splfHdl : '*' : *blank : *blank : splfNm : -1 : 1 : percolateErrors )
        // would be enough for regular (i.e., interactive and submitted) jobs, but it does
        // not work for remote commands (a.k.a. server jobs).  In the latter, the spool file
        // is created by a special job named QPRTJOB.

        curUsrNm = rtvJobUsrNm();
        latestSplfId = rtvLatestSplf( curUsrNm : usrData );

        QSPOPNSP( latestSplfHdl :
                  latestSplfId.qlfJobNm :
                  *blank :
                  *blank :
                  latestSplfId.nm :
                  latestSplfId.nb :
                  1 :
                  percolateErrors );

        return latestSplfHdl;

      /end-free
     P                 e


     PsplfLineStartsWith...
     P                 b                   Export
     DsplfLineStartsWith...
     D                 pi
     D expString                    256a   Const Varying

      /free

        splf.bufPos_p = findInSpool( NL : splf.bufPos_p : splf.usrSpcEnd_p );
        splf.bufPos_p = bufEqual( expString : splf.bufPos_p + 1 );

      /end-free
     P                 e
