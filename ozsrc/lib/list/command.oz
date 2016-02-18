/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

abstract class Command {
 public:
  Execute, GetName;
 public:
  IsEqual, Hash;
 protected:
  Name, MyName, New;

  /* instance variabels */
  String Name;

  /* public methods */
  String GetName(){ return Name; }

  int Execute( SList ) : abstract;

  int IsEqual( Command another ){
    return Name -> IsEqual( another -> GetName());
  }

  char MyName()[]{
    char n[];
    return n;
  }

  void New(){
    Name => NewFromArrayOfChar( MyName());
  }

  unsigned int Hash(){
    if( Name ){
      return Name -> Hash();
    }
    return 0;
  }
}
