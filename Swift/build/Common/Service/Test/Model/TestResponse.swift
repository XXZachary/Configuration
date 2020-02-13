//
//  TestResponse.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/11/15.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

/**
 在swift3中，编译器自动推断@objc，换句话说，它自动添加@objc
 在swift4中，编译器不再自动推断，你必须显式添加@objc
 还有一种更简单的方法，不必一个一个属性的添加,下面这种写法
 @objcMembers
 class Test {
 
 }
 */

@objcMembers
class TestAreasResponse: NSObject {
    var name:String = ""
    var area:String = ""
    
    init(_ resp:[String:String]) {
        super.init()
        self.setValuesForKeys(resp)
    }
}

class TestResponse: XBaseResponse {
    var areas:[TestAreasResponse] = []
//    var areas1:Array<[String:String]> = []
//    var areas2 = Array<[String:String]>()
//    var areas3 = [[String:String]]()
//    var areas8 = Array.init(repeating: ["":""], count: 0)

//    var areas4:[String:String] = [:]
//    var areas5:Dictionary<String,String> = [:]
//    var areas6 = [String:String]()
//    var areas7 = Dictionary<String,String>()
    
    required init(_ resp: Dictionary<String, Any>) {
        super.init(resp)
        XZLog("xxz")
        
        let area = resp.arrayForKeyNotNull(xBaseResponse_Data) as! [[String:String]]
        for item in area {
            let itemResp = TestAreasResponse.init(item)
            areas.append(itemResp)
        }
    }
}
