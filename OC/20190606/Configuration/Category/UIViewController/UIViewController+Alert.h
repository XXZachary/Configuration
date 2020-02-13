//
//  UIViewController+Alert.h
//  AnimatedDemo
//
//  Created by Zachary on 2018/3/1.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CancelBlock) (void);
typedef void (^OtherBlock) (NSInteger index);

@interface UIViewController (Alert)

@property (nonatomic, strong) NSNumber *isSheet;

/**alert*/
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)mesasge cancelTitle:(NSString *)cancelTitle otherTitle:(NSArray <NSString *> *)otherTitleArr cancel:(CancelBlock)cancel other:(OtherBlock)other;

/**sheet*/
- (void)showSheetWithTitle:(NSString *)title message:(NSString *)mesasge cancelTitle:(NSString *)cancelTitle otherTitle:(NSArray <NSString *> *)otherTitleArr cancel:(CancelBlock)cancel other:(OtherBlock)other;

/**
 self.isSheet = @(YES);
 [self showAlertWithTitle:nil message:@"请选择" cancelTitle:@"取消" otherTitle:@[@"1", @"2", @"3"] cancel:^{} other:^(NSInteger index) {
        XXZLog(@"1 = %ld", index);
 }];
 }
 else if (indexPath.row == 2) {
 [self showSheetWithTitle:nil message:@"请选择" cancelTitle:@"取消" otherTitle:@[@"1", @"2", @"3"] cancel:^{} other:^(NSInteger index) {
        XXZLog(@"2 = %ld", index);
 }];
 */

@end
