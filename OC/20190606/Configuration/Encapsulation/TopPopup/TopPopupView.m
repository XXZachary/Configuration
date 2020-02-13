//
//  TopPopupView.m
//  SLifeX
//
//  Created by Slife on 2019/8/8.
//  Copyright © 2019 slife. All rights reserved.
//

#import "TopPopupView.h"

@interface TopPopupView ()

@property (nonatomic, strong) QMUILabel *msg;

@property (nonatomic, copy) NSString *content; //提示语
@property (nonatomic, strong) UIColor *bgColor; //背景颜色

@end

@implementation TopPopupView

+ (TopPopupView *)popup:(NSString *)msg toView:(UIView *)view {
    if (view == nil) view = KEY_WINDOW;
    
    TopPopupView *popup = [[TopPopupView alloc] init];
    popup.content = msg;
    [view addSubview:popup];
    
    [popup mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.mas_equalTo(view);
    }];
    
    [popup showAnimated];
    
    return popup;
}

+ (void)pop:(NSString *)msg toView:(UIView *)view {
    if (view == nil) view = KEY_WINDOW;
    
    TopPopupView *popup = [[TopPopupView alloc] init];
    popup.content = msg;
    [view addSubview:popup];
    
    [popup mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.mas_equalTo(view);
    }];
    
    [popup showAnimated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [popup hiddenAnimated];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = ClearColor; //[BlackColor colorWithAlphaComponent:0.4];
        self.alpha = 0.0;
        
        [self buildLayout];
    }
    
    return self;
}

#pragma mark - Zachary -


#pragma mark - Zachary - notification action


#pragma mark - Zachary - action


#pragma mark - Zachary - build layout
- (void)buildLayout {
    [self loadMsg];
}

#pragma mark - Zachary - loading
- (void)loadMsg {
    _msg = [[QMUILabel alloc] init];
    _msg.backgroundColor = UICOLOR_FROM(@"#CC38A4");
    _msg.textColor = WhiteColor;
    _msg.textAlignment = NSTextAlignmentCenter;
    _msg.font = font_bold(14);
    _msg.numberOfLines = 0;
    _msg.contentEdgeInsets = UIEdgeInsetsMake(15+SafeArea_Status_H, 20, 15, 20);
    [self addSubview:_msg];
    
    //默认值
    _msg.hidden = YES;
//    _msg.alpha = 0;
    
    [_msg mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.top.mas_equalTo(self);
    }];
}

#pragma mark - Zachary - getter


#pragma mark - Zachary - setter
- (void)setContent:(NSString *)content {
    _content = content;
    _msg.text = content;
}

#pragma mark - Zachary - method
- (void)showAnimated {
    if (_msg.hidden == NO) {
        return;
    }
    
    [_msg.superview layoutIfNeeded];
    _msg.hidden = NO;
    _msg.transform = CGAffineTransformTranslate(_msg.transform, 0, -_msg.height);
    
    WEAKSELF
    [UIView animateWithDuration:0.23 animations:^{
        self.alpha = 1.0;
        
//        weakSelf.msg.alpha = 1.0;
        weakSelf.msg.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hiddenAnimated {
    if (_msg.hidden == YES) {
        return;
    }
    
    WEAKSELF
    [UIView animateWithDuration:0.23 animations:^{
        self.alpha = 0.0;
        
//        weakSelf.msg.alpha = 0.0;
        weakSelf.msg.transform = CGAffineTransformTranslate(weakSelf.msg.transform, 0, -weakSelf.msg.height);
    } completion:^(BOOL finished) {
        weakSelf.msg.hidden = YES;
    }];
}

#pragma mark - Zachary - server


#pragma mark - Zachary - system


#pragma mark - Zachary - dealloc
- (void)dealloc {
    
}

#pragma mark - Zachary - other
+ (NSString *)minusDigital:(double)digital {
    NSString *stringNumber = [NSString stringWithFormat:@"%lf", digital];
    NSNumber *nsNumber = @(stringNumber.doubleValue);
    NSString *outNumber = [NSString stringWithFormat:@"%@", nsNumber];
    
    return outNumber;
}

+ (NSString *)minusDigitalString:(NSString *)digital {
    NSString *stringNumber = digital;
    NSNumber *nsNumber = @(stringNumber.doubleValue);
    NSString *outNumber = [NSString stringWithFormat:@"%@", nsNumber];
    
    return outNumber;
}

+ (NSString *)timestamp:(NSTimeInterval)timestamp {
    NSDate *date = [XXZDateModel dateFromTimestamp:(timestamp/1000.0)];
    NSDateFormatter *fmt = [XXZDateModel dateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [fmt stringFromDate:date];
    
    return dateStr;
}

//去掉d小数点后面无用的0
+ (NSString *)cutUseless:(double)digital :(int)bit {
    NSString *str = @"";
    switch (bit) {
        case 2:
        {
            str =  [NSString stringWithFormat:@"%.2lf", digital];
        }
            break;
        case 4:
        {
            str =  [NSString stringWithFormat:@"%.4lf", digital];
        }
            break;
        case 6:
        {
            str =  [NSString stringWithFormat:@"%.6lf", digital];
        }
            break;
        case 8:
        {
            str =  [NSString stringWithFormat:@"%.8lf", digital];
        }
            break;
            
        default:
            str =  [NSString stringWithFormat:@"%.4lf", digital];
            break;
    }
    
    NSString *tmp = @"";
    for (NSInteger i=str.length-1; i>=0; i--) {
        NSString *c = [str substringWithRange:NSMakeRange(i, 1)];
        if (![c isEqualToString:@"0"]) {
            if ([c isEqualToString:@"."]) {
                tmp = [str substringToIndex:i];
                return tmp;
            }
            else {
                tmp = [str substringToIndex:i+1];
                return tmp;
            }
        }
    }
    
    return tmp;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
