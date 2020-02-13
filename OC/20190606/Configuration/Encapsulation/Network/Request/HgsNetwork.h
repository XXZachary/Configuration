//
//  HgsNetwork.h
//  HgsNetwork
//
//  Created by Xavier Zachary on 15/12/7.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface HgsNetwork : NSObject

/**
*  同步POST请求, 获取数据
*
*  @param URLString 将要请求的接口地址
*  @param bodyData  请求的参数转化后的二进制文件
*
*  @return 给定接口所请求下的返回数据
*/
+ (NSDictionary *)sendPostSynchronousRequest:(NSString *)URLString andBody:(NSData *)bodyData;

/**
 *  上传单张图片和其他参数
 *
 *  @param URLString  将要请求的接口地址
 *  @param image      单张图片实体
 *  @param parameters 其他参数
 *
 *  @return 上传后返回的数据
 */
+ (NSDictionary *)postImageRequest:(NSString *)URLString UIImage:(UIImage*)image parameters:(NSDictionary *)parameters;

/**
 *  上传多张张图片和其他参数
 *
 *  @param URLString  将要请求的接口地址
 *  @param imageArr   多张图片实体的数组
 *  @param parameters 其他参数
 *
 *  @return 上传后返回的数据
 */
+ (NSDictionary *)postImageRequest:(NSString *)URLString imgArr:(NSMutableArray*)imageArr parameters:(NSDictionary *)parameters;

@end
NS_ASSUME_NONNULL_END
