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


// we have no support for getting executor ID


// we don't use Object::GetPropertyPathName


// we have a bug in gen-spec-src

/*
 * idextractor.oz
 *
 * Identifier extractor
 * No support for internationalization
 */

class IdentifierExtractor : TokenExtractor (rename New SuperNew;) {
/* method interface */
  constructor: New;
  public: Extract;
  protected: IsDigit, IsLetter, SetInitialBufferSize;

/* instance variables */
    unsigned int InitialBufferSize; /* = 16; */

/* method implementations */
    void New () {
	SuperNew ();
	SetInitialBufferSize ();
    }

    Token Extract (Stream file) {
	int c;

	if (IsLetter (c = file->GetC ())) {
	    return ExtractIdentifier (c, file);
	} else if (c == StreamConstants::EOF) {
	    EOFToken eof;
	    return eof=>New ();
	} else {
	    file->UngetC (c);
	    return 0;
	}
    }

    IdentifierToken ExtractIdentifier (int first, Stream file) {
	IdentifierToken token;
	char buffer [];
	unsigned int i = 0;
	int c = first;

	length buffer = InitialBufferSize;
	do {
	    buffer [i ++] = c;
	    if (i == length buffer)
	      length buffer += InitialBufferSize;
	} while (IsLetter (c = file->GetC ()) || IsDigit (c));
	buffer [i] = 0;
	if (c != StreamConstants::EOF)
	  file->UngetC (c);
	return token=>New (buffer);
    }

    void SetInitialBufferSize () {InitialBufferSize = 16;}
}
