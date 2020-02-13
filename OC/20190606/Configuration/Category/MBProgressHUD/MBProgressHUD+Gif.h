//
//  MBProgressHUD+Gif.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/5/27.
//  Copyright © 2019 com.xxzing.future. All rights reserved.
//

#import "MBProgressHUD.h"

//NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Gif)

+ (void)showGifToView:(UIView *)view;

+ (void)hideGifHUDForView:(UIView *)view;
+ (void)hideGifHUD;

@end

//NS_ASSUME_NONNULL_END
