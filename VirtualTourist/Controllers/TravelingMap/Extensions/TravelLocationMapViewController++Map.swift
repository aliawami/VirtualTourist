//
//  TravelLocationMapViewController++Map.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 11/1/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension TravelLocationMapViewController{
    //MARK: MAP Annotation
    
    func setupAnnotations(){
        if userAnnotations.count == 0{
            return
        }
        
        var annotations = [MKPointAnnotation]()
        
        for location in userAnnotations{
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        
        travelingMap.addAnnotations(annotations)
        travelingMap.reloadInputViews()
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pinID, for: annotation) as? MKPinAnnotationView
        
        if let pinView = pinView {
            pinView.annotation = annotation
        }else{
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinID)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
 
        }
        
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var searchLocation:Location?
        let coordentat = view.annotation!.coordinate
        for loc in userAnnotations{
            if loc.latitude == coordentat.latitude  && loc.longitude == coordentat.longitude{
                searchLocation = loc
                navigateToPhotoGallery(location: searchLocation!)
            }
        }
    }
    
    
}
