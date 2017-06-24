//
//  KeyConfig.h
//  FangshangTourism
//
//  Created by wendy on 15/7/28.
//  Copyright (c) 2015年 wendy. All rights reserved.
//

#ifndef FangshangTourism_KeyConfig_h
#define FangshangTourism_KeyConfig_h

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif


#define WEAK_SELF @weakify(self);
#define STRONG_SELF @strongify(self); if(!self) {return;};

#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };


///-----------
/// SSKeychain
///-----------
#define BW_SERVICE_NAME @"com.leichunfeng.MVVMReactiveCocoa"
#define BW_RAW_LOGIN    @"RawLogin"
#define BW_PASSWORD     @"Password"
#define BW_ACCESS_TOKEN @"AccessToken"

///-----------
/// JPush
///-----------

#define BW_JPUSH_APPKEY @"7b2e5bfbb70acf54fad002bb"




#endif
