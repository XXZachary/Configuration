//
//  XXZSandbox.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/7/31.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

class XXZSandbox: NSObject {
    private override init() {}
    
    static func moveItemAtPath(_ src:String?, _ dst:String) { //移动
        if let tempSrc = src {
            let fm = FileManager.default
            if fm.fileExists(atPath: dst) {
                XXZLog("dst file path have exist")
                return;
            }
            
            try! fm.moveItem(atPath: tempSrc, toPath: dst)
        }
        else {
            XXZLog("src file path have no exist")
        }
    }
    
    static func copyItemAtPath(_ src:String?, _ dst:String) { //拷贝
        if let tempSrc = src {
            let fm = FileManager.default
            
            if fm.fileExists(atPath: dst) {
                XXZLog("dst file path have exist")
                return;
            }
            
            try! fm.copyItem(atPath: tempSrc, toPath: dst)
        }
        else {
            XXZLog("src file path have no exist")
        }
    }
    
    static func removeFileWithFolder(_ extensionName:String, _ folderName:String) { //移除指定扩展名的所有文件
        if extensionName.isBlank() {
            XXZLog("no file extension name")
            return;
        }
        
        var completePath = ""
        if folderName.isBlank() { //没有文件夹
            completePath = NSHomeDirectory().appending("/Documents")
        }
        else { //有文件夹
            completePath = NSHomeDirectory().appending("/Documents/\(folderName)")
        }
        
        let fm = FileManager.default
        
        //获取文件夹下的所有文件
        let fileArr = try! fm.contentsOfDirectory(atPath: completePath)
        if fileArr.count <= 0 { //没有文件
            return;
        }
        
        for i in 0..<fileArr.count {
            let filePath = fileArr[i]
            if filePath .hasSuffix(extensionName) {
                try! fm.removeItem(atPath: completePath.appending("/\(filePath)"))
            }
        }
    }
    
    static func removeFileWithPath(_ fileName:String, _ folderName:String = "") { //移除指定文件夹内的文件
        let fm = FileManager.default
        
        var completePath = ""
        if folderName.isBlank() { //没有文件夹
            completePath = NSHomeDirectory().appending("/Documents/\(fileName)")
        }
        else { //有文件夹
            completePath = NSHomeDirectory().appending("/Documents/\(folderName)/\(fileName)")
        }
        
        if fm.fileExists(atPath: completePath) { //若存在, 移除
            try! fm.removeItem(atPath: completePath)
        }
        else {
            XXZLog("file is not exist")
        }
    }
    
    static func removeFolderWithPath(_ folderName:String) { //移除文件夹及文件夹内的文件
        let fm = FileManager.default
        
        let completePath = NSHomeDirectory().appending("/Documents/\(folderName)")
        if fm.fileExists(atPath: completePath) { //若存在, 移除
            try! fm.removeItem(atPath: completePath)
        }
        else {
            XXZLog("folder is not exist")
        }
    }
    
    static func createWithPath(_ fileName:String, _ folderName:String = "") { //根据文件名及文件夹名 创建文件及文件夹
        var createType = 0
        if !fileName.isBlank() && !folderName.isBlank() { //创建文件及文件夹
            createType = 1
        }
        else if !fileName.isBlank() { //只创建文件
            createType = 2
        }
        else if !folderName.isBlank() { //只创建文件夹
            createType = 3
        }
        else {
            XXZLog("no meaning")
        }
        
        let completePath = self.pathWithName(fileName, folderName)
        let fm = FileManager.default
        
        if createType == 1 {
            //创建文件夹
            let folderPath = self.pathWithName("", folderName)
            if !fm.fileExists(atPath: folderPath) {
                try! fm.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }
            else {
                XXZLog("folder have exist")
            }
            
            //创建文件
            if !fm.fileExists(atPath: completePath) {
                let flag = fm.createFile(atPath: completePath, contents: nil, attributes: nil)
                if !flag {
                    XXZLog("create file failed")
                }
            }
            else {
                XXZLog("file have exist")
            }
        }
        else if createType == 2 { //只创建文件
            if !fm.fileExists(atPath: completePath) {
                let flag = fm.createFile(atPath: completePath, contents: nil, attributes: nil)
                if !flag {
                    XXZLog("create file failed")
                }
            }
            else {
                XXZLog("file have exist")
            }
        }
        else if createType == 3 { //只创建文件夹
            if !fm.fileExists(atPath: completePath) {
                try! fm.createDirectory(atPath: completePath, withIntermediateDirectories: true, attributes: nil)
            }
            else {
                XXZLog("folder have exist")
            }
        }
        else {
            XXZLog("no meaning")
        }
    }
    
    static func pathWithName(_ file:String, _ folder:String = "") -> String { //根据文件名及文件夹名 获取文件路径
        let home = NSHomeDirectory()
        
        var appendName = ""
        if !file.isBlank() && !folder.isBlank() { //有文件名和文件夹名
            appendName = String.init(format: "Documents/%@/%@", folder, file)
        }
        else if !file.isBlank() { //只有文件名
            appendName = String.init(format: "Documents/%@", file)
        }
        else if !folder.isBlank() { //只有文件夹名
            appendName = String.init(format: "Documents/%@", folder)
        }
        else {
            XXZLog("no meaning")
            return ""
        }
        
        //拼接完整路径
        let path = home.appending("/\(appendName)")
        XXZLog("\(path)")
        
        return path
    }

}
