//
//  UITableView+Exts.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/10/16.
//  Copyright © 2018年 com.xxzing.future. All rights reserved.
//

#import "UITableView+Exts.h"

@implementation UITableView (Exts)

- (void)showNoData:(BOOL)isNoData type:(XXZNoDataType)type {
    if (isNoData) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = WhiteColor;
        self.backgroundView = backView;
        
        //图
        UIImageView *noData = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self returnNoDataImage][@(type)]]];
        [backView addSubview:noData];
        
        noData.clipsToBounds = YES;
        noData.contentMode = UIViewContentModeCenter;
        
        [noData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(backView);
            make.centerY.mas_equalTo(backView).offset(-50);
            make.width.height.mas_equalTo(200);
        }];
        
        //文本
        UILabel *describe = [[UILabel alloc] init];
        [backView addSubview:describe];
        
        describe.font = FONT_S(16);
        describe.textColor = LIGHT_COLOR;
        describe.textAlignment = NSTextAlignmentCenter;
        describe.text = [self returnNoDataTitle][@(type)];
        
        [describe mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(noData.mas_bottom);
            make.height.mas_equalTo(15);
            make.centerX.mas_equalTo(backView);
        }];
    }
    else {
        self.backgroundView = nil;
    }
}

- (NSDictionary *)returnNoDataImage {
    return @{
             @(XXZNoDataTypeSystemMessage):@"no_data_system_message",
             @(XXZNoDataTypeMyAppoint):@"no_data_my_appoint",
             @(XXZNoDataTypeMyOrder):@"no_data_my_order"
             };
}

- (NSDictionary *)returnNoDataTitle {
    return @{
             @(XXZNoDataTypeSystemMessage):@"暂无消息 ",
             @(XXZNoDataTypeMyAppoint):@"暂无预约",
             @(XXZNoDataTypeMyOrder):@"暂无订单"
             };
}

@end
