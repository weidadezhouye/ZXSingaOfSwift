//
//  ZXWelcomeBackController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/30.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import SDWebImage

class ZXWelcomeBackController: UIViewController {

//    头像底部的约束
    private var iconViewBottomCons:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
//        MARK: - 网络加载头像********************************
//        let iconName = ZXUserAccount.loadAccount()?.avatar_large ?? "avatar_default_big"
//        iconView.image = UIImage(named: iconName)
        
        if let urlString = ZXUserAccount.loadAccount()?.avatar_large {
            // 设置用户的头像
            iconView.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "avatar_default_big"))
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        开启动画
        iconViewBottomCons?.constant = -(UIScreen.mainScreen().bounds.height-160)
        
        UIView.animateWithDuration(2.0, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.welcome.alpha = 1
                    }, completion: { (_) -> Void in
//                        
       (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootViewController(true)
                        
                })
        }

    }
    
    
//    准备控件
   private func prepareUI() {
    view.addSubview(bgImage)
    
    view.addSubview(iconView)
    
    view.addSubview(welcome)
    
//    去除自带的自动布局
    iconView.translatesAutoresizingMaskIntoConstraints = false
    bgImage.translatesAutoresizingMaskIntoConstraints = false
    welcome.translatesAutoresizingMaskIntoConstraints = false
    
    
//    布局添加约束
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bg": bgImage]))
    
    view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bg" : bgImage]))
    
//    头像
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
    
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
    
    view.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 85))
    
    // 垂直 底部160
    iconViewBottomCons = NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160)
    view.addConstraint(iconViewBottomCons!)
    
    // 欢迎归来
    // H
    view.addConstraint(NSLayoutConstraint(item: welcome, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: welcome, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
    
    }
    
    
    

//   懒加载
//    背景图片
    private lazy var bgImage:UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
//    欢迎归来的文本
    private lazy var welcome:UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "欢迎归来"
        welcomeLabel.textColor = UIColor.randomColor()
        welcomeLabel.alpha = 0
        return welcomeLabel
        
    }()
//    头像
    private lazy var iconView: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "avatar_default_big"))
//        裁剪头像
        icon.layer.cornerRadius = 42.5
        icon.layer.masksToBounds = true
        return icon
        
    }()
    
}
