//
//  MD5Model.m
//  JiaKeB
//
//  Created by fuzhaorui on 15/5/27.
//  Copyright (c) 2015年 HgsZehong. All rights reserved.
//

#import "MD5Model.h"

@implementation MD5Model

typedef uint32_t CC_LONG;       /* 32 bit unsigned integer */
extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)
__OSX_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);
#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];//返回 大写用X小写用x
    
    return output;
}

@end
