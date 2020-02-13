//
//  BasePopView.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/9/10.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import "BasePopView.h"

@interface BasePopView ()

@end

@implementation BasePopView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [BlackColor colorWithAlphaComponent:0.4];
        self.alpha = 0.0;
        
        [self buildSuperLayout];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [BlackColor colorWithAlphaComponent:0.4];
        self.alpha = 0.0;
        
        [self buildSuperLayout];
    }
    
    return self;
}

#pragma mark -


#pragma mark - notification action


#pragma mark - action


#pragma mark - build layout
- (void)buildSuperLayout {
    [self loadSuperMaskView];
}

#pragma mark - loading
- (void)loadSuperMaskView {
    _maskView = [[UIView alloc] init];
    [self addSubview:_maskView];
    
    _maskView.hidden = YES;
    _maskView.alpha = 0;
    _maskView.backgroundColor = WhiteColor;
}

#pragma mark - getter


#pragma mark - setter


#pragma mark - method
- (void)showAnimated {
    if (_maskView.hidden == NO) {
        return;
    }
    
    _maskView.hidden = NO;
    _maskView.transform = CGAffineTransformTranslate(_maskView.transform, 0, _maskView.height);
    
    WEAKSELF
    [UIView animateWithDuration:0.23 animations:^{
        self.alpha = 1.0;
        
        weakSelf.maskView.alpha = 1.0;
        weakSelf.maskView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hiddenAnimated {
    if (_maskView.hidden == YES) {
        return;
    }
    
    WEAKSELF
    [UIView animateWithDuration:0.23 animations:^{
        self.alpha = 0.0;
        
        weakSelf.maskView.alpha = 0.0;
        weakSelf.maskView.transform = CGAffineTransformTranslate(weakSelf.maskView.transform, 0, weakSelf.maskView.height);
    } completion:^(BOOL finished) {
        weakSelf.maskView.hidden = YES;
    }];
}

- (void)showAlpha {
    if (_maskView.hidden == NO) {
        return;
    }
    
    _maskView.hidden = NO;
    _maskView.transform = CGAffineTransformTranslate(_maskView.transform, 0, -_maskView.y);
    
    WEAKSELF
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1.0;
        
        weakSelf.maskView.alpha = 1.0;
        weakSelf.maskView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hiddenAlpha {
    if (_maskView.hidden == YES) {
        return;
    }
    
    WEAKSELF
    [UIView animateWithDuration:0.23 animations:^{
        self.alpha = 0.0;
        
        weakSelf.maskView.alpha = 0.0;
        weakSelf.maskView.transform = CGAffineTransformTranslate(weakSelf.maskView.transform, 0, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        weakSelf.maskView.hidden = YES;
    }];
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
