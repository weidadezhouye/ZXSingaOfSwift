//
//  ZXNTWorking.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/28.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import AFNetworking

enum ZXNetWorkError : Int{
    case emptyToken = -1
    case emptyId = -2
    
    var description: String{
        get {
            switch self {
            case ZXNetWorkError.emptyToken:
                return "accessToken为空"
            case ZXNetWorkError.emptyId:
                return "uid为空"
        
            }
            
        }
        
    }
    
    // 枚举可以定义方法
    func error() -> NSError {
        return NSError(domain: "cn.itcast.error.network", code: rawValue, userInfo: ["errorDescription" : description])
    }

}

class ZXNTWorking: NSObject {
//    属性
    private var afnManager:AFHTTPSessionManager
    
    
    // 创建单例
    static let sharedInstance: ZXNTWorking = ZXNTWorking()
    
    override init() {
        let urlString = "https://api.weibo.com/"
        afnManager = AFHTTPSessionManager(baseURL: NSURL(string: urlString))
        afnManager.responseSerializer.acceptableContentTypes?.insert("text/plain")
    }
    

//  https://api.weibo.com/oauth2/authorize?client_id=1240096386&redirect_uri=http://www.baidu.com
    
//    MARK: - OAtuh授权
//    申请应用时分配的AppKey
    private let client_id = "1240096386"
    /// 申请应用时分配的AppSecret
    private let client_secret = "bd443bcb13c5e48bd7148fae615a2294"
    
    /// 请求的类型，填写authorization_code
    private let grant_type = "authorization_code"
    
    /// 回调地址
    let redirect_uri = "http://www.baidu.com"
    
    // OAtuhURL地址
    func oauthRUL() -> NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        return NSURL(string: urlString)!
    }
 
    // 使用闭包回调
    // MARK: - 加载AccessToken
    /// 加载AccessToken
    func loadAccessToken(code: String, finshed: NetworkFinishedCallback) {
        // url
        let urlString = "oauth2/access_token"
        
        // NSObject
        // AnyObject, 任何 class
        // 参数
        let parameters = [
            "client_id": client_id,
            "client_secret": client_secret,
            "grant_type": grant_type,
            "code": code,
            "redirect_uri": redirect_uri
        ]
        
        // 测试返回结果类型
        //        responseSerializer = AFHTTPResponseSerializer()
        // result: 请求结果
        afnManager.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
            
            //            let data = String(data: result as! NSData, encoding: NSUTF8StringEncoding)
            //            print("data: \(data)")
            
            finshed(result: result as? [String: AnyObject], error: nil)
            }) { (_, error: NSError) -> Void in
                finshed(result: nil, error: error)
        }
    }
    
    // MARK: - 获取用户信息
    func loadUserInfo(finshed: NetworkFinishedCallback) {
        
//        守卫：
        // 守卫,和可选绑定相反
        // parameters 代码块里面和外面都能使用
        guard var parameters = tokenDict() else {
            // 能到这里来表示 parameters 没有值
            print("没有accessToken")
            
            let error = ZXNetWorkError.emptyToken.error()
            // 告诉调用者
            finshed(result: nil, error: error)
            return
        }

        
        // 判断uid
        if ZXUserAccount.loadAccount()?.uid == nil {
            print("没有uid")
            let error = ZXNetWorkError.emptyId.error()
            
//            告诉调用者
            finshed(result: nil, error: error)
            return
        }
        
        // url
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 添加元素
        parameters["uid"] = ZXUserAccount.loadAccount()!.uid!
        
        
        requestGET(urlString, parameters: parameters, finshed: finshed)
        
    }
    
    /// 判断access token是否有值,没有值返回nil,如果有值生成一个字典
    func tokenDict() -> [String: AnyObject]? {
        if ZXUserAccount.loadAccount()?.access_token == nil {
            return nil
        }
        
        return ["access_token": ZXUserAccount.loadAccount()!.access_token!]
    }
    
//    MARK: - 获取微博数据
    func loadStatus(since_id: Int, max_id: Int, finished: NetworkFinishedCallback){
        
        guard var parameters = tokenDict() else {
            
            finished(result: nil, error: ZXNetWorkError.emptyToken.error())
             return
        }
       
        // 添加参数 since_id和max_id
        // 判断是否有传since_id,max_id
        if since_id > 0 {
        parameters["since_id"] = since_id
        } else if max_id > 0 {
        parameters["max_id"] = max_id - 1
        }

        
        let urlString = "2/statuses/home_timeline.json"
//        1.加载网络数据（如果不给力，尝试加载本地数据）
        if true {
            requestGET(urlString, parameters: parameters, finshed: finished)
        } else {
            loadLocalStatus(finished)
        }

        
    }
    
//       加载本地的链接
    private func loadLocalStatus(finished: NetworkFinishedCallback) {
        // 获取路径
        let path = NSBundle.mainBundle().pathForResource("statuses", ofType: "json")
        
        // 加载文件数据
        let data = NSData(contentsOfFile: path!)
        
        // 转成json
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0))
            // 有数据
            finished(result: json as? [String : AnyObject], error: nil)
        } catch {
            print("出异常了")
        }
    }
    
    
    // 类型别名 = typedefined
    typealias NetworkFinishedCallback = (result: [String: AnyObject]?, error: NSError?) -> ()
    
    // MARK: - 封装AFN.GET
    func requestGET(URLString: String, parameters: AnyObject?, finshed: NetworkFinishedCallback) {
        
        afnManager.GET(URLString, parameters: parameters, success: { (_, result) -> Void in
            finshed(result: result as? [String: AnyObject], error: nil)
            }) { (_, error) -> Void in
                finshed(result: nil, error: error)
        }
    }

    
    
    
}
