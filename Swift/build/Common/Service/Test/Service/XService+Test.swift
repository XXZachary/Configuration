//
//  XService+Test.swift
//  LearnSwiftDemo
//
//  Created by Zachary on 2018/11/15.
//  Copyright © 2018 Zachary. All rights reserved.
//

import UIKit

extension XService {
    static func requestWithTest(_ model:TestModel, _ completion:@escaping Completion) {
        self.coreProcess(NSStringFromClass(TestResponse.self), model, completion)
    }
}
