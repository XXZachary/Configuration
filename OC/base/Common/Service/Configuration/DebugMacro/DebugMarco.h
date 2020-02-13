//
//  DebugMarco.h
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#ifndef CommonLibrary_DebugMarco_h
#define CommonLibrary_DebugMarco_h

// 日志

#ifdef DEBUG

#ifndef DebugLog
#define DebugLog(fmt, ...) NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#else

#ifndef DebugLog
#define DebugLog(fmt, ...) // NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#define NSLog // NSLog


#endif

#endif

