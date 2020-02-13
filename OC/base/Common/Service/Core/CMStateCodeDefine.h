//
//  CMStateCodeDefine.h
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
///

#ifndef CMStateCodeDefine_h
#define CMStateCodeDefine_h

#define kErr_CMStateCode_NeedLogin1   (-101) //token长时间未使用而过期，需重新登陆
#define kErr_CMStateCode_NeedLogin2   (-102) //token错误验证失败
#define kErr_CMStateCode_NeedLogin3   (-103) //token值不存在

#define kErr_CMStateCode_Unknown   (-1) //请求类型错误
#define kErr_CMStateCode_Parameter   (-9) //请输入手机号

#define kErr_CMStateCode_NeedUpdate   5001 //当前版本过低

#endif /* CMStateCodeDefine_h */
