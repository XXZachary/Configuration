//
//  XXZHintView.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/7/20.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

fileprivate class MaskView:UIView {
    //MARK: ------ Zachary - constant & variable ------
    var activity:UIActivityIndicatorView!
    var message: UILabel?
    
    //MARK: ------ Zachary - init ------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化
        self.backgroundColor = blackColor.withAlphaComponent(0.8)
        self.radius(5)
        
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------ buildLayout ------
    func buildLayout() {
        loadActivity()
        loadMessage()
    }
    
    //MARK: ------ loading ------
    func loadActivity() {
        activity = UIActivityIndicatorView(style: .whiteLarge)
        self.addSubview(activity)
    }
    
    func loadMessage() {
        message = UILabel()
        self.addSubview(message!)
        
        message?.font = FONT_M(15)
        message?.textColor = whiteColor
        message?.numberOfLines = 1;
        message?.textAlignment = .center
    }
    
    //MARK: ------ method ------
    func show(_ animated:Bool) {
        if animated {
            activity.startAnimating()
        }
    }
    
    func hide(_ animated: Bool) {
        activity.stopAnimating()
    }
    
    func setInfo(_ isHaveIndicator:Bool, _ msg: String) {
        message?.text = msg
        
        //菊花布局
        if isHaveIndicator {
            activity.isHidden = false
            
            activity?.snp.remakeConstraints { (make) -> Void in
                make.centerX.equalTo(self)
                make.top.equalTo(self.snp.top).offset(15)
            }
        }
        else {
            activity.isHidden = true
        }
        
        //消息内容布局
        if !msg.isBlank() {
            message?.snp.remakeConstraints { (make) -> Void in
                make.left.equalTo(self.snp.left).offset(20)
                make.right.equalTo(self.snp.right).offset(-20)
                
                if !isHaveIndicator {
                    make.centerY.equalTo(self)
                }
                else {
                    make.top.equalTo(activity.snp.bottom).offset(10)
                    make.height.equalTo(20)
                }
            }
        }

    }
}

class XXZHintView: UIView {
    
    fileprivate static var isHaveIndicator = true //默认有菊花指示器
    fileprivate static var msg: String = "" //默认无提示语
    fileprivate var removeFromSuperViewOnHide: Bool = true //隐藏时, 是否删除提示框; 默认删除
    fileprivate var maskview: MaskView?
    
    //返回实例
    static func showInView( _ msg:String, _ view:UIView) -> XXZHintView {
        self.msg = msg
        
        XXZHintView.isHaveIndicator = true //显示指示器
        
        let hintView = XXZHintView.init(view, msg)
        view.addSubview(hintView)
        
        hintView.backgroundColor = clearColor
        hintView.isUserInteractionEnabled = true
        hintView.isShow = true
        
        return hintView
    }
    
    //不返回实体
    static func showNoInView(_ msg:String, _ view:UIView) {
        self.msg = msg
        
        if msg.isBlank() { //无提示语, 不显示提示框
            return;
        }
        
        XXZHintView.isHaveIndicator = false //不显示指示器
        
        let hintView = XXZHintView.init(view, msg)
        view.addSubview(hintView)
        
        hintView.backgroundColor = clearColor
        hintView.isUserInteractionEnabled = true
        hintView.isShow = true
        
        //1秒后 隐藏
        hintView.hideAfter(1.0)
    }
    
    fileprivate init(_ show:UIView, _ msg:String) {
        super.init(frame: show.bounds)
        
        buildLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {

    }

    //MARK: ------ delegate ------
    
    
    //MARK: ------ action ------
    @objc fileprivate func hideShareNoReturnAction() {
        isShow = false
    }
    
    //MARK: ------ build layout ------
    fileprivate func buildLayout() {
        loadMaskView()
    }
    
    //MARK: ------ loading ------
    fileprivate func loadMaskView() {
        if maskview == nil {
            maskview = MaskView.init()
            self.addSubview(maskview!)
        }
        
        if XXZHintView.isHaveIndicator { //有指示器
            if XXZHintView.msg.isBlank() { //无提示语
                maskview?.snp.remakeConstraints { (make) -> Void in
                    make.center.equalTo(self)
                    make.width.height.equalTo((37+15*2))
                }
            }
            else { //有提示语
                maskview?.snp.remakeConstraints { (make) -> Void in
                    make.center.equalTo(self)
                    make.height.equalTo((37+15*2+10+20))
                    make.width.lessThanOrEqualTo(self.width-20*2)
                }
            }
        }
        else { //无指示器
            maskview?.snp.remakeConstraints { (make) -> Void in
                make.center.equalTo(self)
                make.height.equalTo((10*2+20))
                make.width.lessThanOrEqualTo(self.width-20*2)
            }
        }
        
        //提示信息
        maskview?.setInfo(XXZHintView.isHaveIndicator, XXZHintView.msg)
    }
    
    //MARK: ------ property ------
    fileprivate var isShow: Bool = true { //是否显示, 默认显示; 含旋转
        willSet {
            if newValue {
                self.isHidden = false
                self.maskview?.show(XXZHintView.isHaveIndicator)
            }
            else {
                self.isHidden = true
                maskview?.hide(true)
                
                //隐藏是否移除
                if removeFromSuperViewOnHide {
                    self.maskview?.removeFromSuperview()
                    self.maskview = nil
                    self.removeFromSuperview()
                }
            }
        }
    }
    
    //MARK: ------ method ------
    func hideAfter(_ after:TimeInterval=0.0) {//0秒后 隐藏
        self.perform(#selector(hideShareNoReturnAction), with: nil, afterDelay: after)
    }
    
    //MARK: ------ deinit ------
    deinit {
        //coding...
    }
    
    //MARK: ------ other ------
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
