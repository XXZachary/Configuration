//
//  XBaseModel.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/14.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

class XBaseModel: NSObject {
    var token: String = ""
    
    //请求地址
    func getRequestUrl() -> String {
        return ""
    }
    
    //请求参数
    func changeToDic() -> Dictionary<String, String> {
        var dict = Dictionary<String,String>()
        
        if !token.isBlank() {
            dict["token"] = token
        }
        
        return dict
    }
    
    //
    
}
