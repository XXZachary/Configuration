//
//  AppDelegate+Login.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/9/19.
//  Copyright © 2018年 Zachary. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func loginApp() {
//        XCurrentUserInfo.shareInstance.cmUserId = "xxz"
//        XCurrentUserInfo.shareInstance.saveUserInfo()
        
        if XCurrentUserInfo.shareInstance.isLogined {
            switchAppHome()
        }
        else {
            switchAppLogin()
        }
    }
    
    func switchAppHome() {
        if window == nil {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.backgroundColor = whiteColor
        }
        
        let home = HomeViewController.init()
        let homeNav = XXZNavigationController.init(rootViewController: home)
        
        let middle = MiddleViewController()
        let middleNav = XXZNavigationController.init(rootViewController: middle)
        
        let mine = MineViewController();
        let mineNav = XXZNavigationController.init(rootViewController: mine)
        
        let tabBar = XXZTabBarController()
        tabBar.viewControllers = [homeNav, middleNav, mineNav]
        
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
    
    func switchAppLogin() {
        if window == nil {
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.backgroundColor = whiteColor
        }
        
        let login = LoginViewController.init()
        let nav = XXZNavigationController.init(rootViewController: login)
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
