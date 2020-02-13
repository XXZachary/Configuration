//
//  KBaseModel.h
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBaseModel : NSObject

@property (nonatomic, copy) NSString *token;

- (NSString *)getPostRequestURL;
- (NSMutableDictionary *)changeToDic; //留给子类的纯接口

- (NSString *)encrypt_body;    //对字典内容进行加密
- (NSString *)no_encrypt_body; //对字典内容不进行加密

- (NSData *)toJSONData:(id)theData;
- (NSString *)useThreeDES_Encry:(NSData *)rSource; //解密获取的加密数据

#pragma mark - Zachary - base64
//UIImage转base64字符串
- (NSString *)imageToBase64String:(UIImage *)image;
//base64字符串转UIImage
- (UIImage *)base64StringToImage:(NSString *)imageStr;

@end
