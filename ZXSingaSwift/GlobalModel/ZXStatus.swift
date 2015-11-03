//
//  ZXStatus.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import SDWebImage

class ZXStatus: NSObject {

    /// 微博创建时间
    var created_at: String?
    
    /// 字符串型的微博ID
    var id: Int = 0
    
    /// 微博信息内容
    var text: String?
    
    /// 微博来源
    var source: String?
    
    /// 微博的配图
    var pic_urls: [[String: AnyObject]]? {
        didSet{
            
            let count = pic_urls?.count ?? 0
            if count == 0 {
                return
            }
            
            storePictureUrls = [NSURL]()
            
            for dict in pic_urls! {
                if let urlString = dict["thumbnail_pic"] as? String {
                    // 有url地址
                    storePictureUrls?.append(NSURL(string: urlString)!)
                }
            }
        }
        
    }
//    返回微博的配图 对应的URL数组
    var storePictureUrls:[NSURL]?
    
    /// 计算型属性,
    var pictureURLs: [NSURL]? {
        get {
            // 判断:
            // 1.原创微博: 返回 storePictureURLs
            // 2.转发微博: 返回 retweeted_status.storePictureURLs
            return retweeted_status == nil ? storePictureUrls : retweeted_status!.storePictureUrls
        }
    }
//  缓存行高
    var rowheight:CGFloat?
    
//    被转发的微博
    var retweeted_status:ZXStatus?
    
    /// 用户模型
    var user: ZXUser?
    
    func cellID() ->String{
        return retweeted_status == nil ? ZXStatusCellIdentifier.NormalCell.rawValue : ZXStatusCellIdentifier.ForwardCell.rawValue
        
    }
    
//    字典转模型
    init(dict:[String:AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
    }
    // KVC赋值每个属性的时候都会调用
    override func setValue(value: AnyObject?, forKey key: String) {
        // 判断user赋值时, 自己字典转模型
        if key == "user" {
            if let dict = value as? [String: AnyObject]
            {
                // 字典转模型
                // 赋值
                user = ZXUser(dict: dict)
                return
            }
        }else if key == "retweeted_status" {
                if let dict = value as? [String: AnyObject] {
                    // 字典转模型
                    // 被转发的微博
                    retweeted_status = ZXStatus(dict: dict)
                }
            // 一定要记得return
            return
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
    class func loadStatus(since_id: Int, max_id: Int, finished: (statuses: [ZXStatus]?, error: NSError?) -> ()) {

        ZXNTWorking.sharedInstance.loadStatus(since_id, max_id: max_id) { (result, error) -> () in
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
//                self.cacheWebImage(statuses, finished: finished)
                finished(statuses: statuses, error: nil)
            } else {
                // 没有数据,通知调用者
                finished(statuses: nil, error: nil)
            }
        }
    }

    class func cacheWebImage(statuses: [ZXStatus]?, finished: (statuses: [ZXStatus]?, error: NSError?) -> ()) {
        // 创建任务组
        let group = dispatch_group_create()
        
        // 判断是否有模型
        guard let list = statuses else {
            // 没有模型
            return
        }
        
        // 记录缓存图片的大小
        var length = 0
        
        // 遍历模型
        for status in list {
            // 如果没有图片需要下载,接着遍历下一个
            let count = status.pictureURLs?.count ?? 0
            if count == 0 {
                // 没有图片,遍历下一个模型
                continue
            }
            
            // 判断是否有图片需要下载
            if let urls = status.pictureURLs {
                // 有需要缓存的图片,遍历,一张-张缓存
                //                for url in urls {
                if urls.count == 1 {
                    let url = urls[0]
                    print(url)
                    // 缓存图片
                    // 在缓存之前放到任务组里面
                    dispatch_group_enter(group)
                    SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image, error, _, _, _) -> Void in
                        // 离开组
                        dispatch_group_leave(group)
                        
                        // 判断有没有错误
                        if error != nil {
                            print("下载图片出错:\(url)")
                            return
                        }
                        
                        // 没有出错
                        print("下载图片完成:\(url)")
                        
                        // 记录下载图片的大小
                        if let data = UIImagePNGRepresentation(image) {
                            length += data.length
                        }
                    })
                }
            }
        }
        
        // 所有图片都下载完,在通知调用者
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            print("所有图片下载完成,告诉调用者获取到了微博数据: 大小:\(length / 1024)")
            // 通知调用者,已经有数据
            finished(statuses: statuses, error: nil)
        }
    }

    
    
}
