//
//  ChooseDateView.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/6/2.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "ChooseDateView.h"

@interface ChooseDateView ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation ChooseDateView {
    UIView *_maskView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [BLACK_COLOR colorWithAlphaComponent:0.5];
        
        self.alpha = 0.0;
        self.hidden = YES;
        
        [self buildLayout];
    }
    
    return self;
}

#pragma mark - action
- (void)buttonAction:(UIButton *)button {
    NSInteger tag = button.tag;
    
    switch (tag) {
        case 100: //取消
        {
            [self hide];
        }
            break;
        case 101: //确定
        {
            [self hide];
        }
            break;
            
        default:
            break;
    }
}

- (void)nowDateAction:(UIDatePicker *)datePicker {
    if ([_delegate respondsToSelector:@selector(chooseDateViewWithDateComponents:)]) {
        // 获取 在这个控件上设置的时间
        NSDate *selected = [datePicker date]; // 获取被选中的时间
        
#if 0
        NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
        selectDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss"; // 设置时间和日期的格式
        NSString *dateAndTime = [selectDateFormatter stringFromDate:selected]; // 把date类型转为设置好格式的string类型
        
        XXZLog(@"dateAndTime = %@", dateAndTime);
#endif
        
        NSString *weekday = [XXZDateModel returnWeekdayWithDate:selected];
        NSInteger second = [XXZDateModel returnSecondWithDate:selected];
        NSInteger minute = [XXZDateModel returnMinuteWithDate:selected];
        NSInteger hour = [XXZDateModel returnHourWithDate:selected];
        NSInteger day = [XXZDateModel returnDayWithDate:selected];
        NSInteger month = [XXZDateModel returnMonthWithDate:selected];
        NSInteger year = [XXZDateModel returnYearWithDate:selected];
        
        XXZLog(@"%d, %d, %d, %d, %d, %d, %@", year, month, day, hour, minute, second, weekday);
        NSMutableDictionary *dateComponentDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  @(year), @"year",
                                                  @(month), @"month",
                                                  @(day), @"day",
                                                  @(hour), @"hour",
                                                  @(minute), @"minute",
                                                  @(second), @"second",
                                                  weekday, @"weekday",
                                                  nil];
        
        [_delegate chooseDateViewWithDateComponents:dateComponentDict];
    }
    else {
        XXZLog(@"没有实现选择日期的代理方法");
    }
}

#pragma mark - build layout
- (void)buildLayout {
    [self loadMaskView];
    [self loadCurrentDate];
}

#pragma mark - loading
- (void)loadCurrentDate {
    //设置控件
    //初始化UIDatePicker 对象，并设置这个 控件的 坐标位置，宽和高
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44*RATIO_WIDTH, self.width, 44*RATIO_WIDTH*4)];
//    _datePicker.backgroundColor = WHITE_COLOR;
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    // 设置时区, 中国在东八区
    [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GTM+8"]];
    [_maskView addSubview:self.datePicker];
    
    //设置日期范围
    NSDate *dateMax = [NSDate date];
    NSDate *dateMin = [NSDate dateWithTimeIntervalSinceNow:-20*365*24*60*60];
    _datePicker.maximumDate = dateMax;
    _datePicker.minimumDate = dateMin;
    
    [_datePicker addTarget:self action:@selector(nowDateAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)loadMaskView {
    _maskView = [[UIView alloc] init];
    _maskView.frame = CGRectMake(0, self.height-(44*5)*RATIO_WIDTH, self.width, 44*5*RATIO_WIDTH);
    _maskView.backgroundColor = WHITE_COLOR;
    [self addSubview:_maskView];
    
    [self loadButtonWithMaskView:_maskView];
}

- (void)loadButtonWithMaskView:(UIView *)view {
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((SCREEN_WIDTH-80)*i, 0, 80, 44*RATIO_WIDTH);
//        button.backgroundColor = CYAN_COLOR;
        button.tag = 100+i;
        button.titleLabel.font = FONT_S(16);
        [button setTitleColor:UICOLOR_FROM_YELLOW forState:0];
        
        if (i == 0) {
            [button setTitle:@"取消" forState:0];
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        }
        else {
            [button setTitle:@"确定" forState:0];
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
        }
        
        [view addSubview:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44*RATIO_WIDTH-1, self.width, 0.5)];
    downLine.backgroundColor = [UICOLOR_LIGHT colorWithAlphaComponent:0.5];
    [view addSubview:downLine];
}

#pragma mark - method
- (void)show {
    self.hidden = NO;
    _maskView.transform = CGAffineTransformTranslate(_maskView.transform, 0,  _maskView.frame.size.height);
    
    [UIView animateWithDuration:.3 animations:^(void) {
        _maskView.transform = CGAffineTransformIdentity;
        self.alpha = 1.0;
    } completion:nil];
}

- (void)hide {
    [UIView animateWithDuration:.3 animations:^(void) {
        _maskView.transform = CGAffineTransformTranslate(_maskView.transform, 0,  _maskView.frame.size.height);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - getter


#pragma mark - setter
- (void)setDpMode:(UIDatePickerMode)dpMode {
    _datePicker.datePickerMode = dpMode;
}

#pragma mark - dealloc
- (void)dealloc {
    
}

#pragma mark - other

@end
