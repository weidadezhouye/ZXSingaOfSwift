//
//  ZXUser.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXUser: NSObject {

    /// 字符串型的用户UID
    var idstr: String?
    
    /// 友好显示名称
    var name: String?
    
    /// 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    /// verified_type 没有认证:-1   认证用户:0  企业认证:2,3,5  达人:220
    var verified_type: Int = -1

    var verifiedImageName : UIImage?
        {
        switch verified_type{
        case 0:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
 
            
        }
    }
    
    var mbrank : Int = 0
   
    var mbrankImage : UIImage? {
        if mbrank > 0 && mbrank <= 6 {
        return UIImage(named: "common_icon_membership_level\(mbrank)")
       
        }
    
    return nil
    
    }
    
    init(dict : [String : AnyObject]){
        super.init()
        
        setValuesForKeysWithDictionary(dict)
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    /// 对象的打印
    override var description: String {
        let properties = ["idstr", "name", "profile_image_url", "verified_type", "mbrank"]
        
        return "\n\t用户模型:\(dictionaryWithValuesForKeys(properties))"
    }

}
