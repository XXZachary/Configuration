//
//  XBaseService.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/11/14.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

typealias Completion = (_ success:Bool, _ resp:XBaseResponse) -> Void
typealias Sucess = (_ resp:[String:Any]) -> Void
typealias Failure = (_ error:Error) -> Void

class XBaseService: NSObject {
    
    func requestByModel(_ model:XBaseModel, _ method:String, _ success: @escaping Sucess, _ failure: @escaping Failure) {
        let url = HttpUrlHost.appending(model.getRequestUrl())
        let body = model.changeToDic().jsonString()
        
        if method == "POST" { //post
            XXZSessionTask().privateAsynDataTaskWithBody(url, body) { (flag, tmp) in
                if flag {
                    //数据请求成功
                    success(tmp)
                }
                else {
                    //服务器方面的错误
                }
            }
        }
        else { //get
            
        }
    }
    
    func responsePostSuccess(_ resp:Any, _ respDict:Dictionary<AnyHashable,Any>) -> Bool {
        
        return true
    }
    
    func responseGetSuccess(_ resp:Any, _ respDict:Dictionary<AnyHashable,Any>) -> Bool {
        
        return true
    }
    
    ///Zachary - other ------
    
}
