//
//  XXZTextField.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/29.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZTextField.h"

@interface XXZTextField ()

// 子类化UITextField，增加insert属性
@property (nonatomic, assign) UIEdgeInsets insets;

@end

@implementation XXZTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self changedPropertyOfPlaceHolder];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self changedPropertyOfPlaceHolder];
    }
    
    return self;
}

#pragma mark - 改变placeholder的字体属性
- (void)changedPropertyOfPlaceHolder {
    //改变颜色
    [self setValue:UICOLOR_LIGHT forKeyPath:@"_placeholderLabel.textColor"];
    //改变字体
    [self setValue:FONT_S(12) forKeyPath:@"_placeholderLabel.font"];
}

//设置 placeholder 的属性
- (void)changedPropertyOfPlaceHolderWithHolderText:(NSString *)holderText {
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]
                        range:NSMakeRange(0, holderText.length)];
    
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    self.attributedPlaceholder = placeholder;
}

#pragma mark - UITextField文字周围增加边距
// 在.m文件重写下列方法
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.insets);
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.insets);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.insets);
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeWhileEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)adjustRectWithWidthRightView:(CGRect)bounds {
    CGRect paddedRect = bounds;
    paddedRect.size.width -= CGRectGetWidth(self.rightView.frame);
    
    return paddedRect;
}

#pragma mark - 设置UITextField光标位置
// textField需要设置的textField，index要设置的光标位置
- (void)cursorLocation:(UITextField *)textField index:(NSInteger)index {
    NSRange range = NSMakeRange(index, 0);
    UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument] offset:range.location];
    UITextPosition *end = [textField positionFromPosition:start offset:range.length];
    [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
