#ifndef _OZ00010000020007b3P_H_
#define _OZ00010000020007b3P_H_


#define OZClassPart0001000002fffffd_0_in_00010000020007b2 1
#define OZClassPart0001000002fffffe_0_in_00010000020007b2 1
#define OZClassPart00010000020007df_0_in_00010000020007b2 -1
#define OZClassPart00010000020007e0_0_in_00010000020007b2 -1
#define OZClassPart00010000020007b2_0_in_00010000020007b2 0

typedef struct OZ00010000020007b3Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozContents;
  int pad0;

  /* protected (data) */
  unsigned int ozMask;

  /* protected (zero) */
} OZ00010000020007b3Part_Rec, *OZ00010000020007b3Part;

#ifdef OZ_ObjectPart_Set_OIDAsKey_global_DirectoryServer_global_ResolvableObject___
#undef OZ_ObjectPart_Set_OIDAsKey_global_DirectoryServer_global_ResolvableObject___
#endif
#define OZ_ObjectPart_Set_OIDAsKey_global_DirectoryServer_global_ResolvableObject___ OZ00010000020007b3Part

#endif _OZ00010000020007b3P_H_
