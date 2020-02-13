//
//  CertTypeView.m
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/28.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "CertTypeView.h"

@interface CertTypeView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *itemPickerView;
@property (nonatomic, strong) NSMutableArray *addItemsArr;

@end

@implementation CertTypeView {
    UIView *_maskView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //（1：身份证 2: 组织机构代码证 3：护照 4：军官证 5：港澳回乡证或台胞证 6：其他）
        _addItemsArr = [NSMutableArray arrayWithObjects: @"身份证", @"组织机构代码", @"护照", @"军官证",  @"港澳回乡证或台胞证", @"其他", nil];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        self.alpha = 0.0;
        self.hidden = YES;
        
        [self buildLayout];
    }
    
    return self;
}

#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _addItemsArr.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44*RATIO_WIDTH;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (_addItemsArr.count) {
        return _addItemsArr[row];
    }
    
    return nil;
}

#if 1
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UIView *maskView = [[UIView alloc] init];
    maskView.frame = CGRectMake(0, 0, self.frame.size.width, 44*RATIO_WIDTH);
    
//    UIView *topLine = [[UIView alloc] init];
//    topLine.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
//    topLine.backgroundColor = [UICOLOR_LIGHT colorWithAlphaComponent:0.5];
////    [maskView addSubview:topLine];
    
    UILabel *content = [[UILabel alloc] init];
    content.frame = CGRectMake(0, 0, self.frame.size.width, 44*RATIO_WIDTH);
    content.text = @"content";
    content.font = FONT_S(16);
    content.textAlignment = NSTextAlignmentCenter;
    content.textColor = UICOLOR_DARK;
    [maskView addSubview:content];
    
    if (_addItemsArr.count) {
        content.text = _addItemsArr[row];
    }
    
//    UIView *downLine = [[UIView alloc] init];
//    downLine.frame = CGRectMake(0, 0, self.frame.size.width, 44*RATIO_WIDTH-0.5);
//    downLine.backgroundColor = [UICOLOR_LIGHT colorWithAlphaComponent:0.5];
//    [maskView addSubview:downLine];
    
    return maskView;
}
#endif

#pragma mark - action
- (void)buttonAction:(UIButton *)button {
    
    NSInteger tag = button.tag;
    
    switch (tag) {
        case 100: //取消
        {
//            [self hideAddItemsView];
            [self hide];
        }
            break;
        case 101: //确定
        {
            if (_addItemsArr.count) {
                if ([_delegate respondsToSelector:@selector(certTypeViewWithDateStr:)]) {
                    NSInteger row = [_itemPickerView selectedRowInComponent:0];
                    [_delegate certTypeViewWithDateStr:_addItemsArr[row]];
                    [self hide];
                }
            }
            else {
                XXZLog(@"没有数据..");
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - build layout
- (void)buildLayout {
    [self loadMaskView];
    [self loadLocalMaskView];
    [_maskView addSubview:self.itemPickerView];
    
    //默认第一行
    [_itemPickerView selectRow:0 inComponent:0 animated:NO];
}

#pragma mark - loading
- (void)loadMaskView {
    _maskView = [[UIView alloc] init];
    _maskView.frame = CGRectMake(0, self.height-(44*4)*RATIO_WIDTH, self.width, 44*4*RATIO_WIDTH);
    _maskView.backgroundColor = WHITE_COLOR;
    [self addSubview:_maskView];
}

- (void)loadLocalMaskView {
    UIView *maskView = [[UIView alloc] init];
    maskView.frame = CGRectMake(0, 0, self.width, 44*RATIO_WIDTH);
//    maskView.backgroundColor = CYAN_COLOR;
    [_maskView addSubview:maskView];
    
    [self loadButtonWithMaskView:maskView];
}

- (void)loadButtonWithMaskView:(UIView *)view {
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((self.width-80*RATIO_WIDTH)*i, 0, 80*RATIO_WIDTH, 44*RATIO_WIDTH);
//        button.backgroundColor = CYAN_COLOR;
        button.tag = 100+i;
        button.titleLabel.font = FONT_S(14);
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
- (UIPickerView *)itemPickerView {
    if (_itemPickerView == nil) {
        _itemPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44*RATIO_WIDTH, self.width, 44*3*RATIO_WIDTH)];
        _itemPickerView.delegate = self;
        _itemPickerView.dataSource = self;
        _itemPickerView.backgroundColor = WHITE_COLOR;
    }
    return _itemPickerView;
}

#pragma mark - setter


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
