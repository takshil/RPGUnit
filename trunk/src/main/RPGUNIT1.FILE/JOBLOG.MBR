     H NoMain Option(*SrcStmt)


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNITY1,JOBLOG


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNIT1,TESTCASE
      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,OPNLIST
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,QGYCLST
      /copy RPGUNITY1,QGYOLJBL
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Private Procedure Prototypes
      //----------------------------------------------------------------------

     D getSentTimeStamp...
     D                 pr              z
     D  msg                                Const LikeDs(dsOLJL0100EntHdr)


      //----------------------------------------------------------------------
      //   Procedure Definitions
      //----------------------------------------------------------------------

     P assertJobLogContains...
     P                 b                   Export
     D assertJobLogContains...
     D                 pi
     D  msgId                         7a   Const
     D  timeLimit                      z   Const

       // Job log message field selection for QGYOLJBL API.
     D fldSelect       ds                  Qualified
     D  listDirection                10a   Inz('*PRV')
     D  qlfJobNm                     26a   Inz('*')
     D  intJobId                     16a   Inz(*blank)
     D  startMsgKey                   4a   Inz(x'FFFFFFFF')
     D  maxMsgLen                    10i 0 Inz(0)
     D  maxMsgHlpLen                 10i 0 Inz(0)
     D  fldIdOff                     10i 0
     D  fldCnt                       10i 0 Inz(1)
     D  callMsgqNmOff                10i 0
     D  callMsgqNmLen                10i 0 Inz(%size(fldSelect.callMsgqNm))
     D  fldId1                       10i 0 Inz(OLJL_SND_PGM_NM)
     D  callMsgqNm                    1a   Inz('*')

     D listInfo        ds                  LikeDs(dsOpnList)
     D msgBasicInfo    ds                  LikeDs(dsOLJL0100EntHdr)
     D                                     Based(p_msgBasicInfo)
     D p_msgBasicInfo  s               *
     D jobLogList      s          32766a
     D sentTimeStamp   s               z
     D msgIdx          s             10i 0
     D msgFound        s               n   Inz(*off)

      /free

        fldSelect.fldIdOff = %addr(fldSelect.fldId1) - %addr(fldSelect);
        fldSelect.callMsgqNmOff =
                         %addr(fldSelect.callMsgqNm) - %addr(fldSelect);

        QGYOLJBL( jobLogList :
                  %size( jobLogList ) :
                  listInfo :
                  FULL_SYNCHRONOUS_BUILD :
                  fldSelect :
                  %size( fldSelect ) :
                  percolateErrors );

        p_msgBasicInfo = %addr( jobLogList );
        msgIdx = 1;

        dow 1=1;
          if msgIdx > listInfo.retRcdCnt;
            sndEscapeMsgToCaller( 'Insufficient implementation. ' +
                  'Should use QGYGTLE to retrieve records after ' +
                               %char( listInfo.retRcdCnt ) + '. ' +
                                          'Please open an issue.' );
          endif;

          sentTimeStamp = getSentTimeStamp( msgBasicInfo );

          if sentTimeStamp < timeLimit;
            leave;
          endif;

          if msgBasicInfo.msgId = msgId;
            msgFound = *on;
            leave;
          endif;

          // Go to next message in the job log.
          p_msgBasicInfo = %addr( jobLogList ) + msgBasicInfo.nextEntOff;
          msgIdx += 1;
        enddo;

        QGYCLST( listInfo.rqsHdl : percolateErrors );

        assert( msgFound : 'Message ' + msgId + ' not found in the job log.' );

      /end-free
     P                 e


     P getFullTimeStamp...
     P                 b                   Export
     D getFullTimeStamp...
     D                 pi              z

     D now             s               z

     C/EXEC SQL Set :now = Current_TimeStamp
     C/END-EXEC
      /free

        return now;

      /end-free
     P                 e


      //----------------------------------------------------------------------
      //   Private Helper Procedures
      //----------------------------------------------------------------------

     P getSentTimeStamp...
     P                 b
     D getSentTimeStamp...
     D                 pi              z
     D  msg                                Const LikeDs(dsOLJL0100EntHdr)

     D sentDateAsIso   s              8a

      /free

        sentDateAsIso = %char( %date( msg.sentDate : *cymd0) : *iso0 );
        return %timestamp( sentDateAsIso +
                           msg.sentTime +
                           msg.microseconds :
                           *iso0 );

      /end-free
     P                 e
