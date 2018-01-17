//
//  SwipingController+extension.swift
//  Autolayout_sample
//
//  Created by Hankho on 2018/1/17.
//  Copyright © 2018年 Hankho. All rights reserved.
//

import UIKit

extension SwipingController {
    // 修正橫屏豎屏互換screensize問題
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // animate(alongsideTransition:completion:)
        // Runs the specified animations at the same time as the view controller transition animations.
        coordinator.animate(alongsideTransition: { (_) in
            // 更新布局对象，此方法会强制生成新layout
            self.collectionViewLayout.invalidateLayout()
            // 除了第一頁有位移所以要在做offset調整，其他頁面正常
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
}
