/*
 * Copyright(c) 1994-1996 Information-technology Promotion Agency, Japan(IPA)
 *
 * All rights reserved.
 * This software and documentation is a result of the Open Fundamental
 * Software Technology Project of Information-technology Promotion Agency,
 * Japan(IPA).
 *
 * Permissions to use, copy, modify and distribute this software are governed
 * by the terms and conditions set forth in the file COPYRIGHT, located in
 * this release package.
 */
/*
  Copyright (c) 1994 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/
// we don't use record

//#define NORECORDACOPS

// we use broadcast
//#define NOBROADCAST

// we flush objects
//#define NOFLUSH

// we don't test flush
//#define FLUSHTESTATSTARTING

// we are debugging
//#define NDEBUG

// we have a bug in remote instantiation


// we lookup configuration table for configured class ID


// we don't list directory by unix 'ls' command, but opendir library
//#define LISTBYLS

// we need change directory to $OZHOME before OzRead and OzSpawn


// we don't use OzRemoveCode
//#define USEOZREMOVECODE

// we don't read parents version IDs from private.i.
//#define READPARENTSFROMPRIVATEDOTI

// we have bug in alias


// we have no executor who recognize relative path from OZHOME


// we have OzCopy
//#define NOOZCOPY

// we don't have OzRename


// we distribute class not by tar'ed directory
//#define DISTRIBUTEWITHTAR

// we have bug in StreamBuffer


// we have no support for getting executor ID


// we don't use Object::GetPropertyPathName


// we have a bug in gen-spec-src


// we have a bug in reference counter treatment when forking thread
//#define NOFORKBUG

// we don't have a bug in assigning 0 to a record instance

/*
 * vstring.oz
 *
 * String representing a version of a class part.
 * Based on a mutable string class String.
 */

class VersionString {
/* interface */
  constructor: New;
  public:
    Assign, AsString, Compare, Content, Duplicate,
    GetImplementationPart, GetProtectedPart, GetPublicPart,
    IsEqual, IsEqualTo, IsGreaterThan, IsGreaterThanOrEqualTo,
    IsLessThan, IsLessThanOrEqualTo, IsNotEqualTo,
    SetImplementationPart, SetProtectedPart, SetPublicPart;

  /* instance variables */
  protected: PublicPart, ProtectedPart, ImplementationPart;

    unsigned int PublicPart;
    unsigned int ProtectedPart;
    unsigned int ImplementationPart;

/* method implementations */
    void New () {
	PublicPart = 0;
	ProtectedPart = 0;
	ImplementationPart = 0;
    }

    VersionString Assign (VersionString vs) {
	SetPublicPart (vs->GetPublicPart ());
	SetProtectedPart (vs->GetProtectedPart ());
	SetImplementationPart (vs->GetImplementationPart ());
	return self;
    }

    String AsString () {
	String s=>NewFromArrayOfChar (Content ());

	return s;
    }

    int Compare (VersionString s) {
	int r;

	if (self == s)
	  return 0;

	if (PublicPart == 0) {
	    return - s->GetPublicPart ();
	} else if ((r = PublicPart - s->GetPublicPart ()) != 0) {
	    return r;
	} else if (ProtectedPart == 0) {
	    return - s->GetProtectedPart ();
	} else if ((r = ProtectedPart - s->GetProtectedPart ()) != 0) {
	    return r;
	} else if (ImplementationPart == 0) {
	    return - s->GetImplementationPart ();
	} else if ((r = ImplementationPart - s->GetImplementationPart ())
		   != 0) {
	    return r;
	} else {
	    return 0;
	}
    }

    char Content ()[] {
	ArrayOfCharOperators acops;
	char buf [];


	if (PublicPart == 0) {

	    buf = acops.Duplicate ("*.*.*");

	} else {

	    buf = acops.ItoA (PublicPart);

	    if (ProtectedPart == 0) {

		buf = acops.Concatenate (buf, acops.Duplicate (".*.*"));

	    } else {

		buf = acops.Concatenate (buf, acops.Duplicate ("."));
		buf = acops.Concatenate (buf, acops.ItoA (ProtectedPart));

		if (ImplementationPart == 0) {

		    buf = acops.Concatenate (buf, acops.Duplicate (".*"));

		} else {

		    buf = acops.Concatenate (buf, acops.Duplicate ("."));
		    buf = acops.Concatenate (buf,
					     acops.ItoA (ImplementationPart));

		}
	    }
	}
	return buf;
    }

    VersionString Duplicate () {
	VersionString vs=>New ();

	return vs->Assign (self);
    }

    unsigned int GetPublicPart () {return PublicPart;}
    unsigned int GetProtectedPart () {return ProtectedPart;}
    unsigned int GetImplementationPart () {return ImplementationPart;}

    int IsEqual (VersionString vs) {return IsEqualTo (vs);}
    int IsEqualTo (VersionString vs) {return Compare (vs) == 0;}
    int IsGreaterThan (VersionString vs) {return Compare (vs) > 0;}
    int IsGreaterThanOrEqualTo (VersionString vs) {return Compare (vs) >= 0;}
    int IsLessThan (VersionString vs) {return Compare (vs) < 0;}
    int IsLessThanOrEqualTo (VersionString vs) {return Compare (vs) <= 0;}
    int IsNotEqualTo (VersionString vs) {return Compare (vs) != 0;}

    VersionString SetPublicPart (unsigned int n) {
	PublicPart = n;
	return self;
    }

    VersionString SetProtectedPart (unsigned int n) {
	ProtectedPart = n;
	return self;
    }

    VersionString SetImplementationPart (unsigned int n) {
	ImplementationPart = n;
	return self;
    }
}
