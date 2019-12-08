//
//  MemeMeCollectionViewController++DataSource.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import CoreData

extension MemeMeCollectionViewController{
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return memeFetchedResultsController.sections?.count ?? 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeFetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memeFetchedResultsController.object(at: indexPath)
        let deletingGestur = UILongPressGestureRecognizer(target: self, action: #selector(deletingMeme(sender:)))
        deletingGestur.allowableMovement = 0.0
        if isGrid{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCell, for: indexPath) as! MemeCollectionViewCell
            cell.addGestureRecognizer(deletingGestur)
            
            cell.setupView(image: meme.meme!)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tableCell, for: indexPath) as! MemeTableLikeCollectionViewCell
            cell.addGestureRecognizer(deletingGestur)
            cell.setupCellView(meme:meme)
            return cell
        }
    }
    
    
}
