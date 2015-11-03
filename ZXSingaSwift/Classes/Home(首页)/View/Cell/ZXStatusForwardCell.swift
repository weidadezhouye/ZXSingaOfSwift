//
//  ZXStatusForwardCell.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/1.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXStatusForwardCell: ZXStatusCell {

    
    // 覆盖父类的模型属性
    // 添加 override关键字,实现属性监视器,先调用父类的属性监视器,在调用子类的属性监视器
    override var status: ZXStatus? {
        didSet {
            print("\(status?.idstr),子类监视器")
            // 设置转发微博label的内容
            let name = status?.retweeted_status?.user?.name ?? "名称为空"
            let text = status?.retweeted_status?.text ?? "内容为空"
            forwardLabel.text = "@\(name): \(text)"
        }
    }
    
    /// 覆盖父类的方法
    override func prepareUI() {
        // 记得调用父类的prepareUI
        super.prepareUI()
        
        // 添加子控件
        //        contentView.addSubview(bkgButton)
        // 将 bkgButton 插入到 配图的下面
        contentView.insertSubview(bkgButton, belowSubview: pictureView)
        contentView.addSubview(forwardLabel)
        
        // 添加约束
        // 背景
        // 左上角约束
        bkgButton.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: nil, offset: CGPoint(x: -8, y: 8))
        // 右下角
        bkgButton.ff_AlignVertical(type: ff_AlignType.TopRight, referView: bottomView, size: nil)
        
        // 被转发微博内容label
        forwardLabel.ff_AlignInner(type: ff_AlignType.TopLeft, referView: bkgButton, size: nil, offset: CGPoint(x: 8, y: 8))
        // 宽度约束
        contentView.addConstraint(NSLayoutConstraint(item: forwardLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width - 2 * 8))
        
        // 配图的约束
        let cons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: forwardLabel, size: CGSize(width: 0, height: 0), offset: CGPoint(x: 0, y: 8))
        
        // 获取配图的宽高约束
        pictureViewHeightCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Height)
        pictureViewWidthCon = pictureView.ff_Constraint(cons, attribute: NSLayoutAttribute.Width)
    }
    
    // MARK: - 懒加载
    /// 灰色的背景
    private lazy var bkgButton: UIButton = {
        let button = UIButton()
        
        // 设置背景
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        return button
        }()
    
    /// 被转发微博内容label
    private lazy var forwardLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.darkGrayColor()
        label.numberOfLines = 0
        
        label.text = "我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字"
        
        return label
        }()

 
    
    
    

}
