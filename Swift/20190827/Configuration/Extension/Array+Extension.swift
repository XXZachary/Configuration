//
//  Array+Extension.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/19.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

//MARK: ------ Zachary - 数据转换 ------
extension Array {
    ///Array 转 json string
    func jsonString() -> String {
        let array = self
        
        if array.isEmpty {
            return ""
        }
        if (!JSONSerialization.isValidJSONObject(array)) {
            return ""
        }
        
        let data : Data! = try? JSONSerialization.data(withJSONObject: array, options: [])
        let jsonString = String(data:data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        
        return jsonString!
    }
    
    ///Array 转 json data
    func jsonData() -> Data {
        let array = self
        
        if array.isEmpty {
            return Data.init()
        }
        if (!JSONSerialization.isValidJSONObject(array)) {
            return Data.init()
        }
        
        let data : Data! = try? JSONSerialization.data(withJSONObject: array, options: [])
        
        return data
    }
    
    ///取值
    func index(_ index:Int) -> Any {
        let array = self
        if index<array.count {
            return array[index]
        }
        
        return ""
    }
}

//MARK: ------ Zachary - 中文转字母及排序 ------
extension Array {
    ///将中文字符串数组 转换成 中文拼音字符串数组
    /**
     * isUp: true 大写, false 小写
     * isFirst: true 首字母, false 全部
     */
    func toPinyin(_ isFirst:Bool=false, _ isUp:Bool=true) -> [String] {
        var needArr:[String] = []
        for i in 0..<tmp.count {
            let str = tmp[i]
            
            let needStr = str.toPinyin(isUp, !isFirst)
            if isFirst {
                if !needArr.contains(needStr) { //去重
                    needArr.append(needStr)
                }
            }
            else {
                needArr.append(needStr)
            }
        }
        
        return needArr
    }
    
    ///给字母字符串数组排序
    /**
     * isAscending: true 升序, false 降序
     */
    func alphabet(_ isAscending:Bool=false) -> [String] {
        var sortArr = tmp.sorted()
        
        if isAscending {
            sortArr.reverse()
        }
        
        return sortArr
    }
    
    ///排好序且分完组的元组:分组和索引; 默认升序排列
    func sort(_ isDesending:Bool = false) -> (section:[[String]], index:[String]) {
        if tmp.count == 0 { return ([], []) }
        
        let indexArr = indexSort(tmp, isDesending)
        let sectionArr = sectionSort(tmp, isDesending)
        
        return (sectionArr, indexArr)
    }
    
    //MARK: --------------------------------
    private var tmp:[String] {
        return self as! [String]
    }
    
    ///给排好序的数组分组; 默认升序排列
    private func sectionSort(_ data:[String], _ isDesending:Bool = false) -> [[String]] {
        if data.count == 0 { return [] }
        
        var resultArr:[[String]] = []
        var itemArr:[String] = []
        
        //排好序的数据
        let sortPinyin = pinyinWithSort(data, isDesending)
        
        var isHave = false //是否有 "#", 默认没有
        var tempStr = ""
        for i in 0..<sortPinyin.count {
            let temp = sortPinyin[i]
            let string = temp.string
            let pinyin = temp.pinYin.to(1)//substring(to: temp.pinYin.index(temp.pinYin.startIndex, offsetBy: 1))
            
            //判断是否存在特殊字符
            if !isHave {
                if pinyin == "#" {
                    isHave = true
                }
            }
            
            if i == 0 { //添加第一个
                itemArr.append(string)
                tempStr = pinyin
            }
            else {
                if tempStr != pinyin { //不相同, 分新组
                    resultArr.append(itemArr) //添加
                    
                    itemArr = [] //移除
                    itemArr.append(string) //新组
                    
                    tempStr = pinyin
                }
                else { //相同
                    itemArr.append(string)
                }
            }
            
            //添加最后一组
            if i+1 == sortPinyin.count {
                resultArr.append(itemArr)
            }
        }
        
        if isHave { //如果有特殊字符, 调整位置
            if isDesending { //升序
                //            resultArr.insert(resultArr.first!, at: resultArr.count)
                //            resultArr.removeFirst()
            }
            else { //降序
                //            resultArr.insert(resultArr.last!, at: 0)
                //            resultArr.removeLast()
                
                resultArr.insert(resultArr.first!, at: resultArr.count)
                resultArr.removeFirst()
            }
        }
        
        return resultArr
    }
    
    ///给排好序的索引分组; 默认升序排列
    private func indexSort(_ data:[String], _ isDesending:Bool = false) -> [String] {
        if data.count == 0 { return [] }
        
        var resultArr:[String] = []
        
        //排好序的数据
        let sortPinyin = pinyinWithSort(data, isDesending)
        
        for temp in sortPinyin { //取第一个中文的第一个字母 且 去重
            let c = temp.pinYin.to(1)//substring(to: temp.pinYin.index(temp.pinYin.startIndex, offsetBy: 1))
            if !resultArr.contains(c) {
                resultArr.append(c)
            }
        }
        
        //将"#"调换位置
        if resultArr.contains("#") { //如果有#, 则调换位置
            if resultArr.count == 0 {
                return []
            }
            
            if isDesending { //升序
                //            resultArr.insert(resultArr.first!, at: resultArr.count)
                //            resultArr.removeFirst()
            }
            else { //降序
                //            resultArr.insert(resultArr.last!, at: 0)
                //            resultArr.removeLast()
                
                resultArr.insert(resultArr.first!, at: resultArr.count)
                resultArr.removeFirst()
            }
        }
        
        return resultArr
    }
    
    ///给字母排序; 默认升序排列
    private func pinyinWithSort(_ data:[String], _ isDesending:Bool = false) -> [PinyinClass] {
        if data.count == 0 { return [] }
        
        //转换后的字母数组
        let pinyin = transferStringToPinyin(data)
        
        //排序
        //    let sortPinyin = NSSortDescriptor.init(key: "pinYin", ascending: isDesending)
        //    let descriptor:[NSSortDescriptor] = [sortPinyin]
        //
        //    let result = (pinyin as NSArray).sortedArray(using: (descriptor))
        
        let result = pinyin.sorted { (obj1, obj2) -> Bool in
            if isDesending {
                return obj1.pinYin>obj2.pinYin
            }
            else {
                return obj2.pinYin>obj1.pinYin
            }
        }
        
        return result
    }
    
    ///将 汉字的拼音首字母 及 字母 转换成大写字母
    private func transferStringToPinyin(_ data:[String]) -> [PinyinClass]{
        if data.count == 0 { return [] }
        
        var resultStringArr:[PinyinClass] = []
        
        for content in data {
            let pinyinSort = PinyinClass.init("", "")
            pinyinSort.string = content //保留原有的字符串
            
            for c in content { //核心部分
                let temp = String.init(c)
                let transformContents = CFStringCreateMutableCopy(nil, 0, temp as CFString)
                
                CFStringTransform( transformContents, nil, kCFStringTransformMandarinLatin, false) //转换成不带音标的符号
                CFStringTransform( transformContents, nil, kCFStringTransformStripDiacritics, false) //中文的拉丁字母
                
                let ztransformContents = transformContents! as String
                let index = ztransformContents.index(ztransformContents.startIndex, offsetBy: 0)
                let firstString = ztransformContents[index]
                
                pinyinSort.pinYin = pinyinSort.pinYin.appending(String.init(firstString).uppercased())
                
                //将特殊字符 转换成 "#"
                let tempStr = pinyinSort.pinYin.to(1)//substring(to: pinyinSort.pinYin.index(pinyinSort.pinYin.startIndex, offsetBy: 1))
                if !(tempStr.isAllAlphabet()) { //非字母
                    pinyinSort.pinYin = "#"
                }
            }
            
            resultStringArr.append(pinyinSort) //加入数组
        }
        
        return resultStringArr
    }
    
    /*
     let kCFStringTransformStripCombiningMarks: CFString! //删除重音符号
     let kCFStringTransformToLatin: CFString! //中文的拉丁字母
     let kCFStringTransformFullwidthHalfwidth: CFString!//全角半宽
     let kCFStringTransformLatinKatakana: CFString!//片假名拉丁字母
     let kCFStringTransformLatinHiragana: CFString!//平假名拉丁字母
     let kCFStringTransformHiraganaKatakana: CFString!//平假名片假名
     let kCFStringTransformMandarinLatin: CFString!//普通话拉丁字母
     let kCFStringTransformLatinHangul: CFString!//韩文的拉丁字母
     let kCFStringTransformLatinArabic: CFString!//阿拉伯语拉丁字母
     let kCFStringTransformLatinHebrew: CFString!//希伯来语拉丁字母
     let kCFStringTransformLatinThai: CFString!//泰国拉丁字母
     let kCFStringTransformLatinCyrillic: CFString!//西里尔拉丁字母
     let kCFStringTransformLatinGreek: CFString!//希腊拉丁字母
     let kCFStringTransformToXMLHex: CFString!//转换为XML十六进制字符
     let kCFStringTransformToUnicodeName: CFString!//转换为Unicode的名称
     @availability(iOS, introduced=2.0)
     let kCFStringTransformStripDiacritics: CFString!//转换成不带音标的符号
     */
}

///排序辅助类
private class PinyinClass {
    var string:String
    var pinYin:String
    
    init(_ string:String, _ pinYin:String) {
        self.string = string
        self.pinYin = pinYin
    }
}
