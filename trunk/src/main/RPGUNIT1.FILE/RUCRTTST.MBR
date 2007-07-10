       //----------------------------------------------------------------------
       // Implementation of RUCRTST Command.
       //----------------------------------------------------------------------

       //----------------------------------------------------------------------
       //   IMPORTS
       //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,PGMMSG
      /copy RPGUNITY1,QCMDEXC
      /copy RPGUNITY1,TEMPLATES


       //----------------------------------------------------------------------
       //   PUBLIC PROTOTYPES
       //----------------------------------------------------------------------

      /copy RPGUNITY1,RUCRTTST


       //----------------------------------------------------------------------
       //   PRIVATE PROTOTYPES
       //----------------------------------------------------------------------

     D crtRpgMod       pr
     D  testPgm                            Const LikeDs(Object_t)
     D  srcFile                            Const LikeDs(Object_t)
     D  cOption                            Const LikeDs(Options_t)
     D  dbgView                      10a   Const

     D crtSrvPgm       pr                  LikeDs(Object_t)
     D  testPgm                            Const LikeDs(Object_t)
     D  bndSrvPgm                          Const LikeDs(ObjectArray_t)
     D  bndDir                             Const LikeDs(ObjectArray_t)
     D  bOption                            Const LikeDs(Options_t)


       //----------------------------------------------------------------------
       //   CONSTANTS
       //----------------------------------------------------------------------

       //----------------------------------------------------------------------
       //   TEMPLATES
       //----------------------------------------------------------------------

       //----------------------------------------------------------------------
       //   GLOBAL VARIABLES
       //----------------------------------------------------------------------

     D srvPgm          ds                  LikeDs(Object_t)


       //----------------------------------------------------------------------
       //   MAIN PROGRAM
       //----------------------------------------------------------------------

     DRUcrtTst         pr
     D testPgm                             Const LikeDs(Object_t)
     D srcFile                             Const LikeDs(Object_t)
     D cOption                             Const LikeDs(Options_t)
     D dbgView                       10a   Const
     D bndSrvPgm                           Const LikeDs(ObjectArray_t)
     D bndDir                              Const LikeDs(ObjectArray_t)
     D bOption                             Const LikeDs(Options_t)

     DRUcrtTst         pi
     D testPgm                             Const LikeDs(Object_t)
     D srcFile                             Const LikeDs(Object_t)
     D cOption                             Const LikeDs(Options_t)
     D dbgView                       10a   Const
     D bndSrvPgm                           Const LikeDs(ObjectArray_t)
     D bndDir                              Const LikeDs(ObjectArray_t)
     D bOption                             Const LikeDs(Options_t)

      /free

       monitor;
         crtRpgMod( testPgm : srcFile : cOption : dbgView );
         srvPgm = crtSrvPgm( testPgm : bndSrvPgm : bndDir : bOption );

         sndCompMsg( 'Test program ' + %trim(srvPgm.nm)
                   + ' created in library ' + %trim(srvPgm.lib) + '.' );

       on-error;
         sndEscapeMsgAboveCtlBdy( 'Unable to create test '
                                  + %trim(testPgm.nm) + '.' );
       endmon;

       *inlr = *on;

      /end-free


     P crtRpgMod       b
     D crtRpgMod       pi
     D  testPgm                            Const LikeDs(Object_t)
     D  srcFile                            Const LikeDs(Object_t)
     D  cOption                            Const LikeDs(Options_t)
     D  dbgView                      10a   Const

       // A command to be executed.
     D cmd             s            256a   Varying
      /free

         cmd = getCrtRpgModCmd( testPgm : srcFile : cOption : dbgView );
         sndInfoMsg( cmd );
         qcmdexc( cmd : %len(cmd) );

      /end-free
     P                 e


     P crtSrvPgm       b
     D crtSrvPgm       pi                  LikeDs(Object_t)
     D  testPgm                            Const LikeDs(Object_t)
     D  bndSrvPgm                          Const LikeDs(ObjectArray_t)
     D  bndDir                             Const LikeDs(ObjectArray_t)
     D  bOption                            Const LikeDs(Options_t)

       // Export all procedures from the service program.
     D EXPORT_ALL      c                   Const('*ALL')
       // A command to be executed.
     D cmd             s            256a   Varying
       // Bound Service Programs, with RPGUnit services included.
     D bndSrvPgmWithRU...
     D                 ds                  LikeDs(ObjectArray_t)
       // Completion message data.
     D compMsgData     s            256a
       // Target service program.
     D targetSrvPgm    ds                  LikeDs(Object_t)

      /free

         bndSrvPgmWithRU = bndSrvPgm;
         bndSrvPgmWithRU.size += 1;
         bndSrvPgmWithRU.object(bndSrvPgmWithRU.size).nm = 'RUTESTCASE';
         bndSrvPgmWithRU.object(bndSrvPgmWithRU.size).lib = '*LIBL';

         cmd = getCrtSrvPgmCmd( testPgm :
                                bndSrvPgmWithRU :
                                bndDir :
                                bOption :
                                EXPORT_ALL );
         sndInfoMsg( cmd );
         qcmdexc( cmd : %len(cmd) );

         compMsgData = rcvMsgData( '*COMP' );
         targetSrvPgm = %subst( compMsgData : 1 : 20 );

         return targetSrvPgm;

      /end-free
     P                 e


     P getCrtSrvPgmCmd...
     P                 b                   Export
     D getCrtSrvPgmCmd...
     D                 pi           256a
     D  testPgm                            Const LikeDs(Object_t)
     D  bndSrvPgm                          Const LikeDs(ObjectArray_t)
     D  bndDir                             Const LikeDs(ObjectArray_t)
     D  options                            Const LikeDs(Options_t)
     D  export                       10a   Const

       // Command string accumulator.
     D cmd             s            256a   Varying
       // Counter.
     D i               s             10i 0

      /free

        cmd = 'CRTSRVPGM SRVPGM(' + serializeObjectName( testPgm ) + ') ';
        cmd += 'MODULE(QTEMP/' + %trim(testPgm.nm) + ') ';
        cmd += serializeObjectArray( 'BNDSRVPGM' : bndSrvPgm );
        cmd += serializeObjectArray( 'BNDDIR'    : bndDir    );
        cmd += serializeOptions( 'OPTION' : options );

        if export <> *blank;
          cmd += 'EXPORT(' + %trim(export) + ') ';
        endif;

        return cmd;

      /end-free
     P getCrtSrvPgmCmd...
     P                 e


     P getCrtRpgModCmd...
     P                 b                   Export
     D getCrtRpgModCmd...
     D                 pi           256a
     D  testPgm                            Const LikeDs(Object_t)
     D  srcFile                            Const LikeDs(Object_t)
     D  options                            Const LikeDs(Options_t)
     D  dbgView                      10a   Const

       // Command string accumulator.
     D cmd             s            256a   Varying
       // Counter.
     D i               s             10i 0

      /free

        cmd = 'CRTRPGMOD MODULE(QTEMP/' + %trim(testPgm.nm) + ') ';

        if srcFile <> *blank;
          cmd += 'SRCFILE(' + serializeObjectName(srcFile) + ') ';
        endif;

        cmd += serializeOptions( 'OPTION' : options );

        if dbgView <> *blank;
          cmd += 'DBGVIEW(' + %trim(dbgView) + ') ';
        endif;

        return cmd;

      /end-free
     P getCrtRpgModCmd...
     P                 e


     PserializeObjectArray...
     P                 b                   Export
     DserializeObjectArray...
     D                 pi           256a   Varying
     D headToken                     10a   Const
     D array                               Const LikeDs(ObjectArray_t)

       // Serialized Object Array.
     D serialized      s            256a   Varying
       // Counter.
     D i               s             10i 0

      /free

        if array.size = 0;
          return '';
        endif;

        serialized = %trim(headToken) + '(';

        for i = 1 to array.size;
          serialized += serializeObjectName( array.object(i) ) + ' ';
        endfor;

        serialized += ') ';

        return serialized;

      /end-free
     PserializeObjectArray...
     P                 e


     P serializeObjectName...
     P                 b                   Export
     D serializeObjectName...
     D                 pi            21a   Varying
     D  object                             Const LikeDs(Object_t)

       // Serialized object name.
     D serialized      s            256a   Varying Inz('')

      /free

        if object.lib <> *blank;
          serialized += %trim(object.lib) + '/';
        endif;

        serialized += %trim(object.nm);

        return serialized;

      /end-free
     P serializeObjectName...
     P                 e


     PserializeOptions...
     P                 b                   Export
     DserializeOptions...
     D                 pi           256a   Varying
     D headToken                     10a   Const
     D options                             Const LikeDs(Options_t)

       // Serialized Options.
     D serialized      s            256a   Varying
       // Counter.
     D i               s             10i 0

      /free

        if options.size = 0;
          return '';
        endif;

        serialized = 'OPTION(';

        for i = 1 to options.size;
          serialized += %trim(options.option(i)) + ' ';
        endfor;

        if options.size > 0;
          serialized += ') ';
        endif;

        return serialized;

      /end-free
     PserializeOptions...
     P                 e

