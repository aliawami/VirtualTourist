//
//  PhotoAlbum++UICollectionViewDataSource.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit


extension PhotoAlbum{
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoFetchedResultsController.sections?.count ?? 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoFetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PhotoCell
       let removingGesture = UILongPressGestureRecognizer(target: self, action: #selector(removingGesture(source:)))
       cell.addGestureRecognizer(removingGesture)
        let photo = photoFetchedResultsController.object(at: indexPath)
        if let image = photo.image {
            cell.photo.image = UIImage(data: image)
        }
        
        cell.setupView()
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! MapHeaderCell
        header.focusCenter = location
        header.setupView()
        
        return header
        
        
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoToMeme = photoFetchedResultsController.object(at: indexPath)
        let reciever = MemeMeViewController()
        reciever.dataController = dataController
        reciever.imageURL = photoToMeme.largeImageURL
        navigationController?.pushViewController(reciever, animated: true)
    }
    
    
    @objc func removingGesture(source: UILongPressGestureRecognizer){
        
        let cellIndextPath = collectionView.indexPathForItem(at: source.view!.center)
        let cell = collectionView.cellForItem(at: cellIndextPath!)!
        
        if source.state == UIGestureRecognizer.State.ended{
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cell.layer.zPosition = 3
                cell.transform = CGAffineTransform(translationX: 0, y: -cell.frame.height*2)
                cell.alpha = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.removingPhotoFromCoreData(indexPath: cellIndextPath!)
                })
            }) { (_) in
                
            }
            
        }
    }
    
}

