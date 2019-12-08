//
//  TravelLocationMapViewController+++CoreData.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 11/1/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation
import CoreData
import MapKit
import UIKit


extension TravelLocationMapViewController{
    
    //MARK: DataController
    
    func fetchLocations(){
        //Fetch Locations
        let fetchRequest:NSFetchRequest<Location> = Location.fetchRequest()
        do{
            let request = try dataController!.viewContext.fetch(fetchRequest)
            userAnnotations = request
            travelingMap.reloadInputViews()
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    

    
    //Save Location
    func saveLocationToCodeData(location: CLLocationCoordinate2D){
        DispatchQueue.global().sync {
            
            let newLocation = Location(context: dataController!.viewContext)
            newLocation.latitude = location.latitude
            newLocation.longitude = location.longitude
            
            self.userAnnotations.insert(newLocation, at: 0)
            
        }
    }
  
}
