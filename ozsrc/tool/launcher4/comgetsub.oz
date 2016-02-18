/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

class ComGetSub : LauncherCommand{
 constructor:
  New;
 public:
  Execute;

  char MyName()[]{ return "GetSub"; }

  int Execute( SList args ){
    LauncherEvaluator le = MyEvaluator();
    int type = narrow( Atom, args -> Car()) -> AsInteger();
    ProjectSS prj = narrow( ProjectSS, le -> Search( narrow( SList, args -> Cdr() -> Car())));
    le -> SendEvent( prj -> GetSubs( type ) -> AsString());
    return 0;
  }
}
