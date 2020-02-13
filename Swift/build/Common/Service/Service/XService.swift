//
//  XService.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/11/14.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

class XService: XBaseService {
    
    static func coreProcess(_ respStr:String, _ model:XBaseModel, _ completion:@escaping Completion) {
        if !isNetwork {
            XZLog("网络异常")
            XXZHintView.showNoInView("网络异常", KEY_WINDOW!)
            return;
        }
        
        XBaseService.init().requestByModel(model, "POST", { (tmp) in
            if !tmp.isEmpty {
                //解析并新建对应的Response
                let cls = NSClassFromString(respStr) as! XBaseResponse.Type
                let resp = cls.init(tmp)
                
                if Int(resp.code) == 0 {
                    completion(true, resp)
                }
                else {
                    completion(false, resp)
                }
            }
            else {
                XZLog("没有数据")
            }
            
        }) { (error) in
            //服务器方面的错误
        }

    }
}
