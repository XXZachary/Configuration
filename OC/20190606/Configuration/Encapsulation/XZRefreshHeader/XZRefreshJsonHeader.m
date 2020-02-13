//
//  XZRefreshJsonHeader.m
//  SLifeX
//
//  Created by Slife on 2019/8/15.
//  Copyright © 2019 slife. All rights reserved.
//

#import "XZRefreshJsonHeader.h"
#import "LOTAnimationView.h"

@interface XZRefreshJsonHeader ()

@property (nonatomic, strong) LOTAnimationView *animationView;

@end

@implementation XZRefreshJsonHeader

- (void)prepare {
    [super prepare];
    
    self.stateLabel.hidden = YES;
    self.backgroundColor = WhiteColor;
    
    [self loadLottieView];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    CGRect frame = self.bounds;
    frame.size.height = 60;
    self.bounds = frame;
    
    _animationView.frame = CGRectMake((SCREEN_WIDTH-60)/2, 0, 60, 60);
}

- (void)loadLottieView {
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"refresh_header"];
    animation.backgroundColor = WhiteColor;
    animation.loopAnimation = YES;
//    animation.autoReverseAnimation = YES;
//    animation.animationSpeed = 2.4;
    [self addSubview:animation];
    
    _animationView = animation;
    [_animationView playWithCompletion:^(BOOL animationFinished) {
        
    }];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    XZLog(@"scrollViewContentOffsetDidChange = %@", change);
    
    NSValue *tmp = [change objectForKey:NSKeyValueChangeNewKey];
    CGPoint point = [tmp CGPointValue];
    
    CGFloat y_off = fabs(point.y);
    XZLog(@"point = %lf", y_off);
    
    CGFloat progress = 0;
    if (y_off<=60) {
        progress = y_off/60;
        _animationView.animationProgress = progress;
    }
    else {
        
    }
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    XZLog(@"state = %ld", state);
    
    [_animationView stop];
//    [_animationView setAnimationNamed:@"refresh_header"];
    
    switch (state) {
        case MJRefreshStateIdle: //闲置
            [_animationView stop];
            break;
        case MJRefreshStatePulling: //松开就可以进行刷新的状态
            
            break;
        case MJRefreshStateRefreshing: //正在刷新中的状态
//            [_animationView setAnimationNamed:@"refresh_header"];
            _animationView.animationProgress = 1;
            [_animationView play];
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
