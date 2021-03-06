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

class UnixIO {
  constructor: New, Spawn, Open;
  public: PutChar, PutReturn, PutInt, PutStr, PutString, PutOID;
  public: PutHex, PutObject;
  public: Read, Write, ReadString, WriteString;
  public: StartDebugging, EndDebugging;
  public: Close;

    char aBuffer[];

    int Debug;

    int aFDout, aFDin;

    void AllocateBuffer (int size) {
	char buf[] = aBuffer;

	inline "C" {
	    if (buf)
	      OzExecFree ((OZ_Pointer) buf);
	}
	length aBuffer = size;
    }

    void Init () {
	AllocateBuffer (1024);
	Debug = 0;
    }

    void New () {
	Init ();
	aFDout = aFDin = 0;
    }

    void Open (char filename[], char mode[], int perm) {
	String m=>NewFromArrayOfChar (mode);
	EnvironmentVariable env;
	String buf;

	buf = env.GetEnv ("OZROOT")->ConcatenateWithArrayOfChar ("/")
	  ->ConcatenateWithArrayOfChar (filename);

	filename = buf->Content ();

	Init ();

	if (m->IsEqualToArrayOfChar ("r")) {
	    inline "C" {
		OZ_InstanceVariable_UnixIO (aFDin)
		  = OzOpen (OZ_ArrayElement (filename, char), O_RDONLY, perm);
	    }
	    aFDout = 0;
	} else if (m->IsEqualToArrayOfChar ("w")) {
	    inline "C" {
		OZ_InstanceVariable_UnixIO (aFDout)
		  = OzOpen (OZ_ArrayElement (filename, char), 
			    O_WRONLY | O_CREAT | O_TRUNC, perm);
	    }
	    aFDin = 0;
	} else if (m->IsEqualToArrayOfChar ("a")) {
	    inline "C" {
		OZ_InstanceVariable_UnixIO (aFDout)
		  = OzOpen (OZ_ArrayElement (filename, char), 
			    O_APPEND | O_CREAT, perm);
	    }
	    aFDin = 0;
	} else if (m->IsEqualToArrayOfChar ("r+")) {
	    inline "C" {
		OZ_InstanceVariable_UnixIO (aFDin) 
		  = OzOpen (OZ_ArrayElement (filename, char), O_RDWR, perm);
	    }
	    aFDout = aFDin;
	} else if (m->IsEqualToArrayOfChar ("w+")) {
	    inline "C" {
		OZ_InstanceVariable_UnixIO (aFDout)
		  = OzOpen (OZ_ArrayElement (filename, char), 
			    O_RDWR | O_CREAT | O_TRUNC, perm);
	    }
	    aFDin = aFDout;
	} else if (m->IsEqualToArrayOfChar ("a+")) {
	    inline "C" {
		OZ_InstanceVariable_UnixIO (aFDout)
		  = OzOpen (OZ_ArrayElement (filename, char), 
			    O_RDWR | O_APPEND | O_CREAT | O_TRUNC, 
			    perm);
	    }
	    aFDin = aFDout;
	}
    }

    void Spawn (char argv [][]) {
	int argc = length argv, i;

	Init ();

	inline "C" {
	    char *arg[256];
	    OZ_Array buf;

	    for (i = 0; i < argc; i++) {
		buf = (OZ_ArrayElement (argv, OZ_Array))[i],
		arg[i] = OZ_ArrayElement (buf, char);
	    }

	    arg[i] = 0;

	    OZ_InstanceVariable_UnixIO (aFDin) = OzVspawn (arg[0], arg);
	}
	aFDout = aFDin;
    }

    char Read (int size)[] {
	char buf[];
	int len;

	if (!aFDin)
	  return 0;

	if (size > length aBuffer) {
	    AllocateBuffer (size);
	    buf = aBuffer;
	} else {
	    len = length aBuffer;
	    buf = aBuffer;
	    inline "C" {
		int i;
		for (i = 0; i < len; i++)
		  ((char *) OZ_ArrayElement (buf, char))[i] = 0;
	    }
	}

	inline "C" {
	    if ((len = OzRead (OZ_InstanceVariable_UnixIO (aFDin),
			       OZ_ArrayElement (buf, char), size)) < 0) {
		OzDebugf ("error: (UnixIO: Read) cannot read\n");
	    }
	}

	if (len <= 0)
	  return 0;
	else
	  return aBuffer;
    }

    String ReadString (int size) {
	String str;

	if (!Read (size))
	  return 0;

	return str=>NewFromArrayOfChar (aBuffer);
    }

    void Write (char b []) {
	int size;

	if (!aFDout)
	  return;

	size = length b;

	inline "C" {
	    if (OzWrite (OZ_InstanceVariable_UnixIO (aFDout),
			 OZ_ArrayElement (b, char), size) < 0)
	      OzDebugf ("error: (UnixIO: Write) cannot write\n");
	}
    }

    void WriteString (String str) {
	Write (str->Content ());
    }

    void StartDebugging () {
	Debug = 1;
    }

    void EndDebugging () {
	Debug = 0;
    }

    UnixIO PutChar (char c) {
	if (aFDout)
	  inline "C" {
	      if (OzWrite (OZ_InstanceVariable_UnixIO (aFDout),
			   (char *)&c, sizeof (char)) < 0)
		OzDebugf ("error: (UnixIO: PutChar) cannot write\n");
	  } else
	    inline "C" {
		OzDebugf ("%c", c); 
	    }

	return self;
    }

    UnixIO PutReturn () {
	return PutChar ('\n');
    }

    UnixIO PutInt (int d) {
	if (aFDout) {
	    inline "C" {
		char s[20];

		OzSprintf (s, "%d", d);

		if (OzWrite (OZ_InstanceVariable_UnixIO (aFDout),
			     s, OzStrlen (s)) < 0)
		  OzDebugf ("error: (UnixIO: PutInt) cannot write\n");
	    }
	} else
	  inline "C" {
	      OzDebugf ("%d", d); 
	  }

	return self;
    }

    UnixIO PutHex (int d) {
	if (aFDout) 
	  inline "C" {
	      if (OzWrite (OZ_InstanceVariable_UnixIO (aFDout),
			   (char *)&d, sizeof (int)) < 0)
		OzDebugf ("error: (UnixIO: PutHex) cannot write\n");
	  } else
	    inline "C" {
		OzDebugf ("%x", d); 
	    }

	return self;
    }

    UnixIO PutObject (Object o) {
	if (aFDout) 
	  inline "C" {
	      if (OzWrite (OZ_InstanceVariable_UnixIO (aFDout),
			   (char *)o, sizeof (OZ_Object)) < 0)
		OzDebugf ("error: (UnixIO: PutObject) cannot write\n");
	  } else
	    inline "C" {
		OzDebugf ("%x", o); 
	    }

	return self;
    }

    UnixIO PutStr (char s[]) {
	int fd = aFDout ? aFDout : 2;

	inline "C" {
	    char *buf = OZ_ArrayElement (s, char);

	    if (OzWrite (fd, buf, OzStrlen (buf)) < 0)
	      OzDebugf ("error: (UnixIO: PutStr) cannot write\n");
	}
	   
	return self;
    }

    UnixIO PutString (String str) {
	return PutStr (str->Content ());
    }

    UnixIO PutOID (global Object o) {
	if (aFDout) 
	  inline "C" {
	      char buf[17];

	      OzSprintf (buf, "%08x%08x", 
			 (int) (o >> 32), (int) (o & 0xffffffff));

	      if (OzWrite (OZ_InstanceVariable_UnixIO (aFDout),
			   buf, 16) < 0)
		OzDebugf ("error: (UnixIO: PutOID) cannot write\n");
	  } else
	    inline "C" {
		OzDebugf ("%08x%08x", (int) (o >> 32), (int) (o & 0xffffffff));
	    }

	return self;
    }

    void Close () {
	if (aFDout != aFDin) {
	    if (aFDout)
	      inline "C" { OzClose (OZ_InstanceVariable_UnixIO (aFDout)); }
	    if (aFDin)
	      inline "C" { OzClose (OZ_InstanceVariable_UnixIO (aFDin)); }
	} else if (aFDout)
	  inline "C" { OzClose (OZ_InstanceVariable_UnixIO (aFDout)); }
    }
}
