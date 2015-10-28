//
//  ZXBaseViewController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXBaseViewController: UITableViewController,ZXVisiterViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }

    
    let login = false
    
    override func loadView() {
        login ? super.loadView() : loginInVisiterView()
    }
    
    func loginInVisiterView()
    {
        let visiterView  = ZXVisiterView()
        
        view = visiterView
        
//        设置背景颜色（在设置遮盖的位置要注释掉，否则会出现分层效果）
//        view.backgroundColor = UIColor.whiteColor()
        
        if self is ZXHomeViewController
        {
//            开始旋转
            visiterView.startRotationAnimation()
            
        }
        else if self is ZXMessageViewController
        {
//            更换图片和文字
            visiterView.loadVisiter("visitordiscover_image_message", title: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
        }
        else if self is ZXDiscoverViewController
        {
            //            更换图片和文字
            visiterView.loadVisiter("visitordiscover_image_message", title: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过")
        }
        else if self is ZXMeViewController
        {
            //            更换图片和文字
            visiterView.loadVisiter("visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
        }
        visiterView.visiterDelegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "visiterViewRegester")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: "visiterViewLogin")
        
    }
    
    func visiterViewRegester(){
        
        
        
    }
    
    func visiterViewLogin(){
        
        let ouathVc = ZXOuathController()
        let nav = UINavigationController(rootViewController: ouathVc)
        
        presentViewController(nav, animated: true, completion:nil)
    }
    
    
}



