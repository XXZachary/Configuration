//
//  XXZFrame.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#ifndef XXZFrame_h
#define XXZFrame_h


/* ***************************************************** */
#define SCREEN_BOUND        ([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH         ([[UIScreen mainScreen] bounds].size.width)


/* ***************************************************** */
//是不是iPhone
#define Is_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 判断设备是否为iphoneX 通过状态栏控制
#define  IS_PHONE_X     (([UIApplication sharedApplication].statusBarFrame.size.height)>20?YES:NO)

//获取当前屏幕最大的值
#define CURRENT_MAX_HEIGHT (SCREEN_HEIGHT>SCREEN_WIDTH?SCREEN_HEIGHT:SCREEN_WIDTH)
#define Is_iPhone_X         ((CURRENT_MAX_HEIGHT == 812.0||CURRENT_MAX_HEIGHT == 896.0) ? YES : NO)

//iPhone系列
#define RATIO_HEIGHT    (SCREEN_HEIGHT/480.f)
#define RATIO_WIDTH     (SCREEN_WIDTH/320.f)

//#define Safe_Status_H                    (isiPhoneX ? 44 : 20) //状态栏
//#define Safe_Navbar_H                  (isiPhoneX ? 88 : 64) //导航条
//#define Safe_Tabbar_H                   (isiPhoneX ? 83 : 49) //工具栏
//
//#define Safe_Top_H                        (isiPhoneX ? 24 : 0) //顶部安全区
//#define Safe_Bottom_H                  (isiPhoneX ? 34 : 0) //底部安全区

#define SafeArea_Status_H            (Is_iPhone_X ? 44 : 20) //状态栏
#define SafeArea_Navbar_H           (Is_iPhone_X ? 88 : 64) //导航条+状态栏
#define SafeArea_Tabbar_H           (Is_iPhone_X ? 83 : 49) //工具栏

#define SafeArea_Top_H                (Is_iPhone_X ? 24 : 0) //顶部安全区
#define SafeArea_Bottom_H          (Is_iPhone_X ? 34 : 0) //底部安全区

#define Safe_Status_H                    SafeArea_Status_H
#define Safe_Navbar_H                  SafeArea_Navbar_H
#define Safe_Tabbar_H                   SafeArea_Tabbar_H

#define Safe_Top_H                        SafeArea_Top_H
#define Safe_Bottom_H                  SafeArea_Bottom_H

#define CELL_H     (44.f) //cell默认高度

/* ***************************************************** */
//iPad系列
//是否竖屏: YES是竖屏, 否则横屏
#define IPAD_IS_PORTRAIT    (SCREEN_HEIGHT>SCREEN_WIDTH ? YES : NO)

#define IPAD_RATIO_H            (SCREEN_HEIGHT/(IPAD_IS_PORTRAIT == YES ? 1024.f : 768.f))
#define IPAD_RATIO_W           (SCREEN_WIDTH/(IPAD_IS_PORTRAIT == NO ? 1024.f : 768.f))

#define IPAD_SB_H               (20.f*IPAD_RATIO_W) //状态栏
#define IPAD_NB_H              (44.f*IPAD_RATIO_W) //导航条
#define IPAD_SNB_H            (IPAD_SB_H+IPAD_NB_H) //状态栏导航栏之和

#define IPAD_TB_H               (49.f*IPAD_RATIO_W) //工具栏
#define IPAD_CELL_H          (44.f*IPAD_RATIO_W) //cell默认高度

/* ***************************************************** */


#endif /* XXZFrame_h */
