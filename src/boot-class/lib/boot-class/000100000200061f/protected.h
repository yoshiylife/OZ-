#define _OZ000100000200061fP_H_


#define OZClassPart0001000002fffffd_0_in_000100000200061e 1
#define OZClassPart0001000002fffffe_0_in_000100000200061e 1
#define OZClassPart0001000002000628_0_in_000100000200061e -1
#define OZClassPart0001000002000629_0_in_000100000200061e -1
#define OZClassPart000100000200061e_0_in_000100000200061e 0

typedef struct OZ000100000200061fPart_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozContents;
  int pad0;

  /* protected (data) */
  unsigned int ozMask;

  /* protected (zero) */
} OZ000100000200061fPart_Rec, *OZ000100000200061fPart;

#ifdef OZ_ObjectPart_Set_Assoc_String_ProjectLinkSS__
#undef OZ_ObjectPart_Set_Assoc_String_ProjectLinkSS__
#endif
#define OZ_ObjectPart_Set_Assoc_String_ProjectLinkSS__ OZ000100000200061fPart

#endif _OZ000100000200061fP_H_
