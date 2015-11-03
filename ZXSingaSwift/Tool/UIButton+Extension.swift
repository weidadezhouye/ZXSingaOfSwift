
//
//  UIButton+Extension.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/1.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit


extension UIButton {
//    便利构造函数
    convenience init (imageName:String,titleName:String,titleColor:UIColor,fontsize:CGFloat) {
       self.init()
        
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        setTitle(titleName, forState: UIControlState.Normal)
        setTitleColor(titleColor, forState: UIControlState.Normal)
        
        titleLabel?.font = UIFont.systemFontOfSize(fontsize)
        
       
    }
    
    
}