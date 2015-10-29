//
//  ZXNTWorking.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/28.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import AFNetworking


class ZXNTWorking: AFHTTPSessionManager {
//   网络单例继承AFN
    static let sharedInstance: ZXNTWorking = {
        let baseURL = NSURL(string: "https://api.weibo.com/")!
        let tools = ZXNTWorking(baseURL: baseURL)
        return tools
        }()
//  https://api.weibo.com/oauth2/authorize?client_id=1810681274&redirect_uri=http://gz.itcast.cn  
//    MARK: - OAtuh授权
//    申请应用时分配的AppKey
    private let client_id = "1810681274"
    /// 申请应用时分配的AppSecret
    private let client_secret = "0268f38d773f7489c55b0cc893af947e"
    
    /// 请求的类型，填写authorization_code
    private let grant_type = "authorization_code"
    
    /// 回调地址
    let redirect_uri = "http://gz.itcast.cn"
    
    // OAtuhURL地址
    func oauthRUL() -> NSURL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)"
        return NSURL(string: urlString)!
    }

    
    
    // 使用闭包回调
    // MARK: - 加载AccessToken
    /// 加载AccessToken
    func loadAccessToken(code: String, finshed: (result: [String: AnyObject]?, error: NSError?) -> ()) {
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
        POST(urlString, parameters: parameters, success: { (_, result) -> Void in
            
            //            let data = String(data: result as! NSData, encoding: NSUTF8StringEncoding)
            //            print("data: \(data)")
            
            finshed(result: result as? [String: AnyObject], error: nil)
            }) { (_, error: NSError) -> Void in
                finshed(result: nil, error: error)
        }
    }

    
    
}
