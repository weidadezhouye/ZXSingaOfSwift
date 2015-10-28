//
//  ZXTabBarController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        创建自己的tabbar
        let newTabBar = ZXTabBar()
        newTabBar.addBtn.addTarget(self, action: "addBtnClick", forControlEvents: UIControlEvents.TouchDragInside)
//        使用kvc
        setValue(newTabBar, forKey: "tabBar")
        
//        tabBar.tintColor = UIColor.orangeColor()
        
        
       let homeVc = ZXHomeViewController()
        addChildVc(homeVc, title: "首页", imageName: "tabbar_home")
        
        let messageVc = ZXMessageViewController()
        addChildVc(messageVc, title: "消息", imageName: "tabbar_message_center")

        let discoverVc = ZXDiscoverViewController()
        addChildVc(discoverVc, title: "发现", imageName: "tabbar_discover")
        
        let meVc = ZXMeViewController()
        addChildVc(meVc, title: "我", imageName: "tabbar_profile")
        
        
    }
    
  
    
    
    
//   添加按钮
    private func addChildVc(controller:UIViewController,title:String,imageName:String){
        controller.title = title;
        
        controller.tabBarItem.image = UIImage(named: imageName)
        
        let nav = UINavigationController(rootViewController: controller)
        
        self.addChildViewController(nav)
        
        
    }
    
    
    
//    加号按钮的点击事件
    private func addBtnClick()
    {
        print("fff")
    }
    
}
