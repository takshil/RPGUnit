      //
      // User Space utilities.
      //

     H NoMain Option(*SrcStmt)


       //----------------------------------------------------------------------
       //   Public Procedure Prototypes
       //----------------------------------------------------------------------

      /copy RPGUNITY1,USRSPC


       //----------------------------------------------------------------------
       //   Imported Procedures
       //----------------------------------------------------------------------

      /copy RPGUNITY1,QUSCRTUS
      /copy RPGUNITY1,QUSPTRUS


       //----------------------------------------------------------------------
       //   Global DS
       //----------------------------------------------------------------------

      /copy RPGUNITY1,ERRORCODE
      /copy RPGUNITY1,TEMPLATES


       //----------------------------------------------------------------------
       //   Procedures Definition
       //----------------------------------------------------------------------

     P crtUsrSpc       b                   Export
      //----------------------------------------------------------------------
      // Creates a user space. See prototype.
      //----------------------------------------------------------------------
     D crtUsrSpc       pi              *
     D  usrSpc                             Const LikeDs(Object_t)
     D  text                         50a   Const

       // User Space to store proc list.
     D usrSpcCrtParm   ds                  LikeDs(UsrSpcCrtParm_t)
       // Pointer to the user space.
     D usrSpc_p        s               *

      /free

        usrSpcCrtParm.nm        = usrSpc;
        usrSpcCrtParm.attribute = 'USRSPC';
        usrSpcCrtParm.size      = 1024;
        usrSpcCrtParm.value     = x'00';
        usrSpcCrtParm.auth      = '*ALL';
        usrSpcCrtParm.text      = text;
        usrSpcCrtParm.replace   = '*YES';

        QUSCRTUS( usrSpcCrtParm.nm :
                  usrSpcCrtParm.attribute :
                  usrSpcCrtParm.size :
                  usrSpcCrtParm.value :
                  usrSpcCrtParm.auth :
                  usrSpcCrtParm.text :
                  usrSpcCrtParm.replace :
                  percolateErrors );

        QUSPTRUS( usrSpc : usrSpc_p );

        return usrSpc_p;

      /end-free
     P crtUsrSpc       e
