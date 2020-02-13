//
//  XXZSandBox.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "XXZSandBox.h"

@implementation XXZSandBox

//创建的文件或文件夹 存放在Documents文件夹下
//获取文件或文件夹路径, 若是文件则含文件类型, 若是文件夹则只有文件夹名
+ (NSString *)documentsWithFileName:(NSString *)fileName folderName:(NSString *)folderName {
    //获取根目录
    NSString *home = NSHomeDirectory();
    NSString *appendName = nil;
    
    //拼接
    if (folderName.length && fileName.length) {//创建文件夹下的文件
        appendName = [NSString stringWithFormat:@"Documents/%@/%@", folderName, fileName];
    }
    else if (fileName.length) { //创建文件
        appendName = [NSString stringWithFormat:@"Documents/%@",fileName];
    }
    else if (folderName.length) {//创建文件夹
        appendName = [NSString stringWithFormat:@"Documents/%@", folderName];
    }
    else { //无意义
        return nil;
    }
    
    //拼接完整路径
    NSString *filePath = [home stringByAppendingPathComponent:appendName];
    XXZLog(@"filePath = %@", filePath);
    
    return filePath;
}

//创建文件或文件夹, 若是文件则含文件类型, 若是文件夹则只有文件夹名
+ (void)createFileWithFileName:(NSString *)fileName folderName:(NSString *)folderName {
    NSInteger createType = -1;
    if (!fileName.length && !folderName.length) {//无意义
        XXZLog(@"文件和文件夹没有名称..");
        return;
    }
    
    NSString *completePath = [self documentsWithFileName:fileName folderName:folderName];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (folderName.length && !fileName.length) { //文件夹路径
        createType = 0;
    }
    else if (fileName.length && !folderName.length) { //文件路径
        createType = 1;
    }
    else if (folderName.length && fileName.length) { //文件夹下的文件路径
        createType = 2;
    }
    else { //无意义
        return;
    }
    
    
    if (![fm fileExistsAtPath:completePath]) {
        if (createType == 0) { //创建文件夹
            if (![fm fileExistsAtPath:completePath]) { //若不存在, 创建
                BOOL flag = [fm createDirectoryAtPath:completePath withIntermediateDirectories:YES attributes:nil error:nil];
                if (!flag) {
                    XXZLog(@"文件夹创建失败");
                }
            }
        }
        else if (createType == 1) { //创建文件
            if (![fm fileExistsAtPath:completePath]) { //若不存在, 创建
                BOOL flag = [fm createFileAtPath:completePath contents:nil attributes:nil];
                if (!flag) {
                    XXZLog(@"文件创建失败");
                }
            }
        }
        else if (createType ==2) { //创建文件夹下的文件
            NSString *folderPath = [self documentsWithFileName:nil folderName:folderName];
            if (![fm fileExistsAtPath:folderName]) {//创建文件夹
                BOOL flag = [fm createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
                if (!flag) {
                    XXZLog(@"文件夹创建失败");
                }
                else {
                    NSString *filePath = [self documentsWithFileName:fileName folderName:folderPath];
                    if (![fm fileExistsAtPath:filePath]) { //创建该文件夹下的文件
                        BOOL flag = [fm createFileAtPath:completePath contents:nil attributes:nil];
                        if (!flag) {
                            XXZLog(@"文件夹下的文件创建失败");
                        }
                    }
                }
                
            }
        }
        else {//无意义
            return;
        }
    }
    else{
        XXZLog(@"file have existed : \n%@",completePath);
    }
}

//移除文件夹及文件夹内的文件：
+ (BOOL)removeFolderWithFolderPath:(NSString *)folderPath {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:folderPath]) { //若存在,移除
        BOOL success = [fm removeItemAtPath:folderPath error:nil];
        if (success) {
            return YES;
        }
        else {
            XXZLog(@"移除失败..");
        }
    }
    else {
        XXZLog(@"路径不存在..");
    }
    
    return NO;
}

//移除文件
+ (BOOL)removeFileWithFilePath:(NSString *)filePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:filePath]) { //若存在,移除
        BOOL success = [fm removeItemAtPath:filePath error:nil];
        if (success) {
            return YES;
        }
        else {
            XXZLog(@"移除失败..");
        }
    }
    else {
        XXZLog(@"路径不存在..");
    }
    
    return NO;
}

//删除文件夹指定类型的文件
+ (BOOL)removeFileWithFolderPath:(NSString *)folderPath extension:(NSString *)extension {
    if (!extension.length) {
        XXZLog(@"没有输入扩展名..");
        return NO;
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:folderPath]) {
        XXZLog(@"文件夹路径不存在!");
        return NO;
    }
    
    //获取文件夹下的所有文件 => test.plist
    NSArray *contents = [fm contentsOfDirectoryAtPath:folderPath error:NULL];
    if (!contents.count) { //没有, 直接返回
        return YES;
    }
    
    NSEnumerator *e = [contents objectEnumerator];
    NSString *fileName;
    
    while ((fileName = [e nextObject])) {
        NSString *pathExtension = [fileName pathExtension];//取出扩展名
        
        if ([pathExtension isEqualToString:extension]) {//删除符合条件的文件
            BOOL flag = [fm removeItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:NULL];
            
            if (!flag) {//删除失败,直接返回
                XXZLog(@"移除(%@)失败..", fileName);
                return NO;
            }
        }
    }
    
    return YES;
}

//拷贝
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:srcPath] || ![fm fileExistsAtPath:dstPath]) {
        XXZLog(@"路径错误..");
        return NO; //是否存在资源路径 //是否存在目的地路径
    }
    
    //拷贝
    NSString *finalPath = [dstPath stringByAppendingPathComponent:[srcPath lastPathComponent]];
    BOOL success = [fm copyItemAtPath:srcPath toPath:finalPath error:nil];
    if (!success) {
        XXZLog(@"拷贝失败..");
        return NO;
    }
    
    return YES;
}

//移动
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:srcPath] || ![fm fileExistsAtPath:dstPath]) {
        XXZLog(@"路径错误..");
        return NO; //是否存在资源路径 //是否存在目的地路径
    }
    
    //移动
    NSString *finalPath = [dstPath stringByAppendingPathComponent:[srcPath lastPathComponent]];
    BOOL success = [fm moveItemAtPath:srcPath toPath:finalPath error:nil];
    if (!success) {
        XXZLog(@"移动失败..");
        return NO;
    }
    
    return YES;
}

@end
