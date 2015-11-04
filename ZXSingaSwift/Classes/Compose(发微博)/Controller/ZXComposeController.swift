//
//  ZXComposeController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/3.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXComposeController: UIViewController {
    
    // MARK: - 属性
    /// toolBar底部约束
    private var toolBarBottomCon: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        prepareUI()
//        注册通知监听键盘的frame的改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardFrameChanged:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
        
        
    }
//    销毁通知
    deinit {
        
    NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
//    实现frame改变的方法
    func keyBoardFrameChanged(notifition:NSNotification) {
        
        print("\(notifition)")
        let endFrame = notifition.userInfo!["UIKeyboardFrameEndUserInfoKey"]!.CGRectValue
        let duration = notifition.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! NSTimeInterval
//        设置toolBar的frame值改变
        toolBarBottomCon?.constant = -(UIScreen.mainScreen().bounds.height - endFrame.origin.y)
        
        UIView.animateWithDuration(duration) { () -> Void in
//            重新布局
            self.view.layoutIfNeeded()
        }
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
        
    }
    
    
//  准备控件的控制器
    private func prepareUI(){
//        布局导航控制器
        setupNavgationBar()
        
//        布局toolBar
        setupToolBar()
      
//        布局textView
        setupTextView()
        
        
    }
    
    
    private func setupNavgationBar(){
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
    
//    设置toolBar
    private func setupToolBar(){
        
        view.addSubview(toolBar)
        
//        添加约束
//        toolBar.ff_AlignHorizontal(type: ff_AlignType.BottomLeft, referView: view, size: CGSizeMake(UIScreen.mainScreen().bounds.width, 44))
        let cole = toolBar.ff_AlignInner(type: ff_AlignType.BottomLeft, referView: view, size: CGSizeMake(UIScreen.mainScreen().bounds.width, 44))
        toolBarBottomCon = toolBar.ff_Constraint(cole, attribute: NSLayoutAttribute.Bottom)
        
        
        
        var items = [UIBarButtonItem]()
        
        // 每个item对应的图片名称
        let itemSettings = [["imageName": "compose_toolbar_picture", "action": "picture"],
            ["imageName": "compose_trendbutton_background", "action": "trend"],
            ["imageName": "compose_mentionbutton_background", "action": "mention"],
            ["imageName": "compose_emoticonbutton_background", "action": "emoticon"],
            ["imageName": "compose_addbutton_background", "action": "add"]]
        
        
        var index = 0
//        开始设置tabBar按钮
        for name in itemSettings {
            
            let imageNam = name["imageName"]
            let action = name["action"]!
            let item = UIBarButtonItem(imageName:imageNam!)
            
            let button = item.customView as! UIButton
            button.addTarget(self, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)
            
            items.append(item)
//            添加弹簧，错开距离
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
            
            index++
            
            
        }
//        移除最后一个弹簧
        items.removeLast()
        
        toolBar.items = items
        
        
    }
    
    
//    设置textView
    func setupTextView() {
        
//        添加
        view.addSubview(textView)
        
//        设置约束
      
        textView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: view, size: nil)
        
        textView.ff_AlignVertical(type: ff_AlignType.TopRight, referView: toolBar, size: nil)
        
        
    }
    
    // MARK: - 按钮点击事件
    func picture() {
        print("图片")
    }
    
    func trend() {
        print("#")
    }
    
    func mention() {
        print("@")
    }
    
    func emoticon() {
        print("表情")
    }
    
    func add() {
        print("加号")
    }

    

//    取消按钮的点击
    func cancelBtnClick() {
//        注销后键盘将会推出
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        
    }
 

//    发送按钮的点击
    func sendBtnClick() {
        
        
    }
    
    
//    MARK: - 懒加载
    private lazy var toolBar : UIToolbar = {
     
        let toolBa = UIToolbar()
        
        toolBa.backgroundColor = UIColor(white: 0.8, alpha: 1)
        
        return toolBa
    
    }()
    
    
//    懒加载textView
    private lazy var textView : ZXTextView = {
        let textView = ZXTextView()
        textView.font = UIFont.systemFontOfSize(18)
        textView.textColor = UIColor(white: 0.8, alpha: 1)
        
        textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        textView.backgroundColor = UIColor.purpleColor()
        
        textView.textStr = "写点什么吧"
//        当拖拽的时候键盘消息
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        textView.bounces = true
//        不要垂直的弹簧效果
        textView.alwaysBounceVertical = true
//        遵循代理协议
        textView.delegate = self
        
        return textView
        }()
    
    
}

//MARK: UITextViewDelegate代理方法实现
extension ZXComposeController: UITextViewDelegate{
    
//    当里面的属性文本的值该百年的时候通知代理
    func textViewDidChange(textView: UITextView) {
//       确立发送按钮的能不能点击状态
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        
        
    }
    
}

