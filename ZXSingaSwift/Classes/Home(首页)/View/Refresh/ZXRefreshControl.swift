//
//  ZXRefreshControl.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/3.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXRefreshControl: UIRefreshControl {

    private let RefreshOffSet:CGFloat = -60
    
//    标记，用于去除重复的答案
    private var isUp = false
    
//    覆盖父类的frame
    override var frame:CGRect {
        
        didSet{
            
            if frame.origin.y >= 0{
                
                return
                
            }
//            判断系统是否在刷新
            if refreshing {
//                调用自定义的View，开始旋转
                refreshView.startLoading()
                
            }
            
            if frame.origin.y < RefreshOffSet && !isUp {
//                箭头转上去
                isUp = true
                refreshView.rotationpullDown(isUp)
                
            }else if frame.origin.y > RefreshOffSet && isUp{
//                箭头转下去
                isUp = false
                refreshView.rotationpullDown(isUp)
            }
            
        }
        
    }
//    重写父类的结束刷新的方法
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopLoading()
    }
    
//   MARK: -构造方法
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        prepareUI()
        
    }

    private func prepareUI(){
        
        addSubview(refreshView)
        
        refreshView.ff_AlignInner(type: ff_AlignType.CenterCenter, referView: self, size: refreshView.bounds.size)
        
        
    }
    
    
//    MARK: -懒加载
    
    private lazy var refreshView:ZXRefreshView = ZXRefreshView.refreshView()

}


class ZXRefreshView: UIView {
//   下拉刷新视图
    @IBOutlet weak var pullDownView: UIView!
//    加载更多的菊花
    @IBOutlet weak var loadImageView: UIImageView!
    
//    箭头
    @IBOutlet weak var pullDownClick: UIImageView!
//    加载xib
    class func refreshView() -> ZXRefreshView{
        return NSBundle.mainBundle().loadNibNamed("ZXRefresh", owner: nil, options: nil).last as! ZXRefreshView
    
    }
    
//    箭头旋转动画
    func rotationpullDown(isUp : Bool){
        
        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.pullDownClick.transform = isUp ?CGAffineTransformMakeRotation(CGFloat(M_PI - 0.01)):CGAffineTransformIdentity
        }
        
    }
    
//    开始旋转
    func startLoading() {
//        如果动画正在执行，不添加动画
        let animKey = "animKey"
        if let _ = loadImageView.layer.animationForKey(animKey)
        {
            return
            
        }
        pullDownView.hidden = true
//        旋转
        let anim = CABasicAnimation(keyPath: "transfrom.rotation")
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.25
        anim.toValue = M_PI * 2
        anim.removedOnCompletion = false
//        
        loadImageView.layer.addAnimation(anim, forKey: animKey)
        
    }
    
    func stopLoading() {
//        显示tipView
        pullDownView.hidden = false
//        停止旋转
        loadImageView.layer.removeAllAnimations()
        
        
    }
    
}