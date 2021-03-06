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
 * bholder.oz
 *
 * holder of Boolean
 */

class BooleanHolder : Exclusive (rename New SuperNew;) {
  constructor: New;
  public: Reset, Revert, Set, Test;
  public: Lock, Unlock;
  protected: SuperNew;
  protected: Value;
  protected: LockCondition, Locking;

/* instance variables */
    int Value;

/* method implementations */
    void New (int value) {
	SuperNew ();
	Value = value;
    }

    void Change (int val) : locked {Value = val;}

    void Reset () {
	Lock ();
	Change (0);
	Unlock ();
    }

    void Revert () {
	Lock ();
	Change (! Value);
	Unlock ();
    }

    void Set () {
	Lock ();
	Change (1);
	Unlock ();
    }

    int Test () : locked {return Value;}
}
