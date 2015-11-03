
//
//  UIImageView+Extension.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/1.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

extension UIImageView {
    
//    重写第三方的方法，防止方法改变的时候大面积替换工作
    func zx_setImageWithURL(url: NSURL!){
        sd_setImageWithURL(url)
        
    }
    
    
    func zx_setImageWithURL(url: NSURL!, placeholderImage placeholder: UIImage!){
        
        sd_setImageWithURL(url, placeholderImage: placeholder)
    }
    
    
}

