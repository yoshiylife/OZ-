#define _OZ00010000020004d2P_H_


#define OZClassPart0001000002fffffd_0_in_00010000020004d1 1
#define OZClassPart0001000002fffffe_0_in_00010000020004d1 1
#define OZClassPart00010000020004d6_0_in_00010000020004d1 -1
#define OZClassPart00010000020004d7_0_in_00010000020004d1 -1
#define OZClassPart00010000020004d1_0_in_00010000020004d1 0

typedef struct OZ00010000020004d2Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozContents;
  int pad0;

  /* protected (data) */
  unsigned int ozMask;

  /* protected (zero) */
} OZ00010000020004d2Part_Rec, *OZ00010000020004d2Part;

#ifdef OZ_ObjectPart_Set_ProjectLinkSS_
#undef OZ_ObjectPart_Set_ProjectLinkSS_
#endif
#define OZ_ObjectPart_Set_ProjectLinkSS_ OZ00010000020004d2Part

#endif _OZ00010000020004d2P_H_
