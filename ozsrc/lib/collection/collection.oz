/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

// we don't use record

//#define NORECORDACOPS

// we flush objects
//#define NOFLUSH

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


// boot classes are modifiable


// when object manager is started, its configuration cache won't be cleared
//#define CLEARCONFIGURATIONCACHEATSTART

// the executor doesn't expect a class cannot be found


// now, creating Feb.1 sources


// Executing Plan Plum: compressing the size of class object

/*
 * collection.oz
 *
 * Collection of data or objects.
 * Abstract class
 */

/* TYPE PARAMETERS: TContent */

abstract class Collection <TContent> {
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
    TContent Add (TContent content) : abstract;
    TContent DoNext (Iterator <TContent> i) : abstract;
    unsigned int Hash () : abstract;
    int IsEqual (Collection <TContent> collection) : abstract;
    unsigned int OccurrencesOf (TContent content) : abstract;
    TContent Remove (TContent content) : abstract;

/* method inplementation */
    Collection <TContent> AddAll (Collection <TContent> collection) {
	collection->AddContentsTo (self);
	return collection;
    }

    Collection <TContent> AddContentsTo (Collection <TContent> collection){
	Iterator <TContent> i;
	TContent content;

	for (i=>New (self); (content = i->PostIncrement ()) != 0;)
	  collection->Add (content);
	i->Finish ();
	return collection;
    }

    TContent AsArray () [] {
	TContent array [];
	Iterator <TContent> i;
	TContent t;
	unsigned int j = 0;

	length array = Size ();
	debug (0, "Collection::AsArray: Size = %d\n", length array);
	for (i=>New (self); (t = i->PostIncrement ()) != 0;) {
	    array [j++] = t;
	}
	i->Finish ();
	return array;
    }

    void DoFinish (Iterator <TContent> i) {}

    void DoReset (Iterator <TContent> i) {}

    int Includes (TContent content) {return OccurrencesOf (content) != 0;}

    int IsEmpty () {return Size () == 0;}

    void New () {
	DefaultCapacity = 16;
	ExpansionFactor = 2;
	ExpansionIncrement = 32;
    }

    void NewWithCollection (Collection <TContent> collection) {
	New ();
	AddAll (collection);
    }

    Collection <TContent> RemoveAll (Collection <TContent> collection) {
	Iterator <TContent> i;
	TContent content;

	for (i=>New (collection);
	     (content = i->PostIncrement ()) != 0;)
	  Remove (content);
	i->Finish ();
	return collection;
    }

    void RemoveAllContent () {
	Iterator <TContent> i;
	TContent content;

	for (i=>New (self); (content = i->PostIncrement ()) != 0;)
	  Remove (content);
	i->Finish ();
    }

    unsigned int Size () {
	Iterator <TContent> i;
	unsigned int size = 0;

	for (i=>New (self); (i->PostIncrement ()) != 0;)
	  size ++;
	i->Finish ();
	return size;
    }
}
