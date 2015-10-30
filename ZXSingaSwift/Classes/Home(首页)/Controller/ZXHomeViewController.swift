//
//  ZXHomeViewController.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/10/27.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXHomeViewController: ZXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.navgationItem("navigationbar_pop")
        
        
        
        
        
           }

}
