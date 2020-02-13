//
//  XZTabBarController.swift
//  Swift_5.1_Learning
//
//  Created by Slife on 2019/8/16.
//  Copyright © 2019 Zachary. All rights reserved.
//

import UIKit

class XZTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buildLayout()
    }
    
    //MARK: - ------ Zachary - <#delegate#> ------
    
    
    //MARK: - ------ Zachary - action ------
    
    
    //MARK: - ------ Zachary - build layout ------
    func buildLayout() {
        self.tabBar.tintColor = blackColor
        self.tabBar.backgroundImage = imageWithColor(whiteColor, .init(width: SCREEN_WIDTH, height: CGFloat(SafeArea_Tabbar_H)))
        self.tabBar.shadowImage = imageWithColor(clearColor, .init(width: SCREEN_WIDTH, height: 1))
//        self.tabBar.barStyle = UIBarStyleBlack;
//        self.tabBar.translucent = false;
        
        let igv = UIImageView.init()
        igv.image = UIImage.init(named: "line_up_icon")
        igv.frame = CGRect.init(x: 0, y: -10, width: SCREEN_WIDTH, height: 10)
        self.tabBar.addSubview(igv)
    }
    
    override func addChild(_ childController: UIViewController) {
        super.addChild(childController)
        childController.tabBarItem = loadTabBarItem(self.children.count-1)
        
    }
    
    //MARK: - ------ Zachary - loading ------
    func loadTabBarItem(_ index:Int) -> UITabBarItem {
        //icon
        let select = UIImage.init(named: returnSelectIcon()[index])
        let deselect = UIImage.init(named: returnDeselectIcon()[index])
        
        //item
        let item = UITabBarItem.init(title: returnTitles()[index], image: select?.withRenderingMode(.alwaysOriginal), selectedImage: deselect?.withRenderingMode(.alwaysOriginal))
        
        //字体颜色
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:select_color], for: .selected)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:deselect_color], for: .normal)
        
        return item
    }
    
    
    //MARK: - ------ Zachary - method ------
    
    
    //MARK: - ------ Zachary - server ------
    
    
    //MARK: - ------ Zachary - setter & getter ------
    
    
    //MARK: - ------ Zachary - system ------
    
    
    //MARK: - ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: - ------ Zachary - other ------
    let select_color = color("#8B63E6")
    let deselect_color = color("#9C9EB9")
    
    func returnTitles() -> Array<String> {
        return ["首页", "财富", "我的"]
    }
    
    func returnSelectIcon() -> Array<String> {
        return ["deselect_tabbar_icon", "deselect_tabbar_icon", "deselect_tabbar_icon"]
    }
    
    func returnDeselectIcon() -> Array<String> {
        return ["select_tabbar_icon", "select_tabbar_icon", "select_tabbar_icon"]
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
