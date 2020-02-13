//
//  XXZSessionTask.m
//  Zachary
//
//  Created by Jiayu_Zachary on 2016/10/31.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZSessionTask.h"

//限制与服务器交互最长时间, 单位 s
static NSUInteger timeoutInterval = 30.0;

@interface XXZSessionTask () <NSURLSessionDelegate, NSURLSessionTaskDelegate>

@end

@implementation XXZSessionTask

+ (XXZSessionTask *)shareInstance {
    static XXZSessionTask *sessionTask = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionTask = [[XXZSessionTask alloc] init];
    });
    
    return sessionTask;
}

#pragma mark - ----------------------------------------------------------
#pragma mark - NSURLSessionDelegate
//会话级别的回调
#if 0
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    // 1. 先判断服务器采用的认证方法是否为NSURLAuthenticationMethodServerTrust，ServerTrust是比较常用的，当然还有其他的认证方法。
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        // 2. 获取需要验证的信任对象，并采用系统默认验证方式SecTrustEvaluate进行验证，其中验证的API在Security库中
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        SecTrustResultType result;
        OSStatus status = SecTrustEvaluate(trust, &result);
        
        if (status == errSecSuccess && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)) {
            // 3. 验证成功，根据服务器返回的受保护空间中的信任对象，创建一个挑战凭证，并且挑战方式为使用凭证挑战
            credential = [NSURLCredential credentialForTrust:trust];
            disposition = NSURLSessionAuthChallengeUseCredential;
            
        } else {
            // 3. 验证失败，取消本次挑战认证
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
    } else {
        // 1. 如果服务器采用的认证方法不是ServerTrust，可判断是否为其他认证，如何NSURLAuthenticationMethodHTTPDigest，等等，这里我没有判断，直接处理为系统默认处理。
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    // 4. 无论结果如何，都要回到给服务端
    completionHandler(disposition, credential);
}
#endif

#pragma mark - NSURLSessionTaskDelegate
#if 1
//任务级别的回调
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    // 1. 先判断服务器采用的认证方法是否为NSURLAuthenticationMethodServerTrust，ServerTrust是比较常用的，当然还有其他的认证方法。
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        // 2. 获取需要验证的信任对象，并设置信任对象要验证的证书为之前导入的证书，在SecTrustEvaluate进行验证，其中验证的API在Security库中
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef)[self returnAnchorCertificates]);
        SecTrustResultType result;
        OSStatus status = SecTrustEvaluate(trust, &result);
        
        if (status == errSecSuccess && (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified)) {
            // 3. 验证成功，根据服务器返回的受保护空间中的信任对象，创建一个挑战凭证，并且挑战方式为使用凭证挑战
            credential = [NSURLCredential credentialForTrust:trust];
            disposition = NSURLSessionAuthChallengeUseCredential;
            
        } else {
            // 3. 验证失败，取消本次挑战认证
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
    } else {
        // 1. 如果服务器采用的认证方法不是ServerTrust，可判断是否为其他认证，如何NSURLAuthenticationMethodHTTPDigest，等等，这里我没有判断，直接处理为系统默认处理。
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    // 4. 无论结果如何，都要回到给服务端
    completionHandler(disposition, credential);
}
#endif

- (NSArray *)returnAnchorCertificates {
    // 1. 先导入证书    // 2. 证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"222" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    SecCertificateRef myCert = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)(cerData));
    
    // 自建信任证书列表
    return @[CFBridgingRelease(myCert)];
}

// 3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if(error == nil) {
        XXZLog(@"任务成功");
    }
    else {
        XXZLog(@"任务失败");
    }
}

#pragma mark - -----------------------------同步-----------------------------
#pragma mark -  data task 普通参数 获取数据
- (void)synDataTaskWithMainPath:(NSString *)mainPath body:(NSString *)bodyData result:(DataTaskResult)result {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //拼接request
    [self synDataTaskWithMainPath:mainPath andBody:bodyData result:result];
}

- (void)synDataTaskWithMainPath:(NSString *)mainPath andBody:(NSString *)paraStr result:(DataTaskResult)result {
    
    NSURL *url = [NSURL URLWithString:mainPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPBody:[paraStr dataUsingEncoding:4]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //    NSURLSessionDataTask * task = [session dataTaskWithURL:url];
    
#if 1
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
            [self showResponseCode:response];
        
            NSDictionary *dic = nil;
            if(error == nil) {
                dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
                
                if (dic) {
                    
                }
                else {
                    XXZLog(@"数据格式不正确...");
                }
                
            }
            else {
                XXZLog(@"请求失败 = %@", error);
            }
            
            result(dic); //返回结果
//        });
    }];
#endif
    
    [task resume]; //执行
}

#pragma mark - -----------------------------异步-----------------------------
#pragma mark -  data task 普通参数 获取数据
- (void)asynDataTaskWithMainPath:(NSString *)mainPath body:(NSString *)bodyData result:(DataTaskResult)result {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        //拼接request
        [self dataTaskWithMainPath:mainPath andBody:bodyData result:result];
    });
}

- (void)asynDataTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras result:(DataTaskResult)result {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSString *path = @"";
        if (paras) { //不为 nil
            NSArray *keyArr = paras.allKeys;
            for (int i=0; i<keyArr.count; i++) {
                NSString *keyStr = keyArr[i];
                NSString *valueStr = paras[keyStr];
                
                NSString *unit = @"&";
                if (i+1 == keyArr.count) {
                    unit = @"";
                }
                
                path = [path stringByAppendingString:[NSString stringWithFormat:@"%@=%@%@", keyStr, valueStr, unit]];
            }
            
            if (path.length) { //有参数
                
            }
            else { //无参数
                
            }
        }
        else { //为 nil
            
        }
        
        //拼接request
        [self dataTaskWithMainPath:mainPath andBody:path result:result];
    });
}

- (void)dataTaskWithMainPath:(NSString *)mainPath andBody:(NSString *)paraStr result:(DataTaskResult)result {
    
    NSURL *url = [NSURL URLWithString:mainPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPBody:[paraStr dataUsingEncoding:4]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
#if 0
     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:
     @"application/json",
     @"application/octet-stream",
     @"text/javascript",
     @"text/json",
     @"text/html",
     @"text/css",
     @"text/plain",
     nil]];
#endif
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    
#if 1
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
            [self showResponseCode:response];
            
            NSDictionary *dic = nil;
            if(error == nil) {
                dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
                
                if (dic) {
                    
                }
                else {
                    XXZLog(@"数据格式不正确...");
                }
                
            }
            else {
                XXZLog(@"请求失败 = %@", error);
            }
            
            result(dic); //返回结果
        });
    }];
#endif
    
    [task resume]; //执行
}

#pragma mark - data task 普通参数+图片集合 上传数据
- (void)asynDataTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras pics:(NSMutableArray *)picsArr result:(DataTaskResult)result {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        //1 -
        //分界线的标识符
        NSString *MARK_FORM_BOUNDARY = @"Xavier Zachary";
        //分界线 --MARK_FORM_BOUNDARY
        NSString *startMPboundary = [[NSString alloc]initWithFormat:@"--%@", MARK_FORM_BOUNDARY];
        //结束符 MARK_FORM_BOUNDARY--
        NSString *endMPboundary = [[NSString alloc]initWithFormat:@"%@--", startMPboundary];
        
        //3 -
        //http body的字符串
        NSMutableString *bodyStr = [[NSMutableString alloc] init];
        //参数的集合的所有key的集合
        NSArray *keys = [paras allKeys];
        //遍历keys
        for(int i=0; i<[keys count]; i++) {
            //得到当前key
            NSString *key = [keys objectAtIndex:i];
            //添加分界线，换行
            [bodyStr appendFormat:@"%@\r\n", startMPboundary];
            //添加字段名称，换2行
            [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
            //添加字段的值
            [bodyStr appendFormat:@"%@\r\n", [paras objectForKey:key]];
        }
        
        //3 -
        //声明myRequestData，用来放入http body
        NSMutableData *myRequestData=[NSMutableData data];
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        //循环加入上传图片
        for(int i = 0; i< picsArr.count; i++){
            UIImage *image = picsArr[i]; ////要上传的图片
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
        
        //2 -
        //根据url初始化request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:mainPath] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeoutInterval];
        
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
        
        //去请求
        [self dataTaskWithRequest:request result:result];
    });
}

- (void)dataTaskWithRequest:(NSMutableURLRequest *)request result:(DataTaskResult)result {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
            [self showResponseCode:response];
            
            NSDictionary *dic = nil;
            if(error == nil) {
                dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
                
                if (dic) {
                    
                }
                else {
                    XXZLog(@"数据格式不正确...");
                }
                
            }
            else {
                XXZLog(@"请求失败 = %@", error);
            }
            
            result(dic); //返回结果
        });
        
    }];
    
    [task resume]; //执行
}

- (void)asynDataTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras pics:(NSMutableArray *)picsArr type:(NSInteger)type result:(DataTaskResult)result {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
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
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:mainPath] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeoutInterval];
        
        //3 -
        //http body的字符串
        NSMutableString *bodyStr = [[NSMutableString alloc] init];
        //参数的集合的所有key的集合
        NSArray *keys = [paras allKeys];
        //遍历keys
        for(int i=0; i<[keys count]; i++) {
            //得到当前key
            NSString *key = [keys objectAtIndex:i];
            //添加分界线，换行
            [bodyStr appendFormat:@"%@\r\n", startMPboundary];
            //添加字段名称，换2行
            [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
            //添加字段的值
            [bodyStr appendFormat:@"%@\r\n", [paras objectForKey:key]];
        }
        
        //3 -
        //声明myRequestData，用来放入http body
        NSMutableData *myRequestData=[NSMutableData data];
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        //循环加入上传图片
        for(int i = 0; i< picsArr.count; i++){
            UIImage *image = picsArr[i]; ////要上传的图片
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
            
            //            [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"image-%d.png\"\r\n", i, i];
            
            
            //type = 0, 只有行驶证(2 正面, 3 反面), 1 只有身份证(0 正面, 1 反面), 2 两者都有
            if (type == 0) {
                if (i == 0) {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 2]; //行驶证 正面
                }
                else {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 3]; //行驶证 反面
                }
            }
            else if (type == 1) {
                if (i == 0) {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 0]; //身份证 正面
                }
                else {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 1]; //身份证 反面
                }
            }
            else {
                if (i == 0) {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 2]; //行驶证 正面
                }
                else if (i == 1) {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 3]; //行驶证 反面
                }
                else if (i == 2) {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 0]; //身份证 正面
                }
                else {
                    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"ImageField-%d\"; filename=\"ImageField-%d.png\"\r\n", i, 1]; //身份证 反面
                }
            }
            
            
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
        
        //去请求
        [self dataTaskWithRequest:request result:result];
    });
}

#pragma mark - ----------------------------------------------------------
#pragma mark - upload task 上传数据
- (void)uploadTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras result:(UploadTaskResult)result {
    
}

- (void)uploadTaskWithMainPath:(NSString *)mainPath andBody:(NSString *)paraStr result:(UploadTaskResult)result {
    
    NSURL *url = [NSURL URLWithString:mainPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    NSData *data = [paraStr dataUsingEncoding:4];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
            [self showResponseCode:response];
            
            NSDictionary *dic = nil;
            if(error == nil) {
                dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments error:nil];
                
                if (dic) {
                    
                }
                else {
                    XXZLog(@"数据格式不正确...");
                }
                
            }
            else {
                XXZLog(@"请求失败 = %@", error);
            }
            
            result(dic); //返回结果
        });
    }];
    
    [task resume]; //执行
}

#pragma mark - download task下载数据
- (void)downloadTaskWithMainPath:(NSString *)mainPath parameter:(NSMutableDictionary *)paras result:(DownloadTaskResult)result {
    
}

- (void)downloadTaskWithMainPath:(NSString *)mainPath andBody:(NSString *)paraStr result:(DownloadTaskResult)result {
    NSURL *url = [NSURL URLWithString:mainPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication].keyWindow setWindowLevel:UIWindowLevelNormal];
            [self showResponseCode:response];
            
            if(error == nil) {
                
            }
            else {
                XXZLog(@"请求失败 = %@", error);
            }
            
            result(location); //返回结果
        });
    }];
    
    [task resume]; //执行
}

#pragma mark - ----------------------------------------------------------
#pragma mark - 输出 http 响应的状态码
- (void)showResponseCode:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    
    XXZLog(@"responseStatusCode = %ld", responseStatusCode);
    if (responseStatusCode == 200) {
        XXZLog(@"服务器成功返回网页");
    }
    else if (responseStatusCode == 404) {
        XXZLog(@"请求的网页不存在");
    }
    else if (responseStatusCode == 503) {
        XXZLog(@"服务不可用");
    }
    else {
        switch (responseStatusCode) {
            case 100:
            {
                XXZLog(@"(继续) 请求者应当继续提出请求. 服务器返回此代码表示已收到请求的第一部分, 正在等待其余部分. ");
            }
                break;
            case 101:
            {
                XXZLog(@"(切换协议) 请求者已要求服务器切换协议, 服务器已确认并准备切换. ");
            }
                break;
                
            case 200:
            {
                XXZLog(@"(成功) 服务器已成功处理了请求. 通常, 这表示服务器提供了请求的网页. ");
            }
                break;
            case 201:
            {
                XXZLog(@"(已创建) 请求成功并且服务器创建了新的资源. ");
            }
                break;
            case 202:
            {
                XXZLog(@"(已接受) 服务器已接受请求, 但尚未处理. ");
            }
                break;
            case 203:
            {
                XXZLog(@"(非授权信息) 服务器已成功处理了请求, 但返回的信息可能来自另一来源. ");
            }
                break;
            case 204:
            {
                XXZLog(@"(无内容) 服务器成功处理了请求, 但没有返回任何内容. ");
            }
                break;
            case 205:
            {
                XXZLog(@"(重置内容) 服务器成功处理了请求, 但没有返回任何内容. ");
            }
                break;
            case 206:
            {
                XXZLog(@"(部分内容) 服务器成功处理了部分 GET 请求. ");
            }
                break;
                
            case 300:
            {
                XXZLog(@"(多种选择) 针对请求, 服务器可执行多种操作. 服务器可根据请求者 (user agent) 选择一项操作或提供操作列表供请求者选择. ");
            }
                break;
            case 301:
            {
                XXZLog(@"(永久移动) 请求的网页已永久移动到新位置. 服务器返回此响应(对 GET 或 HEAD 请求的响应)时, 会自动将请求者转到新位置. ");
            }
                break;
            case 302:
            {
                XXZLog(@"(临时移动) 服务器目前从不同位置的网页响应请求, 但请求者应继续使用原有位置来进行以后的请求. ");
            }
                break;
            case 303:
            {
                XXZLog(@"(查看其他位置) 请求者应当对不同的位置使用单独的 GET 请求来检索响应时, 服务器返回此代码. ");
            }
                break;
            case 304:
            {
                XXZLog(@"(未修改) 自从上次请求后, 请求的网页未修改过. 服务器返回此响应时, 不会返回网页内容. ");
            }
                break;
            case 305:
            {
                XXZLog(@"(使用代理) 请求者只能使用代理访问请求的网页. 如果服务器返回此响应, 还表示请求者应使用代理. ");
            }
                break;
            case 306:
            {
                XXZLog(@"在最新版的规范中, 306状态码已经不再被使用. ");
            }
                break;
            case 307:
            {
                XXZLog(@"(临时重定向) 服务器目前从不同位置的网页响应请求, 但请求者应继续使用原有位置来进行以后的请求. ");
            }
                break;
                
            case 400:
            {
                XXZLog(@"(错误请求) 服务器不理解请求的语法. ");
            }
                break;
            case 401:
            {
                XXZLog(@"(未授权) 请求要求身份验证. 对于需要登录的网页, 服务器可能返回此响应. ");
            }
                break;
            case 402:
            {
                XXZLog(@"402 该状态码是为了将来可能的需求而预留的. ");
            }
                break;
            case 403:
            {
                XXZLog(@"(禁止) 服务器拒绝请求. ");
            }
                break;
            case 404:
            {
                XXZLog(@"(未找到) 服务器找不到请求的网页. ");
            }
                break;
            case 405:
            {
                XXZLog(@"(方法禁用) 禁用请求中指定的方法. ");
            }
                break;
            case 406:
            {
                XXZLog(@"(不接受) 无法使用请求的内容特性响应请求的网页. ");
            }
                break;
            case 407:
            {
                XXZLog(@"(需要代理授权) 此状态代码与 401(未授权)类似, 但指定请求者应当授权使用代理. ");
            }
                break;
            case 408:
            {
                XXZLog(@"(请求超时) 服务器等候请求时发生超时. ");
            }
                break;
            case 409:
            {
                XXZLog(@"(冲突) 服务器在完成请求时发生冲突. 服务器必须在响应中包含有关冲突的信息. ");
            }
                break;
            case 410:
            {
                XXZLog(@"(已删除) 如果请求的资源已永久删除, 服务器就会返回此响应. ");
            }
                break;
            case 411:
            {
                XXZLog(@"(需要有效长度) 服务器不接受不含有效内容长度标头字段的请求. ");
            }
                break;
            case 412:
            {
                XXZLog(@"(未满足前提条件) 服务器未满足请求者在请求中设置的其中一个前提条件. ");
            }
                break;
            case 413:
            {
                XXZLog(@"(请求实体过大) 服务器无法处理请求, 因为请求实体过大, 超出服务器的处理能力. ");
            }
                break;
            case 414:
            {
                XXZLog(@"(请求的 URL 过长) 请求的 URL(通常为网址)过长, 服务器无法处理. ");
            }
                break;
            case 415:
            {
                XXZLog(@"(不支持的媒体类型) 请求的格式不受请求页面的支持. ");
            }
                break;
            case 416:
            {
                XXZLog(@"(请求范围不符合要求) 如果页面无法提供请求的范围, 则服务器会返回此状态代码. ");
            }
                break;
            case 417:
            {
                XXZLog(@"(未满足期望值) 服务器未满足\"期望\"请求标头字段的要求. ");
            }
                break;
                
            case 500:
            {
                XXZLog(@"(服务器内部错误) 服务器遇到错误, 无法完成请求. ");
            }
                break;
            case 501:
            {
                XXZLog(@"(尚未实施) 服务器不具备完成请求的功能. 例如, 服务器无法识别请求方法时可能会返回此代码. ");
            }
                break;
            case 502:
            {
                XXZLog(@"(错误网关) 服务器作为网关或代理, 从上游服务器收到无效响应. ");
            }
                break;
            case 503:
            {
                XXZLog(@"(服务不可用) 服务器目前无法使用(由于超载或停机维护). 通常, 这只是暂时状态. ");
            }
                break;
            case 504:
            {
                XXZLog(@"(网关超时) 服务器作为网关或代理，但是没有及时从上游服务器收到请求. ");
            }
                break;
            case 505:
            {
                XXZLog(@"(HTTP 版本不受支持) 服务器不支持请求中所用的 HTTP 协议版本. ");
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - 输出 http 响应的状态码 详细描述
// 百度百科: http://baike.baidu.com/link?url=tS5RoDr8_38bV3Ud43QuYtAJyIc36P8non9q9_n7Ua4B-8kuvaoUunZ1glhphuS9ntbpDB1y9d0FPaoGX4s-d_

/*
 一些常见的状态码为：
 200 - 服务器成功返回网页
 404 - 请求的网页不存在
 503 - 服务不可用
 
 详细分解：
 1xx (临时响应) 表示临时响应并需要请求者继续执行操作的状态代码.
 
 代码说明
 100 (继续) 请求者应当继续提出请求. 服务器返回此代码表示已收到请求的第一部分,正在等待其余部分。
 101 (切换协议) 请求者已要求服务器切换协议,服务器已确认并准备切换.
 
 2xx (成功) 表示成功处理了请求的状态代码.
 代码说明
 200 (成功) 服务器已成功处理了请求。 通常，这表示服务器提供了请求的网页。
 201 (已创建) 请求成功并且服务器创建了新的资源。
 202 (已接受) 服务器已接受请求，但尚未处理。
 203 (非授权信息) 服务器已成功处理了请求，但返回的信息可能来自另一来源。
 204 (无内容) 服务器成功处理了请求，但没有返回任何内容。
 205 (重置内容) 服务器成功处理了请求，但没有返回任何内容。
 206 (部分内容) 服务器成功处理了部分 GET 请求。
 
 3xx (重定向) 表示要完成请求，需要进一步操作。 通常，这些状态代码用来重定向。
 代码 说明
 300 (多种选择) 针对请求, 服务器可执行多种操作. 服务器可根据请求者 (user agent) 选择一项操作或提供操作列表供请求者选择。
 301 (永久移动) 请求的网页已永久移动到新位置. 服务器返回此响应(对 GET 或 HEAD 请求的响应)时, 会自动将请求者转到新位置。
 302 (临时移动) 服务器目前从不同位置的网页响应请求, 但请求者应继续使用原有位置来进行以后的请求.
 303 (查看其他位置) 请求者应当对不同的位置使用单独的 GET 请求来检索响应时，服务器返回此代码。
 304 (未修改) 自从上次请求后, 请求的网页未修改过. 服务器返回此响应时, 不会返回网页内容。
 305 (使用代理) 请求者只能使用代理访问请求的网页. 如果服务器返回此响应, 还表示请求者应使用代理.
 307 (临时重定向) 服务器目前从不同位置的网页响应请求, 但请求者应继续使用原有位置来进行以后的请求.
 
 4xx (请求错误) 这些状态代码表示请求可能出错，妨碍了服务器的处理。
 代码说明
 400 (错误请求) 服务器不理解请求的语法。
 401 (未授权) 请求要求身份验证。 对于需要登录的网页，服务器可能返回此响应。
 403 (禁止) 服务器拒绝请求。
 404 (未找到) 服务器找不到请求的网页。
 405 (方法禁用) 禁用请求中指定的方法。
 406 (不接受) 无法使用请求的内容特性响应请求的网页。
 407 (需要代理授权) 此状态代码与 401（未授权）类似，但指定请求者应当授权使用代理。
 408 (请求超时) 服务器等候请求时发生超时。
 409 (冲突) 服务器在完成请求时发生冲突。 服务器必须在响应中包含有关冲突的信息。
 410 (已删除) 如果请求的资源已永久删除，服务器就会返回此响应。
 411 (需要有效长度) 服务器不接受不含有效内容长度标头字段的请求。
 412 (未满足前提条件) 服务器未满足请求者在请求中设置的其中一个前提条件。
 413 (请求实体过大) 服务器无法处理请求，因为请求实体过大，超出服务器的处理能力。
 414 (请求的 URL 过长) 请求的 URL(通常为网址)过长，服务器无法处理。
 415 (不支持的媒体类型) 请求的格式不受请求页面的支持。
 416 (请求范围不符合要求) 如果页面无法提供请求的范围，则服务器会返回此状态代码。
 417 (未满足期望值) 服务器未满足"期望"请求标头字段的要求。
 
 5xx (服务器错误) 这些状态代码表示服务器在尝试处理请求时发生内部错误. 这些错误可能是服务器本身的错误, 而不是请求出错。
 代码说明
 500 (服务器内部错误) 服务器遇到错误，无法完成请求。
 501 (尚未实施) 服务器不具备完成请求的功能。 例如，服务器无法识别请求方法时可能会返回此代码。
 502 (错误网关) 服务器作为网关或代理，从上游服务器收到无效响应。
 503 (服务不可用) 服务器目前无法使用(由于超载或停机维护)。 通常，这只是暂时状态。
 504 (网关超时) 服务器作为网关或代理，但是没有及时从上游服务器收到请求。
 505 (HTTP 版本不受支持) 服务器不支持请求中所用的 HTTP 协议版本。
 */

#pragma mark - other

@end
