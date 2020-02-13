//
//  KeyboardManager.h
//  DaiHotel
//
//  Created by Zachary on 2017/5/10.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardManager : NSObject

+ (KeyboardManager *)shareInstance;

@property (nonatomic) BOOL keyboardIsVisible;

@end
