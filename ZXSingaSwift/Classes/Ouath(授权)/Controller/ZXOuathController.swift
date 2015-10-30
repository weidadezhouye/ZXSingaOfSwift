//
//  ZXOuathController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/28.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import SVProgressHUD

class ZXOuathController: UIViewController {
    
   override func loadView() {
        view = webView
//    设置代理
    webView.delegate = self
    
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "新浪微博"
        
        
        print("xxxxx")
        
//        加载页面
        let request = NSURLRequest(URL: ZXNTWorking.sharedInstance.oauthRUL())
        webView.loadRequest(request)
        
        
        
//     创建取消按钮，并且监听她的点击事件
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelBtnClick")
        
//        view.backgroundColor = UIColor.brownColor()
        
    }
//    监听取消按钮的点击事件
    func cancelBtnClick(){
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion:nil)
        
    }
    
    
//    MARK: - 懒加载webview
    private lazy var webView = UIWebView()
    

}

extension ZXOuathController: UIWebViewDelegate {
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showWithStatus("哥正在玩命帮你加载...", maskType: SVProgressHUDMaskType.Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL!.absoluteString
        //        加载的不是回调地址
        if !urlString.hasPrefix(ZXNTWorking.sharedInstance.redirect_uri){
            return true
        }
//      如果点击确定或者取消拦截不加载
        if let query = request.URL?.query {
            print("query:\(query)")
            let codeString = "code="
            if query.hasPrefix(codeString)
            {
                let nsQuery = query as NSString
                
                let code = nsQuery.substringFromIndex(codeString.characters.count)
                
                print("code : \(code)")
//                获取 AccessToken
                loadAccessToken(code)
            }else{
//                取消
                
            }
            
        }
        return false
    }
    
//    调用网络工具加载access token
    func loadAccessToken(code:String) {
        ZXNTWorking.sharedInstance.loadAccessToken(code) { (result, error) -> () in
            if error != nil || result == nil {
//                SVProgressHUD.showErrorWithStatus("网络不给力。。。", maskType: SVProgressHUDMaskType.Black)
////                延迟关闭
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(Int64)(NSEC_PER_SEC*1)), dispatch_get_main_queue(), { () -> Void in
//                    self.cancelBtnClick()
//                })
                self.netError("网络不给力...")
                return
            }
          print("result : \(result)")
            
//            保存数据
            let account = ZXUserAccount(dict: result!)
//            保存在沙盒
            account.saveAccount()
            
            // 加载用户数据
            account.loadUserInfo({ (error) -> () in
                if error != nil {
                    self.netError("加载用户数据出错...")
                    return
                }
                
                print("account:\(ZXUserAccount.loadAccount())")
                self.cancelBtnClick()
                
                // 切换控制器
                (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootViewController(false)
            })

        }
        
    }
    
    private func netError(message: String) {
        SVProgressHUD.showErrorWithStatus(message, maskType: SVProgressHUDMaskType.Black)
        
        // 延迟关闭. dispatch_after 没有提示,可以拖oc的dispatch_after来修改
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
            self.cancelBtnClick()
        })
    }
    
}



