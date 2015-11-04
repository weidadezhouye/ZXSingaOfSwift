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
        
        refreshControl = ZXRefreshControl()
//        添加下拉刷新事件
        refreshControl?.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
<<<<<<< HEAD
        
//        调用方法开始刷新
        refreshControl?.beginRefreshing()
//        代码触发刷新事件（因为一进去就会调用刷新数据）
        refreshControl?.sendActionsForControlEvents(UIControlEvents.ValueChanged)
=======
//        
        refreshControl?.beginRefreshing()
//        代码触发刷新事件（因为一进去就会调用刷新数据）
//        refreshControl?.sendActionsForControlEvents(UIControlEvents.ValueChanged)
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
        
        
//        ZXStatus.loadStatus { (statuses, error) -> () in
//            if error != nil {
//               SVProgressHUD.showErrorWithStatus("加载微博数据失败，请检查网络", maskType: SVProgressHUDMaskType.Black)
//                return
//            }
//            
//            if statuses == nil || statuses?.count == 0 {
//                SVProgressHUD.showErrorWithStatus("没有新的微博数据", maskType: SVProgressHUDMaskType.Black)
//                return
//            }
//            
////           有微博数据
//            self.statuses = statuses
//            
//            print("statuses\(statuses)")
//            
//        }
           }
    
    func loadData() {
<<<<<<< HEAD
       
        print("加载")
=======
        // TODO: 测试获取微博数据
        print("加载微博数据")
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
        // 默认下拉刷新,获取id最大的微博, 如果没有数据,就默认加载20
        var since_id = statuses?.first?.id ?? 0
        var max_id = 0
        
        // 如果菊花正在转,表示 上拉加载更多数据
        if pullUpView.isAnimating() {
            // 上拉加载更多数据
            since_id = 0
<<<<<<< HEAD
            max_id = statuses?.last?.id ?? 0
=======
            max_id = statuses?.last?.id ?? 0 // 设置为最后一条微博的id
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
        }
        
        ZXStatus.loadStatus(since_id, max_id: max_id) { (statuses, error) -> () in
            // 关闭下拉刷新控件
            self.refreshControl?.endRefreshing()
            
            // 将菊花停止
            self.pullUpView.stopAnimating()
            
            if error != nil {
<<<<<<< HEAD
                SVProgressHUD.showErrorWithStatus("加载数据失败,网络不给力", maskType: SVProgressHUDMaskType.Black)
=======
                SVProgressHUD.showErrorWithStatus("加载微博数据失败,网络不给力", maskType: SVProgressHUDMaskType.Black)
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
                
                return
            }
            
            
            // 下拉刷新,显示加载了多少条微博
            if since_id > 0 {
                let count = statuses?.count ?? 0
                self.showTipView(count)
            }
            
            // 能到下面来说明没有错误
            if statuses == nil || statuses?.count == 0 {
                SVProgressHUD.showInfoWithStatus("没有新的微博数据", maskType: SVProgressHUDMaskType.Black)
                return
            }
            
            // 判断如果是下拉刷新,加获取到数据拼接在现有数据的前
<<<<<<< HEAD
            if since_id > 0 {
                
                
                // 最新数据 =  新获取到的数据 + 原有的数据
                self.statuses = statuses! + self.statuses!
            } else if max_id > 0 {  // 上拉加载更多数据
                
                
                // 最新数据 =  原有的数据 + 新获取到的数据
=======
            if since_id > 0 {   // 下拉刷新
                // 最新数据 =  新获取到的数据 + 原有的数据
                print("下拉刷新,获取到: \(statuses?.count)");
                self.statuses = statuses! + self.statuses!
            } else if max_id > 0 {  // 上拉加载更多数据
                // 最新数据 =  原有的数据 + 新获取到的数据
                print("上拉加载更多数据,获取到: \(statuses?.count)");
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
                self.statuses = self.statuses! + statuses!
            } else {
                // 有微博数据
                self.statuses = statuses
<<<<<<< HEAD
               
            }
=======
                print("获取最新20条数据.获取到 \(statuses?.count) 条微博")
            }
            
        }
    }

    
    
    /// 显示下拉刷新加载了多少条微博
    private func showTipView(count: Int) {
        let tipLabelHeight: CGFloat = 44
        let tipLabel = UILabel()
        tipLabel.frame = CGRect(x: 0, y: -20 - tipLabelHeight, width: UIScreen.mainScreen().bounds.width, height: tipLabelHeight)
        
        tipLabel.textColor = UIColor.whiteColor()
        tipLabel.backgroundColor = UIColor.orangeColor()
        tipLabel.font = UIFont.systemFontOfSize(16)
        tipLabel.textAlignment = NSTextAlignment.Center
        
        tipLabel.text = count == 0 ? "没有新的微博" : "加载了 \(count) 条微博"
        
        // 导航栏是从状态栏下面开始
        // 添加到导航栏最下面
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        
        let duration = 0.75
        // 开始动画
        UIView.animateWithDuration(duration, animations: { () -> Void in
            // 让动画反过来执行
            //            UIView.setAnimationRepeatAutoreverses(true)
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
            
            // 重复执行
            //            UIView.setAnimationRepeatCount(5)
            tipLabel.frame.origin.y = tipLabelHeight
            }) { (_) -> Void in
                
                UIView.animateWithDuration(duration, delay: 0.3, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    tipLabel.frame.origin.y = -20 - tipLabelHeight
                    }, completion: { (_) -> Void in
                        tipLabel.removeFromSuperview()
                })
        }
    }

    
<<<<<<< HEAD
    
    /// 展示下拉刷新加载了多少条微博
    private func showTipView(count: Int) {
        let tipLabelHeight: CGFloat = 44
        let tipLabel = UILabel()
        tipLabel.frame = CGRect(x: 0, y: -20 - tipLabelHeight, width: UIScreen.mainScreen().bounds.width, height: tipLabelHeight)
        
        tipLabel.backgroundColor = UIColor.orangeColor()
        tipLabel.font = UIFont.systemFontOfSize(16)
        
        tipLabel.textColor = UIColor.whiteColor()
        
        tipLabel.textAlignment = NSTextAlignment.Center
        
        tipLabel.text = count == 0 ? "没有新的微博" : "加载了 \(count) 条微博"
        
        // 导航栏是从状态栏下面开始
        // 添加到导航栏最下面
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        
        let duration = 0.75
        // 开始动画
        UIView.animateWithDuration(duration, animations: { () -> Void in
            // 让动画反过来执行
            //            UIView.setAnimationRepeatAutoreverses(true)
            
            // 重复执行
            //            UIView.setAnimationRepeatCount(5)
            tipLabel.frame.origin.y = tipLabelHeight
            }) { (_) -> Void in
                
                UIView.animateWithDuration(duration, delay: 0.3, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    tipLabel.frame.origin.y = -20 - tipLabelHeight
                    }, completion: { (_) -> Void in
                        tipLabel.removeFromSuperview()
                })
        }
    }

    
=======
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
    
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
        
        // 当最后一个cell显示的时候来加载更多微博数据
        // 如果菊花正在显示,就表示正在加载数据,就不加载数据
        if indexPath.row == statuses!.count - 1 && !pullUpView.isAnimating() {
            // 菊花转起来
            pullUpView.startAnimating()
            
            // 上拉加载更多数据
            loadData()
        }

        
        
        
        return cell
        
    }
    
<<<<<<< HEAD
    //     MARK: - 懒加载
    /// 上拉加载更多数据显示的菊控制器
=======
    // MARK: - 懒加载
    /// 上拉加载更多数据显示的菊花
>>>>>>> ae99e3aeaeb811dee421f838c73163212442c343
    private lazy var pullUpView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        indicator.color = UIColor.magentaColor()
        
        return indicator
        }()

    
}
