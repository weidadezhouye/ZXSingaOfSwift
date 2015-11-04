//
//  ZXVisiterView.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

//设置代理
protocol ZXVisiterViewDelegate: NSObjectProtocol{
    
   func visiterViewRegester()
    func visiterViewLogin()
    
    
}


class ZXVisiterView: UIView {
//  设置visiterDelegate的代理
    weak var visiterDelegate : ZXVisiterViewDelegate?
    
    //    注册按钮的点击
    func regesterBtnClick () {
        visiterDelegate?.visiterViewRegester()
        
    }
    
    //    登录按钮的点击
    func loginBtnClick () {
        visiterDelegate?.visiterViewLogin()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        prepareUI()
    }

  
    func loadVisiter(imageName : String , title:String) {
        
//        隐藏
        sendSubviewToBack(coverImage)
        homeView.hidden = true
//        更换图片
        iconView.image = UIImage(named: imageName)
//        设置提示文字
        message.text = title
        message.sizeToFit()
        
        
    }
    
    func startRotationAnimation() {
        
        let anitation = CABasicAnimation(keyPath: "transform.rotation")
        
        anitation.toValue = 2 * M_PI
        anitation.repeatCount = MAXFLOAT
        anitation.duration = 10
        
//        一定要设置移除
        anitation.removedOnCompletion = false
//        设置开始动画
        iconView.layer.addAnimation(anitation, forKey: "homeRotation")
        
    }
    
    /// 暂停旋转
    func pauseAnimation() {
        // 记录暂停时间
        let pauseTime = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        
        // 设置动画速度为0
        iconView.layer.speed = 0
        
        // 设置动画偏移时间
        iconView.layer.timeOffset = pauseTime
    }
    
    /// 恢复旋转
    func resumeAnimation() {
        // 获取暂停时间
        let pauseTime = iconView.layer.timeOffset
        
        // 设置动画速度为1
        iconView.layer.speed = 1
        
        iconView.layer.timeOffset = 0
        
        iconView.layer.beginTime = 0
        
        let timeSincePause = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        
        iconView.layer.beginTime = timeSincePause
    }

    
    
    private func  prepareUI(){
        
        backgroundColor = UIColor(white: 237.0 / 255, alpha: 1)
       
//        添加控件
        addSubview(iconView)
        
        addSubview(coverImage)
        
        addSubview(homeView)
        
        addSubview(message)
        
        addSubview(regesterBtn)
        
        addSubview(loginBtn)
        
//        去除系统自带的约束
        iconView.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        message.translatesAutoresizingMaskIntoConstraints = false
        regesterBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        
//        代码设置约束
        self.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        
          self.addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -40))
        
        // 小房子
        // x
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        // 消息label
        // x
        addConstraint(NSLayoutConstraint(item: message, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        // y
        addConstraint(NSLayoutConstraint(item: message, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: iconView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        // width
        addConstraint(NSLayoutConstraint(item: message, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 240))
        
        // 注册按钮
        // 左边
        addConstraint(NSLayoutConstraint(item: regesterBtn, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: message, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        
        // 顶部
        addConstraint(NSLayoutConstraint(item: regesterBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: message, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        // 宽度
        addConstraint(NSLayoutConstraint(item: regesterBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        
        // 高度
        addConstraint(NSLayoutConstraint(item: regesterBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
        // 登录按钮
        // 右边
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: message, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
        // 顶部
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: message, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 16))
        
        // 宽度
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        
        // 高度
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 35))
        
//        设置coverImage的约束
        addConstraint(NSLayoutConstraint(item: coverImage, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: coverImage, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: coverImage, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: coverImage, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: message, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        
        
        
        
    }
    
//    懒加载滚动的图片
    private lazy var iconView: UIImageView = {
       let icon = UIImageView()
        
        let images = UIImage(named: "visitordiscover_feed_image_smallicon")
        icon.image = images
        
        icon.sizeToFit()
        
        return icon
    }()
    
    
//    懒加载
    private lazy var homeView: UIImageView = {
        let homeV = UIImageView()
        
        let images = UIImage(named: "visitordiscover_feed_image_house")
        homeV.image = images
        
        homeV.sizeToFit()
        
        return homeV
        
    }()
    
//    懒加载文字
    private lazy var message: UILabel = {
        let messageLabel = UILabel()
        
        messageLabel.text = "关注一些人,看看有上面惊喜"
        messageLabel.numberOfLines = 0
        
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.sizeToFit()
        
        messageLabel.textColor = UIColor.grayColor()
        
        return messageLabel
        
    }()
    
//    懒加载注册按钮
    private lazy var regesterBtn:UIButton = {
        let regester = UIButton()
        
        regester.setTitle("注册", forState: UIControlState.Normal)
        
        regester.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        regester.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
//        监听注册按钮的点击事件
        regester.addTarget(self, action: "regesterBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        regester.sizeToFit()
        return regester
    }()
    
//    懒加载登陆按钮
    private lazy var loginBtn:UIButton = {
        let login = UIButton()
        
        login.setTitle("登陆", forState: UIControlState.Normal)
        
        login.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        login.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        
//        监听登陆按钮的点击事件
        login.addTarget(self, action: "loginBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        login.sizeToFit()
        return login
        }()
    
    
    
//    懒加载遮盖按钮
    private lazy var coverImage:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    

}
