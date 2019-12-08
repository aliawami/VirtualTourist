//
//  DataController.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 10/30/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation
import CoreData


class DataController{
    let persistentContainer:NSPersistentContainer
    
    //View Context
    var viewContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    init(modelName:String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    //Load PersistentStore
    
    func load(completion: (()->Void)? = nil){
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            
        }
    }
    
    func saveData(){
        try? viewContext.save()
    }
    
    
    
    
}
