#ifndef _OZ00010000020006c5P_H_
#define _OZ00010000020006c5P_H_


#define OZClassPart0001000002fffffd_0_in_00010000020006c4 1
#define OZClassPart0001000002fffffe_0_in_00010000020006c4 1
#define OZClassPart00010000020006ce_0_in_00010000020006c4 -1
#define OZClassPart00010000020006cf_0_in_00010000020006c4 -1
#define OZClassPart00010000020006c4_0_in_00010000020006c4 0

typedef struct OZ00010000020006c5Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozContents;
  int pad0;

  /* protected (data) */
  unsigned int ozMask;

  /* protected (zero) */
} OZ00010000020006c5Part_Rec, *OZ00010000020006c5Part;

#ifdef OZ_ObjectPart_Set_Assoc_String_Package__
#undef OZ_ObjectPart_Set_Assoc_String_Package__
#endif
#define OZ_ObjectPart_Set_Assoc_String_Package__ OZ00010000020006c5Part

#endif _OZ00010000020006c5P_H_
