//
//  ZXStatusTopView.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/31.
//  Copyright © 2015年  周学明. All rights reserved.
//



import UIKit

class ZXStatusTopView: UIView {

    var status: ZXStatus? {
        didSet{
            if let iconUrl = status?.user?.profile_image_url{
                
                iconView.sd_setImageWithURL(NSURL(string: iconUrl))
                
            }
            
//            如果不是会员，则设置头像为灰色，被复用了
//            if status?.user?.mbrank==0 {
//                
//                nameLabel.textColor = UIColor.grayColor()
//            }
            
            // 名称
            nameLabel.text = status?.user?.name
            
            // 时间
            timeLabel.text = status?.created_at
            
            // 来源
            sourceLabel.text = "来自火星微博"
            
            verifiedView.image = status?.user?.verifiedImageName
            
            menmberView.image = status?.user?.mbrankImage
        }
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
        
    }

    func prepareUI() {
        addSubview(headerLineView)
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(verifiedView)
        addSubview(menmberView)
        
        
        //    为headerLineView添加约束
        headerLineView.ff_AlignInner(type: ff_AlignType.TopLeft, referView: self, size: CGSizeMake(UIScreen.mainScreen().bounds.width, 10), offset: CGPointMake(0, 0))
        
//        头像
        iconView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: headerLineView, size: CGSizeMake(35, 35), offset: CGPointMake(8, 8))
        
//        名称
        nameLabel.ff_AlignHorizontal(type: ff_AlignType.TopRight, referView: iconView, size: nil, offset: CGPointMake(8, 0))
        
//        时间
        timeLabel.ff_AlignHorizontal(type: ff_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPointMake(8, 0))
        
        /// 来源
        sourceLabel.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: timeLabel, size: nil, offset: CGPoint(x: 8, y: 0))
        
        /// 会员等级
        menmberView.ff_AlignHorizontal(type: ff_AlignType.CenterRight, referView: nameLabel, size: CGSize(width: 14, height: 14), offset: CGPoint(x: 8, y: 0))
        
        /// 认证图标
        verifiedView.ff_AlignInner(type: ff_AlignType.BottomRight, referView: iconView, size: CGSize(width: 17, height: 17), offset: CGPoint(x: 8.5, y: 8.5))
        

        
    }
    
    
//    MARK: - 懒加载
//    头像
    private lazy var iconView = UIImageView()
    
//    姓名
    private lazy var nameLabel:UILabel = UILabel(fonsize: 14, textColor: UIColor.orangeColor())
//    时间
    private lazy var timeLabel:UILabel = UILabel(fonsize: 9, textColor: UIColor.orangeColor())
//    来源
    private lazy var sourceLabel:UILabel = UILabel(fonsize: 9, textColor: UIColor.lightGrayColor())
    
//    认证图标
    private lazy var verifiedView = UIImageView()
//    会员等级
    private lazy var menmberView:UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    //    添加顶部的一条分割线
    private lazy var headerLineView:UIView =
    {
        let headerLine = UIView()
        headerLine.backgroundColor = UIColor(white: 0.90, alpha: 1)
//        headerLine.backgroundColor = UIColor.yellowColor()
        return headerLine
        
        }()
    
    
}
