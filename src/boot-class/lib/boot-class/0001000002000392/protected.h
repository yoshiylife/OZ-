#define _OZ0001000002000392P_H_


#define OZClassPart0001000002fffffd_0_in_0001000002000391 1
#define OZClassPart0001000002fffffe_0_in_0001000002000391 1
#define OZClassPart00010000020000b4_0_in_0001000002000391 -2
#define OZClassPart00010000020000b5_0_in_0001000002000391 -2
#define OZClassPart0001000002000382_0_in_0001000002000391 -1
#define OZClassPart0001000002000383_0_in_0001000002000391 -1
#define OZClassPart0001000002000391_0_in_0001000002000391 0
#define OZClassPart0000000000000000_0_in_0000000000000000 999

typedef struct OZ0001000002000392Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Array ozOrderedIndex;
  int pad0;

  /* protected (data) */
  int ozOrderedIndexMax;

  /* protected (zero) */
} OZ0001000002000392Part_Rec, *OZ0001000002000392Part;

#ifdef OZ_ObjectPart_SortableSet_0_
#undef OZ_ObjectPart_SortableSet_0_
#endif
#define OZ_ObjectPart_SortableSet_0_ OZ0001000002000392Part

#endif _OZ0001000002000392P_H_
