//
//  MemeMeCollectionViewController++Delegate.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import CoreData

extension MemeMeCollectionViewController{
    
    


    
       // MARK: UICollectionViewDelegateFlowLayout
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MemeDisplayerViewController()
        let meme = memeFetchedResultsController.object(at: indexPath)
        vc.memeImage = UIImage(data: meme.meme!)
        navigationController?.pushViewController(vc, animated: true)
    }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           if isGrid{
               return grideCellDimension
           }else{
               return tableCellDimension
           }
       }
       
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return space
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return space
       }
    
    
    @objc func deletingMeme(sender:UILongPressGestureRecognizer){
        let cellIndexPath = collectionView.indexPathForItem(at: sender.view!.center)
        let cell = collectionView.cellForItem(at: cellIndexPath!)!
        
        switch sender.state {
        case .began:
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.4543850806)
        case .ended:
            cell.contentView.backgroundColor = .white
            removingMemeFromCoreData(indexPath: cellIndexPath!)
        case .cancelled, .failed:
            cell.contentView.backgroundColor = .white
        default:
            print("The state is \(sender.state)")
        }
    }
}
