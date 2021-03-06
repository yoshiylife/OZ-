/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

class ComGetCurrent : LauncherCommand{
 constructor:
  New;
 public:
  Execute;

  char MyName()[]{ return "GetCurrent"; }

  int Execute( SList args ){
    LauncherEvaluator le = MyEvaluator();
    le -> SendEvent( le -> GetCurrentProject() -> Fullname() -> AsString());
    return 0;
  }
}
