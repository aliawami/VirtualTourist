//
//  MapHeaderCell.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import MapKit



class MapHeaderCell:UICollectionViewCell, MKMapViewDelegate{
    //MARK: Subviews
    private let pinID = "Pin"
    var focusCenter:Location?
    var coordinate:CLLocationCoordinate2D!
    lazy var locationMap: MKMapView = {
        let map = MKMapView(frame: .zero)
        
        map.delegate = self
        map.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: pinID)
        map.isUserInteractionEnabled = false
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
        
    }()
    
    
    //MARK: CellViewSetup
    func setupView(){
        self.clipsToBounds = true
        if let focusCenter = focusCenter{
            coordinate = CLLocationCoordinate2D(latitude: focusCenter.latitude, longitude: focusCenter.longitude)
            let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            locationMap.setRegion(coordinateRegion, animated: true)
            setupAnnotations()
        }
        
        self.addSubview(locationMap)
        
        let margins = self
        locationMap.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        locationMap.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        locationMap.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        locationMap.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        
    }
    
    
    //MARK: MAP Annotation
    
    func setupAnnotations(){
        
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        annotations.append(annotation)
        
        locationMap.addAnnotations(annotations)
        locationMap.reloadInputViews()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: pinID, for: annotation) as? MKPinAnnotationView
        
        if let pinView = pinView {
            pinView.annotation = annotation
        }else{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinID)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
        }
        
        return pinView
    }
    
    
}

