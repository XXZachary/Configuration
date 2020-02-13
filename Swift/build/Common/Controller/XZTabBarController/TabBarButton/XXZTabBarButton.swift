//
//  XXZTabBarButton.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/9/19.
//  Copyright © 2018年 Zachary. All rights reserved.
//

import UIKit

class XXZTabBarButton: UIButton {
    //MARK: ------ Zachary - constant & variable ------
    var img:UIImageView?
    var title: UILabel?
    
    //MARK: ------ Zachary - init ------
    init() {
        super.init(frame: CGRect.zero)
        //coding...
        self.backgroundColor = whiteColor
        self.isHighlighted = false;
        
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: ------ Zachary - <#delegate#> ------
    
    
    //MARK: ------ Zachary - action ------
    
    
    //MARK: ------ Zachary - build layout ------
    func buildLayout() {
        loadImgView()
        loadTitle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        img?.frame = CGRect.init(x: (self.width-20)/2, y: 5, width: 20, height: 20)
        title?.frame = CGRect.init(x: 0, y: (img?.frame.maxY)!+1, width: self.width, height: 20)
    }
    
    //MARK: ------ Zachary - loading ------
    func loadTitle() {
        if title == nil {
            title = UILabel.init()
            title?.font = FONT_S(10)
            title?.textAlignment = NSTextAlignment.center
            title?.text = "item"
            self.addSubview(title!)
        }
    }
    
    func loadImgView() {
        if img == nil {
            img = UIImageView.init()
            img?.contentMode = UIView.ContentMode.scaleAspectFit
            self.addSubview(img!)
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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
