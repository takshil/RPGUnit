      //
      // Prototype for QGYOLJBL API.
      //
      // Open List of Job Log Messages
      //
      // http://publib.boulder.ibm.com/iseries/v5r2/ic2924/info/apis/qgyoljbl.htm
      //

     DQGYOLJBL         pr                  ExtPgm('QGYOLJBL')
     D jobLogList                 32766a   Options(*VarSize)
     D jobLogListLen                 10i 0 Const
     D listInfo                            LikeDs(dsOpnList)
     D nbOfRcdToRtn                  10i 0 Const
     D msgSelect                  32766a   Const Options(*VarSize)
     D msgSelectLen                  10i 0 Const
     D error                      32766a   Options(*VarSize: *Omit) NoOpt

     DdsOLJL0100EntHdr...
     D                 ds                  Qualified Based(template)
     D nextEntOff                    10i 0
     D retFldOff                     10i 0
     D retFldCnt                     10i 0
     D msgSeverity                   10i 0
     D msgId                          7a
     D msgType                        2a
     D msgKey                         4a
     D msgfNm                        10a
     D msgfLib                       10a
     D sentDate                       7a
     D sentTime                       6a
     D microseconds                   6a

     DdsOLJL0100FldHdr...
     D                 ds                  Qualified Based(template)
     D nextFldOff                    10i 0
     D fldInfoLen                    10i 0
     D fldId                         10i 0
     D dataType                       1a
     D dataSts                        1a
     D                               14a
     D dataLen                       10i 0

       // Number of records to return:
       // - All records are built synchronously in the list by the main job.
     D FULL_SYNCHRONOUS_BUILD...
     D                 c                   Const(-1)

       // Field Identifiers:
       // - replacement data or impromptu message text
     D OLJL_RPL_DATA   c                   Const(0201)
       // - message
     D OLJL_MSG        c                   Const(0301)
       // - message with replacement data
     D OLJL_MSG_WITH_RPL_DATA...
     D                 c                   Const(0302)
       // - sending program name
     D OLJL_SND_PGM_NM...
     D                 c                   Const(0603)
       // - receiving program name
     D OLJL_RCV_PGM_NM...
     D                 c                   Const(0703)
