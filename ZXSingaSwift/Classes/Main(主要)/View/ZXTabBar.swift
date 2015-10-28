
//
//  ZXTabBar.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXTabBar: UITabBar {

    
    private let count: CGFloat = 5
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width / count
        
        let frame = CGRectMake(0, 0, width, bounds.height)
        
        var index = 0;
//        布局四个子控件的frame
        for view in subviews{
            
            if view is UIControl && !(view is UIButton) {
                view.frame = CGRectOffset(frame, width * CGFloat(index), 0)
                
                index += index == 1 ? 2 : 1
            }
            
        }
        
//        设置加号按钮的frame
        addBtn.frame = CGRectOffset(frame, width * 2, 0)
        
    }
    
    
    
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        
        //        设置图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        //        设置背景图片
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState:UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState:UIControlState.Highlighted)
        
         self.addSubview(btn)
        
        return btn
        }()
    
   
    
    
}
