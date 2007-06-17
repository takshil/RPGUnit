
       //----------------------------------------------------------------------
       //   PUBLIC PROTOTYPES
       //----------------------------------------------------------------------

     D getCrtRpgModCmd...
     D                 pr           256a
     D  pgm                                Const LikeDs(Object_t)
     D  srcFile                            Const LikeDs(Object_t)
     D  options                            Const LikeDs(Options_t)
     D  dbgView                      10a   Const

     D getCrtSrvPgmCmd...
     D                 pr           256a
     D  pgm                                Const LikeDs(Object_t)
     D  bndSrvPgm                          Const LikeDs(ObjectArray_t)
     D  bndDir                             Const LikeDs(ObjectArray_t)
     D  options                            Const LikeDs(Options_t)
     D  export                       10a   Const

     D serializeObjectArray...
     D                 pr           256a   Varying
     D  headToken                    10a   Const
     D  array                              Const LikeDs(ObjectArray_t)

     D serializeObjectName...
     D                 pr            21a   Varying
     D  object                             Const LikeDs(Object_t)

     DserializeOptions...
     D                 pr           256a   Varying
     D headToken                     10a   Const
     D options                             Const LikeDs(Options_t)


       //----------------------------------------------------------------------
       //   TEMPLATES
       //----------------------------------------------------------------------

       // A sized array of OS400 objects.
     D ObjectArray_t   ds                  Based(template) Qualified
     D  size                          5i 0
     D  object                             Dim(3) LikeDs(Object_t)

       // A sized list of options.
     D Options_t       ds                  Based(template) Qualified
     D  size                          5i 0
     D  option                       10a   Dim(3)

