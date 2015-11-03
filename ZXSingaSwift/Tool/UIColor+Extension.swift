//
//  UIColor+Extension.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/30.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

extension UIColor{
    
//    返回一个随机色
    class func randomColor()->UIColor{
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
        
    }
    
    private class func randomValue() ->CGFloat {
        return CGFloat(arc4random_uniform(256))/255
        
        
    }
}
