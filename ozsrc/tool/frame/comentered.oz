/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

class ComEntered : CommandFor<Series> {
 constructor:
  New;
 public:
  Execute;

  char MyName()[]{ return "FieldTextChanged"; }

  int Execute( SList args ){
    IntAsKey key => New( args -> Car() -> AsString() -> AtoI());
    String value = args -> Cdr() -> Car() -> AsString();
    Item  anItem;
    Field aField;
    Slide current = Client -> GetCurrentSlide();

    if(( anItem = current -> FindItem( key )) == 0 ){
      if(( anItem = current -> GetScreen() -> FindItem( key )) == 0 ){
        raise CollectionExceptions<IntAsKey>::UnknownKey( key );
      }
    }
    aField = narrow( Field, anItem );
    aField -> Entered( Client, current, value );
    
//    Client -> FieldEntered( key, value );
    return 0;
  }
}

