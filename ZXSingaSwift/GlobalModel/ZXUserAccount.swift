//
//  ZXUserAccount.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/29.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXUserAccount: NSObject ,NSCoding{
//    设置access_token，借口获取授权后的access_token
    var access_token:String?
    
    var expires_in:NSTimeInterval = 0 {
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            print("expires_date:\(expires_date)")
        }
    
    }
    
//    我们现在就要拼接这段路径
//    https://api.weibo.com/oauth2/authorize?client_id=1810681274&redirect_uri=http://gz.itcast.cn
    
    var uid:String?
    var expires_date:NSDate?
    
    
    // KVC 字典转模型
    init(dict: [String: AnyObject]) {
        
        super.init()
        // 将字典里面的每一个key的值赋值给对应的模型属性
        setValuesForKeysWithDictionary(dict)
    }
    
    // 当字典里面的key在模型里面没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        return "access_token:\(access_token), expires_in:\(expires_in), uid:\(uid): expires_date:\(expires_date)"
    }

    static let accountPath = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    
//    保存数据
    func saveAccout() {
        NSKeyedArchiver.archiveRootObject(self, toFile: ZXUserAccount.accountPath)
        
    }
    
//    类方法访问属性需要将属性定义成 static
    class func loadAccount() -> ZXUserAccount? {
    let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? ZXUserAccount
        return account
    
    }
    
//    MARK: - 归档解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(uid, forKey: "uid")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    

}
