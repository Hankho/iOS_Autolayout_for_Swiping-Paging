//
//  SwipingController+UICollectionView.swift
//  Autolayout_sample
//
//  Created by Hankho on 2018/1/17.
//  Copyright © 2018年 Hankho. All rights reserved.
//

import UIKit

extension SwipingController {
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //要幾個item
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    //
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        //index.item 從 0 開始count，所以搭配我的pages Array也是從index 0 開始
        let page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    //每一個item的size,需調用 UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }
}
