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


// we use exceptions with parameters
//#define NOEXCEPTIONPARAMETER

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
//#define NOALIASBUG

// we have no executor who recognize relative path from OZHOME


// we have OzCopy
//#define NOOZCOPY

// we distribute class not by tar'ed directory


// we have bug in StreamBuffer

/*
 * oidaskey.oz
 *
 * Add methods needed for keys of collections to global object.
 */

/* TYPE PARAMETERS: TKey */

class OIDAsKey <global DirectoryServer<global ResolvableObject>> {
  constructor: New;
  public: Compare, Get, Hash, IsEqual, Set;

/* instance variables */
    global DirectoryServer<global ResolvableObject> Key;

/* method implementations */
    void New (global DirectoryServer<global ResolvableObject> o) {Set (o);}

    int Compare (OIDAsKey <global DirectoryServer<global ResolvableObject>> k) {
	int res;
	global DirectoryServer<global ResolvableObject> o1 = Get ( );
	global DirectoryServer<global ResolvableObject> o2 = k->Get ( );

	inline "C" {
	    res = o1 - o2;
	}
	return res;
    }

    global DirectoryServer<global ResolvableObject> Get () : locked {return Key;}

    unsigned int Hash () {
	unsigned int res;
	global DirectoryServer<global ResolvableObject> k = Get ( );

	inline "C" {
	    res = (unsigned int) k;
	}
	return res;
    }

    int IsEqual (OIDAsKey <global DirectoryServer<global ResolvableObject>> k) {return Get () == k->Get ();}

    void Set (global DirectoryServer<global ResolvableObject> o) : locked {Key = o;}
}
