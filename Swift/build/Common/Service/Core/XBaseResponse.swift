//
//  XBaseResponse.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/14.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

class XBaseResponse: NSObject {
    public let xBaseResponse_Code = "code"
    public let xBaseResponse_Message = "msg"
    public let xBaseResponse_Data = "data"
    
    var code = ""
    var message = ""
    
    func decodeData(_ dict:Dictionary<AnyHashable,Any>) -> Dictionary<AnyHashable,Any> {
        return dict.dictionaryForKeyNotNull(xBaseResponse_Data)
    }
    
    func decodeArrayData(_ dict:Dictionary<AnyHashable,Any>) -> Array<Any> {
        return dict.arrayForKeyNotNull(xBaseResponse_Data)
    }
    
    required init(_ resp:Dictionary<String,Any>) {
        super.init()
        
        code = resp.stringForKeyNotNull(xBaseResponse_Code)
        message = resp.stringForKeyNotNull(xBaseResponse_Message)
    }
}
