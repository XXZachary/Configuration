//
//  XXZTabBarButton.m
//  Zachary
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Zachary. All rights reserved.
//

#import "XXZTabBarButton.h"

@implementation XXZTabBarButton 

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self buildLayout];
    }
    return self;
}

#pragma mark -


#pragma mark - action


#pragma mark - build layout
- (void)buildLayout {
    [self loadImgView];
    [self loadTitleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _img.frame = CGRectMake((self.frame.size.width-20)/2, 5, 20, 20);
    _title.frame = CGRectMake(0, CGRectGetMaxY(_img.frame)+1, self.frame.size.width, 20);
}

#pragma mark - loading
- (void)loadImgView {
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
//        _img.backgroundColor = [UIColor redColor];
        [self addSubview:_img];
    }
}

- (void)loadTitleLabel {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:10.0];
        _title.textAlignment = NSTextAlignmentCenter;
//        _title.textColor = UICOLOR_LIGHT;
//        _title.backgroundColor = [UIColor cyanColor];
        _title.text = @"item";
        [self addSubview:_title];
    }
}

#pragma mark - getter


#pragma mark - setter
//什么也不做就可以取消系统按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
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
