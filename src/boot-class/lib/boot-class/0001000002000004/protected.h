#define _OZ0001000002000004P_H_


#define OZClassPart0001000002fffffd_0_in_0001000002000003 1
#define OZClassPart0001000002fffffe_0_in_0001000002000003 1
#define OZClassPart0001000002000008_0_in_0001000002000003 -1
#define OZClassPart0001000002000009_0_in_0001000002000003 -1
#define OZClassPart0001000002000003_0_in_0001000002000003 0
#define OZClassPart0000000000000000_0_in_0000000000000000 999

typedef struct OZ0001000002000004Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozContents;
  int pad0;

  /* protected (data) */
  unsigned int ozMask;

  /* protected (zero) */
} OZ0001000002000004Part_Rec, *OZ0001000002000004Part;

#ifdef OZ_ObjectPart_Set_OIDAsKey_global_CopyOfPrimaryCopyScheme_0___
#undef OZ_ObjectPart_Set_OIDAsKey_global_CopyOfPrimaryCopyScheme_0___
#endif
#define OZ_ObjectPart_Set_OIDAsKey_global_CopyOfPrimaryCopyScheme_0___ OZ0001000002000004Part

#endif _OZ0001000002000004P_H_
