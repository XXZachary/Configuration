//
//  XXZTextView.m
//  DaiHotel
//
//  Created by Zachary on 2017/6/13.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "XXZTextView.h"

@interface XXZTextView ()

@property (nonatomic, strong) UILabel *holder;

@end

static NSRange _selectRange;

@implementation XXZTextView {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //coding...
        _selectRange = NSMakeRange(0, 0);
        
        [self buildSuperLayout];
    }
    
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (IS_BLANK_STRING(textView.text)) {
        _holder.hidden = NO;
    }
    else {
        _holder.hidden = YES;
    }
    
    _selectRange = textView.selectedRange;
}

#pragma mark - notification action


#pragma mark - action


#pragma mark - build layout
- (void)buildSuperLayout {
    [self addSubview:self.holder];
    [_holder mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.height.mas_equalTo(25);
    }];
}

#pragma mark - loading


#pragma mark - getter
- (UILabel *)holder {
    if (_holder == nil) {
        _holder = [[UILabel alloc] init];
        _holder.text = @"请输入...";
        _holder.font = FONT_S(14);
        _holder.textColor = UICOLOR_LIGHT;
//        _holder.backgroundColor = [UIColor redColor];
    }
    
    return _holder;
}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder {
    _holder.text = placeholder;
}

- (void)setTextNew:(NSString *)textNew {
    self.text = textNew;
    
    if (IS_BLANK_STRING(textNew)) {
        _holder.hidden = NO;
    }
    else {
        _holder.hidden = YES;
    }
}

#pragma mark - method
//给UILabel设置行间距和字间距
+ (void)setTextViewSpace:(UITextView*)textView withValue:(NSString*)str withFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paraStyle.alignment = NSTextAlignmentLeft;
//    paraStyle.hyphenationFactor = 1.0;
//    paraStyle.firstLineHeadIndent = 0.0;
//    paraStyle.paragraphSpacingBefore = 0.0;
//    paraStyle.headIndent = 0;
//    paraStyle.tailIndent = 0;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
//                          NSKernAttributeName:@0.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    textView.attributedText = attributeStr;
    
    //定位
    textView.selectedRange = _selectRange;
}

//光标的高度
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect rect = [super caretRectForPosition:position];
    rect.size.height = self.font.lineHeight;
    
    return rect;
}

#pragma mark - dealloc
- (void)dealloc {
    
}

#pragma mark - other
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
