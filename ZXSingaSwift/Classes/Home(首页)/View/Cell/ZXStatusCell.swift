//
//  ZXStatusCell.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXStatusCell: UITableViewCell {

//    MARK: - 属性
    var status : ZXStatus? {
        
        didSet{
//            将模型赋值给topView
            topView.status = status
            
//            设置微博的内容
            contentLabel.text = status?.text
            
        }
    }
    
//    MARK: - 构造函数
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    准备UI
   private func prepareUI() {
    
        contentView.addSubview(topView)
    
    contentView.addSubview(contentLabel)
    
//    设置约束
    
    topView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSizeMake(UIScreen.mainScreen().bounds.width, 44))
    
    contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPointMake(8, 8))
    
//    设置宽度
    contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width-2*8))
    
//    为contantView和底部的contantLabel底部重合
    contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
    
    
    
        
    }
    
    
    
    
    
//    MARK: - 懒加载
    private lazy var topView: ZXStatusTopView = ZXStatusTopView()
    
    private lazy var contentLabel:UILabel = {
        let label = UILabel(fonsize: 16, textColor: UIColor.blackColor())
        
        label.textAlignment = NSTextAlignment.Left
        
        label.numberOfLines = 0
        
        return label
        
        
    }()
    
    
    
    

}
