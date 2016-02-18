/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

class BinaryHolder : Holder{
 constructor:
  New;

 public:
  AsTrue, AsFalse, Reverse, IsTrue, IsFalse;

  int Value;

  void New(){ Value = 0; }

  void AsTrue(){ Value = 1; }
  void AsFalse(){ Value = 0; }
  void Reverse(){ Value = ( Value == 0 ); }

  int IsTrue(){ return Value; }
  int IsFalse(){ return !Value; }
}
