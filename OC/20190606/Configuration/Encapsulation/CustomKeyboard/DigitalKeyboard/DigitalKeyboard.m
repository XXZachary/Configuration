//
//  DigitalKeyboard.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "DigitalKeyboard.h"

#define MASK_HEIGHT 44*RATIO_WIDTH*4

@interface DigitalKeyboard ()

NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *showLabel;
@property (strong) id<UITextInput> textView;
NS_ASSUME_NONNULL_END

@end

@implementation DigitalKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, MASK_HEIGHT);
        self.backgroundColor = UICOLOR_FROM(@"#C7CCD5");
//        self.backgroundColor = UICOLOR_FROM_RGB(174, 176, 184);
        _keyBoardType = XXZKeyboardTypeDefault;
//        ViewBorderRadius(self, 0, 0.5, [[UIColor lightGrayColor] colorWithAlphaComponent:0.5]);
        
        [self buildLayout];
    }
    return self;
}

#pragma mark -


#pragma mark - action
- (void)upInsideAction:(UIButton *)btn {
//    XXZLog(@"upInsideAction");
    
    if (btn.tag == 9) { //逗号
        if (_keyBoardType == XXZKeyboardTypeDefault) { //不含逗号键盘
            
        }
        else if (_keyBoardType == XXZKeyboardTypeDecimalPad) { //含逗号键盘
            [self convertToTextViewWithText:@"."];
        }
        else {
            XXZLog(@"其他键盘...");
        }
    }
    else if (btn.tag == 11) { //删除
        [self deleteContent];
    }
    else { //0-9
        [self convertToTextViewWithText:btn.titleLabel.text];
    }
    
}

- (void)downAction:(UIButton *)btn {
//    XXZLog(@"downAction");
}

- (void)drawOutside:(UIButton *)btn {
//    XXZLog(@"drawOutside");
}

#pragma mark - build layout
- (void)buildLayout {
    [self loadDigitalButton];
}

#pragma mark - loading
- (void)loadDigitalButton {
//    UIView *line = [[UIView alloc] init];
//    line.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
//    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
//    [self addSubview:line];
    
    CGFloat width = (self.frame.size.width-2)/3;
    CGFloat height = (self.frame.size.height-3)/4;
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(j*(width+1), i*(height+1), width, height);
            btn.tag = (i*3+j);
            btn.titleLabel.font = [UIFont systemFontOfSize:30.0];
            [btn setTitleColor:BLACK_COLOR forState:0];
            [self addSubview:btn];
            
            if (btn.tag == 9) { // 是否有逗号
                btn.titleLabel.font = FONT_S(12);
                [btn setTitle:@"•" forState:0];
                btn.hidden = YES;
            }
            else if (btn.tag == 10) { //0
                btn.backgroundColor = WHITE_COLOR;
                [btn setTitle:@"0" forState:0];
            }
            else if (btn.tag == 11) { //删除
                btn.titleLabel.font = FONT_S(14);
                [btn setTitle:@"删除" forState:0];
                [btn setTitleColor:[UIColor redColor] forState:0];
//                [btn setImage:[UIImage imageNamed:@"deleteImg"] forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"deleteImgHighLight"] forState:UIControlStateHighlighted];
            }
            else {
                btn.backgroundColor = WHITE_COLOR;
                [btn setTitle:[NSString stringWithFormat:@"%d", (i*3+j)+1] forState:0];
            }
            
            [btn addTarget:self action:@selector(upInsideAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(drawOutside:) forControlEvents:UIControlEventTouchDragOutside];
        }
    };
}

#pragma mark - getter


#pragma mark - setter
- (void)setKeyBoardType:(XXZKeyboardType)keyBoardType {
    _keyBoardType = keyBoardType;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            if (btn.tag == 9) { //逗号
                if (_keyBoardType == XXZKeyboardTypeNumberPad) {
                    btn.hidden = YES;
                }
                else if (_keyBoardType == XXZKeyboardTypeDecimalPad) {
                    btn.hidden = NO;
                }
                else {
                    XXZLog(@"其他键盘...");
                }
            }
        }
    }
    
}

#pragma mark - set custom key board
//自定义键盘
-(void)setCustomKeyboard:(id<UITextInput>)textField {
    if([textField isKindOfClass:[UITextField class]]) {
        [(UITextField *)textField setInputView:self];
    }
    
    if([textField isKindOfClass:[UITextView class]]) {
        [(UITextView *)textField setInputView:self];
    }
    
    _textView = textField;
}

//输入字符
- (void)convertToTextViewWithText:(NSString *)text{
    [self inputContentWithText:text];
}

//删除字符
- (void)deleteContent {
    //删除上一个
    [self.textView deleteBackward];
}

//将选择的键盘商的内容输入到指定的位置
- (void)inputContentWithText:(NSString *)text {
    [self.textView insertText:text];
    
    if ([self.textView isKindOfClass:[UITextView class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
    else if ([self.textView isKindOfClass:[UITextField class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
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
