      //
      // Unit tests for RUCRTTST.
      //

     H NoMain


      //----------------------------------------------------------------------
      //   Exported Procedures
      //----------------------------------------------------------------------

     Dsetup            pr
     DtestOnlyPgmName  pr
     DtestPgmAndLibName...
     D                 pr
     DtestSrcFile      pr
     DtestOneCompileOption...
     D                 pr
     DtestTwoCompileOptions...
     D                 pr
     DtestDbgView      pr
     DtestOneBndSrvPgm...
     D                 pr
     DtestTwoBndSrvPgm...
     D                 pr
     DtestOneBndDir    pr
     DtestOneBindingOption...
     D                 pr
     DtestExport       pr
     DtestBndDirWithoutLibrary...
     D                 pr
     DtestSerializeObjectNameWithLibrary...
     D                 pr
     DtestSerializeObjectNameWithoutLibrary...
     D                 pr


      //----------------------------------------------------------------------
      //   Imported Procedures
      //----------------------------------------------------------------------

      /copy RPGUNIT1,TESTCASE
      /copy RPGUNITY1,RUCRTTST
      /copy RPGUNITY1,TEMPLATES


      //----------------------------------------------------------------------
      //   Constants
      //----------------------------------------------------------------------

       // No debugging view given by user.
     D noDbgView       c                   Const(*blank)
       // No source file given by user.
     D noSrcFile       c                   Const(*blank)
       // No export option.
     D noExport        c                   Const(*blank)


      //----------------------------------------------------------------------
      //   Global Variables
      //----------------------------------------------------------------------

       // No compile option.
     D noCOption       ds                  LikeDs(Options_t)
       // No service program to bind.
     D noBndSrvPgm     ds                  LikeDs(ObjectArray_t)
       // No binding directory.
     D noBndDir        ds                  LikeDs(ObjectArray_t)
       // No binding option.
     D noBOption       ds                  LikeDs(Options_t)

       // Command to create an RPG module.
     D crtRpgModCmd    s            256a
       // Command to create a Service Program object.
     D crtSrvPgmCmd    s            256a


      //----------------------------------------------------------------------
      //   Test Procedures
      //----------------------------------------------------------------------

     Psetup            b                   Export
     Dsetup            pi
      /free

        clear crtRpgModCmd;

        clear noCOption;
        noCOption.size = 0;

        clear noBndSrvPgm;
        noBndSrvPgm.size = 0;

        clear noBndDir;
        noBndDir.size = 0;

        clear noBOption;
        noBOption.size = 0;

      /end-free
     Psetup            e


     PtestOnlyPgmName  b                   Export
     DtestOnlyPgmName  pi
      /free

        crtRpgModCmd = getCrtRpgModCmd( 'PGM_NAME            ' :
                                        noSrcFile :
                                        noCOption :
                                        noDbgView );
        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME            ' :
                                        noBndSrvPgm :
                                        noBndDir :
                                        noBOption :
                                        noExport );

        aEqual( 'CRTRPGMOD MODULE(QTEMP/PGM_NAME)' : crtRpgModCmd );
        aEqual( 'CRTSRVPGM SRVPGM(PGM_NAME) MODULE(QTEMP/PGM_NAME)' :
                crtSrvPgmCmd );

      /end-free
     PtestOnlyPgmName  e


     PtestPgmAndLibName...
     P                 b                   Export
     DtestPgmAndLibName...
     D                 pi
      /free

        crtRpgModCmd = getCrtRpgModCmd( 'PGM_NAME2 LIB_NAME  ' :
                                        noSrcFile :
                                        noCOption :
                                        noDbgView );
        aEqual( 'CRTRPGMOD MODULE(QTEMP/PGM_NAME2)' : crtRpgModCmd );

      /end-free
     PtestPgmAndLibName...
     P                 e


     PtestSrcFile      b                   Export
     DtestSrcFile      pi
      /free

        crtRpgModCmd = getCrtRpgModCmd( 'PGM_NAME  *CURLIB   ' :
                                        'QRPGLESRC *LIBL     ' :
                                        noCOption :
                                        noDbgView );
        aEqual( 'CRTRPGMOD MODULE(QTEMP/PGM_NAME) '
              + 'SRCFILE(*LIBL/QRPGLESRC)' : crtRpgModCmd );

      /end-free
     PtestSrcFile      e


     PtestOneCompileOption...
     P                 b                   Export
     DtestOneCompileOption...
     D                 pi

     DoneCOption       ds                  LikeDs(Options_t)

      /free

        oneCOption.size = 1;
        oneCOption.option(1) = '*SRCSTMT';

        crtRpgModCmd = getCrtRpgModCmd( 'PGM_NAME  *CURLIB   ' :
                                        noSrcFile :
                                        oneCOption :
                                        noDbgView );
        aEqual( 'CRTRPGMOD MODULE(QTEMP/PGM_NAME) '
              + 'OPTION(*SRCSTMT )' : crtRpgModCmd );

      /end-free
     PtestOneCompileOption...
     P                 e


     PtestTwoCompileOptions...
     P                 b                   Export
     DtestTwoCompileOptions...
     D                 pi

     DtwoCOptions      ds                  LikeDs(Options_t)

      /free

        twoCOptions.size = 2;
        twoCOptions.option(1) = '*SRCSTMT';
        twoCOptions.option(2) = '*NODEBUGIO';

        crtRpgModCmd = getCrtRpgModCmd( 'PGM_NAME  *CURLIB   ' :
                                        noSrcFile :
                                        twoCOptions :
                                        noDbgView );
        aEqual( 'CRTRPGMOD MODULE(QTEMP/PGM_NAME) '
              + 'OPTION(*SRCSTMT *NODEBUGIO )' : crtRpgModCmd );

      /end-free
     PtestTwoCompileOptions...
     P                 e


     PtestDbgView      b                   Export
     DtestDbgView      pi
      /free

        crtRpgModCmd = getCrtRpgModCmd( 'PGM_NAME  *CURLIB   ' :
                                        noSrcFile :
                                        noCOption :
                                        '*LIST' );
        aEqual( 'CRTRPGMOD MODULE(QTEMP/PGM_NAME) '
              + 'DBGVIEW(*LIST)' : crtRpgModCmd );

      /end-free
     PtestDbgView      e


     PtestOneBndSrvPgm...
     P                 b                   Export
     DtestOneBndSrvPgm...
     D                 pi

      // Binding one Service Program.
     DoneBndSrvPgm     ds                  LikeDs(ObjectArray_t)

      /free

        // Setup.

        oneBndSrvPgm.size = 1;
        oneBndSrvPgm.object(1).nm = 'SRVPGM_NM';
        oneBndSrvPgm.object(1).lib = 'SRVPGM_LIB';

        // Execution.

        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME  *CURLIB   ' :
                                        oneBndSrvPgm :
                                        noBndDir :
                                        noBOption :
                                        noExport );

        // Control.

        aEqual( 'CRTSRVPGM SRVPGM(*CURLIB/PGM_NAME) MODULE(QTEMP/PGM_NAME) '
              + 'BNDSRVPGM(SRVPGM_LIB/SRVPGM_NM )' : crtSrvPgmCmd );

      /end-free
     PtestOneBndSrvPgm...
     P                 e


     PtestTwoBndSrvPgm...
     P                 b                   Export
     DtestTwoBndSrvPgm...
     D                 pi

      // Binding two Service Programs.
     DtwoBndSrvPgm     ds                  LikeDs(ObjectArray_t)

      /free

        // Setup.

        twoBndSrvPgm.size = 2;
        twoBndSrvPgm.object(1).nm = 'SRVPGM_NM';
        twoBndSrvPgm.object(1).lib = 'SRVPGM_LIB';
        twoBndSrvPgm.object(2).nm = 'SRVPGM_NM2';
        twoBndSrvPgm.object(2).lib = 'SRVPGM_LB2';

        // Execution.

        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME  *CURLIB   ' :
                                        twoBndSrvPgm :
                                        noBndDir :
                                        noBOption :
                                        noExport );

        // Control.

        aEqual( 'CRTSRVPGM SRVPGM(*CURLIB/PGM_NAME) MODULE(QTEMP/PGM_NAME) '
              + 'BNDSRVPGM(SRVPGM_LIB/SRVPGM_NM SRVPGM_LB2/SRVPGM_NM2 )'
              : crtSrvPgmCmd );

      /end-free
     PtestTwoBndSrvPgm...
     P                 e


     PtestOneBndDir    b                   Export
     DtestOneBndDir    pi

      // One binding directory.
     DoneBndDir        ds                  LikeDs(ObjectArray_t)

      /free

        // Setup.

        oneBndDir.size = 1;
        oneBndDir.object(1).nm = 'BNDDIR_NM';
        oneBndDir.object(1).lib = 'BNDDIR_LIB';

        // Execution.

        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME  *CURLIB   ' :
                                        noBndSrvPgm :
                                        oneBndDir :
                                        noBOption :
                                        noExport );

        // Control.

        aEqual( 'CRTSRVPGM SRVPGM(*CURLIB/PGM_NAME) MODULE(QTEMP/PGM_NAME) '
              + 'BNDDIR(BNDDIR_LIB/BNDDIR_NM )' : crtSrvPgmCmd );

      /end-free
     PtestOneBndDir    e


     PtestBndDirWithoutLibrary...
     P                 b                   Export
     DtestBndDirWithoutLibrary...
     D                 pi

      // One binding directory.
     DoneBndDir        ds                  LikeDs(ObjectArray_t)

      /free

        // Setup.

        oneBndDir.size = 1;
        oneBndDir.object(1).nm = 'BNDDIR_NM';
        oneBndDir.object(1).lib = *blank;

        // Execution.

        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME  *CURLIB   ' :
                                        noBndSrvPgm :
                                        oneBndDir :
                                        noBOption :
                                        noExport );

        // Control.

        aEqual( 'CRTSRVPGM SRVPGM(*CURLIB/PGM_NAME) MODULE(QTEMP/PGM_NAME) '
              + 'BNDDIR(BNDDIR_NM )' : crtSrvPgmCmd );

      /end-free
     PtestBndDirWithoutLibrary...
     P                 e


     PtestOneBindingOption...
     P                 b                   Export
     DtestOneBindingOption...
     D                 pi

      // One Binding Option.
     DoneBOption       ds                  LikeDs(Options_t)

      /free

        // Setup.

        oneBOption.size = 1;
        oneBOption.option(1) = '*DUPPROC';

        // Execute.

        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME  *CURLIB   ' :
                                        noBndSrvPgm :
                                        noBndDir :
                                        oneBOption :
                                        noExport );

        // Control.

        aEqual( 'CRTSRVPGM SRVPGM(*CURLIB/PGM_NAME) MODULE(QTEMP/PGM_NAME) '
              + 'OPTION(*DUPPROC )' : crtSrvPgmCmd );

      /end-free
     PtestOneBindingOption...
     P                 e


     PtestExport       b                   Export
     DtestExport       pi

       // Export option.
     D export          s             10a

      /free

        // Setup.

        export = '*ALL';

        // Execute.

        crtSrvPgmCmd = getCrtSrvPgmCmd( 'PGM_NAME  *CURLIB   ' :
                                        noBndSrvPgm :
                                        noBndDir :
                                        noBOption :
                                        export );

        // Control.

        aEqual( 'CRTSRVPGM SRVPGM(*CURLIB/PGM_NAME) MODULE(QTEMP/PGM_NAME) '
              + 'EXPORT(*ALL)' : crtSrvPgmCmd );

      /end-free
     PtestExport       e


     PtestSerializeObjectNameWithLibrary...
     P                 b                   Export
     DtestSerializeObjectNameWithLibrary...
     D                 pi

      // An object name.
     Dobject           ds                  LikeDs(Object_t)

      /free

        // Setup.

        object.nm = 'OBJNAME';
        object.lib = 'OBJLIB';

        // Execute and control.

        aEqual( 'OBJLIB/OBJNAME' : serializeObjectName(object) );

      /end-free
     PtestSerializeObjectNameWithLibrary...
     P                 e


     PtestSerializeObjectNameWithoutLibrary...
     P                 b                   Export
     DtestSerializeObjectNameWithoutLibrary...
     D                 pi

      // An object name.
     Dobject           ds                  LikeDs(Object_t)

      /free

        // Setup.

        object.nm = 'OBJNAME';
        object.lib = *blank;

        // Execute and control.

        aEqual( 'OBJNAME' : serializeObjectName(object) );

      /end-free
     PtestSerializeObjectNameWithoutLibrary...
     P                 e
