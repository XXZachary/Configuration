//
//  HgsNetwork.m
//  HgsNetwork
//
//  Created by Xavier Zachary on 15/12/7.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "HgsNetwork.h"

//限制与服务器交互最长时间, 单位 s
static NSUInteger timeoutInterval = 50.0;

@implementation HgsNetwork

#pragma mark - post
//同步POST请求, 获取数据
+ (NSDictionary *)sendPostSynchronousRequest:(NSString *)URLString andBody:(NSData *)bodyData {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //1 -
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    if (bodyData) {
        [request setHTTPBody:bodyData];
    }
    
    //2 -
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    XXZLog(@"error = %@", err);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if(receiveData == nil) {
        return [[NSDictionary alloc]initWithObjects:@[@"1010", @"连接超时"] forKeys:@[@"code", @"msg"]];
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
    
    [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
    
    if (dic.count) {
        
    }
    
    return dic;
}

//上传单张图片和其他参数
+ (NSDictionary *)postImageRequest:(NSString *)URLString UIImage:(UIImage*)image parameters:(NSDictionary *)parameters {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //1 -
    //分界线的标识符
    NSString *MARK_FORM_BOUNDARY = @"Xavier Zachary";
    //分界线 --MARK_FORM_BOUNDARY
    NSString *startMPboundary = [[NSString alloc] initWithFormat:@"--%@", MARK_FORM_BOUNDARY];
    //结束符 MARK_FORM_BOUNDARY--
    NSString *endMPboundary = [[NSString alloc] initWithFormat:@"%@--", startMPboundary];
    
    //2 -
    //根据url初始化request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeoutInterval];
    
    //3 -
    //http body的字符串
    NSMutableString *bodyStr = [[NSMutableString alloc] init];
    //参数的集合的所有key的集合
    NSArray *keys= [parameters allKeys];
    //遍历keys
    for(int i=0; i<[keys count]; i++) {
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //添加分界线，换行
        [bodyStr appendFormat:@"%@\r\n", startMPboundary];
        //添加字段名称，换2行
        [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        //添加字段的值
        [bodyStr appendFormat:@"%@\r\n", [parameters objectForKey:key]];
    }
    
    ////添加分界线，换行
    [bodyStr appendFormat:@"%@--\r\n", startMPboundary];
    
    //4 - 
    //声明pic字段，文件名为boris.png
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"ImageField\"; filename=\"headerImg.png\"\r\n"];
    //声明上传文件的格式
//    [bodyStr appendFormat:@"Content-Type: image/png\r\n\r\n"];
    [bodyStr appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = nil; //得到图片的data
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) { //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }
    else { //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    
    //将image的data加入
    [myRequestData appendData:data];
    
    //5 -
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc] initWithFormat:@"\r\n%@", endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //6 -
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc] initWithFormat:@"multipart/form-data; boundary=%@",MARK_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    
    //7 -
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (receiveData == nil) {
        return [[NSDictionary alloc] initWithObjects:@[@"1010", @"连接超时"] forKeys:@[@"code", @"msg"]];
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
    
    if (dic.count) {
        
    }
    
    return dic;
}

//上传多张张图片和其他参数
+ (NSDictionary *)postImageRequest:(NSString *)URLString imgArr:(NSMutableArray*)imageArr parameters:(NSDictionary *)parameters {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //1 -
    //分界线的标识符
    NSString *MARK_FORM_BOUNDARY = @"Xavier Zachary";
    //分界线 --MARK_FORM_BOUNDARY
    NSString *startMPboundary = [[NSString alloc]initWithFormat:@"--%@", MARK_FORM_BOUNDARY];
    //结束符 MARK_FORM_BOUNDARY--
    NSString *endMPboundary = [[NSString alloc]initWithFormat:@"%@--", startMPboundary];
    
    //2 -
    //根据url初始化request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeoutInterval];
    
    //3 -
    //http body的字符串
    NSMutableString *bodyStr = [[NSMutableString alloc] init];
    //参数的集合的所有key的集合
    NSArray *keys = [parameters allKeys];
    //遍历keys
    for(int i=0; i<[keys count]; i++) {
        //得到当前key
        NSString *key = [keys objectAtIndex:i];
        //添加分界线，换行
        [bodyStr appendFormat:@"%@\r\n", startMPboundary];
        //添加字段名称，换2行
        [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        //添加字段的值
        [bodyStr appendFormat:@"%@\r\n", [parameters objectForKey:key]];
    }
    
    //3 -
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    //循环加入上传图片
    for(int i = 0; i< imageArr.count; i++){
        UIImage *image = imageArr[i]; ////要上传的图片
        NSData *data = nil; //得到图片的data
        //判断图片是不是png格式的文件
//        if (UIImagePNGRepresentation(image)) { //返回为png图像。
//            data = UIImagePNGRepresentation(image);
//        }
//        else { //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 0.1);
//        }
        
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n", startMPboundary];
        
        [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"image-%d.png\"\r\n", i, i];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:data]; //将image的data加入
        [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //5 -
    //声明结束符：--AaB03x--
    NSString *end = [[NSString alloc] initWithFormat:@"%@\r\n", endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //6 -
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@", MARK_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    
    //7 -
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if (receiveData == nil) {
        return [[NSDictionary alloc] initWithObjects:@[@"1010", @"连接超时"] forKeys:@[@"code", @"msg"]];
    }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
    
    if (dic.count) {
        
    }
    
    return dic;
}

#pragma mark - other


#pragma mark - -----
+ (NSArray *)returnArr {
    return @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O",@"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
}

@end
