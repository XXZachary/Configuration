//
//  KBaseModel.m
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import "KBaseModel.h"
#import "NSString+ThreeDES.h"
#import "JSONKit.h"

@implementation KBaseModel

- (NSString *)getPostRequestURL{
    
    return nil;
}

- (NSMutableDictionary *)changeToDic {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(!IS_BLANK_STRING([ECurrentUserInfo sharedInstance].cmToken)){
        [dict setObject:[ECurrentUserInfo sharedInstance].cmToken forKey:@"token"];
    }
    return dict;
}

#pragma mark - Zachary -
/*
 * 加密后的 body 数据
 */
- (NSString *)encrypt_body {
    NSData *jsonData = [self toJSONData:[self changeToDic] ];
    NSString *encrypt_data = [self useThreeDES_Encry:jsonData];
    return encrypt_data;
}

/*
 * 不加密后的 body 数据
 */
- (NSString *)no_encrypt_body {
    NSData *jsonData = [self toJSONData:[self changeToDic] ];
    NSString *no_encrypt_data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return no_encrypt_data;
}

- (NSData *)toJSONData:(id)theData{
	NSError *error = nil;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];

	if ([jsonData length] > 0 && error == nil){
		return jsonData;
	}
    else {
		return nil;
	}
}

- (NSString *)useThreeDES_Encry:(NSData *)rSource {
    NSString *stringBefore = [[NSString alloc] initWithData:rSource encoding:NSUTF8StringEncoding];
    NSString *encry_str = [NSString encrypt:stringBefore];
    return encry_str;
}

#pragma mark - Zachary - base64
//UIImage转base64字符串
- (NSString *)imageToBase64String:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NSString *imageStr = [imageData base64EncodedStringWithOptions:0];
    
    return imageStr;
}

//base64字符串转UIImage
- (UIImage *)base64StringToImage:(NSString *)imageStr {
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageStr options:0];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
