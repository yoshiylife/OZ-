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


// we have bug in StreamBuffer


// we have no support for getting executor ID


// we don't use Object::GetPropertyPathName


// we have a bug in gen-spec-src


// we have a bug in reference counter treatment when forking private thread
//#define NOFORKBUG
/*
 * collection.oz
 *
 * Collection of data or objects.
 * Abstract class
 */

/* TYPE PARAMETERS: TContent */

abstract class Collection <Token> {
  protected: /* for the constructor of subclasses */
    New, NewWithCollection;
  public:
    Add, AddAll, AddContentsTo, AsArray, DoFinish, DoNext,
    DoReset, Hash, Includes, IsEmpty, IsEqual, OccurrencesOf, Remove,
    RemoveAllContent, RemoveAll, Size;

  protected: DefaultCapacity, ExpansionFactor, ExpansionIncrement;

/* instance variables */
    /* default initial collection capacity */
    unsigned int DefaultCapacity; /* = 16; */

    /* collection (Set,Bag,Dictionary) expansion factor  */
    unsigned int ExpansionFactor; /* = 2; */

    /* collection (OrderedCollection) expansion increment */
    unsigned int ExpansionIncrement; /* = 32; */

/* abstract methods */
    Token Add (Token content) : abstract;
    Token DoNext (Iterator <Token> i) : abstract;
    unsigned int Hash () : abstract;
    int IsEqual (Collection <Token> collection) : abstract;
    unsigned int OccurrencesOf (Token content) : abstract;
    Token Remove (Token content) : abstract;

/* method inplementation */
    Collection <Token> AddAll (Collection <Token> collection) {
	collection->AddContentsTo (self);
	return collection;
    }

    Collection <Token> AddContentsTo (Collection <Token> collection){
	Iterator <Token> i;
	Token content;

	for (i=>New (self); (content = i->PostIncrement ()) != 0;)
	  collection->Add (content);
	i->Finish ();
	return collection;
    }

    Token AsArray () [] {
	Token array [];
	Iterator <Token> i;
	Token t;
	unsigned int j = 0;

	length array = Size ();
	debug (0, "Collection::AsArray: Size = %d\n", length array);
	for (i=>New (self); (t = i->PostIncrement ()) != 0;) {
	    array [j++] = t;
	}
	i->Finish ();
	return array;
    }

    void DoFinish (Iterator <Token> i) {}

    void DoReset (Iterator <Token> i) {}

    int Includes (Token content) {return OccurrencesOf (content) != 0;}

    int IsEmpty () {return Size () == 0;}

    void New () {
	DefaultCapacity = 16;
	ExpansionFactor = 2;
	ExpansionIncrement = 32;
    }

    void NewWithCollection (Collection <Token> collection) {
	New ();
	AddAll (collection);
    }

    Collection <Token> RemoveAll (Collection <Token> collection) {
	Iterator <Token> i;
	Token content;

	for (i=>New (collection);
	     (content = i->PostIncrement ()) != 0;)
	  Remove (content);
	i->Finish ();
	return collection;
    }

    void RemoveAllContent () {
	Iterator <Token> i;
	Token content;

	for (i=>New (self); (content = i->PostIncrement ()) != 0;)
	  Remove (content);
	i->Finish ();
    }

    unsigned int Size () {
	Iterator <Token> i;
	unsigned int size = 0;

	for (i=>New (self); (i->PostIncrement ()) != 0;)
	  size ++;
	i->Finish ();
	return size;
    }
}
