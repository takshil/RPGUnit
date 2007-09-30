
       //
       // Get Spooled File Data API
       //

     D QSPGETSP        pr                  ExtPgm('QSPGETSP')
     D   splfHdl                     10i 0 Const
     D   usrSpcNm                    20a   Const
     D   fmtNm                        8a   Const
     D   ordNbOfBuf                  10i 0 Const
     D   splfEnd                     10a   Const
     D   error                    32766a   Options(*varsize) NoOpt

       // QSP API Generic Header Section.
     D qspGenHdr_t     ds                  Qualified Based(template)
     D   genUsrAra                   64a
     D   hdrSize                     10i 0
     D   strLvl                       4a
     D   splfLvl                      6a
     D   fmt                          8a
     D   compInd                      1a
     D                                1a
     D   usrSpcSizeUsed...
     D                               10i 0
     D   firstBufOff                 10i 0
     D   nbOfBufRqs                  10i 0
     D   nbOfBufRtn                  10i 0
     D   prtDtaSize                  10i 0
     D   nbOfCompPg                  10i 0
     D   nbOfFirstPg                 10i 0
     D   offToFirstPg                10i 0
     D                                8a

