//
//  ZXHomeViewController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXHomeViewController: ZXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        prepareUI()
        
        
        
        
        
           }
    
   private func prepareUI() {
//        导航按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.navgationItem("navigationbar_pop")
//        
        let btn = ZXTitleBtn()
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        
        let userName = ZXUserAccount.loadAccount()?.name ?? "无名小辈"
        btn.setTitleColor(UIColor.randomColor(), forState: UIControlState.Normal)
        btn.setTitle(userName, forState: UIControlState.Normal)
        
        btn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        navigationItem.titleView = btn
        
        
    }

   @objc private func titleBtnClick(button : UIButton) {
        button.selected = !button.selected
    
    var transform: CGAffineTransform?
    if button.selected {
        
        transform = CGAffineTransformMakeRotation(CGFloat(M_PI-0.01))
        
        
    }else
    {
        transform = CGAffineTransformIdentity
        
    }
    
    UIView.animateWithDuration(0.25) { () -> Void in
        
        button.imageView?.transform = transform!
    }
    
        
        
    }
    
}
