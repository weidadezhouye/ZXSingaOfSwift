//
//  ZXTitleBtn.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXTitleBtn: UIButton {

   
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        交换按钮的image和label的位置
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = titleLabel!.frame.width + 3
        
        
        
    }
    
    

}
