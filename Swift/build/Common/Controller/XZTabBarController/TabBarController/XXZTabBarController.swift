//
//  XXZTabBarController.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/9/19.
//  Copyright © 2018年 Zachary. All rights reserved.
//

import UIKit

class XXZTabBarController: UITabBarController, XXZTabBarDelegate {
    //MARK: ------ Zachary - constant & variable ------
    var tabBarView:XXZTabBar?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for view in self.tabBar.subviews {
            if !(view.isKind(of: XXZTabBar.self)) {
                view.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buildLayout()
        
        loadTabBarWithCount()
    }
    
    //MARK: ------ Zachary - XXZTabBarDelegate ------
    func tabBar(_ tabBar: XXZTabBar, _ from: NSInteger, _ to: NSInteger) {
        self.selectedIndex = to
    }
    
    //MARK: ------ Zachary - action ------
    
    
    //MARK: ------ Zachary - build layout ------
    func buildLayout() {
        
    }
    
    //MARK: ------ Zachary - loading ------
    private func loadTabBarWithCount() {
        let count = selectImage().count
        
        //删除现有的tabBar
        var rect:CGRect = self.tabBar.bounds
        rect.size.height = (rect.size.height+CGFloat(SafeArea_Bottom_H));
        
        
        //去掉线
        self.tabBar.shadowImage = imageWithColor(clearColor, CGSize.init(width: SCREEN_WIDTH, height: 1))
        self.tabBar.backgroundImage = UIImage.init()
        
        //测试添加自己的视图
        tabBarView = XXZTabBar.init()
        self.tabBar.addSubview(tabBarView!)
        
        tabBarView?.titleNameArr = tabBarTitleName()
        tabBarView?.frame = rect;
        tabBarView?.delegate = self;
        tabBarView?.backgroundColor = whiteColor
        tabBarView?.shadow(blackColor.withAlphaComponent(0.2), 5, 0.3)
        
        //为控制器添加按钮
        for i in 0..<count {
            tabBarView?.tag = i;
        
            let imageName = deselectImage(i)
            let imageNameSel = selectImage()[i]
        
            let image = UIImage.init(named: imageName)
            let imageSel = UIImage.init(named: imageNameSel)
        
            //传入已选和未选的图片
            tabBarView?.addButtonWithImage(image!, imageSel!)
        }
    }
    
    //MARK: ------ Zachary - method ------
    
    
    //MARK: ------ Zachary - server ------
    
    
    //MARK: ------ Zachary - setter & getter ------
    
    
    //MARK: ------ Zachary - system ------
    
    
    //MARK: ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: ------ Zachary - other ------
    private func selectImage() -> [String] {
        let arr = ["select", "select", "select"]
    
        return arr;
    }
    
    private func deselectImage(_ index:NSInteger) -> String {
        let arr = ["deselect", "deselect", "deselect"]
    
        return arr[index];
    }
    
    private func tabBarTitleName() -> [String] {
        return ["首页", "中间", "我的"]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
