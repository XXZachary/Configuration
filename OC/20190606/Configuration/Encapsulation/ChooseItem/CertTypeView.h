//
//  CertTypeView.h
//  Saas
//
//  Created by Jiayu_Zachary on 16/9/28.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CertTypeViewDelegate <NSObject>

- (void)certTypeViewWithDateStr:(NSString *)certTypeStr;

@end

@interface CertTypeView : UIView

@property (nonatomic, weak) id<CertTypeViewDelegate>delegate;

- (void)show;

@end
NS_ASSUME_NONNULL_END

/**
 - (void)loadCertTypeView {
 _certTypeView = [[CertTypeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
 _certTypeView.delegate = self;
 [[UIApplication sharedApplication].keyWindow addSubview:_certTypeView];
 }
 */
