//
//  ZXStatusCell.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXStatusCell: UITableViewCell {

    // MARK: - 属性
    /// 配图宽度约束
    var pictureViewWidthCon: NSLayoutConstraint?
    
    /// 配图高度约束
    var pictureViewHeightCon: NSLayoutConstraint?
    
//    MARK: - 属性
    var status : ZXStatus? {
        
        didSet{
//            将模型赋值给topView
            topView.status = status
            
            pictureView.status = status
            
            let size = pictureView.calcViewSize()
            
            // 重新设置配图的宽高约束
            pictureViewWidthCon?.constant = size.width
            pictureViewHeightCon?.constant = size.height
            
//            设置微博的内容
            contentLabel.text = status?.text
            
        }
    }
    
    // 设置cell的模型,cell会根据模型,从新设置内容,更新约束.获取子控件的最大Y值
    // 返回cell的高度
    func rowHeight(status: ZXStatus) -> CGFloat {
        // 设置cell的模型
        self.status = status
        
        // 更新约束
        layoutIfNeeded()
        
        // 获取子控件的最大Y值
        let maxY = CGRectGetMaxY(bottomView.frame)
        
        return maxY
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
    func prepareUI() {
    
    
    
        contentView.addSubview(topView)
    
    contentView.addSubview(contentLabel)
    
    contentView.addSubview(pictureView)
    
    contentView.addSubview(bottomView)
    
//    设置约束
    
    topView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: contentView, size: CGSizeMake(UIScreen.mainScreen().bounds.width, 53))
    
    contentLabel.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPointMake(8, 8))
    
//    设置宽度
    contentView.addConstraint(NSLayoutConstraint(item: contentLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: UIScreen.mainScreen().bounds.width-2*8))
    

    
//    为bottomView添加约束
    bottomView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: pictureView, size: CGSizeMake(UIScreen.mainScreen().bounds.width, 44), offset: CGPointMake(-8, 8))
    
    
    //    为contantView和bottomView底部的底部重合
//    contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: bottomView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
    
      

    
  
    

    
        
    }
    
    
    
    
    
//    MARK: - 懒加载
//    顶部视图
     lazy var topView: ZXStatusTopView = ZXStatusTopView()
//    文本内容
     lazy var contentLabel:UILabel = {
        let label = UILabel(fonsize: 16, textColor: UIColor.blackColor())
        
        label.textAlignment = NSTextAlignment.Left
        
        label.numberOfLines = 0
        
        return label
        
        
    }()
    
//    赞，转发，评论的底部视图
    var bottomView: ZXStatusBottomView = ZXStatusBottomView()
    
//微博配图
    lazy var pictureView = ZXPictureView()
    

}
