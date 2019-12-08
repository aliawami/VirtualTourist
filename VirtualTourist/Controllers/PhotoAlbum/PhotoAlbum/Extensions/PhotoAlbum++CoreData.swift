//
//  PhotoAlbum++CoreData.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 11/1/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import CoreData
import UIKit

extension PhotoAlbum: NSFetchedResultsControllerDelegate{
    
    //MAKR: Fetch
    func fetchPhotos(){
        //Fetch Request
        let fetchRequest:NSFetchRequest<Photos> = Photos.fetchRequest()
        let sortDescriptorByDate = NSSortDescriptor(key: PhotosKeys.loadingDate.rawValue, ascending: true)
        let predicte = NSPredicate(format: "location == %@", location!)
        
        fetchRequest.sortDescriptors = [sortDescriptorByDate]
        fetchRequest.predicate = predicte
        
       
        photoFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController!.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        photoFetchedResultsController.delegate = self
        do{
            try photoFetchedResultsController.performFetch()
        }catch{
            alerting(with: error.localizedDescription)
        }
        if let sections = photoFetchedResultsController.sections{
            if sections.first!.numberOfObjects < 1{
                self.setupTextInformation()
                loadingNewCollection(pageNumber: 1)
            }
        }
        
    }
    
    //MARK:NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        if activityIndecator.isAnimating{
            activityIndecator.stopAnimating()
            reloadCollectionButton.isEnabled = true
            removeInformatvieLabel()
            
            let isFirstTime = UserDefaults.standard.bool(forKey: UserDefaultKeys.HasLaunchedBefore.rawValue)
            let firstVisit = UserDefaults.standard.bool(forKey: UserDefaultKeys.visitedPhotos.rawValue)
            if isFirstTime == true && firstVisit == false{
                alerting(with: "To delete Photo, \n Use Long Press")
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.visitedPhotos.rawValue)
            }
        }
        collectionView.reloadData()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else {return }
        switch type {
        case .insert:
            collectionView.insertItems(at: [indexPath])
        case .delete:
            collectionView.deleteItems(at: [indexPath])
        case .update:
            collectionView.reloadItems(at: [indexPath])
        case .move:
            collectionView.moveItem(at: indexPath, to: newIndexPath!)
        }
    }
    
    
    
    
    //MARK: Save Photos
    func addingPhotosToCodeData(photos:[FlickerPhoto]){
        DispatchQueue.global().sync {
            for photo in photos{
                let newPhoto = Photos(context: self.dataController!.viewContext)
                newPhoto.url = URL(string: photo.buildThumbnailURL())
                newPhoto.largeImageURL = URL(string: photo.buildURL())
                newPhoto.location = self.location!
                if let image = self.loadImageData(url: URL(string: photo.buildThumbnailURL())!){
                    newPhoto.image = image
                }
                self.dataController!.saveData()
            }
        }
    }
    
    
    //MAKR: Removing Photo
    func removingPhotoFromCoreData(indexPath: IndexPath){
        let photoToDelete = photoFetchedResultsController.object(at: indexPath)
         self.dataController!.viewContext.delete(photoToDelete)
        
    }
    
    
    
    
}
