//
//  XXZSessionTask.h
//  Zachary
//
//  Created by Jiayu_Zachary on 2016/10/31.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DataTaskResult) (NSDictionary *result);
typedef void (^UploadTaskResult) (NSDictionary *result);
typedef void (^DownloadTaskResult) (NSDictionary *result);

@interface XXZSessionTask : NSObject

/**
 * 初始化实例
 */
+ (XXZSessionTask *)shareInstance;

/**
 *  同步获取数据, 直接传入body格式数据
 *
 *  @param mainPath 将要请求的接口地址
 *  @param bodyData  请求的参数拼接的字符串
 *
 *  @return result 给定接口所请求下的返回数据
 */
- (void)synDataTaskWithMainPath:(NSString *)mainPath body:(NSString *)bodyData result:(DataTaskResult)result;

/**
 *  异步获取数据, 直接传入body格式数据
 *
 *  @param mainPath 将要请求的接口地址
 *  @param bodyData  请求的参数拼接的字符串
 *
 *  @return result 给定接口所请求下的返回数据
 */
- (void)asynDataTaskWithMainPath:(NSString *)mainPath body:(NSString *)bodyData result:(DataTaskResult)result;

/**
 *  异步获取数据, 直接传入字典格式数据
 *
 *  @param mainPath 将要请求的接口地址
 *  @param paras 字典格式的数据
 *
 *  @return result 给定接口所请求下的返回数据
 */
- (void)asynDataTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras result:(DataTaskResult)result;

/**
 *  异步上传多张张图片和其他参数
 *
 *  @param mainPath  将要请求的接口地址
 *  @param picsArr   多张图片实体的数组
 *  @param paras 其他参数
 *
 *  @return result 上传后返回的数据
 */
- (void)asynDataTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras pics:(NSMutableArray *)picsArr result:(DataTaskResult)result;

/**
 *  异步上传多张张图片(特殊: 行驶证和身份证)和其他参数
 *
 *  @param mainPath  将要请求的接口地址
 *  @param picsArr   多张图片实体的数组
 *  @param type     type = 0, 只有行驶证(2 正面, 3 反面), 1 只有身份证(0 正面, 1 反面), 2 两者都有
 *  @param paras 其他参数
 *
 *  @return result 上传后返回的数据
 */
- (void)asynDataTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras pics:(NSMutableArray *)picsArr type:(NSInteger)type result:(DataTaskResult)result;

/**
 *  异步上传数据
 *
 *  @param mainPath  将要请求的接口地址
 *  @param paras 其他参数
 *
 *  @return result 上传后返回的数据
 */
- (void)uploadTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras result:(UploadTaskResult)result;

/**
 *  异步下载数据
 *
 *  @param mainPath  将要请求的接口地址
 *  @param paras 其他参数
 *
 *  @return result 上传后返回的数据
 */
- (void)downloadTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras result:(DownloadTaskResult)result;

@end
NS_ASSUME_NONNULL_END
