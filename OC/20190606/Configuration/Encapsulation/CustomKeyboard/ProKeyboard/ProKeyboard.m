//
//  ProKeyboardView.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "ProKeyboard.h"

#define BTN_WIDTH 30*RATIO_WIDTH
#define BTN_HEIGHT 40*RATIO_WIDTH

#define Y_INTERNAL 8*RATIO_WIDTH
#define X_INTERNAL (SCREEN_WIDTH-BTN_WIDTH*9)/10

#define MASK_HEIGHT (40*4*RATIO_WIDTH+Y_INTERNAL*5)

@interface ProKeyboard ()

NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *showLabel;
@property (strong) id<UITextInput> textView;
NS_ASSUME_NONNULL_END

@end

@implementation ProKeyboard {
    NSArray *_dataSpurceArr;
    NSString *_content;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT-MASK_HEIGHT, SCREEN_WIDTH, MASK_HEIGHT);
        [self buildLayout];
    }
    return self;
}

#pragma mark - action
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

//提交结果
- (void)okAction:(UIButton *)btn {
//    XXZLog(@"确定 = %@", _content);
    [((UITextField *)_textView) resignFirstResponder];
    
    if ([_delegate respondsToSelector:@selector(cancelCustomKeyboard:)]) {
        [_delegate cancelCustomKeyboard:(UITextField *)_textView];
    }
}

#pragma mark - build layout
- (void)buildLayout {
    //获取数据源
    _dataSpurceArr = [self getDataSourceWithProvince];
    
    [self addSubview:self.maskView];
    [self addSubview:self.showLabel];
    
    [self loadButton];
}

#pragma mark - getter
- (void)loadButton {
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<9; j++) {
            
            int index = i*9+j;
            //27个省+4个直辖市
            if (index > _dataSpurceArr.count-1) {
                [self loadOkBtn];
                return;
            }
            
            //省
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(X_INTERNAL+(BTN_WIDTH+X_INTERNAL)*j, Y_INTERNAL+(BTN_HEIGHT+Y_INTERNAL)*i, BTN_WIDTH, BTN_HEIGHT);
            btn.backgroundColor = [UIColor whiteColor];
            ViewRadius(btn, 3.0);
            btn.tag = index;
            [_maskView addSubview:btn];
            
            if (_dataSpurceArr.count) {//绑定数据
                [btn setTitle:_dataSpurceArr[index] forState:0];
                [btn setTitleColor:[UIColor blackColor] forState:0];
                [btn setTitleColor:[UIColor blueColor] forState:1 << 0];
                
                [btn addTarget:self action:@selector(btnUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(btnDownAction:) forControlEvents:UIControlEventTouchDown];
                [btn addTarget:self action:@selector(btnDrawOutside:) forControlEvents:UIControlEventTouchDragOutside];
            }
        }
    }
}

//确定
- (void)loadOkBtn {
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(SCREEN_WIDTH-BTN_WIDTH*2-X_INTERNAL*3/2, Y_INTERNAL*4+BTN_HEIGHT*3, BTN_WIDTH*2, BTN_HEIGHT);
    okBtn.backgroundColor = UICOLOR_FROM_YELLOW;
    [okBtn setTitle:@"确定" forState:0];
    [okBtn setTitleColor:[UIColor blackColor] forState:0];
    ViewRadius(okBtn, 3.0);
    [_maskView addSubview:okBtn];
    
    [okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
}

//button载体
- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc] init];
//        _maskView.frame = CGRectMake(0, SCREEN_HEIGHT-MASK_HEIGHT, SCREEN_WIDTH, MASK_HEIGHT);
        _maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, MASK_HEIGHT);
        _maskView.backgroundColor = [UIColor colorWithRed:0.741 green:0.765 blue:0.808 alpha:1.000];
    }
    return _maskView;
}

//提示
- (UILabel *)showLabel {
    if (_showLabel == nil) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.frame = CGRectMake(0, 0, 100*RATIO_WIDTH, 100*RATIO_WIDTH);
        _showLabel.center = CGPointMake(self.frame.size.width/2, -self.frame.size.height/2);
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

#pragma mark - data source
- (NSArray *)getDataSourceWithProvince {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AFLPN" ofType:@"plist"];
    NSArray *arrData = [[NSArray alloc] initWithContentsOfFile:path];

    return [arrData objectAtIndex:0];
}

#pragma mark - set custom key board
//自定义键盘
-(void)setCustomKeyboard:(id<UITextInput>)textField {
    if([textField isKindOfClass:[UITextField class]]) {
        [(UITextField *)textField setInputView:self];
    }
    _textView = textField;
}

//将选择的键盘商的内容输入到指定的位置
- (void)convertToTextViewWithText:(NSString *)text{
    [self.textView deleteBackward];//删除上一个, 只输入一个

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
