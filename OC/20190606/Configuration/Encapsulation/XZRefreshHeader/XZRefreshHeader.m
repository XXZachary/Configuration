//
//  XZRefreshHeader.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/10/19.
//  Copyright © 2018年 www.xxzachary.com. All rights reserved.
//

#import "XZRefreshHeader.h"

@interface XZRefreshHeader ()

@property (nonatomic, strong) FLAnimatedImageView* imageView;
@property (nonatomic, strong) FLAnimatedImage *image;

@end

@implementation XZRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.stateLabel.hidden = YES;
    self.backgroundColor = WhiteColor;
    
    [self playGif];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    CGRect frame = self.bounds;
    frame.size.height = Safe_Status_H+40;
    self.bounds = frame;
    
    _imageView.frame = CGRectMake(0, Safe_Status_H, SCREEN_WIDTH, 40);
}

-(void)playGif {
    _imageView = [[FLAnimatedImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"refreshing_9090" withExtension:@"gif"];
    _image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfURL:imgUrl]];
    _imageView.animatedImage = _image;
    
    [self addSubview:_imageView];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
//    XZLog(@"刷新状态 = %ld", state);
    
    _imageView.image = [UIImage imageNamed:@"refreshing_9090_"];
    
    switch (state) {
        case MJRefreshStateIdle: //闲置
            
            break;
        case MJRefreshStatePulling: //松开就可以进行刷新的状态
            
            break;
        case MJRefreshStateRefreshing: //正在刷新中的状态
            _imageView.animatedImage = _image;
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
