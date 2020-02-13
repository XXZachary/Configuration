//
//  Dictionary+Extension.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/19.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

extension Dictionary {
    //MARK: ------ Zachary - 数据转换 ------
    ///Dictionary 转 json string
    func jsonString() -> String {
        let dictionary = self
        
        if dictionary.isEmpty {
            return ""
        }
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            return ""
        }
        
        let data : Data! = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data:data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        
        return jsonString!
    }
    
    ///Dictionary 转 json data
    func jsonData() -> Data {
        let dictionary = self
        
        if dictionary.isEmpty {
            return Data.init()
        }
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            return Data.init()
        }
        
        let data : Data! = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return data
    }
    
    //MARK: ------ Zachary - 取符合要求的值------
    ///value 是 String
    func stringForKeyNotNull(_ key:AnyHashable) -> String {
        let dict = self as [AnyHashable:Any]
        var value = ""
        
        if !dict.isEmpty {
            if let tmp = dict[key] {
                if tmp is String {
                    value = tmp as! String
                }
                else if tmp is NSNumber {
                    value = (tmp as! NSNumber).stringValue
                }
            }
        }
        
        return value
    }
    
    ///value 是 Array
    func arrayForKeyNotNull(_ key:AnyHashable) -> [Any] {
        let dict = self as [AnyHashable:Any]
        var value: [Any]?
        
        if !dict.isEmpty {
            if let tmp = dict[key] {
                if tmp is Array<Any> {
                    value = tmp as? [Any]
                }
            }
        }
        
        return value!
    }
    
    ///value 是 Dictionary
    func dictionaryForKeyNotNull(_ key:AnyHashable) -> [AnyHashable:Any] {
        let dict = self as [AnyHashable:Any]
        var value: [AnyHashable:Any]?
        
        if !dict.isEmpty {
            if let tmp = dict[key] {
                if tmp is Dictionary {
                    value = tmp as? [AnyHashable:Any]
                }
            }
        }
        
        return value!
    }
    
    ///取值
    func key(_ key:AnyHashable) -> Any {
        let dict = self as [AnyHashable:Any]
        if let value=dict[key] {
            return value
        }
        
        return ""
    }
    
    ///赋值
    func value(_ key:AnyHashable, _ value:Any) {
        var dict = self as [AnyHashable:Any]
        dict[key] = value
    }
}
