//
//  ZXTextView.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/4.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXTextView: UITextView {

//    占位
    var textStr:String? {
        
    didSet{
    
//        
        textLabel.text = textStr
        textLabel.font = font
        
        textLabel.sizeToFit()
    
    }
    }
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
//        布局
        prepareUI()
   
//        添加通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textLabelChanged", name:UITextViewTextDidChangeNotification, object: self)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    移除通知
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    func textLabelChanged() {
        
        textLabel.hidden = hasText()
        
    }
    
//    布局
    func prepareUI(){
        
        addSubview(textLabel)
        
//        设置约束
        textLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: nil, offset: CGPointMake(8, 5))
        
        
        
        
        
    }
    
    
    
    
//    MARK: - 懒加载
    private lazy var textLabel : UILabel = {
        
        let textLb = UILabel(fonsize: 18, textColor: UIColor.grayColor())
        
        return textLb
        
        
    }()
    
    

}
