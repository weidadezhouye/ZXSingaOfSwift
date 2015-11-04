//
//  ZXStatusBottomController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/1.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXStatusBottomView: UIView {

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        prepareUI()
        
    }

//   准备ui
    private func prepareUI() {
        
        addSubview(zanBtn)
        addSubview(lineViewOne)
        addSubview(zhuanFaBtn)
        addSubview(lineViewTwo)
        addSubview(pingLunBtn)
        
//        约束控件
        self.ff_HorizontalTile([zanBtn,zhuanFaBtn,pingLunBtn], insets: UIEdgeInsetsZero)
        
//        分割线添加约束
        lineViewOne.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: zanBtn, size: nil)
        
        lineViewTwo.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: zhuanFaBtn, size: nil)
        
        
        
        
    }
    

//    MARK: - 懒加载
    private lazy var zanBtn : UIButton = UIButton(imageName: "timeline_icon_unlike", titleName: "赞", titleColor: UIColor.grayColor(), fontsize: 18)
  
    private lazy var zhuanFaBtn : UIButton = UIButton(imageName: "timeline_icon_retweet", titleName: "转发", titleColor: UIColor.grayColor(), fontsize: 18)
    
    
    private lazy var pingLunBtn : UIButton = UIButton(imageName: "timeline_icon_comment", titleName: "评论", titleColor: UIColor.grayColor(), fontsize: 18)
    
    private lazy var lineViewOne : UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
    
    private lazy var lineViewTwo : UIImageView = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))


}
