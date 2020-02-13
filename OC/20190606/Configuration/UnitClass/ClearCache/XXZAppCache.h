//
//  XXZAppCache.h
//  UICollectionVIewDemo
//
//  Created by Zachary on 2017/7/11.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXZAppCache : NSObject

//获取app缓存大小
+ (CGFloat)getCacheSize;

//清理app缓存
+ (void)clearAppCache;

@end
