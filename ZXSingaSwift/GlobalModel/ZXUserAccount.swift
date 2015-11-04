//
//  ZXUserAccount.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/29.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXUserAccount: NSObject ,NSCoding{
    
    class func userLogin() ->Bool {
        return ZXUserAccount.loadAccount() != nil
    }
    
    
//    设置access_token，借口获取授权后的access_token
    var access_token:String?
    
    var expires_in:NSTimeInterval = 0 {
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            print("expires_date:\(expires_date)")
        }
    
    }
    
//    我们现在就要拼接这段路径
//    https://api.weibo.com/oauth2/authorize?client_id=1810681274&redirect_uri=http://www.baidu.com
    

    
    var uid:String?
    var expires_date:NSDate?
    
    /// 友好显示名称
    var name: String?
    
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    // KVC 字典转模型
    init(dict: [String: AnyObject]) {
        
        super.init()
        // 将字典里面的每一个key的值赋值给对应的模型属性
        setValuesForKeysWithDictionary(dict)
    }
    
    // 当字典里面的key在模型里面没有对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
        return "access_token:\(access_token), expires_in:\(expires_in), uid:\(uid): expires_date:\(expires_date), name:\(name), avatar_large:\(avatar_large)"
    }
    
    // MARK: - 加载用户信息
    // 控制调用这个方法,不管成功还是失败,都需要告诉调用者
    func loadUserInfo(finish: (error: NSError?) -> ()) {
        ZXNTWorking.sharedInstance.loadUserInfo { (result, error) -> () in
            if error != nil || result == nil {
                finish(error: error)
                return
            }
            
            // 加载成功
            self.name = result!["name"] as? String
            self.avatar_large = result!["avatar_large"] as? String
            
            // 保存到沙盒
            self.saveAccount()
            
            // 同步到内存中,把当前对象赋值给内存中的 userAccount
            ZXUserAccount.userAccount = self
            finish(error: nil)
        }
    }
    
    // 类方法访问属性需要将属性定义成 static
    // 对象方法访问static属性需要 类名.属性名称
    static let accountPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last! + "/Account.plist"
    // MARK: - 保存对象
    func saveAccount() {
        // account.plist
        
        NSKeyedArchiver.archiveRootObject(self, toFile: ZXUserAccount.accountPath)
    }
    
    // 类方法访问属性需要将属性定义成 static
    private static var userAccount: ZXUserAccount?
    
    // 加载loadAccount 是用频繁,解档账号比较耗性能,只加载一次,保存到内存中,以后访问内存的中账号
    class func loadAccount() -> ZXUserAccount? {
        // 判断内存有没有
        if userAccount == nil {
            // 内存中没有才来解档,并赋值给内存中的账号
            userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? ZXUserAccount
        }
        
                if userAccount != nil && userAccount?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
            print("账号有效，啊哈")
            return userAccount
        }
        
        return nil
    }
    
    // MARK: - 归档和解档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
    }

}
