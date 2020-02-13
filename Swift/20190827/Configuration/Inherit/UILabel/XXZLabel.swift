//
//  XXZLabel.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/7/18.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

enum XXZTextAlignment: Int {
    case middleCenterTop = 1 //水平居中 上对齐
    case middleCenter //居中对齐
    case middleCenterBottom //水平居中 下对齐
    
    case leftTop //左上对齐
    case leftCenter //垂直居中 左对齐
    case leftBottom //左下对齐
    
    case rightTop //右上对齐
    case rightCenter //垂直居中 右对齐
    case rightBottom //右下对齐
    
    case defaultType
}

class XXZLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        XXZLog("\(frame)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        willSet {
//            XXZLog("newValue = \(newValue)")
        }
    }

    ///对齐方式, 默认居中
    var textAlignmentType:XXZTextAlignment = XXZTextAlignment.middleCenter {
        didSet {
//            XXZLog("oldValue = \(oldValue)")
        }
        
        willSet {
//            XXZLog("newValue = \(newValue)")
            self.setNeedsDisplay()
        }
    }
    
    //绘制
    override func drawText(in rect: CGRect) {
        let actualRect = textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: actualRect)
    }
    
    //计算具体位置
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        
        switch self.textAlignmentType {
        case .middleCenterTop:
            rect.origin = CGPoint.init(x: (bounds.width-rect.width)/2, y: rect.y)
        case .middleCenter: //默认 居中
            rect.origin = CGPoint.init(x: (bounds.width-rect.width)/2, y: (bounds.height-rect.height)/2)
        case .middleCenterBottom:
            rect.origin = CGPoint.init(x: (bounds.width - rect.width) / 2, y: (bounds.maxY - rect.height))
            
        case .leftTop:
            rect.origin = CGPoint.init(x: (bounds.x), y: bounds.y)
        case .leftCenter:
            rect.origin = CGPoint.init(x: (bounds.x), y: (bounds.height-rect.height)/2)
        case .leftBottom:
            rect.origin = CGPoint.init(x: (bounds.x), y: (bounds.maxY-rect.height))
        
        case .rightTop:
            rect.origin = CGPoint.init(x: (bounds.maxX-rect.width), y: (bounds.y))
        case .rightCenter:
            rect.origin = CGPoint.init(x: (bounds.maxX-rect.width), y: (bounds.height-rect.height)/2)
        case .rightBottom:
            rect.origin = CGPoint.init(x: (bounds.maxX-rect.width), y: (bounds.maxY-rect.height))
            
        default:
            XXZLog("default type")
        }
        
        return rect
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
