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
 * otm.oz
 *
 * Table of global objects
 */

class ObjectTableManager : Exclusive (rename New SuperNew;) {
  constructor: New;
  public: Add, Download, GetEntry, List, Lookup, Remove, Size, Shutdown;
  public: Lock, Unlock;
  protected: SuperNew;
  protected: anExecutor, Table;

/* instance variables */
    Executor anExecutor;
    SimpleTable <global Object, ObjectTableEntry> Table;

/* method implementations */

    void New (Executor e) {
	SuperNew ();
	anExecutor = e;
	Table=>New ();
    }


    void Add (global Object o, ObjectTableEntry ote) {
	Lock ();
	ote = Table->Add (o, ote);
	Unlock ();
	if (ote != 0) {
	    raise ObjectManagerExceptions::FatalError
	            ("Adding already existing global object.");
	}
    }

    void Download () : locked {
	unsigned int i, capa = Table->Capacity ();

	for (i = 0; i < capa; ++i) {
	    global Object o = Table->KeyAt (i);

	    if (o != 0) {
		ObjectTableEntry ote = Table->At (i);
		int init = ote->InitialStatus ();


		anExecutor->ObjectTableDownLoad (o, init);

		ote->Initialize ();
	    }
	}
    }

    ObjectTableEntry GetEntry (global Object o) {
	try {
	    return Table->AtKey (o);
	} except {
	    CollectionExceptions <global Object>::UnknownKey (k) {
		raise ObjectManagerExceptions::UnknownObject (o);
	    }
	}
    }

    global Object List ()[] {return Table->SetOfKeys ();}

    global Object Lookup (global Object o) {
	return Table->IncludesKey (o) ? o : 0;
    }

    void Remove (global Object o) {
	ObjectTableEntry ote;

	try {
	    Lock ();
	    ote = Table->RemoveKey (o);
	    Unlock ();
	    ote->Destroy ();
	} except {
	    CollectionExceptions <global Object>::UnknownKey (k) {
		Unlock ();
		raise ObjectManagerExceptions::UnknownObject (o);
	    }
	    default {
		Unlock ();
		raise;
	    }
	}
    }

    unsigned int Size () {return Table->Size ();}

    void Shutdown () {
	unsigned int i, capa;

	Lock ();
	capa = Table->Capacity ();
	for (i = 0; i < capa; i++) {
	    global Object o = Table->KeyAt (i);

	    if (o != 0) {
		ObjectTableEntry ote = Table->At (i);

		debug (0,"ObjectTableManager::Shutdown: next object = %O\n",o);
		ote->Shutdown ();
		if (! ote->IsPermanent ()) {
		    ote = Table->RemoveKey (o);
		    ote->Destroy ();
		}
	    }
	}
	Unlock ();
    }
}
