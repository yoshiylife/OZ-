/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

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


// we have a bug in reference counter treatment when forking thread
//#define NOFORKBUG

// we don't have a bug in assigning 0 to a record instance

/*
 * dictionary.oz
 *
 * Keyed set.
 */

/* TYPE PARAMETERS: TKey,TValue */

class Dictionary <String, ProjectLinkSS> : Set <Assoc <String, ProjectLinkSS>>
  (rename FindIndexOf FindIndexOfInSet;
   rename FindObjectWithKey FindObjectWithKeyInSet;
   rename OccurrencesOf OccurrencesOfInSet;) {
    constructor: New, NewWithSize;
    public:
      AddAssoc, AssocAt, AtKey, DoFinish, DoNext, DoReset,
      IncludesKey, IsEmpty, IsEqual, RemoveKey, SetAtKey, SetOfKeies, Size;

    protected:
      Add, FindIndexOf, FindIndexOfInSet, FindObjectWithKey,
      FindObjectWithKeyInSet, H, OccurrencesOf, OccurrencesOfInSet;

    protected: Contents, Mask;

/* no instance variable */

/* method implementations */
      Assoc <String, ProjectLinkSS> AddAssoc (String key, ProjectLinkSS value) {
	  Assoc <String, ProjectLinkSS> a=>New (key, value);
	  Assoc <String, ProjectLinkSS> b = Add (a);

	  debug {
	      inline "C" {
		  OzDebugf ("Dictionary::AddAssoc: key = %x, value = %p\n",
			    key, value);
	      }
	  }
	  if (a != b)
	    raise CollectionExceptions<String>::RedefinitionOfKey (key);
	  return b;
      }

      Assoc <String, ProjectLinkSS> AssocAt (String key) {return FindObjectWithKey (key);}

      ProjectLinkSS AtKey (String key) {
	  Assoc <String, ProjectLinkSS> assoc = FindObjectWithKey (key);

	  if (assoc == 0) {
	      raise CollectionExceptions<String>::UnknownKey (key);
	  } else {
	      return assoc->Value ();
	  }
      }

      int FindIndexOf (String key) {
	  int i;

	  for (i = H (key->Hash ()); Contents [i] != 0;
	       i = (i-1) & Mask) {
	      if (Contents [i]->Key ()->IsEqual (key))
		break;
	  }

	  debug {
	      inline "C" {
		  OzDebugf ("Dictionary::FindIndexOf: returning %d for %p\n",
			    i, key);
	      }
	  }
	  return i;
      }

      Assoc <String, ProjectLinkSS> FindObjectWithKey (String key) {
	  return Contents [FindIndexOf (key)];
      }

      int IncludesKey (String key) {
	  return FindObjectWithKey (key) != 0;
      }

      unsigned int OccurrencesOf (String key) {
	  return (FindObjectWithKey (key) != 0) ? 1 : 0;
      }

      Assoc <String, ProjectLinkSS> RemoveKey (String key) {
	  Assoc <String, ProjectLinkSS> assoc = FindObjectWithKey (key);

	  if (assoc == 0) {
	      raise CollectionExceptions<String>::UnknownKey (key);
	  } else {
	      return Remove (assoc);
	  }
      }

      ProjectLinkSS SetAtKey (String key, ProjectLinkSS data) {
	  Assoc <String, ProjectLinkSS> assoc = FindObjectWithKey (key);

	  if (assoc == 0) {
	      raise CollectionExceptions<String>::UnknownKey (key);
	  } else {
	      return assoc->SetValue (data);
	  }
      }

      Set <String> SetOfKeies () {
	  Set <String> s=>New ();
	  Iterator <Assoc <String, ProjectLinkSS>> i;
	  Assoc <String, ProjectLinkSS> assoc;

	  for (i=>New (self);
	       (assoc = i->PostIncrement ()) != 0;) {
	      s->Add (assoc->Key ());
	  }
	  return s;
      }
  }
