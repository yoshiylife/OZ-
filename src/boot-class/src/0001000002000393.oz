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

/*
 * sortableset.oz
 *
 * Sortable Set.
 * Element must not be 0.
 */

/* TYPE PARAMETERS: TContent */

class SortableSet <TContent> : Set <TContent> {
  constructor: New, NewWithSize;

  public:
    Add, AddAll, AddContentsTo, AsArray, Compare,
    DoFinish, DoNext, DoReset, FindObjectWithKey, Includes,
    IsEmpty, IsEqual,
    OccurrencesOf, Remove, RemoveAll, RemoveAllContent, Size;

  protected: Capacity, FindIndexOf, H, ReSize, SetCapacity;

  protected: Contents, DefaultCapacity, Mask, OrderedIndex, OrderedIndexMax;

/* instance variables */
    unsigned int OrderedIndex [];
    int OrderedIndexMax;

/* method implementations */
    int Compare (SortableSet <TContent> collection) {
	Iterator <TContent> i=>New (self);
	Iterator <TContent> j=>New (collection);
	int res;

	for (;;) {
	    TContent ci, cj;

	    ci = i->PostIncrement ();
	    cj = j->PostIncrement ();
	    if (ci == 0) {
		res = (cj == 0) ? 0 : -1;
		break;
	    } else if (cj == 0) {
		res = 1;
		break;
	    } else if ((res = ci->Compare (cj)) != 0) {
		break;
	    }
	}
	i->Finish ();
	j->Finish ();
	return res;
    }

    TContent DoNext (Iterator <TContent> pos) {
	int i;

	i = pos->GetIndex ();
	pos->SetIndex (i + 1);
	if (i <= OrderedIndexMax)
	  return Contents [OrderedIndex [i]];
	else
	  return 0;
    }

    void DoReset (Iterator <TContent> po) {Sort ();}

    void Sort () {
	int n = length Contents, i, j, k;

	length OrderedIndex = n;

	for (i = 0, j = 0; i < n; i ++) {
	    if (Contents [i] != 0) {
		OrderedIndex [j++] = i;
	    }
	    OrderedIndexMax = j - 1;

	    /* bubble sort */
	    for (i = 0; i < (OrderedIndexMax - 1); i ++) {
		for (j = OrderedIndexMax; j > i; j --) {
		    if (Contents [OrderedIndex [j]]
			->Compare (Contents [OrderedIndex [j - 1]])
			< 0) {
			k = OrderedIndex [j];
			OrderedIndex [j] = OrderedIndex [j - 1];
			OrderedIndex [j - 1] = k;
		    }
		}
	    }
	}
    }
}
