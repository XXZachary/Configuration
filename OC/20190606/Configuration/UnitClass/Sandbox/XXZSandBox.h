//
//  XXZSandBox.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXZSandBox : NSObject

/**
 *  获取Documents文件夹下的文件夹路径或文件路径
 *
 *  @param fileName   文件名, 例如: @"test.plist"
 *  @param folderName 文件夹名, 例如: @"Test"
 *
 *  @return 文件或文件夹完整路径
 */
+ (NSString *)documentsWithFileName:(nullable NSString *)fileName folderName:(nullable NSString *)folderName;

/**
 *  在Documents文件夹下, 创建文件或文件夹
 *
 *  @param fileName   文件名, 例如: @"test.plist"
*
 *  @param folderName 文件夹名, 例如: @"Test"
 */
+ (void)createFileWithFileName:(nullable NSString *)fileName folderName:(nullable NSString *)folderName;

/**
 *  移除文件夹
 *
 *  @param folderPath 文件夹路径
 *
 *  @return YES 移除成功, NO 移除失败
 */
+ (BOOL)removeFolderWithFolderPath:(NSString *)folderPath;

/**
 *  移除文件
 *
 *  @param filePath 文件路径
 *
 *  @return YES 移除成功, NO 移除失败
 */
+ (BOOL)removeFileWithFilePath:(NSString *)filePath;

/**
 *  移除文件夹下指定类型的文件
 *
 *  @param folderPath 文件夹路径
 *  @param extension  扩展名
 *
 *  @return YES 移除成功, NO 文件夹不存在或移除文件出错或未输入扩展名
 */
+ (BOOL)removeFileWithFolderPath:(NSString *)folderPath extension:(NSString *)extension;

/**
 *  拷贝
 *
 *  @param srcPath 资源路径
 *  @param dstPath 目的地路径
 *
 *  @return YES 拷贝成功, NO 拷贝失败或路径不对
 */
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

/**
 *  移动
 *
 *  @param srcPath 资源路径
 *  @param dstPath 目的地路径
 *
 *  @return YES 移动成功, NO 移动失败或路径不对
 */
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

@end

NS_ASSUME_NONNULL_END
