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
 * wmailsender.oz
 *
 * Mail sender through Web request
 */

class WebMailSender : Launchable {
  protected: SendIt;

    void Launch () {
	global OZCGI cgi;
	String cgi_name=>NewFromArrayOfChar (OZCGIConstants::CGIName);
	String form_name=>NewFromArrayOfChar ("mailer.html");

	cgi = narrow (OZCGI,
		      Where ()->GetNameDirectory ()->Resolve (cgi_name));
	if (cgi != 0) {
	    while (1) {
		HTMLMessage request = cgi->GetRequest (form_name);

		if (request == 0) {
		    break;
		} else {
		    detach fork SendIt (request, cgi);
		}
	    }
	}
    }

    void SendIt (HTMLMessage request, global OZCGI cgi) {
	String to_key=>NewFromArrayOfChar ("to");
	String cc_key=>NewFromArrayOfChar ("cc");
	String subject_key=>NewFromArrayOfChar ("subject");
	String body_key=>NewFromArrayOfChar ("body");
	String req_id=>NewFromArrayOfChar (OZCGIConstants::KeyforRequestID);
	Mailer mailer=>New ();
	String m;

	m=>NewFromArrayOfChar ("To: ");
	m = m->Concatenate (request->AtKey (to_key)->RemoveAny ());
	m = m->ConcatenateWithArrayOfChar ("\ncc: ");
	m = m->Concatenate (request->AtKey (cc_key)->RemoveAny ());
	m = m->ConcatenateWithArrayOfChar ("\nSubject: ");
	m = m->Concatenate (request->AtKey (subject_key)->RemoveAny ());
	m = m->ConcatenateWithArrayOfChar ("\n\n");
	m = m->Concatenate (request->AtKey (body_key)->RemoveAny ());
	mailer->Send (m);
	m=>NewFromArrayOfChar ("<head><title>Mailer Result</title></head>\n");
	m = m->ConcatenateWithArrayOfChar ("<body>sent.</body>\n");
	cgi->PutResult (request->AtKey (req_id)->RemoveAny ()->AtoI (), m);
    }
}
