//
//  TravelLocationMapViewController.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 10/25/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class TravelLocationMapViewController: UIViewController , MKMapViewDelegate {
    
    internal let pinID = "Pin"
    
    var userAnnotations = [Location]()
    var maplatitude:Double!
    var dataController:DataController?

    lazy var travelingMap: MKMapView = {
        let map = MKMapView(frame: .zero)
        
        map.delegate = self
        map.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: pinID)
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(droppingPin(recongizer:)))
        map.addGestureRecognizer(pressGesture)
        map.isZoomEnabled = true
        map.isPitchEnabled = true
        map.isScrollEnabled = true
        map.isRotateEnabled = true
        
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
        
    }()
    
    lazy var memeButton:UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Memes", style: UIBarButtonItem.Style.plain, target: self, action: #selector(displayMemes))
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupMapView()
        navigateToLastCenter()
        navigationItem.rightBarButtonItem = memeButton
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocations()
        setupAnnotations()
        
    }
    
    @objc func displayMemes(){
        let vc = MemeMeCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.dataController = dataController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

    
    func navigateToLastCenter(){
        let long = UserDefaults.standard.double(forKey: UserDefaultKeys.lastLongitude.rawValue)
        let lat = UserDefaults.standard.double(forKey: UserDefaultKeys.lastLatitude.rawValue)
        
        let longDelta = UserDefaults.standard.double(forKey: UserDefaultKeys.longitudinalMeters.rawValue)
        let latDelta = UserDefaults.standard.double(forKey: UserDefaultKeys.latitudinalMeters.rawValue)
        
        
        if long != 0.0 && lat != 0.0{
            let coordentate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            let region = MKCoordinateRegion(center: coordentate, span: span)
            travelingMap.setRegion(region, animated: true)
            
        }
    }
    
    

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.region.center
        let coordenaterInMeters = mapView.region.span
        UserDefaults.standard.set(center.latitude, forKey: UserDefaultKeys.lastLatitude.rawValue)
        UserDefaults.standard.set(center.longitude, forKey: UserDefaultKeys.lastLongitude.rawValue)
        UserDefaults.standard.set(coordenaterInMeters.latitudeDelta, forKey: UserDefaultKeys.latitudinalMeters.rawValue)
        UserDefaults.standard.set(coordenaterInMeters.longitudeDelta, forKey: UserDefaultKeys.longitudinalMeters.rawValue)
    }
    
    
    //MARK: View Setting
    private func setupMapView(){
        self.view.addSubview(travelingMap)
        let margins = self.view!
        travelingMap.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        travelingMap.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        travelingMap.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        travelingMap.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
    
    
    //MARK: Gesturs
    @objc func droppingPin(recongizer :UILongPressGestureRecognizer){
        switch recongizer.state{
        case .ended, .changed:
            let location = recongizer.location(in: travelingMap)
            let coordentate = travelingMap.convert(location, toCoordinateFrom: travelingMap)
            saveLocationToCodeData(location: coordentate)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigateToPhotoGallery(location: self.userAnnotations.first!)
            }
            
        default:
            print(recongizer.state)
        }
        
    }
    
    func navigateToPhotoGallery(location: Location){
        let vc = PhotoAlbum(collectionViewLayout:UICollectionViewFlowLayout())
        vc.dataController = self.dataController
        vc.location = location
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    

    

}
