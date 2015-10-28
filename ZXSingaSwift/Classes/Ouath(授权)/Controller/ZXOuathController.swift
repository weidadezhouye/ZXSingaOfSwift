//
//  ZXOuathController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/28.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXOuathController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "新浪微博"
            
//     创建取消按钮，并且监听她的点击事件
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClick")
        
        view.backgroundColor = UIColor.brownColor()
        
    }
//    监听取消按钮的点击事件
    func cancelBtnClick(){
        
        dismissViewControllerAnimated(true, completion:nil)
        
    }
    
}
