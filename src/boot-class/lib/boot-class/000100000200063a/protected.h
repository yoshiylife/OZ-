#define _OZ000100000200063aP_H_


#define OZClassPart0001000002fffffd_0_in_0001000002000639 1
#define OZClassPart0001000002fffffe_0_in_0001000002000639 1
#define OZClassPart0001000002000643_0_in_0001000002000639 -1
#define OZClassPart0001000002000644_0_in_0001000002000639 -1
#define OZClassPart0001000002000639_0_in_0001000002000639 0

typedef struct OZ000100000200063aPart_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozContents;
  int pad0;

  /* protected (data) */
  unsigned int ozMask;

  /* protected (zero) */
} OZ000100000200063aPart_Rec, *OZ000100000200063aPart;

#ifdef OZ_ObjectPart_Set_Assoc_String_global_ResolvableObject__
#undef OZ_ObjectPart_Set_Assoc_String_global_ResolvableObject__
#endif
#define OZ_ObjectPart_Set_Assoc_String_global_ResolvableObject__ OZ000100000200063aPart

#endif _OZ000100000200063aP_H_
