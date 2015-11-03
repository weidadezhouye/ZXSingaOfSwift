//
//  ZXPictureView.swift
//  ZXSingaSwift
//
//  Created by  周学明 on 15/11/1.
//  Copyright © 2015年  周学明. All rights reserved.
//

import UIKit
import SDWebImage

class ZXPictureView: UICollectionView {
    
    
//    MARK: - 属性
//    cell 的重用标示
    private let StatusPictureViewIdenttifer = "StatusPictureViewIdenttifer"
    
//    微博模型
    var status: ZXStatus?{
        didSet {
//            刷新数据
            reloadData()
        }
        
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return calcViewSize()
    }
    
    func calcViewSize() ->CGSize{
        
        let itemSize = CGSizeMake(90, 90)
        
//        设置itemSize
        layout.itemSize = itemSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
//        间距
        let margin:CGFloat = 10
//        列数
        let column = 3
        
//        根据模型来计算尺寸
        let count = status?.pictureURLs?.count ?? 0
        
        if count == 0{
            return CGSizeZero
        }
        if count == 1{
//            获取图片的url路径
            let urlStr = status!.pictureURLs![0].absoluteString
//            获取缓存图片
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(urlStr)
            var size = CGSizeMake(150, 120)
            if(image != nil)
            {
                size = image.size
            }
            layout.itemSize  = size
            return size
        }
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        
        if count == 4 {
            let width = 2 * itemSize.width + margin
            return CGSizeMake(width, width)
            
        }
//        剩下的就是直接流水布局下来就可以了
        let row = (count + column - 1) / column
        let width = (CGFloat(column) * itemSize.width) + (CGFloat(column)-1) * margin
        
        let height = (CGFloat(row) * itemSize.height) + (CGFloat(row) - 1) * margin
        
        return CGSizeMake(width, height)
        
        
    }
    
//    布局
    private var layout = UICollectionViewFlowLayout()
    
//    MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRectZero, collectionViewLayout: layout)
//        设置颜色
        backgroundColor = UIColor.clearColor()
        // 设置数据源
        dataSource = self
        
//        注册cell
        registerClass(ZXStatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureViewIdenttifer)
        
    }
    
}

// MARK： -扩展ZXPictureView，实现代理方法
extension ZXPictureView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.pictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(StatusPictureViewIdenttifer, forIndexPath: indexPath) as! ZXStatusPictureViewCell
        
        //        cell.backgroundColor = UIColor.randomColor()
        // 模型能直接提供图片的URL数组,外面使用就比较简单
        //        let url = status?.pic_urls?[indexPath.item]["thumbnail_pic"] as? String
        cell.imageUrl = status?.pictureURLs?[indexPath.item]
        
        return cell
    }

    
    
    
}


//MARK: - 自定义cell
class ZXStatusPictureViewCell:UICollectionViewCell{
    var imageUrl: NSURL? {
        didSet{
//            设置图片
            iconView.zx_setImageWithURL(imageUrl)
            
        }
    
    
    }
    
//    MARK: - 构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

   
    
    private func prepareUI(){
        
        contentView.addSubview(iconView)
        
        
        iconView.ff_Fill(contentView)
        
    }
    
   
//    MARK: - 懒加载
    private lazy var iconView :UIImageView = {
        let imageView = UIImageView()
//        设置图片的填充模式（使得效果更加好，用户体验增加）
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
}