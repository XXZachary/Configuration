//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import "CTDisplayView.h"

#import "CTImageUnit.h"
#import "CTLinkUnit.h"

@interface CTDisplayView ()

@property (strong, nonatomic) UIImageView *tapImgeView;
@property (strong, nonatomic) UIView *coverView;

@property (strong,nonatomic)UIWebView *webView;

@end

@implementation CTDisplayView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGestureRecognizer];
    }
    
    return self;
}

#pragma mark - action
- (void)tapAction:(UITapGestureRecognizer *)gr {
    CGPoint point = [gr locationInView:self];
    
    //点击图片
    CTImageData *imageData = [CTImageUnit touchLinkInView:self atPoint:point data:self.ctData];
    if (imageData) {
        NSLog(@"点击的这里是图片");
        
        if (self.clickImageBlock) {
            self.clickImageBlock(imageData);
        }
        else {
            [self showTapImage:[UIImage imageNamed:imageData.name]];
        }
        
        return;
    }

    //点击链接
    CTLinkData *linkData = [CTLinkUnit touchLinkInView:self atPoint:point data:self.ctData];
    if (linkData) {
        NSLog(@"点击的这里是链接");
        
        if (self.clickLinkBlock) {
            self.clickLinkBlock(linkData);
        }
        else {
            [self showTapLink:linkData.url];
        }
        
        return;
    }
}

#pragma mark - loading
//添加手势
- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

#pragma mark - 显示预览图片
//显示图片
- (void)showTapImage:(UIImage *)tapImage{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _coverView.alpha = 0.0;
    _coverView.hidden = YES;
    [keyWindow addSubview:_coverView];
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage)]];
    
    //图片
    _tapImgeView = [[UIImageView alloc] initWithImage:tapImage];
    _tapImgeView.contentMode = UIViewContentModeScaleAspectFit;
    _tapImgeView.frame = _coverView.frame;
    _tapImgeView.center = _coverView.center;
    [_coverView addSubview:_tapImgeView];
    
    [self showImage];
}


- (void)showImage {
    if (_coverView.hidden == NO) {
        return;
    }
    
    _coverView.hidden = NO;
    _tapImgeView.transform = CGAffineTransformScale(_tapImgeView.transform, 0.1, 0.1);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 1.0;
        self.tapImgeView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hideImage {
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 0.0;
        self.tapImgeView.transform = CGAffineTransformScale(self.tapImgeView.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.tapImgeView removeFromSuperview];
        
        self.coverView = nil;
        self.tapImgeView = nil;
    }];
}

#pragma mark - 显示链接
//显示链接网页
- (void)showTapLink:(NSString *)urlStr{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //蒙版
    _coverView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    _coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _coverView.alpha = 0.0;
    _coverView.hidden = YES;
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideLink)]];
    [keyWindow addSubview:_coverView];
    
    //网页
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, keyWindow.frame.size.width-60, keyWindow.frame.size.height-(200))];
    _webView.center = keyWindow.center;
    [_webView setScalesPageToFit:YES];
    [keyWindow addSubview:_webView];
    
    //加载地址
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
    
    [self showLink];
}

- (void)showLink {
    if (_coverView.hidden == NO) {
        return;
    }
    
    _coverView.hidden = NO;
    _webView.transform = CGAffineTransformScale(_webView.transform, 0.1, 0.1);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 1.0;
        self.webView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hideLink {
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 0.0;
        self.webView.transform = CGAffineTransformScale(self.webView.transform, 0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.webView removeFromSuperview];
        
        self.coverView = nil;
        self.webView = nil;
    }];
}

#pragma mark - drawRect
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //1.获取当前绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity); //设置当前文本矩阵
    CGContextTranslateCTM(context, 0, self.bounds.size.height); //文本沿y轴移动
    CGContextScaleCTM(context, 1.0, -1.0); //文本翻转成为CoreText坐标系
    
    //3.绘制内容
    if (self.ctData) {
        //定义string每个部分的样式－>attributedString －> 生成 CTFramesetter -> 得到CTFrame -> 绘制(CTFrameDraw)
        CTFrameDraw(self.ctData.ctFrame, context);
        
        /*
         CoreText实现图文混排是在富文本中插入一个空白的图片占位符的富文本字符串
         通过代理设置相关的图片尺寸信息
         根据从富文本得到的frame计算图片绘制的frame再绘制图片这么一个过程
         */
        for (CTImageData *imageData in self.ctData.imageArray) {
            UIImage *image = [UIImage imageNamed:imageData.name];
            CGContextDrawImage(context, imageData.imageRect, image.CGImage);
        }
    }
}

#pragma mark - setter
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
