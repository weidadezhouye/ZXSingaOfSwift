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
        
        window?.rootViewController = defaultController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
    private func defaultController() -> UIViewController{
//        每次登陆都要来这里判断，如果没有可以加载的用户数据，就直接进入
        if !ZXUserAccount.userLogin() {
            return ZXTabBarController()
        }
        
        return isNewVersion() ? ZXNewFeatureController() : ZXWelcomeBackController()
        
    }
    
    
    
    private func isNewVersion() -> Bool {
//        获取当前的版本号
        let versionStr = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let currentVersion = Double(versionStr)!
        
        print("currentVersion\(currentVersion)")
        
//        获取保存的版本号
        let shaBoxStrKey = "shaBoxStrKey"
        let shaBoxVersion = NSUserDefaults.standardUserDefaults().doubleForKey(shaBoxStrKey)
        print("shaBoxVersion\(shaBoxVersion)")
        
//        保存当前的版本
        NSUserDefaults.standardUserDefaults().setDouble(currentVersion, forKey: shaBoxStrKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
//        对比
        return currentVersion > shaBoxVersion
        
    }
    
    
    
//    MARK: - 切换跟控制器的方法
    func switchRootViewController(isMain:Bool) {
        window?.rootViewController = isMain ? ZXTabBarController() : ZXWelcomeBackController()
        
    }
    
    
    
//    设置颜色
    private func setAllColor(){
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        
    }
    
    

   }

