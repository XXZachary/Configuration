//
//  XXZTextView.h
//  DaiHotel
//
//  Created by Zachary on 2017/6/13.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXZTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) NSString *textNew;

/**
 *给UILabel设置行间距和字间距
 */
+ (void)setTextViewSpace:(UITextView*)textView withValue:(NSString*)str withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing;

- (void)textViewDidChange:(UITextView *)textView;

@end
