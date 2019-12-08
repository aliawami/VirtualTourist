//
//  MemeCollectionViewCell.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//


import UIKit


class MemeCollectionViewCell:UICollectionViewCell{
    //MARK: Subviews
    //Cell image
    lazy var memeImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.backgroundColor = .clear
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    //MARK: CellViewSetup
    func setupView(image:Data){
        self.backgroundColor = .white
        self.memeImage.image = UIImage(data:image)
        self.addSubview(memeImage)
        self.clipsToBounds = true
        
        //Layout
        let margins  = self.safeAreaLayoutGuide
        
        memeImage.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        memeImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        memeImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        memeImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
    }

    
    
}



