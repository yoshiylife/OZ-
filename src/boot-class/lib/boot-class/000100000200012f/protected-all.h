#define _PROTECTED_ALL_000100000200012f_H

#ifndef _PROTECTED_ALL_0001000002000400_H
#define _PROTECTED_ALL_0001000002000400_H

#ifndef _PROTECTED_ALL_0001000002000139_H
#define _PROTECTED_ALL_0001000002000139_H

#ifndef _PROTECTED_ALL_0001000002000074_H
#define _PROTECTED_ALL_0001000002000074_H

#ifndef _OZ0001000002000074P_H_
#define _OZ0001000002000074P_H_


#define OZClassPart0001000002fffffd_0_in_0001000002000073 1
#define OZClassPart0001000002fffffe_0_in_0001000002000073 1
#define OZClassPart0001000002000073_0_in_0001000002000073 0

typedef struct OZ0001000002000074Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */

  /* protected (data) */

  /* protected (zero) */
} OZ0001000002000074Part_Rec, *OZ0001000002000074Part;

#ifdef OZ_ObjectPart_ClassPart
#undef OZ_ObjectPart_ClassPart
#endif
#define OZ_ObjectPart_ClassPart OZ0001000002000074Part

#endif _OZ0001000002000074P_H_


#endif _PROTECTED_ALL_0001000002000074_H
#ifndef _OZ0001000002000139P_H_
#define _OZ0001000002000139P_H_


#define OZClassPart0001000002fffffd_0_in_0001000002000138 1
#define OZClassPart0001000002fffffe_0_in_0001000002000138 1
#define OZClassPart0001000002000073_0_in_0001000002000138 -1
#define OZClassPart0001000002000074_0_in_0001000002000138 -1
#define OZClassPart0001000002000138_0_in_0001000002000138 0

typedef struct OZ0001000002000139Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */

  /* protected (data) */

  /* protected (zero) */
} OZ0001000002000139Part_Rec, *OZ0001000002000139Part;

#ifdef OZ_ObjectPart_ClassVersion
#undef OZ_ObjectPart_ClassVersion
#endif
#define OZ_ObjectPart_ClassVersion OZ0001000002000139Part

#endif _OZ0001000002000139P_H_


#endif _PROTECTED_ALL_0001000002000139_H
#ifndef _OZ0001000002000400P_H_
#define _OZ0001000002000400P_H_


#define OZClassPart0001000002fffffd_0_in_00010000020003ff 1
#define OZClassPart0001000002fffffe_0_in_00010000020003ff 1
#define OZClassPart0001000002000073_0_in_00010000020003ff -2
#define OZClassPart0001000002000074_0_in_00010000020003ff -2
#define OZClassPart0001000002000138_0_in_00010000020003ff -1
#define OZClassPart0001000002000139_0_in_00010000020003ff -1
#define OZClassPart00010000020003ff_0_in_00010000020003ff 0

typedef struct OZ0001000002000400Part_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */
  OZ_Object ozLowerVersions;
  OZ_Object ozVisibleLowerVersions;

  /* protected (data) */
  OID ozDefaultLowerVersion;

  /* protected (zero) */
} OZ0001000002000400Part_Rec, *OZ0001000002000400Part;

#ifdef OZ_ObjectPart_UpperPart
#undef OZ_ObjectPart_UpperPart
#endif
#define OZ_ObjectPart_UpperPart OZ0001000002000400Part

#endif _OZ0001000002000400P_H_


#endif _PROTECTED_ALL_0001000002000400_H
#ifndef _OZ000100000200012fP_H_
#define _OZ000100000200012fP_H_


#define OZClassPart0001000002fffffd_0_in_000100000200012e 1
#define OZClassPart0001000002fffffe_0_in_000100000200012e 1
#define OZClassPart0001000002000073_0_in_000100000200012e -3
#define OZClassPart0001000002000074_0_in_000100000200012e -3
#define OZClassPart0001000002000138_0_in_000100000200012e -2
#define OZClassPart0001000002000139_0_in_000100000200012e -2
#define OZClassPart00010000020003ff_0_in_000100000200012e -1
#define OZClassPart0001000002000400_0_in_000100000200012e -1
#define OZClassPart000100000200012e_0_in_000100000200012e 0

typedef struct OZ000100000200012fPart_Rec {
  OZ_AllocateInfoRec alloc_info;

  /* protected (pointer) */

  /* protected (data) */

  /* protected (zero) */
} OZ000100000200012fPart_Rec, *OZ000100000200012fPart;

#ifdef OZ_ObjectPart_RootPart
#undef OZ_ObjectPart_RootPart
#endif
#define OZ_ObjectPart_RootPart OZ000100000200012fPart

#endif _OZ000100000200012fP_H_


#endif _PROTECTED_ALL_000100000200012f_H
