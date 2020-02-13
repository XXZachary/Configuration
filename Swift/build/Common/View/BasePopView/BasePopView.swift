//
//  BasePopView.swift
//  Carwish
//
//  Created by Zachary on 2018/12/4.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

class BasePopView: UIView {
    
    var back = UIView()

    //MARK: - ------ Zachary - init ------
    init() {
        super.init(frame: .zero)
        //coding...
        
        self.backgroundColor = blackColor.withAlphaComponent(0.4)
        self.alpha = 0.0
        
        buildSuperLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ------ Zachary - <#delegate#> ------
    
    
    //MARK: - ------ Zachary - action ------
    
    
    //MARK: - ------ Zachary - build layout ------
    final func buildSuperLayout() {
        loadSuperBack()
    }
    
    //MARK: - ------ Zachary - loading ------
    final func loadSuperBack() {
        back.isHidden = true
        back.alpha = 0
        back.backgroundColor = .white
        self.addSubview(back)
    }
    
    //MARK: - ------ Zachary - method ------
    final func showAnimated() {
        if back.isHidden==false {
            return;
        }
        
        back.isHidden = false
        back.transform = CGAffineTransform.init(translationX: 0, y: self.back.height)
        
        UIView.animate(withDuration: 0.23, animations: {
            self.alpha = 1.0
            
            self.back.alpha = 1.0
            self.back.transform = CGAffineTransform.identity
            
        }, completion: nil)
    }
    
    final func hiddenAnimated() {
        if back.isHidden==true {
            return;
        }
        
        UIView.animate(withDuration: 0.23, animations: {
            self.alpha = 0.0
            
            self.back.alpha = 0.0
            self.back.transform = CGAffineTransform.init(translationX: 0, y: self.back.height)
            
        }) { (flag) in
            self.back.isHidden = true
        }
    }
    
    //MARK: - ------ Zachary - server ------
    
    
    //MARK: - ------ Zachary - setter & getter ------
    
    
    //MARK: - ------ Zachary - system ------
    
    
    //MARK: - ------ Zachary - deinit ------
    deinit {
        //coding...
        
    }
    
    //MARK: - ------ Zachary - other ------
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
