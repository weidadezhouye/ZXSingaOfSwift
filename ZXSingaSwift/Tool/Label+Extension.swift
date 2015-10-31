
//
//  Label+Extension.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit


extension UILabel {
//    便利构造函数
    convenience init(fonsize:CGFloat,textColor:UIColor){
        self.init()
//        设置颜色
        self.textColor = textColor
//        设置文字大小
        font = UIFont.systemFontOfSize(fonsize)
        
    }
    
    
    
}
