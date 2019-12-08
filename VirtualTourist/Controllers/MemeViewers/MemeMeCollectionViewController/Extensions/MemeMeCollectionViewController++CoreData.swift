//
//  MemeMeCollectionViewController++CoreData.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import CoreData

extension MemeMeCollectionViewController:NSFetchedResultsControllerDelegate{
    //MAKR: Fetch
    func fetchPhotos(){
        //Fetch Request
        let fetchRequest:NSFetchRequest<Memes> = Memes.fetchRequest()
        let sortDescriptorByDate = NSSortDescriptor(key: MemesKeys.creatingDate.rawValue, ascending: true)
        
        
        fetchRequest.sortDescriptors = [sortDescriptorByDate]
        
        
        
        memeFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController!.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        memeFetchedResultsController.delegate = self
        
        do{
            try memeFetchedResultsController.performFetch()
        }catch{
            print(error.localizedDescription)
        }
        if let sections = memeFetchedResultsController.sections{
            if sections.first!.numberOfObjects < 1{
                 self.setupTextInformation()
                
            }
        }
        
    }
    
    //MARK:NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
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
    
    //MAKR: Removing Photo
    func removingMemeFromCoreData(indexPath: IndexPath){
        let photoToDelete = memeFetchedResultsController.object(at: indexPath)
        self.dataController!.viewContext.delete(photoToDelete)
        dataController!.saveData()
        
    }
    
}

