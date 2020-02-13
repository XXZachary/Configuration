//
//  ChooseDateView.h
//  Saas
//
//  Created by Jiayu_Zachary on 16/6/2.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ChooseDateViewDelegate <NSObject>

- (void)chooseDateViewWithDateComponents:(NSMutableDictionary *)dateDict;

@end

@interface ChooseDateView : UIView

@property (nonatomic, weak) id<ChooseDateViewDelegate>delegate;

/**
 *  设置日期的模式, 默认是UIDatePickerModeDateAndTime
 */
@property (nonatomic, assign) UIDatePickerMode dpMode;

//从底部出现
- (void)show;

@end
NS_ASSUME_NONNULL_END

/**
 - (void)loadChooseDateView {
 _chooseDateView = [[ChooseDateView alloc] initWithFrame:self.bounds];
 _chooseDateView.delegate = self;
 [[UIApplication sharedApplication].keyWindow addSubview:_chooseDateView];
 }
 */
