//
//  ZXNTWorking.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/28.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import AFNetworking


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
        // 判断accessToken
        if ZXUserAccount.loadAccount()?.access_token == nil {
            print("没有accessToken")
            return
        }
        
        // 判断uid
        if ZXUserAccount.loadAccount()?.uid == nil {
            print("没有uid")
            return
        }
        
        // url
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 参数
        let parameters = [
            "access_token": ZXUserAccount.loadAccount()!.access_token!,
            "uid": ZXUserAccount.loadAccount()!.uid!
        ]
        
        requestGET(urlString, parameters: parameters, finshed: finshed)
        
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
