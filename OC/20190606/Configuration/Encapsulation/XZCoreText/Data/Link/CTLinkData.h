//
//  CTLinkData.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/15.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTLinkData : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *url;
@property (assign, nonatomic) NSRange range;

@end

NS_ASSUME_NONNULL_END
