//
//  ZXStatus.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXStatus: NSObject {

    /// 微博创建时间
    var created_at: String?
    
    /// 字符串型的微博ID
    var idstr: String?
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]?
    
    /// 用户模型
    var user: ZXUser?
//    字典转模型
    init(dict:[String:AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    // KVC赋值每个属性的时候都会调用
    override func setValue(value: AnyObject?, forKey key: String) {
        // 判断user赋值时, 自己字典转模型
        //        print("key:\(key), value:\(value)")
        if key == "user" {
            if let dict = value as? [String: AnyObject] {
                // 字典转模型
                // 赋值
                user = ZXUser(dict: dict)
                // 一定要记得return
                return
            }
        }
        
        return super.setValue(value, forKey: key)
    }
    
    /// 字典的key在模型里面找不到对应的属性
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    override var description: String {
       
        
        let p = ["created_at", "idstr", "text", "source", "pic_urls", "user"]
        // 数组里面的每个元素,找到对应的value,拼接成字典
        // \n 换行, \t table
        return "\n\t微博模型:\(dictionaryWithValuesForKeys(p))"
    }
    
    /// 加载微博数据
    /// 没有模型对象就能加载数据
    class func loadStatus(finished: (statuses: [ZXStatus]?, error: NSError?) -> ()) {
        ZXNTWorking.sharedInstance.loadStatus { (result, error) -> () in
            if error != nil {
                print("error:\(error)")
                // 通知调用者
                finished(statuses: nil, error: error)
                return
            }
            
            // 判断是否有数据
            if let array = result?["statuses"] as? [[String: AnyObject]] {
                // 有数据
                // 创建模型数组
                var statuses = [ZXStatus]()
                
                for dict in array {
                    // 字典转模型
                    statuses.append(ZXStatus(dict: dict))
                }
                
                // 字典转模型完成
                // 通知调用者
                finished(statuses: statuses, error: nil)
            } else {
                // 没有数据,通知调用者
                finished(statuses: nil, error: nil)
            }
        }
    }

    
}
