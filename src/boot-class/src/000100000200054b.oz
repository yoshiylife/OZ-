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

// we have bug in alias


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

// we use the new ObjectManager::NewObject
//#define NONEWNEWOBJECT

// we have a bug in OzOmObjectTableRemove
//#define NOBUGINOZOMOBJECTTABLEREMOVE
/*
 * set.oz
 *
 * Set.
 * Element must not be 0.
 */

/* TYPE PARAMETERS: TContent */

class Set <OIDAsKey<global ClassID>> : Collection <OIDAsKey<global ClassID>>
  (rename New SuperNew;
   rename AddContentsTo SuperAddContentsTo;)
{
  constructor:
    New, NewWithSize;

  public:
    Add, AddAll, AddContentsTo, AsArray, Difference,
    DoFinish, DoNext, DoReset, FindObjectWithKey, Hash, Includes,
    Intersection, IsEmpty, IsEqual, IsSubSetOf, IsSuperSetOf,
    OccurrencesOf, Remove, RemoveAll, RemoveAllContent, RemoveAny, Size,
    Union;

  protected:
    Capacity, FindIndexOf, H, ReSize, SetCapacity;

  protected: Contents, DefaultCapacity, Mask;

/* instance variables */
    unsigned int Count; /* number of objects in set */
    unsigned int Nbits; /* log base 2 of length Contents */
    unsigned int Mask; /* length Contents - 1 */
    OIDAsKey<global ClassID> Contents [];

/* method implementations */
    void New () {
	SuperNew ();
	length Contents = SetCapacity (DefaultCapacity);
    }

    void NewWithSize (unsigned int size) {
	SuperNew ();
	length Contents = SetCapacity (size);
    }

    /* Add an object to this Set. */
    OIDAsKey<global ClassID> Add (OIDAsKey<global ClassID> t) {
	unsigned int i = FindIndexOf (t);

	if (Contents [i] == 0) { /* add new object */
	    Contents [i] = t;
	    if (++ Count > Capacity () / ExpansionFactor) {
		ReSize (Capacity () * ExpansionFactor);
	    }
	    debug {
		inline "C" {
		    OzDebugf ("Set::Add: Element added. ");
		    OzDebugf ("set = %p, index = %d, t = %p\n",
			      self, i, t);
		}
	    }
	    return t;
	} else {
	    return Contents [i];
	}
    }

    Set <OIDAsKey<global ClassID>> AddContentsTo (Set <OIDAsKey<global ClassID>> collection){
	SuperAddContentsTo (collection);
	return collection;
    }

    unsigned int Capacity () {return length Contents;}

    Set <OIDAsKey<global ClassID>> Difference (Set <OIDAsKey<global ClassID>> s) {
	unsigned int i;
	Set <OIDAsKey<global ClassID>> diff = ShallowCopy ();
	unsigned int n = length Contents;

	for (i = 0; i < n; i ++) {
	    if (Contents [i] != 0 && s->Includes (Contents [i]))
	      diff->Remove (Contents [i]);
	}
	return diff;
    }

    OIDAsKey<global ClassID> DoNext (Iterator <OIDAsKey<global ClassID>> pos) {
	unsigned int n = length Contents, i;

	for (i = pos->GetIndex (); i < n; i ++) {
	    if (Contents [i] != 0) {
		pos->SetIndex (i + 1);
		return Contents [i];
	    }
	}
	pos->SetIndex (n);
	return 0;
    }

    OIDAsKey<global ClassID> FindObjectWithKey (OIDAsKey<global ClassID> key) {
	return Contents [FindIndexOf (key)];
    }

    unsigned int Hash () {
	unsigned int h = 0;
	Iterator <OIDAsKey<global ClassID>> i;
	OIDAsKey<global ClassID> o;

	for (i=>New (self); o = i->PostIncrement ();) {
	    h ^= o->Hash ();
	}
	i->Finish ();
	return h;
    }

    int IsEqual (Collection <OIDAsKey<global ClassID>> s) {
	return IsSubSetOf (s) && IsSuperSetOf (s);
    }

    int IsSubSetOf (Collection <OIDAsKey<global ClassID>> collection) {
	if (Count > collection->Size ()) {
	    return 0;
	} else {
	    unsigned int i;
	    unsigned int n = length Contents;

	    for (i = 0; i < n ; i ++) {
		if (Contents [i] != 0
		    && ! collection->Includes (Contents [i])) {
		    return 0;
		}
	    }
	    return 1;
	}
    }

    int IsSuperSetOf (Collection <OIDAsKey<global ClassID>> collection) {
	if (Count < collection->Size ()) {
	    return 0;
	} else {
	    Iterator <OIDAsKey<global ClassID>> i=>New (collection);
	    OIDAsKey<global ClassID> c;

	    for (i->Reset (); (c = i->PostIncrement ()) != 0;) {
		if (! Includes (c) || collection->OccurrencesOf (c) > 1) {
		    return 0;
		}
	    }
	    return 1;
	}
    }

    /*
     * Return the number of occurences of the specified object
     * in this Set (either 0 or 1).
     */
    unsigned int OccurrencesOf (OIDAsKey<global ClassID> t) {
	return FindObjectWithKey (t) != 0;
    }

    /*
     * Remove object from set.
     * Input: t = object to be removed
     * Returns: removed object
     * Algorithm R, Knuth Vol. 3 p. 527
     */
    OIDAsKey<global ClassID> Remove (OIDAsKey<global ClassID> t) {
	unsigned int i = FindIndexOf (t);
	OIDAsKey<global ClassID> rob = Contents [i];

	if (rob == 0) {
	    raise CollectionExceptions<OIDAsKey<global ClassID>>::ElementNotFound (t);
	} else {
	    unsigned int j, r;

	    while (1) {
		Contents [j = i] = 0;
		do {
		    i = (i - 1) & Mask;
		    if (Contents [i] == 0) {
			-- Count;
			return rob;
		    }
		    r = H (Contents [i]->Hash ());
		} while ((i<=r && r<j) || (r<j && j<i) || (j<i && i<=r));
		Contents [j] = Contents [i];
	    }
	}
	return t;
    }

    OIDAsKey<global ClassID> RemoveAny () {
	if (Size () == 0) {
	    raise CollectionExceptions<OIDAsKey<global ClassID>>::Empty;
	} else {
	    unsigned int n = length Contents, i;

	    for (i = 0; i < n; i ++) {
		if (Contents [i] != 0) {
		    return Remove (Contents [i]);
		}
	    }
	}
    }
	
    /* Change the capacity of this Set to new_size. */
    void ReSize (unsigned int new_size) {
	unsigned int i;

	if (new_size <= Count) {
	    raise
	      CollectionExceptions<OIDAsKey<global ClassID>>::InvalidIntParameter (new_size);
	}
	if (Count > 0) {
	    unsigned int n = length Contents;
	    OIDAsKey<global ClassID> old_contents [] = Contents;
	    OIDAsKey<global ClassID> new_contents [];

	    length new_contents = SetCapacity (new_size);
	    Contents = new_contents;
	    for (i = 0; i < n; i ++) {
		OIDAsKey<global ClassID> t = old_contents [i];
		if (t != 0) {
		    Add (t);
		}
	    }
	} else {
	    length Contents = SetCapacity (new_size);
	}
    }

    Set <OIDAsKey<global ClassID>> Intersection (Set <OIDAsKey<global ClassID>> s) {
	Set <OIDAsKey<global ClassID>> set_intersection = ShallowCopy ();
	unsigned int n = length Contents;
	unsigned int i;

	for (i = 0; i < n; i ++) {
	    if (Contents [i] != 0 && !s->Includes (Contents [i]))
	      set_intersection->Remove (Contents [i]);
	}
	return set_intersection;
    }

    Set <OIDAsKey<global ClassID>> ShallowCopy () {
	Iterator <OIDAsKey<global ClassID>> i;
	OIDAsKey<global ClassID> content;
	Set <OIDAsKey<global ClassID>> new=>NewWithSize (Size ());

	for (i=>New (self); content = i->PostIncrement ();) {
	    new->Add (content);
	}
	i->Finish ();
	return new;
    }

    unsigned int Size () {return Count;}

    Set <OIDAsKey<global ClassID>> Union (Set <OIDAsKey<global ClassID>> s) {
	Set <OIDAsKey<global ClassID>> set_union = ShallowCopy ();

	set_union->AddAll (s);
	return set_union;
    }

/* protected method implementations below */
    unsigned int SetCapacity (unsigned int size) {
	unsigned int s;

	if (size == 0) { /* cannot create 0 sized hash table */
	    size = 1;
	}
	Count = 0;
	Nbits = 0;
	for (s = size - 1; s != 0; s >>= 1) {
	    Nbits ++;
	}
	size = 1 << Nbits;
	Mask = size - 1;
	return size; /* return hash table size */
    }

    /*
     * Search this set for the specified object
     * Input: t = object to search for
     * Returns: index of object if found or of nil slot if not found
     * Algorithm L, Knuth Vol. 3, p. 519
     */
    unsigned int FindIndexOf (OIDAsKey<global ClassID> t) {
	unsigned int i;

	for (i = H (t->Hash ()); Contents [i] != 0; i = (i-1) & Mask) {
	    if (Contents [i]->IsEqual (t))
	      return i;
	}
	return i;
    }

    unsigned int H (unsigned int key) {
	/* mjs:	unsigned long Aw = 2654435769UL; */
	unsigned int Aw = 0x9E3779B9;
	/*      unsigned long Aw = 40503;
		use for 16 bit machines? */
	unsigned long s = ((Aw * key) >> (32 - Nbits));
	unsigned int ret = s & Mask;

	debug (0, "Set <TContent>::H: Aw = %u, key = %u, ", Aw, key);
	debug (0, "Nbits = %u, Mask = %u, ret = %u\n", Nbits, Mask, ret);
	return ret;
	/* Implementation Dependent:
	   32 is a bit length of unsigned int */
    }
}
