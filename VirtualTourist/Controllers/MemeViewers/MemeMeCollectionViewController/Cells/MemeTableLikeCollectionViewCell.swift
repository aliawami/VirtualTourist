//
//  MemeTableLikeCollectionViewCell.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//


import UIKit

class MemeTableLikeCollectionViewCell: UICollectionViewCell {
    
    lazy var memeImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.backgroundColor = .clear
        
        
        
        return imageView
    }()
    
    lazy var memeLabel:UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .black
        label.lineBreakMode = .byClipping
        label.autoresizesSubviews = true
        label.numberOfLines = 0
        
        
        return label
    }()
    
    var memCellStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 3
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    func setupCellView(meme: Memes){
        backgroundColor = .white
        clipsToBounds = true
        
        memeImage.image = UIImage(data: meme.meme!)
        memeLabel.text = "\(meme.topText ?? "")...\(meme.bottomText ?? "")"
        memCellStack.addArrangedSubview(memeImage)
        memCellStack.addArrangedSubview(memeLabel)
        
        
        addSubview(memCellStack)
        let margins = safeAreaLayoutGuide
        memCellStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        memCellStack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        memCellStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        memCellStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    
    
}

