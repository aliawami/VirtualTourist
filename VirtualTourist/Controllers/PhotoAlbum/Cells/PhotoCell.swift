//
//  PhotoCell.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit



class PhotoCell:UICollectionViewCell{
    //MARK: Subviews
    //Cell Label
    lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: CellViewSetup
    func setupView(){
        
        self.clipsToBounds = true
        
        //Layout
        self.addSubview(photo)
        let margins  = self.safeAreaLayoutGuide
        
        photo.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
    }
}

