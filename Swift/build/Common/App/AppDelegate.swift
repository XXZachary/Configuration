//
//  AppDelegate.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/9/19.
//  Copyright © 2018年 Zachary. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        switchAppHome()
        requestWithGetDomain()
        
        return true
    }
    
    func requestWithGetDomain() {
        let url = "https://www.carwish.cn/index.php/api/index/environment"
        XXZSessionTask.shareInstance.privateAsynDataTaskWithBody(url, "") { (success, tmp) in
            if success {
                let code = tmp["code"] as! String
                if code == "0" {
                    let data = tmp["data"] as! [String:String]
                    
                    let stu_version = data["stu_version"]! //学员端正式服版本号
                    //let coach_version = data["coach_version"]! //教练端正式服版本号
                    
                    let enviurl_true = data["enviurl_true"]! //正式服主域名
                    let enviurl_test = data["enviurl_test"]! //测试服主域名
                    
                    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
                    let result = currentVersion.compare(stu_version)
                    if result == .orderedDescending { //当前版本大, 测试服
                        setHttpUrlHost(enviurl_test)
                    }
                    else {// 当前版本不小于App Store版本, 正式服
                        setHttpUrlHost(enviurl_true)
                    }
                }
                else {
                    setHttpUrlHost() //默认正式服
                }
            }
            else {
                setHttpUrlHost() //默认正式服
            }
            
            XZLog("url = \(HttpUrlHost)")
        }
    }
    
    static let shareAppDelegate = AppDelegate.init()

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

