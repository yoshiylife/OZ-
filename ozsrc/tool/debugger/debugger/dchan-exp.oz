/*
  Copyright(c) 1994-1997 Information-technology Promotion Agency, Japan

  All rights reserved.  No guarantee.
  This technology is a result of the Open Fundamental Software Technology
  Project of Information-technology Promotion Agency, Japan (IPA).
*/

//
//	Debug Channel Exceptions for OZ++ World.
//
// CAUTION
//	This source file is written in tabstop=4,hardtabs=8.
//
shared	DebugChannelException {
	Migrated(global Object) ;
	NotFound(global Object) ;
	AlreadyInUse(unsigned int DChann) ;
	NotReady() ;
	IO(global Object) ;
}
