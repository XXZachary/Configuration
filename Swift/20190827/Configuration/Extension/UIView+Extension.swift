//
//  UIView+Extension.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/8/2.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - rect ------
extension CGRect {
    /// 默认的位置
    public var rect: CGRect {
        return self
    }
    
    /// 距离 x
    public var x: CGFloat {
        set {
            self.origin.x = newValue
        }
        get {
            return self.origin.x
        }
    }
    
    /// 距离 y
    public var y: CGFloat {
        set {
            self.origin.y = newValue
        }
        get {
            return self.origin.y
        }
    }
    
    /// 宽
    public var width: CGFloat {
        set {
            self.size.width = newValue
        }
        get {
            return self.size.width
        }
    }
    
    /// 高
    public var height: CGFloat {
        set {
            self.size.height = newValue
        }
        get {
            return self.size.height
        }
    }
}

extension UIView {
    /// 距离 x
    public var x: CGFloat {
        set {
            self.frame.x = newValue
        }
        get {
            return self.frame.x
        }
    }
    /// 距离 y
    public var y: CGFloat {
        set {
            self.frame.y = newValue
        }
        get {
            return self.frame.y
        }
    }
    /// 宽
    public var width: CGFloat {
        set {
            self.frame.width = newValue
        }
        get {
            return self.frame.width
        }
    }
    /// 高
    public var height: CGFloat {
        set {
            self.frame.height = newValue
        }
        get {
            return self.frame.height
        }
    }
    
    /// 最小 x
    public var minX: CGFloat {
        return self.frame.origin.x
    }
    /// 最大 x
    public var maxX: CGFloat {
        return (self.frame.origin.x+self.frame.size.width)
    }
    /// 最小 y
    public var minY: CGFloat {
        return self.frame.origin.y
    }
    /// 最大 y
    public var maxY: CGFloat {
        return (self.frame.origin.y+self.frame.size.height)
    }
    
    /// 中心 x
    public var centerX: CGFloat {
        return (self.x + self.width/2)
    }
    /// 中心 y
    public var centerY: CGFloat {
        return (self.y + self.height/2)
    }
}

//MARK: ------ Zachary - 视图边框 ------
extension UIView {
    fileprivate var tmp:UIView {
        return self
    }
    
    ///圆角
    func radius(_ radius: CGFloat, _ masksToBounds:Bool = true) { //圆角
        tmp.layer.cornerRadius = radius
        tmp.layer.masksToBounds = masksToBounds
    }
    
    ///边框: 颜色及宽
    func border(_ width: CGFloat, _ color:UIColor, _ masksToBounds:Bool = true) { //边框
        tmp.layer.borderColor = color.cgColor
        tmp.layer.borderWidth = width
    }
    
    ///圆角及边框
    func radiusBorder(_ radius: CGFloat, _ width: CGFloat, _ color:UIColor, _ masksToBounds:Bool = true) {
        tmp.layer.cornerRadius = radius
        tmp.layer.masksToBounds = masksToBounds
        tmp.layer.borderColor = color.cgColor
        tmp.layer.borderWidth = width
    }
    
    ///阴影: color 颜色, offset 偏移量, radius 半径, opacity 透明度
    func shadow(_ color:UIColor, _ radius: CGFloat, _ opacity:Float, _ offset: CGSize = CGSize.init(width: 0, height: 0), _ masksToBounds:Bool = false) {
        tmp.layer.shadowColor = color.cgColor
        tmp.layer.shadowOffset = offset
        tmp.layer.shadowRadius = radius
        tmp.layer.shadowOpacity = opacity
        tmp.layer.masksToBounds = masksToBounds
    }
}
