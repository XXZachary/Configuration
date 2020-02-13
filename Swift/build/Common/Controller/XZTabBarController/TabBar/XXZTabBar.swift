//
//  XXZTabBar.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/9/19.
//  Copyright © 2018年 Zachary. All rights reserved.
//

import UIKit

protocol XXZTabBarDelegate {
    //工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
    func tabBar(_ tabBar:XXZTabBar, _ from:NSInteger, _ to: NSInteger) -> Void;
}

class XXZTabBar: UIView {
    //MARK: ------ Zachary - constant & variable ------
    var delegate: XXZTabBarDelegate?
    var selectedBtn: XXZTabBarButton?
    
//    var tmp: [String]?
    var titleNameArr: [String]? {
//        set {
//            tmp = newValue
//        }
//        get {
//            return tmp
//        }
        
        didSet {
            
        }
        
        willSet {
            
        }
    }
    
    //MARK: ------ Zachary - init ------
    init() {
        super.init(frame: CGRect.zero)
        //coding...
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: ------ Zachary - <#delegate#> ------
    
    
    //MARK: ------ Zachary - action ------
    
    
    //MARK: ------ Zachary - build layout ------
    func buildLayout() {
        
    }
    
    //MARK: ------ Zachary - loading ------
    
    
    //MARK: ------ Zachary - method ------
    ///使用特定图片来创建按钮, 可扩展性
    public func addButtonWithImage(_ image: UIImage, _ selectedImage: UIImage) {
        let btn:XXZTabBarButton = XXZTabBarButton.init()
        
        btn.img?.image = image; //未选的图标
        btn.img?.highlightedImage = selectedImage; //已选的图标
        btn.title?.text = titleNameArr?[self.tag]//标签栏标题
        btn.title?.textColor = deselectColor()
        
        self.addSubview(btn)
        
        btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
        
        //选中第一个
        if (self.subviews.count == 1) {
            clickBtn(btn)
        }
    }
    
    ///自定义TabBar的按钮点击事件
    @objc public func clickBtn(_ button: XXZTabBarButton) {
        //1.先将之前选中的按钮设置为未选中
        selectedBtn?.isSelected = false;
        selectedBtn?.img?.isHighlighted = false;
        selectedBtn?.title?.textColor = deselectColor()
        
        //2.再将当前按钮设置为选中
        button.isSelected = true;
        button.img?.isHighlighted = true;
        button.title?.textColor = selectColor()
        
        //3.最后把当前按钮赋值为之前选中的按钮
        self.selectedBtn = button;
        
        if delegate != nil {
            delegate?.tabBar(self, (self.selectedBtn?.tag)!, button.tag)
        }
    }
    
    //MARK: ------ Zachary - server ------
    
    
    //MARK: ------ Zachary - setter & getter ------
    
    
    //MARK: ------ Zachary - system ------
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let count = self.subviews.count
        for i in 0..<count {
            let btn: UIButton = self.subviews[i] as! UIButton
            btn.tag = i //设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
            let x:CGFloat = CGFloat(i) * self.bounds.size.width / CGFloat(count)
            let y:CGFloat = 0
            let width:CGFloat = self.bounds.size.width / CGFloat(count)
            let height:CGFloat = self.bounds.size.height
            btn.frame = CGRect.init(x: x, y: y, width: width, height: height)
        }
    }
    
    //MARK: ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: ------ Zachary - other ------    
    private func selectColor() -> UIColor {
        return color("#303030")
    }
    
    private func deselectColor() -> UIColor {
        return color("#a3a3a3")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
