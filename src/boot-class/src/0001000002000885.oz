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

// we flush objects
//#define NOFLUSH

// we don't test flush
//#define FLUSHTESTATSTARTING

// we are debugging
//#define NDEBUG

// we have no bug in remote instantiation
//#define NOREMOTEINSTANTIATION

// we lookup configuration table for configured class ID


// we don't list directory by unix 'ls' command, but opendir library
//#define LISTBYLS

// we need change directory to $OZHOME before OzRead and OzSpawn


// we don't use OzRemoveCode
//#define USEOZREMOVECODE

// we don't read parents version IDs from private.i.
//#define READPARENTSFROMPRIVATEDOTI

// we have no executor who recognize relative path from OZHOME


// we have OzCopy
//#define NOOZCOPY

// we don't have OzRename


// we distribute class not by tar'ed directory


// we have a bug in class StreamBuffer


// we have no support for getting executor ID


// we use Object::GetPropertyPathName
//#define NOGETPROPERTYPATHNAME

// we have a bug in gen-spec-src


// we have a bug in reference counter treatment when forking private thread
//#define NOFORKBUG

// we have a bug in OzOmObjectTableRemove
//#define NOBUGINOZOMOBJECTTABLEREMOVE

// we have no account directory


// we have no str[fp]time


// boot classes are modifiable

/*
 * mirrorop.oz
 *
 * Mirror operation
 */

class MirrorOperation {
  constructor: New;
  public: GetArgument, GetDate, GetModificationMode, GetOperation;
  public: Hash, IsEqual;

/* instance variables */
    int Operation;
    global ClassID Argument [];
    int ModificationMode;
    Date ModificationDate;

/* method implementations */

    void New (int op, global ClassID arg [], int mode) {
	Operation = op;
	Argument = arg;
	ModificationMode = mode;
	ModificationDate=>Current ();
    }

    global ClassID GetArgument () [] {return Argument;}
    Date GetDate () {return ModificationDate;}
    int GetModificationMode () {return ModificationMode;}
    int GetOperation () {return Operation;}

    unsigned int Hash () {
	return Operation * 100 + length Argument * 10 + ModificationMode;
    }

    int IsEqual (MirrorOperation mo) {
	if (Operation == mo->GetOperation () &&
	    ModificationMode == mo->GetModificationMode ()) {
	    global ClassID arg [] = mo->GetArgument ();
	    unsigned int i, len = length Argument;

	    if (len == length arg) {
		for (i = 0; i < len; i ++) {
		    if (Argument [i] != arg [i]) {
			return 0;
		    }
		}
		return 1;
	    }
	}
	return 0;	      
    }
}
