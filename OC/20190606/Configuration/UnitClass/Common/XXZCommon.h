//
//  XXZCommon.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#ifndef XXZCommon_h
#define XXZCommon_h

/*导入头文件* ****************************/
#import "XXZStringClass.h"

//u9fa5 | u9fff
#import "XXZSRegularClass.h"
#import "XXZDRegularClass.h"
#import "XXZTRegularClass.h"

/*导入头文件* *******************************/


/*类方法, 宏定义* ****************************/
//十六进制颜色 => UIColor
#define UICOLOR_FROM(string) [XXZStringClass colorWithString:string]
//判断字符串是否为空 或并 空格
#define IS_BLANK_STRING(string) [XXZStringClass isBlankString:string]
//混合颜色
#define MIX_COLOR(color1, color2, ratio) [XXZStringClass mixColor1:color1 color2:color2 ratio:ratio]

/*类方法, 宏定义* ****************************/
//判断相机的权限
#define CAMERA_AUTHORIZATION_STATUS [XXZCamera isPermissionVisitCamera]
//判断相册的权限
#define LIBRARY_AUTHORIZATION_STATUS [XXZCamera isPermissionVisitLibrary]

#endif /* XXZCommon_h */
