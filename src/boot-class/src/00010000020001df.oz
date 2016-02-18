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


// we have no bug in class StreamBuffer
//#define STREAMBUFFERBUG

// we have no support for getting executor ID


// we use Object::GetPropertyPathName
//#define NOGETPROPERTYPATHNAME

// we have a bug in reference counter treatment when forking private thread
//#define NOFORKBUG

// we have a bug in OzOmObjectTableRemove
//#define NOBUGINOZOMOBJECTTABLEREMOVE

// we have no account directory


// we have no str[fp]time


// boot classes are modifiable


// when object manager is started, its configuration cache won't be cleared
//#define CLEARCONFIGURATIONCACHEATSTART

// the executor doesn't expect a class cannot be found

/*
 * inttoken.oz
 *
 * Lexical token of integer.
 */

class IntegerToken : Token {
  constructor: New;
  public: Compare, Get, Hash, IsEqual, Print, Type;

  protected: Content;

/* instance variables */
    long Content;

/* method implementations */
    void New (long c) {
	Content = c;
	debug (0, "IntegerToken::New: c = %ld\n", c);
    }

    int Compare (Token t) {
	int res;

	if ((res = Type () - t->Type ()) != 0) {
	    return res;
	} else {
	    long diff = Get () - narrow (IntegerToken, t)->Get ();

	    if (diff > 0) {
		return 1;
	    } else if (diff == 0) {
		return 0;
	    } else {
		return -1;
	    }
	}
    }

    long Get () {
	debug (0, "IntegerToken::Get: Content == %ld\n", Content);
	return Content;
    }

    unsigned int Hash () {
	int r;
	long l = Get ();

	inline "C" {r = l;}
	return r;
    }

    int IsEqual (Token t) {
	return
	  Type () == t->Type ()
	    && Get () == narrow(IntegerToken, t)->Get () == Get ();
    }

    String Print () {
	ArrayOfCharOperators acops;
	int c = Content;
	String res=>NewFromArrayOfChar (acops.ItoA (c));

	return res;
    }

    int Type () {return TokenType::IntegerType;}
}
