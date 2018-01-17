//
//  SwipingController.swift
//  Autolayout_sample
//
//  Created by Hankho on 2018/1/15.
//  Copyright © 2018年 Hankho. All rights reserved.
//

import UIKit

class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "slot_HB", headerText: "HABANERO 遊戲", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our sotres soon."),
        Page(imageName: "slot_BNG", headerText: "BOOONGO 遊戲", bodyText: "Get notified of the saving immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(imageName: "slot_bbinFishHunter", headerText: "BBIN 捕魚達人", bodyText: "England and West Brom player Cyrille Regis played an integral role in dealing with racism in football."),
        Page(imageName: "slot_PT", headerText: "PLAYTECH 遊戲", bodyText: "Mild conditions this morning will disguise the bitter weather expected to hit parts of the UK later, forecasters warn.")
    ]
    
    //上一頁按鈕Layout & Action
    private let previousButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    //下一頁的按鈕Layout & Action
    private let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    //執行上一頁的function
    @objc private func handlePrev() {
        let foreIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: foreIndex, section: 0)
        pageControl.currentPage = foreIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //執行下一頁的function
    @objc private func handleNext() {
        //print("Trying ot advance to next")
        //pageControl.currentPage是從 0 開始
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //輪播的點點點
    //屬性使用 lazy 關鍵字延後屬性初始化時間
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = pages.count
        return pc
    }()
    
    //底下的 PageControl Layout
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton,pageControl,nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    //scroll 後得到資訊
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // 滑一下畫面計算出x座標 offset量
        let x = targetContentOffset.pointee.x
        
        // 因為滑一下offset 為一個螢幕寬，滑第二下offset 為兩個螢幕寬...依此類推，所以 offset / 螢幕寬 ＝ 第幾頁
        // 再把值塞進 pageControl.currentPage
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        
        collectionView?.backgroundColor = .white
        //註冊cell是我自己客製的的PageCell class
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
}
