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
    
    
}