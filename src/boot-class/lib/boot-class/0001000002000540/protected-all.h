#define _PROTECTED_ALL_0001000002000540_H

#ifndef _OZ0001000002000540P_H_
#define _OZ0001000002000540P_H_


#define OZClassPart0001000002fffffd_0_in_000100000200053f 1
#define OZClassPart0001000002fffffe_0_in_000100000200053f 1
#define OZClassPart000100000200053f_0_in_000100000200053f 0

typedef struct OZ0001000002000540Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */

  /* protected (data) */
  unsigned int ozDefaultCapacity;
  unsigned int ozExpansionFactor;
  unsigned int ozExpansionIncrement;

  /* protected (zero) */
} OZ0001000002000540Part_Rec, *OZ0001000002000540Part;

#ifdef OZ_ObjectPart_Collection_Assoc_String_String__
#undef OZ_ObjectPart_Collection_Assoc_String_String__
#endif
#define OZ_ObjectPart_Collection_Assoc_String_String__ OZ0001000002000540Part

#endif _OZ0001000002000540P_H_


#endif _PROTECTED_ALL_0001000002000540_H
