//
//  ZXComposeController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/3.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXComposeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        prepareUI()
        
    }

    private func prepareUI(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Plain, target: self, action: "sendBtnClick")
        
        let pix = "发微博"
        
        if let name =  ZXUserAccount.loadAccount()?.name {
            let titleLabel = UILabel()
            
            titleLabel.font = UIFont.systemFontOfSize(14)
            
            let titleName = pix + "\n" + name
//            创建可变的属性文本
            let attrStr = NSMutableAttributedString(string: titleName)
            
            titleLabel.textColor = UIColor.blackColor()
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = NSTextAlignment.Center
            
            let nameRange = (titleName as NSString).rangeOfString(name)
            
            // 设置属性文本的属性
            attrStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: nameRange)
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: nameRange)
            
            // 顺序不要搞错
            titleLabel.attributedText = attrStr
            titleLabel.sizeToFit()

            
            navigationItem.titleView = titleLabel
            
            
        }else  //没有登陆
        {
            navigationItem.title = pix
        }
        
        
        
        
        
    }
    
    

//    取消按钮的点击
    func cancelBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
 

//    发送按钮的点击
    func sendBtnClick() {
        
        
    }
}
