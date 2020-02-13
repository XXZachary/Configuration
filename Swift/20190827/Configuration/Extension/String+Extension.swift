//
//  String+Extension.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/19.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 字符串转其他类型 ------
extension String {
    fileprivate var text:String {
        return self
    }
    
    ///base64字符串转UIImage
    func base64StringToImage() -> UIImage {
        let imageData = Data.init(base64Encoded: text)
        let image = UIImage.init(data: imageData!)
        
        return image!
    }
    
    ///json string 转 Dictionary
    func toDictionary() -> [String:AnyObject] {
        if text.isEmpty {
            return [String : AnyObject].init()
        }
        
        let jsonData:Data = text.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! [String : AnyObject]
        }
        
        return dict as! [String : AnyObject]
    }
    
    ///json string 转 Array
    func toArray() -> [AnyObject] {
        let jsonData:Data = text.data(using: .utf8)!
        
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! [AnyObject]
        }
        
        return array as! [AnyObject]
    }
}

//MARK: ------ Zachary - 截取字符串 ------
extension String {
    ///判断字符串是否为空 或 空格
    var isBlank:Bool {
        var flag = true //是空
        
        if (text.trimmingCharacters(in: .whitespaces).length) != 0 {
            flag = false //非空
        }
        
        return flag
    }
    
    ///字符串的长度
    var length:Int {
        return self.count;
    }
    
    ///截取字符串到第几位
    func to(_ index:Int) -> String {
        if index > self.length || index <= 0 {
            XXZLog("越界")
            return ""
        }
        
        let range = self.startIndex ..< self.index(self.startIndex, offsetBy: index)
        let beginning = self[range]
        let newString = String(beginning)
        
        let result = newString //self.substring(to: self.index(self.startIndex, offsetBy: index))
        
        return result
    }
    
    ///从第几位开始截取字符串
    func from(_ index:Int) -> String {
        if index > self.length || index <= 0 {
            XXZLog("越界")
            return ""
        }
        
        let range = self.index(self.startIndex, offsetBy: index) ..< self.endIndex
        let beginning = self[range]
        let newString = String(beginning)
        
        let result = newString //self.substring(from: self.index(self.endIndex, offsetBy: -index))
        
        return result
    }
    
    ///截取指定范围的字符串
    func range(_ location:Int, _ length:Int) -> String {
        if ((location+length) > self.length) || (location+length <= 0) {
            XXZLog("越界")
            return ""
        }
        
        let range = self.index(self.startIndex, offsetBy: location) ..< self.index(self.startIndex, offsetBy: (location+length))
        let beginning = self[range]
        let newString = String(beginning)
        
        let result = newString //self.substring(with: range)
        
        return result
    }
    
    ///子字符串在父类中的位置
    func toRange(_ subString:String) -> Range<String.Index>? {
        let tmp = text.range(of: subString)
        
        if tmp != nil {
            return tmp
        }
        
        return nil
    }
}

//MARK: ------ Zachary - 正则判断 ------
extension String {
    ///字符串是否含有 数字
    func isContainDigital() -> Bool {
        if text.isBlank() {
            return false
        }
        
        for (_, value) in text.enumerated() {
            if value >= "0" && value <= "9" {
                return true
            }
        }
        
        return false
    }
    
    ///字符串是否含有 字母
    func isContainAlphabet() -> Bool {
        if text.isBlank() {
            return false
        }
        
        #if false
        for c in text.utf8 {
            if (c >= 64 && c <= 91) || (c >= 96 && c <= 123) {
                return true
            }
        }
        #endif
        
        for (_, value) in text.enumerated() {
            if (value >= "a" && value <= "z") || (value >= "A" && value <= "Z") {
                return true
            }
        }
        
        return false
    }
    
    ///字符串是否含有 汉字
    func isContainChinese() -> Bool {
        if text.isBlank() {
            return false
        }
        
        for i in 0..<text.count {
            let c = (text as NSString).character(at: i)
            
            if c > 0x4e00 && c < 0x9fff {
                return true
            }
        }
        
        return false
    }
    
     ///全部 是或都不是 中文组成的字符串
    func isAllChinese(_ isAll:Bool = true) -> Bool {
        if text.isBlank() {
            return false
        }
        
        var temp = "[^\\u4e00-\\u9fff]" //全部都不是中文组成的字符串
        if isAll {
            temp = "[\\u4e00-\\u9fff]" //全部是由中文组成的字符串
        }
        
        let regex = String.init(format: "^%@{0,%ld}$", temp, text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    ///全部 是或都不是 小写字母组成的字符串
    func isAllSmallAlphabet(_ isAll:Bool = true) -> Bool {
        if text.isBlank() {
            return false
        }
        
        var temp = "[^a-z]"; //全部都不是大写字母组成的字符串
        if isAll {
            temp = "[a-z]"; //全部是由大写字母组成的字符串
        }
        
        let regex = String.init(format: "^%@{0,%ld}$", temp, text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    ///全部 是或都不是 大写字母组成的字符串
    func isAllBigAlphabet(_ isAll:Bool = true) -> Bool {
        if text.isBlank() {
            return false
        }
        
        var temp = "[^A-Z]"; //全部都不是大写字母组成的字符串
        if isAll {
            temp = "[A-Z]"; //全部是由大写字母组成的字符串
        }
        
        let regex = String.init(format: "^%@{0,%ld}$", temp, text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    ///全部 是或都不是 字母组成的字符串
    func isAllAlphabet(_ isAll:Bool = true) -> Bool {
        if text.isBlank() {
            return false
        }
        
        var temp = "[^a-zA-Z]" //全部都不是由字母组成的字符串
        if isAll {
            temp = "[a-zA-Z]"; //全部是由字母组成的字符串
        }
        
        let regex = String.init(format: "^%@{0,%ld}$", temp, text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    ///全部 是或都不是 数字组成的字符串
    func isAllDigital(_ isAll:Bool = true) -> Bool {
        if text.isBlank() { return false }
        
        var temp = "\\D" //全部都不是数字组成的字符串 => [^0-9]
        if isAll {
            temp = "\\d" //全部是由数字组成的字符串 => [0-9]
        }
        
        let regex = String.init(format: "^%@{0,%ld}$", temp, text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    ///验证身份证
    func isValidIdentityCard(isTwo:Bool = true) -> Bool {
        if text.isBlank() {
            return false
        }
        
        if text.length > 18 {
            return false
        }
        
        var temp = "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$" //15位数身份证验证正则表达式
        if isTwo {
            temp = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$" //18位数身份证验证正则表达式
        }
        
        return evaluateWithRegex(temp, text)
    }
    
    ///验证邮箱
    func isValidEmail() -> Bool {
        if text.isBlank() { return false }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        return evaluateWithRegex(regex, text)
    }
    
    ///验证中国手机号
    func isValidMobile() -> Bool {
        if text.isBlank() {
            return false
        }
        
        if text.length != 11 {
            return false
        }
        
        let regex = "^(13[0-9]|14[1,4-9]|15[0-3,5-9]|16[2,5-7]|17[0-3,5-8]|18[0-9]|19[189])\\d{8}$"
        
        return evaluateWithRegex(regex, text)
    }
}

extension String {
    func isAlphabetOrChinese(_ text:String) -> Bool { //只能由 字母 || 汉字 组成的字符串
        if text.isBlank() {
            return false
        }
        
        let regex = String.init(format: "^[A-Za-z\\u4e00-\\u9fff]{0,%d}$", text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    func isDigitalOrChinese(_ text:String) -> Bool { //只能由 数字 || 汉字 组成的字符串
        if text.isBlank() {
            return false
        }
        
        let regex = String.init(format: "^[0-9\\u4e00-\\u9fff]{0,%d}$", text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    func isDigitalOrAlphabet(_ text:String) -> Bool { //只能由 数字 || 字母 组成的字符串
        if text.isBlank() {
            return false
        }
        
        let regex = String.init(format: "^[A-Za-z0-9]{0,%d}$", text.length)
        
        return evaluateWithRegex(regex, text)
    }
}

extension String {
    ///只能由 数字 || 字母 || 汉字 组成的字符串
    func isDigitalOrAlphabetOrChinese() -> Bool {
        if text.isBlank() {
            return false
        }
        
        let regex = String.init(format: "^[a-zA-Z0-9\\u4e00-\\u9fff]{0,%d}$", text.length)
        
        return evaluateWithRegex(regex, text)
    }
    
    ///公共方法
    fileprivate func evaluateWithRegex(_ regex:String, _ text:String) -> Bool {
        let pred = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        if pred.evaluate(with: text) {
            //XXZLog("匹配...")
            return true
        }
        else {
            //XXZLog("不匹配...")
        }
        return false
    }
}

//MARK: ------ Zachary - 中文转字母及排序 ------
extension String {
    ///字符串样式
    /**
     *
     * none,                                //94862.57
     * decimal,                            //94,862.57
     * currency,                           //￥94,862.57
     * percent,                             //9,486,257%
     * scientific,                          //9.486257E4
     * spellOut                            //九万四千八百六十二点五七
     *
     * 9.0 以上
     * ordinal                              //第94,862.57
     * currencyISOCode             //CNY94,862.57
     * currencyPlural                  //94,862.57人民币
     * currencyAccounting         //¥94,862.57
     *
     */
    func stringStyle(_ style:NumberFormatter.Style) -> String {
        if text.isEmpty || text.isBlank() {
            return ""
        }
        
        let formatter = NumberFormatter.init()
        formatter.numberStyle = style
        
        let tmp = formatter.string(from: NSNumber.init(value: Double(text)!))!
        
        return tmp
    }
    
    ///将中文字符串 转换成 中文拼音字符串
    /**
     * isUp: true 大写, false 小写
     * isAll: true 全部, false 首字母
     */
    func toPinyin(_ isUp:Bool, _ isAll:Bool=true) -> String {
        if text.isEmpty || text.isBlank() {
            return ""
        }
        
        var needStr = ""
        for i in 0..<text.length {
            //截取一个中文
            let singleStr = text.range(i, 1)
            //转成了可变字符串
            let str = NSMutableString(string: singleStr)
            //先转换为带声调的拼音
            CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
            //再转换为不带声调的拼音
            CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
            
            //转化为大小写
            var tmpUp = ""
            if isUp {
                tmpUp = str.uppercased
            }
            else {
                tmpUp = str.lowercased
            }
            
            //是否截取首字母
            if !isAll {
                tmpUp = tmpUp.to(1)
            }
            
            //拼接
            if needStr.isBlank() {
                needStr = tmpUp
            }
            else {
                needStr = needStr.appendingFormat("%@", tmpUp)
            }
        }
        
        return needStr
    }
}
