//
//  ZXHomeViewController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

// 统一管理cell的ID
enum ZXStatusCellIdentifier: String {
    case NormalCell = "NormalCell"
    case ForwardCell = "ForwardCell"
}

class ZXHomeViewController: ZXBaseViewController {
    
    private var statuses:[ZXStatus]?{
        didSet {
            
            tableView.reloadData()
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !ZXUserAccount.userLogin()
        {
            return
        }
        
        prepareUI()
        
        prepareTableView()
//        创建下拉刷新控制器
        let refreshVc = ZXRefreshControl()
        
        tableView.addSubview(refreshVc)
        
        ZXStatus.loadStatus { (statuses, error) -> () in
            if error != nil {
               SVProgressHUD.showErrorWithStatus("加载微博数据失败，请检查网络", maskType: SVProgressHUDMaskType.Black)
                return
            }
            
            if statuses == nil || statuses?.count == 0 {
                SVProgressHUD.showErrorWithStatus("没有新的微博数据", maskType: SVProgressHUDMaskType.Black)
                return
            }
            
//           有微博数据
            self.statuses = statuses
            
            print("statuses\(statuses)")
            
            
        }
        
        
        
           }
    
    private func prepareTableView() {
        tableView.registerClass(ZXStatusNomalCell.self, forCellReuseIdentifier: ZXStatusCellIdentifier.NormalCell.rawValue)
         tableView.registerClass(ZXStatusForwardCell.self, forCellReuseIdentifier: ZXStatusCellIdentifier.ForwardCell.rawValue)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
////        设置预算行高
//        tableView.estimatedRowHeight = 300
//        
////        AutomaticDimension 根据约束自己来设置高度
//        tableView.rowHeight = UITableViewAutomaticDimension
//        
        
    }
    
    
   private func prepareUI() {
//        导航按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.navgationItem("navigationbar_pop")
//        
        let btn = ZXTitleBtn()
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        
        let userName = ZXUserAccount.loadAccount()?.name ?? "无名小辈"
        btn.setTitleColor(UIColor.randomColor(), forState: UIControlState.Normal)
        btn.setTitle(userName, forState: UIControlState.Normal)
        
        btn.addTarget(self, action: "titleBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        navigationItem.titleView = btn
        
        
    }
//  加上@objc 的方法就可以在oc中使用 ：
   @objc private func titleBtnClick(button : UIButton) {
        button.selected = !button.selected
    
    var transform: CGAffineTransform?
    if button.selected
    {
//        控件的旋转角度是优先考虑最小的，例如旋转270，会自动方向旋转90达到效果
//        当旋转的是180度，只会顺时针旋转
//        根据控件的旋转特性稍微偏小一点，就能实现逆时针旋转
        transform = CGAffineTransformMakeRotation(CGFloat(M_PI-0.01))
        
    }else
    {
//        无旋转操作
        transform = CGAffineTransformIdentity
        
    }
//    添加动画
    UIView.animateWithDuration(0.25)
        { () -> Void in
//        点击的两种状态的切换
        button.imageView?.transform = transform!
    }
    
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // 获取模型
        let status = statuses![indexPath.row]
        
        // 去模型里面查看之前有没有缓存行高
        if let rowHeight = status.rowheight {
            // 模型有缓存的行高
            //            print("返回cell: \(indexPath.row), 缓存的行高:\(rowHeight)")
            return rowHeight
        }
        // 没有缓存的行高
        
        let id = status.cellID()
        // 获取cell
        let cell = tableView.dequeueReusableCellWithIdentifier(id) as! ZXStatusCell
        
        // 调用cell计算行高的方法
        let rowHeight = cell.rowHeight(status)
        //        print("计算: \(indexPath.row), cell高度: \(rowHeight)")
        
        // 将行高缓存起来
        status.rowheight = rowHeight
        
        return rowHeight
    }
    
    
    
//    MARK:- tableView代理方法
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let status = statuses![indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(status.cellID()) as! ZXStatusCell
        
        cell.status = status
        
        
        
        
        
        return cell
        
    }
    
}
