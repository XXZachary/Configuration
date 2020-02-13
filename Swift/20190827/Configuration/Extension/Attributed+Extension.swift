//
//  AttributedString+Extension.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/30.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 富文本属性 ------
extension NSMutableAttributedString {
    ///字体
    func font(_ font:UIFont, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.font, value: font, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
    }
    
    ///字体颜色
    func foreColor(_ color:UIColor, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
    
    ///字体背景颜色
    func backColor(_ color:UIColor, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: range)
        }
    }
    
    ///删除线
    func strikethrough(_ strikethrough:NSUnderlineStyle = .single, _ color:UIColor=blackColor, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: .init(location: 0, length: tmp.length))
            tmp.addAttribute(NSAttributedString.Key.strikethroughStyle, value: strikethrough.rawValue, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: range)
            tmp.addAttribute(NSAttributedString.Key.strikethroughStyle, value: strikethrough.rawValue, range: range)
        }
    }
    
    ///下划线
    func underline(_ underline:NSUnderlineStyle = .single, _ color:UIColor=blackColor, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: .init(location: 0, length: tmp.length))
            tmp.addAttribute(NSAttributedString.Key.underlineStyle, value: underline.rawValue, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
            tmp.addAttribute(NSAttributedString.Key.underlineStyle, value: underline.rawValue, range: range)
        }
    }
    
    ///字体阴影
    func shadow(_ color:UIColor, _ radius:CGFloat=5, _ offset:CGSize = .zero, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        let shadowClass = NSShadow.init() //实例化阴影
        shadowClass.shadowColor = color
        shadowClass.shadowOffset = offset
        shadowClass.shadowBlurRadius = radius
        
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.shadow, value: shadowClass, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.shadow, value: shadowClass, range: range)
        }
    }
    
    ///字体边框: width>0是空心字, width<0是字体边框, width=0无效果
    func stroke(_ color:UIColor, _ width:CGFloat=3.0, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.strokeColor, value: color, range: .init(location: 0, length: tmp.length))
            tmp.addAttribute(NSAttributedString.Key.strokeWidth, value: width, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.strokeColor, value: color, range: range)
            tmp.addAttribute(NSAttributedString.Key.strokeWidth, value: width, range: range)
        }
    }
    
    ///斜体字
    //obliqueness<0 向左倾斜, obliqueness>0 向右倾斜, obliqueness=0 不倾斜; 建议范围: -1~1
    func obliqueness(_ obliqueness:CGFloat=0.3, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.obliqueness, value: obliqueness, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.obliqueness, value: obliqueness, range: range)
        }
    }
    
    ///字体扁平化
    //expansion>0上下扁平化, expansion<0左右扁平化, expansion=0 不倾斜; 建议范围: -1~1
    func expansion(_ expansion:CGFloat=1.0, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.expansion, value: expansion, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.expansion, value: expansion, range: range)
        }
    }
    
    ///链接
    //UILabel无法使用该属性, 可以使用UITextView 控件.
    func link(_ url:String) {
        if url.isBlank() {
            return;
        }
        
        let urlTmp = URL.init(string: url)!
        tmp.addAttribute(NSAttributedString.Key.link, value: urlTmp, range: .init(location: 0, length: tmp.length))
    }
    
    ///附件
    //NSTextAttachment 类有一个指定的初始化方法(- initWithData:ofType:), 需要指定附件文档的数据和附件文件的类型.
    //如果附件文档数据指定nil, 那么系统将会默认指定为image对象作为值. 因此, 也可以通过这个特性实现图文混排.
    func attachment(_ image:UIImage, _ index:Int) {
        let attach = NSTextAttachment.init(data: nil, ofType: nil)
        attach.bounds = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        attach.image = image
        
        let attachAttri = NSAttributedString.init(attachment: attach)
        tmp.insert(attachAttri, at: index)
    }
    
    ///字间距
    func kernSpacing(_ kernSpacing: CGFloat=1.0) {
        tmp.addAttribute(NSAttributedString.Key.kern, value: kernSpacing, range: .init(location: 0, length: tmp.length))
    }
    
    ///行间距
    func lineSpacing(_ lineSpacing: CGFloat=1.0) {
        let paraStyle = NSMutableParagraphStyle() //段落
        paraStyle.lineBreakMode = .byCharWrapping //结尾部分的内容以…方式省略
        paraStyle.alignment = .left
        paraStyle.lineSpacing = (lineSpacing)
        paraStyle.hyphenationFactor = 1.0 //连字属性 在iOS，唯一支持的值分别为0和1
        paraStyle.firstLineHeadIndent = 0.0 //首行缩进
        paraStyle.headIndent = 0.0 //整体缩进(首行除外)
        paraStyle.tailIndent = 0.0 //尾部缩进
        paraStyle.paragraphSpacingBefore = 0.0 //段首行空白空间
        //        paraStyle.baseWritingDirection = .rightToLeft
        
        //paraStyle.paragraphSpacing = 0.0 //段与段之间的间距
        //paraStyle.minimumLineHeight = 10.0 //最低行高
        //paraStyle.maximumLineHeight = 20.0 //最大行高
        
        tmp.addAttribute(NSAttributedString.Key.paragraphStyle, value: paraStyle, range: .init(location: 0, length: tmp.length))
    }
    
    //MARK: ------ Zachary - other ------
    ///书写方向
    func writingDirection(_ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        //        let a1 = [NSWritingDirection.leftToRight.rawValue|NSWritingDirectionFormatType.override.rawValue]
        //        let a2 = [NSWritingDirection.leftToRight.rawValue|NSWritingDirectionFormatType.embedding.rawValue]
        let a3 = [NSWritingDirection.rightToLeft.rawValue|NSWritingDirectionFormatType.override.rawValue] //有效果
        //        let a4 = [NSWritingDirection.rightToLeft.rawValue|NSWritingDirectionFormatType.embedding.rawValue]
        
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.writingDirection, value: a3, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.writingDirection, value: a3, range: range)
        }
    }
    
    ///连体字符: 一般中文用不到, 在英文中可能出现相邻字母连笔的情况
    func ligature(_ ligature:Bool=true, _ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.ligature, value: ligature, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.ligature, value: ligature, range: range)
        }
    }
    
    ///文本特殊效果
    func textEffect(_ range:NSRange=NSMakeRange(NSNotFound, NSNotFound)) {
        if range.location == NSNotFound { //默认全部
            tmp.addAttribute(NSAttributedString.Key.textEffect, value: NSAttributedString.TextEffectStyle.letterpressStyle.rawValue, range: .init(location: 0, length: tmp.length))
        }
        else { //分段
            if isNotFound(range) {return}
            
            tmp.addAttribute(NSAttributedString.Key.textEffect, value: NSAttributedString.TextEffectStyle.letterpressStyle.rawValue, range: range)
        }
    }
    
    //MARK: ------------------------------------
    //获取当前实体
    private var tmp:NSMutableAttributedString {
        return self
    }
    
    //判断区间是否有效
    private func isNotFound(_ range:NSRange) -> Bool {
        if (range.location+range.length)<=0 || range.length<=0 || range.location<0 {
            XZLog("无意义")
            return true;
        }
        if (range.length>tmp.length) || (range.location>tmp.length) || (range.location+range.length>tmp.length) {
            XZLog("越界")
            return true;
        }
        
        return false
    }
}

//MARK: ------ Zachary - 字符串编辑 ------
///对字符串进行颜色操作
func editStringColor(_ text:String, _ color:[String], _ range:[String]) -> NSMutableAttributedString {
    let attri = NSMutableAttributedString.init(string: text)
    
    return attri
}

///计算字符串高
func calculateStringHeight(_ text:String, _ font:UIFont, _ max:CGSize, _ lineSpacing:CGFloat=1.0, _ kernSpacing: CGFloat=1.0) -> CGSize {
    let dict = attributesString(font, lineSpacing, kernSpacing)
    var size = CGSize.zero
    
    let tmp = text as NSString
    
    if Double(UIDevice.current.systemVersion)! >= 7.0 {
        size = tmp.boundingRect(with: max, options: .usesLineFragmentOrigin, attributes: dict, context: nil).size
    }
    
    return size
}

///富文本设置: 行间距, 字间距
func attributesString(_ text:String, _ font:UIFont, _ lineSpacing:CGFloat=1.0 , _ kernSpacing: CGFloat=1.0) -> NSMutableAttributedString {
    let dict = attributesString(font, lineSpacing, kernSpacing)
    let attri = NSMutableAttributedString.init(string: text, attributes: dict)
    
    return attri
}

///配置富文本属性: 行间距, 字间距
private func attributesString(_ font:UIFont, _ lineSpacing:CGFloat=1.0, _ kernSpacing: CGFloat=1.0) -> [NSAttributedString.Key:Any] {
    //段落
    let paraStyle = NSMutableParagraphStyle()
    paraStyle.lineBreakMode = .byCharWrapping //结尾部分的内容以…方式省略
    paraStyle.alignment = .left
    paraStyle.lineSpacing = (lineSpacing)
    paraStyle.hyphenationFactor = 1.0 //连字属性 在iOS，唯一支持的值分别为0和1
    paraStyle.firstLineHeadIndent = 0.0 //首行缩进
    paraStyle.headIndent = 0.0 //整体缩进(首行除外)
    paraStyle.tailIndent = 0.0 //尾部缩进
    paraStyle.paragraphSpacingBefore = 0.0 //段首行空白空间
    
    //    paraStyle.paragraphSpacing = 0.0 //段与段之间的间距
    //    paraStyle.minimumLineHeight = 10.0 //最低行高
    //    paraStyle.maximumLineHeight = 20.0 //最大行高
    
    let dict: [NSAttributedString.Key:Any] = [
        NSAttributedString.Key.font:font,
        NSAttributedString.Key.paragraphStyle:paraStyle,
        NSAttributedString.Key.kern:(kernSpacing) //字间距
    ]
    
    return dict
}
