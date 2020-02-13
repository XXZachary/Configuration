//
//  XXZSessionTask.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/7/27.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

typealias DataTaskResult = (Bool, [String:Any]) -> Void
typealias UploadTaskResult = ([String:Any]) -> Void
typealias DownloadTaskResult = (Dictionary<String, Any>) -> Void

class XXZSessionTask: NSObject, URLSessionTaskDelegate {
    private let timeoutInterval = 30.0 //网络请求响应时间
    
    static var shareInstance = XXZSessionTask()
//    override init() {}
    
    //MARK: ------ Zachary - URLSessionTaskDelegate ------
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        var disposition = URLSession.AuthChallengeDisposition.performDefaultHandling
//        var credential: URLCredential?
//        
//        // 1. 先判断服务器采用的认证方法是否为NSURLAuthenticationMethodServerTrust，ServerTrust是比较常用的，当然还有其他的认证方法。
//        if challenge.protectionSpace.authenticationMethod  == NSURLAuthenticationMethodServerTrust {
//            // 2. 获取需要验证的信任对象，并设置信任对象要验证的证书为之前导入的证书，在SecTrustEvaluate进行验证，其中验证的API在Security库中
//            let trust = challenge.protectionSpace.serverTrust
//            SecTrustSetAnchorCertificates(trust!, returnAnchorCertificates() as CFArray)
//            var result: SecTrustResultType?
//            let status = SecTrustEvaluate(trust!, &result!)
//            
//            if status == errSecSuccess && (result == SecTrustResultType.proceed || result == SecTrustResultType.unspecified) {
//                // 3. 验证成功，根据服务器返回的受保护空间中的信任对象，创建一个挑战凭证，并且挑战方式为使用凭证挑战
//                credential = URLCredential.init(trust: trust!)
//                disposition = URLSession.AuthChallengeDisposition.useCredential
//            }
//            else {
//                // 3. 验证失败，取消本次挑战认证
//                disposition = URLSession.AuthChallengeDisposition.performDefaultHandling
//            }
//        }
//        else {
//            // 1. 如果服务器采用的认证方法不是ServerTrust，可判断是否为其他认证，如何NSURLAuthenticationMethodHTTPDigest，等等，这里我没有判断，直接处理为系统默认处理。
//            disposition = URLSession.AuthChallengeDisposition.performDefaultHandling
//        }
//        
//        // 4. 无论结果如何，都要回到给服务端
//        completionHandler(disposition, credential)
//    }
//    
//    //获取证书文件
//    private func returnAnchorCertificates() -> [SecCertificate] {
//        let path = Bundle.main.path(forResource: "", ofType: "cer")
//        let data = try? Data.init(contentsOf: URL.init(string: path!)!)
//        let cert = SecCertificateCreateWithData(nil, data! as CFData)
//        
//        return [cert!]
//    }
    
    // 3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            XXZLog("任务成功");
        }
        else {
            XXZLog("任务失败");
        }
    }
    
    //MARK: ------ Zachary - body: 拼接后的字符串参数 ------
    //同步, 传入拼接后的字符串参数
    func synDataTaskWithBody(_ path:String, _ body:String, _ result:@escaping DataTaskResult) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        privateSynDataTaskWithBody(path, body, result)
    }
    
    //异步, 传入拼接后的字符串参数
    func asynDataTaskWithBody(_ path:String, _ body:String, _ result:@escaping DataTaskResult) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.global().async {
            self.privateAsynDataTaskWithBody(path, body, result)
        }
    }
    
    //MARK: ------ Zachary - parameter: 键值参数的字典 ------
    //同步, 传入键值参数的字典
    func synDataTaskWithParameter(_ path:String, _ para:Dictionary<String, String>, _ result: @escaping DataTaskResult) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var body = ""
        if para.count <= 0 {
            XXZLog("没有字典数据...");
        }
        else {
            var i = 0
            for (key, value) in para {
                var unit = "&"
                if i+1 == para.count {
                    unit = ""
                }
                
                body = body.appending("\(key)=\(value)\(unit)")
                i+=1
            }
        }
        
        if body.isBlank() {
            XXZLog("没有参数...")
        }
        else {
            privateSynDataTaskWithBody(path, body, result) //去请求
        }
    }
    //异步, 传入键值参数的字典
    func asynDataTaskWithParameter(_ path:String, _ para:Dictionary<String, String>, _ result:@escaping DataTaskResult) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.global().async {
            var body = ""
            if para.count <= 0 {
                XXZLog("没有字典数据...");
            }
            else {
                var i = 0
                for (key, value) in para {
                    var unit = "&"
                    if i+1 == para.count {
                        unit = ""
                    }
                    
                    body = body.appending("\(key)=\(value)\(unit)")
                    i+=1
                }
            }
            
            if body.isBlank() {
                XXZLog("没有参数...")
            }
            else {
                self.privateAsynDataTaskWithBody(path, body, result) //去请求
            }
        }
    }
    //异步, 传入键值参数的字典及图片
    func asynDataTaskWithPhoto(_ path:String, _ para:Dictionary<String, String>, _ photo:Array<Any>, _ result:@escaping DataTaskResult) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DispatchQueue.global().async {
            let mark = "Xavier Zachary"
            let startMark = "--\(mark)"
            let endMark = "\(mark)--"
            
            //字典参数
            var body = ""
            for (key, value) in para {
                body.append("\(startMark)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
            
            //字典参数转换data
            var requestData = Data.init()
            requestData.append(body.data(using: .utf8)!)
            
            //图片数据
            for i in 0..<photo.count {
                let value = photo[i] as? UIImage
                if value != nil {
                    let imageData = UIImage.init().jpegData(compressionQuality: 0.1) //图片缩小0.1倍
                    if imageData != nil {
                        var imgBody = "\(startMark)\r\n" //标签
                        imgBody.append("Content-Disposition: form-data; name=\"ImageField-\(i)\"; filename=\"image-\(i).png\"\r\n")
                        imgBody.append("Content-Type: application/octet-stream; charset=utf-8\r\n\r\n") //声明上传文件的格式
                        
                        //将body字符串转化为UTF8格式的二进制
                        requestData.append(imgBody.data(using: .utf8)!)
                        requestData.append(imageData!) //将image的data加入
                        requestData.append("\r\n".data(using: .utf8)!)
                    }
                    
                }
            }
            
            let end = "\(endMark)\r\n"
            requestData.append(end.data(using: .utf8)!)
            
            XXZLog(requestData.count)
            
            //初始化
            let url = URL.init(string: path)!
            var request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: self.timeoutInterval)
            //设置HTTPHeader中Content-Type的值
            request.setValue("multipart/form-data; boundary=\(mark)", forHTTPHeaderField: "Content-Type")
            //设置Content-Length
            request.setValue("\(requestData.count)", forHTTPHeaderField: "Content-Length")
            
            request.httpMethod = "POST"
            request.httpShouldHandleCookies = false
            request.httpBody = requestData
            
            self.privateAsynDataTaskWithPhoto(request, result) //去请求
        }
    }
    
    //MARK: ------ Zachary - private method ------
    //同步
    func privateSynDataTaskWithBody(_ path:String, _ body:String, _ result:@escaping DataTaskResult) {
        let url = URL.init(string: path)!
        var request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        request.httpBody = body.data(using: .utf8)
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        /**
         [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
         [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:
         @"application/json",
         @"application/octet-stream",
         @"text/javascript",
         @"text/json",
         @"text/html",
         @"text/css",
         @"text/plain",
         nil]];
         */
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self as URLSessionTaskDelegate, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            var dict: [String: Any] = [:]
            var success = false
            if error != nil { //失败
                XXZLog("request error = \(String(describing: error))")
            }
            else { //成功
                let statusCode = self.showResponseCode(response!)
                if statusCode == 200 {
                    
                    if let jsonData = data {
                        let any = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                        if any != nil {
                            dict = any as! Dictionary<String, Any>
                            success = true
                        }
                        else {
                            XXZLog("解析失败...")
                        }
                    }
                    else {
                        XXZLog("数据错误...")
                    }
                    
                }
                else {
                    XXZLog("请求异常...")
                }
            }
            
            result(success, dict) //闭包返回结果
        }
        
        task.resume() //开始执行任务
    }
    
    //异步
    func privateAsynDataTaskWithBody(_ path:String, _ body:String, _ result:@escaping DataTaskResult) {
        let url = URL.init(string: path)!
        var request = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        
        request.httpMethod = "POST"
        request.httpShouldHandleCookies = false
        request.httpBody = body.data(using: .utf8)
        request.allHTTPHeaderFields = ["Content-Type":"application/x-www-form-urlencoded"]
//        request.setValue("text/html; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self as URLSessionTaskDelegate, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                var dict: [String: Any] = [:]
                var success = false
                if error != nil { //失败
                    XXZLog("request error = \(String(describing: error))")
                }
                else { //成功
                    let statusCode = self.showResponseCode(response!)
                    if statusCode == 200 {
                        
                        if let jsonData = data {
                            let any = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            if any != nil {
                                dict = any as! Dictionary<String, Any>
                                success = true
                            }
                            else {
                                XXZLog("解析失败...")
                            }
                        }
                        else {
                            XXZLog("数据错误...")
                        }
                        
                    }
                    else {
                        XXZLog("请求异常...")
                    }
                }
                
                result(success, dict) //闭包返回结果
            }
            
        }
        
        task.resume() //开始执行任务
    }
    
    //异步, 上传图片
    private func privateAsynDataTaskWithPhoto(_ request:URLRequest, _ result: @escaping DataTaskResult) {
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self as URLSessionTaskDelegate, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                var dict: [String: Any] = [:]
                var success = false
                if error != nil { //失败
                    XXZLog("request error = \(String(describing: error))")
                }
                else { //成功
                    let statusCode = self.showResponseCode(response!)
                    if statusCode == 200 {
                        
                        if let jsonData = data {
                            let any = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                            if any != nil {
                                dict = any as! Dictionary<String, Any>
                                success = true
                            }
                            else {
                                XXZLog("解析失败...")
                            }
                        }
                        else {
                            XXZLog("数据错误...")
                        }
                        
                    }
                    else {
                        XXZLog("请求异常...")
                    }
                }
                
                result(success, dict) //闭包返回结果
            }
            
        }
        
        task.resume() //开始执行任务
    }
    
    //MARK: ------ Zachary - 输出 http 响应的状态码 ------
    private func showResponseCode(_ response:URLResponse) -> (Int) {
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        XXZLog("status code = \(String(describing: statusCode!))")
        
        if let code = statusCode {
            switch code {
            case 100:
                XXZLog("(继续) 请求者应当继续提出请求. 服务器返回此代码表示已收到请求的第一部分, 正在等待其余部分. ");
            case 101:
                XXZLog("(切换协议) 请求者已要求服务器切换协议, 服务器已确认并准备切换. ");
                
            case 200:
                XXZLog("(成功) 服务器已成功处理了请求. 通常, 这表示服务器提供了请求的网页. ");
            case 201:
                XXZLog("(已创建) 请求成功并且服务器创建了新的资源. ");
            case 202:
                XXZLog("(已接受) 服务器已接受请求, 但尚未处理. ");
            case 203:
                XXZLog("(非授权信息) 服务器已成功处理了请求, 但返回的信息可能来自另一来源. ");
            case 204:
                XXZLog("(无内容) 服务器成功处理了请求, 但没有返回任何内容. ");
            case 205:
                XXZLog("(重置内容) 服务器成功处理了请求, 但没有返回任何内容. ");
            case 206:
                XXZLog("(部分内容) 服务器成功处理了部分 GET 请求. ");
                
            case 300:
                XXZLog("(多种选择) 针对请求, 服务器可执行多种操作. 服务器可根据请求者 (user agent) 选择一项操作或提供操作列表供请求者选择. ");
            case 301:
                XXZLog("(永久移动) 请求的网页已永久移动到新位置. 服务器返回此响应(对 GET 或 HEAD 请求的响应)时, 会自动将请求者转到新位置. ");
            case 302:
                XXZLog("(临时移动) 服务器目前从不同位置的网页响应请求, 但请求者应继续使用原有位置来进行以后的请求. ");
            case 303:
                XXZLog("(查看其他位置) 请求者应当对不同的位置使用单独的 GET 请求来检索响应时, 服务器返回此代码. ");
            case 304:
                XXZLog("(未修改) 自从上次请求后, 请求的网页未修改过. 服务器返回此响应时, 不会返回网页内容. ");
            case 305:
                XXZLog("(使用代理) 请求者只能使用代理访问请求的网页. 如果服务器返回此响应, 还表示请求者应使用代理. ");
            case 306:
                XXZLog("在最新版的规范中, 306状态码已经不再被使用. ");
            case 307:
                XXZLog("(临时重定向) 服务器目前从不同位置的网页响应请求, 但请求者应继续使用原有位置来进行以后的请求. ");
                
            case 400:
                XXZLog("(错误请求) 服务器不理解请求的语法. ");
            case 401:
                XXZLog("(未授权) 请求要求身份验证. 对于需要登录的网页, 服务器可能返回此响应. ");
            case 402:
                XXZLog("402 该状态码是为了将来可能的需求而预留的. ");
            case 403:
                XXZLog("(禁止) 服务器拒绝请求. ");
            case 404:
                XXZLog("(未找到) 服务器找不到请求的网页. ");
            case 405:
                XXZLog("(方法禁用) 禁用请求中指定的方法. ");
            case 406:
                XXZLog("(不接受) 无法使用请求的内容特性响应请求的网页. ");
            case 407:
                XXZLog("(需要代理授权) 此状态代码与 401(未授权)类似, 但指定请求者应当授权使用代理. ");
            case 408:
                XXZLog("(请求超时) 服务器等候请求时发生超时. ");
            case 409:
                XXZLog("(冲突) 服务器在完成请求时发生冲突. 服务器必须在响应中包含有关冲突的信息. ");
            case 410:
                XXZLog("(已删除) 如果请求的资源已永久删除, 服务器就会返回此响应. ");
            case 411:
                XXZLog("(需要有效长度) 服务器不接受不含有效内容长度标头字段的请求. ");
            case 412:
                XXZLog("(未满足前提条件) 服务器未满足请求者在请求中设置的其中一个前提条件. ");
            case 413:
                XXZLog("(请求实体过大) 服务器无法处理请求, 因为请求实体过大, 超出服务器的处理能力. ");
            case 414:
                XXZLog("(请求的 URL 过长) 请求的 URL(通常为网址)过长, 服务器无法处理. ");
            case 415:
                XXZLog("(不支持的媒体类型) 请求的格式不受请求页面的支持. ");
            case 416:
                XXZLog("(请求范围不符合要求) 如果页面无法提供请求的范围, 则服务器会返回此状态代码. ");
            case 417:
                XXZLog("(未满足期望值) 服务器未满足\"期望\"请求标头字段的要求. ");
                
            case 500:
                XXZLog("(服务器内部错误) 服务器遇到错误, 无法完成请求. ");
            case 501:
                XXZLog("(尚未实施) 服务器不具备完成请求的功能. 例如, 服务器无法识别请求方法时可能会返回此代码. ");
            case 502:
                XXZLog("(错误网关) 服务器作为网关或代理, 从上游服务器收到无效响应. ");
            case 503:
                XXZLog("(服务不可用) 服务器目前无法使用(由于超载或停机维护). 通常, 这只是暂时状态. ");
            case 504:
                XXZLog("(网关超时) 服务器作为网关或代理，但是没有及时从上游服务器收到请求. ");
            case 505:
                XXZLog("(HTTP 版本不受支持) 服务器不支持请求中所用的 HTTP 协议版本. ");
                
            default:
                XXZLog("其他情况")
            }
            
            return code;
        }
        
        return 0;
    }

    //MARK: ------ Zachary - other ------
    #if false
        var arr0:[Int] = []
        var arr1:Array<Int> = []
        var arr2 = [Int]()
        var arr3 = Array<Int>()
        var arr4:[Int] = Array()
        var arr5:Array<Int> = Array()
        var arr6 = Array(repeating:0, count:3)
        
        var dict0:[Int: Int] = [:]
        var dict1:Dictionary<Int, Int> = [:]
        var dict2 = [Int:Int]()
        var dict3 = Dictionary<Int, Int>()
    #endif
    
    //用 typealias 来为看似较为复杂的闭包类型定义别名
    #if false
    //为没有参数也没有返回值的闭包类型起一个别名
    typealias Nothing = () -> ()
    //如果闭包的没有返回值，那么我们还可以这样写，
    typealias Anything = () -> Void
    //为接受一个Int类型的参数不返回任何值的闭包类型 定义一个别名：PrintNumber
    typealias PrintNumber = (Int) -> ()
    //为接受两个Int类型的参数并且返回一个Int类型的值的闭包类型 定义一个别名：Add
    typealias Add = (Int, Int) -> (Int)
    #endif
}
