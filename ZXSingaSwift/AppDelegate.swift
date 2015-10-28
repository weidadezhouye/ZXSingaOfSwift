//
//  AppDelegate.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/26.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setAllColor()
//        创建窗口
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let tabBarVc = ZXTabBarController()
        
        window?.rootViewController = tabBarVc
        
        window?.makeKeyAndVisible()
        
        
    
        
        return true
    }
    
    private func setAllColor(){
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        
    }
    
    

   }

