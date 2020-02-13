//
//  XXZNavigationController.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/5/13.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

class XXZNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = whiteColor
        self.shadowImage()
    }

    //MARK: ------ Zachary - delegate ------
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if (self.children.count > 0) { // 非根控制器
    
        viewController.hidesBottomBarWhenPushed = true
        
        let back = UIBarButtonItem.init()
        back.title = ""
        viewController.navigationItem.backBarButtonItem = back
        
        self.navigationBar.tintColor = blackColor.withAlphaComponent(1)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font_bold(16), NSAttributedString.Key.foregroundColor: blackColor]
        }
        
        if self.viewControllers.contains(viewController) {
            return;
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }
    
    //MARK: ------ Zachary - action ------
    
    
    //MARK: ------ Zachary - build layout ------
    func buildLayout() {
        
    }
    
    //MARK: ------ Zachary - loading ------
    
    
    //MARK: ------ Zachary - method ------
    
    
    //MARK: ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: ------ Zachary - other ------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UINavigationController {
    ///导航栏默认白色, 带阴影
    func shadowImage(_ color:UIColor = whiteColor) {
        let bgImage = imageWithColor(color, CGSize.init(width: SCREEN_WIDTH*2, height: CGFloat(SafeArea_Navbar_H)))
        self.navigationBar.setBackgroundImage(bgImage, for: UIBarMetrics.default)
        
        var shadowImage = imageName("navigationbar_shadow_light")?.stretchableImage()
        if shadowImage==nil {
            shadowImage = imageWithColor(clearColor, .init(width: SCREEN_WIDTH, height: 1));
        }
        self.navigationBar.shadow(lightGrayColor.withAlphaComponent(0.2), 5, 1)
        self.navigationBar.shadowImage = shadowImage
    }
    
    ///导航栏默认透明, 不带阴影
    func alphaImage() {
        let bgImage = imageWithColor(clearColor, CGSize.init(width: SCREEN_WIDTH, height: CGFloat(SafeArea_Navbar_H)))
        self.navigationBar.setBackgroundImage(bgImage, for: UIBarMetrics.default)
        
        let shadowImage = imageWithColor(clearColor, CGSize.init(width: SCREEN_WIDTH, height: CGFloat(1.0)))
        self.navigationBar.shadowImage = shadowImage
    }
    
    ///恢复系统默认
    func defaultImage() {
        self.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationBar.shadowImage = nil
    }
}
