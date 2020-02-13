//
//  MBProgressHUD+Json.h
//  SLifeX
//
//  Created by Slife on 2019/8/15.
//  Copyright © 2019 slife. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Json)

+ (void)showJsonToView:(nullable UIView *)view;

+ (void)hideJsonHUDForView:(nullable UIView *)view;
+ (void)hideJsonHUD;

@end

NS_ASSUME_NONNULL_END
