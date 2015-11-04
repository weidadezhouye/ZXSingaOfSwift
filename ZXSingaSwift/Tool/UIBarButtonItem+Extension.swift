//
//  UIBarButtonItem+Extension.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/30.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    
// 不创建对象就能创建一个带按钮的UIBarButtonItem 方法一：便利构造方法
    convenience init(imageName: String) {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: imageName), forState:UIControlState.Normal)
        
         button.setImage(UIImage(named: "\(imageName)_highlighted"), forState:UIControlState.Highlighted)
        
        button.sizeToFit()
        
        self.init(customView:button)
        
    }
    
//   不创建对象就能创建一个带按钮的UIBarButtonItem 方法二：类方法
    class func navgationItem(imageName:String) ->UIBarButtonItem {
        let button  = UIButton()
        
        button.setImage(UIImage(named: imageName), forState:UIControlState.Normal)
        
        button.setImage(UIImage(named: "\(imageName)_highlighted"), forState:UIControlState.Highlighted)
        
        button.sizeToFit()
        
        return UIBarButtonItem(customView: button)
        
        
    }
    
    
    
}


