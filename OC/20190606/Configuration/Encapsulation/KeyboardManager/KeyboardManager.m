//
//  KeyboardManager.m
//  DaiHotel
//
//  Created by Zachary on 2017/5/10.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "KeyboardManager.h"

@implementation KeyboardManager

+ (KeyboardManager *)shareInstance {
    static KeyboardManager *_keyboardManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyboardManager = [[KeyboardManager alloc] init];
    });
    
    return _keyboardManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center  addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardWillShowNotification object:nil];
        [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
        _keyboardIsVisible = NO;
    }
    
    return self;
}

- (void)keyboardDidShow {
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide {
    _keyboardIsVisible = NO;
}

- (BOOL)keyboardIsVisible {
    return _keyboardIsVisible;
}

@end
