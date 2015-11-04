//
//  ZXNewFeatureController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/30.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ZXNewFeatureController: UICollectionViewController {
//    全局设置页数
    private var pageCount = 4
    
// 先定义一个布局
   private var layout = UICollectionViewFlowLayout()
    
    init() {
//        创建collectionView必须实现layout
        super.init(collectionViewLayout: layout)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(ZXNewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//       布局ui
      prepareLayOut()
        
    }
//   准备布局
    private func prepareLayOut() {
//        设置大小
        layout.itemSize = UIScreen.mainScreen().bounds.size
//        间距设置为0
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
//        滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
//        分页
        collectionView?.pagingEnabled = true
//        取消弹簧效果
        collectionView?.bounces = false
        
        
        
    }
    
    
//   多少页
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pageCount
    }
    
//  可以设置每一个的属性
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ZXNewFeatureCell
//    随机色
//        cell.backgroundColor = UIColor.randomColor()
        
        cell.imageIndex = indexPath.item
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        正在显示的cell的indexpath
        let showItem  = collectionView.indexPathsForVisibleItems().first!
//        获取正在显示的cell
        let cell = collectionView.cellForItemAtIndexPath(showItem) as! ZXNewFeatureCell
//        最后一页开始动画
        if showItem.item == pageCount - 1 {
//            开始动画
            cell.startAnimation()
            
        }
    }

}

// MARK: - 自定义cell
class ZXNewFeatureCell:UICollectionViewCell{
//    监听属性值的改变，cell即将显示的时候会调用
    var imageIndex:Int = 0 {
        didSet {
//            知道是哪一页
//            设置图片
            bgImage.image = UIImage(named: "new_feature_\(imageIndex+1)")
            
            startBtn.hidden = true
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    开始动画
    func startAnimation() {
        startBtn.hidden = false
//        把按钮tranform设置为0
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
//        动画
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 4, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
//            改变tranfrom
            self.startBtn.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                
        })
        
        
        
    }
    
    
//    准备ui
    private func prepareUI() {
//        添加子视图
        
        contentView.addSubview(bgImage)
//        contentView.didAddSubview(startBtn)
        contentView.addSubview(startBtn)
        
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        
//        添加约束
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bg":bgImage]))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bg":bgImage]))
//        按钮的约束
        contentView.addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: startBtn, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -160))
   
    }

//    监听开始按钮的点击事件
    func startBtnClick() {
        (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootViewController(true)
    }
    
//    MARK: - 懒加载
//    背景
    private lazy var bgImage = UIImageView()
    
//    开始体验按钮
    private lazy var startBtn:UIButton = {
        let btn = UIButton()
        
//        设置图片
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        btn.setTitle("开始体验", forState: UIControlState.Normal)
//        添加点击事件
        btn.addTarget(self, action: "startBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
}

