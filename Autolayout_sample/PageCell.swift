//
//  PageCell.swift
//  Autolayout_sample
//
//  Created by Hankho on 2018/1/15.
//  Copyright © 2018年 Hankho. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        //didSet 是指我們需要page改變後，做以下這些事
        didSet {
            //unwrappedPage防呆如果page有空值
            guard let unwrappedPage = page else { return }
            HBimageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string:unwrappedPage.headerText, attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string:"\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textColor = .white
            descriptionTextView.textAlignment = .center
        }
    }
    //圖片
    private let HBimageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "slot_HB"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    //段落文字
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.black
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    //初始畫面
    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout()
    }
    
    private func setupLayout() {
        
        //HB遊戲圖layout
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        
        //enable auto layout
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.addSubview(HBimageView)
        HBimageView.centerXAnchor.constraint(equalTo:topImageContainerView.centerXAnchor).isActive = true
        HBimageView.centerYAnchor.constraint(equalTo:topImageContainerView.centerYAnchor).isActive = true
        HBimageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        addSubview(descriptionTextView)
        
        //文字layout
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant:24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant:-24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    //
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
