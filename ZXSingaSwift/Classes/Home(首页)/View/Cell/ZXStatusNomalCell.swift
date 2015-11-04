//
//  ZXStatusNomalCell.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/1.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit

class ZXStatusNomalCell: ZXStatusCell {

    
   override func prepareUI() {
    
    super.prepareUI()
    
    
    let clons = pictureView.ff_AlignVertical(type: ff_AlignType.BottomLeft, referView: contentLabel, size: CGSizeMake(0, 0), offset: CGPointMake(0, 8))
    
    pictureViewWidthCon = pictureView.ff_Constraint(clons, attribute: NSLayoutAttribute.Width)
    pictureViewHeightCon = pictureView.ff_Constraint(clons, attribute: NSLayoutAttribute.Height)
    
    
    
        
    }
    
    

}
