//
//  CustomKeyboard.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "DAKeyboard.h"

#define HGSKeyboardCharBtnHeight  35
//#define HGSKeyboardCharBtnWidth  26

#define internal_y 8
#define FONT_VALUE 18.0f
#define CornerRadius 3.0f

//#define HGSKeyboardNumBtnHeight  33+internal_y
#define HGSKeyboardWidth  28

@interface DAKeyboard ()

@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation DAKeyboard {
    NSString *_content;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if(self){
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH*RATIO_WIDTH, (175+internal_y)*RATIO_WIDTH);
//        self.backgroundColor = GETCOLOR(@"#d6d8dc");
        self.backgroundColor = [UIColor colorWithRed:0.741 green:0.765 blue:0.808 alpha:1.000];
        [self createView];
    }
    return self;
}

-(void)createView {//创建
    [self addSubview:self.showLabel];//提示
    [self loadDigital]; //加载数字
    CGRect tempRect = [self loadAlphabet]; //加载字母
    [self loadDelete:tempRect]; //删除按钮
}

//加载数字
- (void)loadDigital {
    NSArray *numberArr = [self getDataSourceWithDigital];
    
    [numberArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_VALUE*RATIO_WIDTH];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = CornerRadius;
        btn.frame = CGRectMake((HGSKeyboardWidth+3.5)*idx+3.5, internal_y, HGSKeyboardWidth, HGSKeyboardCharBtnHeight);
        [btn setTitle:numberArr[idx] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [self addSubview:btn];
        
        btn.frame = CGRectMake(btn.frame.origin.x*RATIO_WIDTH, btn.frame.origin.y*RATIO_WIDTH, btn.frame.size.width*RATIO_WIDTH, btn.frame.size.height*RATIO_WIDTH);
        
        [btn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(btnDownAction:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnDrawOutside:) forControlEvents:UIControlEventTouchDragOutside];
        
    }];
}

//加载大写字母
- (CGRect)loadAlphabet {
    __block CGRect tempRect;
    
    //键盘顺序
    NSArray *charBtnArr = [self getDataSourceWithBigAlphabet];
    
    [charBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if(idx<10) {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_VALUE*RATIO_WIDTH];
            [btn setTitleColor:UICOLOR_FROM(@"#2d3841") forState:0];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = CornerRadius;
            btn.frame = CGRectMake((HGSKeyboardWidth+3.5)*idx+3.5, 42+internal_y, HGSKeyboardWidth, HGSKeyboardCharBtnHeight);
            
            [btn setTitle:charBtnArr[idx] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            
            [self addSubview:btn];
            
            [btn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnDownAction:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(btnDrawOutside:) forControlEvents:UIControlEventTouchDragOutside];
        }
        else if (idx<19) {
            
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_VALUE*RATIO_WIDTH];
            [btn setTitleColor:UICOLOR_FROM(@"#2d3841") forState:0];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = CornerRadius;
            
            CGFloat distance_x = (SCREEN_WIDTH-(HGSKeyboardWidth*9+3.5*9)*RATIO_WIDTH)/2;
            
            btn.frame = CGRectMake((HGSKeyboardWidth+3.5)*(idx-10)+distance_x, internal_y+42+8+HGSKeyboardCharBtnHeight, HGSKeyboardWidth, HGSKeyboardCharBtnHeight);
            
            [btn setTitle:charBtnArr[idx] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            
            [self addSubview:btn];
            
            [btn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnDownAction:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(btnDrawOutside:) forControlEvents:UIControlEventTouchDragOutside];
        }
        else {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:FONT_VALUE*RATIO_WIDTH];
            [btn setTitleColor:UICOLOR_FROM(@"#2d3841") forState:0];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = CornerRadius;
            
            //HGSKeyboardWidth*3/2*RATIO_WIDTH
            CGFloat distance_x = (SCREEN_WIDTH-(HGSKeyboardWidth*8.5+3.5*7)*RATIO_WIDTH)/2;
            
            btn.frame = CGRectMake((HGSKeyboardWidth+3.5)*(idx-19)+distance_x, internal_y+42+8*2+HGSKeyboardCharBtnHeight*2, HGSKeyboardWidth, HGSKeyboardCharBtnHeight);
            
            [btn setTitle:charBtnArr[idx] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            
            [self addSubview:btn];
            
            [btn addTarget:self action:@selector(keyboardAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnDownAction:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(btnDrawOutside:) forControlEvents:UIControlEventTouchDragOutside];
        }
        
        btn.frame = CGRectMake(btn.frame.origin.x*RATIO_WIDTH, btn.frame.origin.y*RATIO_WIDTH, btn.frame.size.width*RATIO_WIDTH, btn.frame.size.height*RATIO_WIDTH);
        tempRect = btn.frame;
    }];
    
    return tempRect;
}

//加载删除
- (void)loadDelete:(CGRect)tempRect {
    //删除按钮
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [delBtn setTitle:@"删除" forState:0];
    delBtn.layer.cornerRadius = CornerRadius;
    delBtn.frame = CGRectMake(tempRect.origin.x+tempRect.size.width+7*RATIO_WIDTH, (internal_y+42+8*2+HGSKeyboardCharBtnHeight*2)*RATIO_WIDTH, HGSKeyboardWidth*2*RATIO_WIDTH, HGSKeyboardCharBtnHeight*RATIO_WIDTH);
    //    delBtn.backgroundColor = WHITECOLOR;
    
    /*
    [delBtn setBackgroundImage:[UIImage imageNamed:@"deleteNumOrChar"] forState:UIControlStateNormal];
    [delBtn setBackgroundImage:[UIImage imageNamed:@"deleteNumOrCharHighlight"] forState:UIControlStateHighlighted];
     */
    delBtn.backgroundColor = UICOLOR_FROM_YELLOW;
    [delBtn setTitle:@"删除" forState:0];
    [delBtn setTitleColor:[UIColor blackColor] forState:0];
    
    [delBtn addTarget:self action:@selector(keyboardDeleteChacter) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:delBtn];
}

#pragma mark - getter
//提示
- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.frame = CGRectMake(0, 0, 100*RATIO_WIDTH, 100*RATIO_WIDTH);
        _showLabel.center = CGPointMake(-25+self.frame.size.width/2, -self.frame.size.height/2);
        _showLabel.font = [UIFont systemFontOfSize:60.0*RATIO_WIDTH];
        _showLabel.text = @"洲";
        _showLabel.hidden = YES;
        ViewRadius(_showLabel, 5.0);
        _showLabel.textColor = [UIColor whiteColor];
        _showLabel.backgroundColor = [UIColor blackColor];
        _showLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _showLabel;
}

#pragma mark - action
//将键盘的数据使用delegate传到指定界面
-(void)keyboardAction:(UIButton *)sender {
    if (_content.length) {
        [self convertToTextViewWithText:_content];
    }
    
    _showLabel.hidden = YES; //提示
}

//删除按钮
-(void)keyboardDeleteChacter {
    if (_content.length) {
        [self deleteCharacterInTextView];
    }
    else {
        //代理删除
        if ([_delegate respondsToSelector:@selector(deleteWithContent)]) {
            [_delegate deleteWithContent];
        }
    }
    
//    //取消键盘
//    if ([_delegate respondsToSelector:@selector(cancelCustomKeyboard:)]) {
//        [_delegate cancelCustomKeyboard:(UITextField *)_textView];
//    }
}

//拖出事件之外
- (void)btnDrawOutside:(UIButton *)btn {
    if (_content.length) {
        [self convertToTextViewWithText:_content];
    }
    _showLabel.hidden = YES;
}

//松手
- (void)btnUpInsideAction:(UIButton *)btn {
    [self convertToTextViewWithText:_content];
    
    _showLabel.hidden = YES;
}

//按下
- (void)btnDownAction:(UIButton *)btn {
    _content = btn.titleLabel.text;
    
//    _showLabel.hidden = NO;
    _showLabel.text = btn.titleLabel.text;
}

#pragma mark - set custom key board
-(void)setCustomKeyboard:(id<UITextInput>)textField {
    if([textField isKindOfClass:[UITextField class]]) {
        [(UITextField *)textField setInputView:self];
    }
    _textView = textField;
}

//将选择的键盘上的内容输入到指定的位置
- (void)convertToTextViewWithText:(NSString *)text{
//    [self.textView deleteBackward];//删除上一个, 只输入一个
    
    [self.textView insertText:text];
    if ([self.textView isKindOfClass:[UITextView class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
    else if ([self.textView isKindOfClass:[UITextField class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
}

//删除字符
- (void)deleteCharacterInTextView {
    [[UIDevice currentDevice] playInputClick];
    [self.textView deleteBackward];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    
    if ([self.textView isKindOfClass:[UITextView class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
    }
    else if ([self.textView isKindOfClass:[UITextField class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
    }
}

#pragma mark - data source
//大写字母
- (NSArray *)getDataSourceWithBigAlphabet {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AFLPN" ofType:@"plist"];
    NSArray *arrData = [[NSArray alloc] initWithContentsOfFile:path];
    
    return [arrData objectAtIndex:1];
}

//数字
- (NSArray *)getDataSourceWithDigital {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AFLPN" ofType:@"plist"];
    NSArray *arrData = [[NSArray alloc] initWithContentsOfFile:path];
    
    return [arrData objectAtIndex:2];
}

@end
