//
//  UIImage+Extension.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/9/26.
//  Copyright © 2018年 Zachary. All rights reserved.
//

import UIKit

//MARK: - ------ Zachary - extension ------
extension UIImage {
    fileprivate var tmp:UIImage {
        return self
    }
    
    ///UIImage转base64字符串
    func imageToBase64String() -> String {
        let imageData = tmp.jpegData(compressionQuality: 0.1)
        let imageStr = imageData?.base64EncodedString()
        
        return imageStr!
    }
    
    ///拉伸
    func stretchableImage() -> UIImage {
        // 设置左边端盖宽度
        let leftCapWidth = (tmp.size.width)*0.5
        // 设置上边端盖高度
        let topCapHeight = (tmp.size.height)*0.5
        
        let newImage = tmp.stretchableImage(withLeftCapWidth: Int(leftCapWidth), topCapHeight: Int(topCapHeight))
        
        return newImage
    }
}

//MARK: - ------ Zachary - other ------
///取本地UIImage
func imageName(_ name:String) -> UIImage? {
    let image = UIImage.init(named: name)
    return image
}

///颜色转图片
func imageWithColor(_ color: UIColor, _ size: CGSize) -> UIImage {
    let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size);
    let context = UIGraphicsGetCurrentContext()
    
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image!;
}


