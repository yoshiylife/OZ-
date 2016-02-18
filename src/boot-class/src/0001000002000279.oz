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

// we don't have OzRename


// we distribute class not by tar'ed directory


// we have bug in StreamBuffer


// we have no support for getting executor ID


// we don't use Object::GetPropertyPathName


// we have a bug in gen-spec-src

/*
 * nldisposer.oz
 *
 * New line disposer
 */

class NewLineDisposer : TokenExtractor {
  constructor: New;
  public: Extract;

/* no instance variable */

/* method implementations */
    Token Extract (Stream file) {
	int c;

	debug {
	    c = file->GetC ();
	    debug (0, "NewLineDisposer::Extract: c = %d\n", c);
	    file->UngetC (c);
	}

	while (IsSpace (c = file->GetC ())) {
	    debug (0, "NewLineDisposer::Extract skipped %d\n", c);
	}
	debug (0, "NewLineDisposer::Extract: next = %d\n", c);

	if (c == StreamConstants::EOF) {
	    EOFToken eof;
	    return eof=>New ();
	} else {
	    file->UngetC (c);
	    return 0;
	}
    }
}
