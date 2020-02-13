//
//  TestModel.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/11/15.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

class TestModel: XBaseModel {
    
    var user_id = ""
    
    override func getRequestUrl() -> String {
        return "/coach/searchitem"
    }
    
    override func changeToDic() -> Dictionary<String, String> {
        let dict = super.changeToDic()
        
        if !user_id.isBlank() {
            dict.value("user_id", user_id)
        }
        
        return dict
    }
}
