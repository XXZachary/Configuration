//
//  XCurrentUserInfo.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/8/1.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

let XZCurrentUserInfo_cmToken = "current_user_cmToken"
let XZCurrentUserInfo_cmUserId = "current_user_cmUserId"
let XZCurrentUserInfo_cmUserMobile = "current_user_cmUserMobile"
let XZCurrentUserInfo_cmUserName = "current_user_cmUserName"

class XCurrentUserInfo: NSObject {
    
    //单例: 简便写法
    static let shareInstance = XCurrentUserInfo.init();
    
//    private static let instance = XCurrentUserInfo.init();
//    class func share() -> XCurrentUserInfo {
//        return instance;
//    }
    
    private override init() {
        super.init()
        self.loadUserInfo()
    }
    
    //本地化属性
    var cmToken = ""
    var cmUserId = ""
    var cmUserMobile = ""
    var cmUserName = ""
    
    ///是否登录
    var isLogined:Bool {
        return !cmUserId.isBlank()
    }
    
    //加载数据
    private func loadUserInfo() {
        let defaults = UserDefaults.standard
        
        let token = defaults.object(forKey: XZCurrentUserInfo_cmToken)
        if token != nil {
            cmToken = token as! String
        }
        let userId = defaults.object(forKey: XZCurrentUserInfo_cmUserId)
        if userId != nil {
            cmUserId = userId! as! String
        }
        let userMobile = defaults.object(forKey: XZCurrentUserInfo_cmUserMobile)
        if userMobile != nil {
            cmUserMobile = userMobile! as! String
        }
        let userName = defaults.object(forKey: XZCurrentUserInfo_cmUserName)
        if userName != nil {
            cmUserName = userName as! String
        }
        
        defaults.synchronize()
    }
    
    ///保存数据
    func saveUserInfo() {
        let defaults = UserDefaults.standard
        
        if !cmToken.isBlank() {
            defaults.set(cmToken, forKey: XZCurrentUserInfo_cmToken)
        }
        if !cmUserId.isBlank() {
            defaults.set(cmUserId, forKey: XZCurrentUserInfo_cmUserId)
        }
        if !cmUserMobile.isBlank() {
            defaults.set(cmUserMobile, forKey: XZCurrentUserInfo_cmUserMobile)
        }
        if !cmUserName.isBlank() {
            defaults.set(cmUserName, forKey: XZCurrentUserInfo_cmUserName)
        }
        
        defaults.synchronize()
    }
    
    ///清除数据
    func clearUserInfo() {
        cmToken = ""
        cmUserId = ""
//        cmUserMobile = ""
        cmUserName = ""
        
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: XZCurrentUserInfo_cmToken)
        defaults.removeObject(forKey: XZCurrentUserInfo_cmUserId)
//        defaults.removeObject(forKey: XZCurrentUserInfo_cmUserMobile)
        defaults.removeObject(forKey: XZCurrentUserInfo_cmUserName)
        
        defaults.synchronize()
    }
}
