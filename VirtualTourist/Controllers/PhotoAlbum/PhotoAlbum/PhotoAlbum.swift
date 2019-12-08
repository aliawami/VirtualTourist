//
//  PhotoAlbum.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import MapKit
import CoreData



class PhotoAlbum: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    
    //Cell IDs
    internal let cellID = "Cell"
    internal let headerID = "Header"
    internal let footerID = "Footer"
    internal var inCreationState = false
    var displayingText = false
    var pageNumber = 1
    var numberOfPage = 1
    
    //Data collection
    
    var location:Location?
    internal var spacing:CGFloat = 3
    var selectedLocation:CLLocationCoordinate2D?
    
    
    var dataController:DataController?
    var photoFetchedResultsController:NSFetchedResultsController<Photos>!
    
    //View
    lazy var reloadCollectionButton:UIButton = {
        let button = UIButton()
        button.setTitle("Update Collection", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.setTitle("Loading Collection", for: UIControl.State.disabled)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: UIControl.State.disabled)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        button.addTarget(self, action: #selector(updateCollection), for: UIControl.Event.touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var noImageLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "No Images"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityIndecator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        activity.hidesWhenStopped = true
        
        
        return activity
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        collectionView.clipsToBounds = false
        collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: cellID)
        collectionView!.register(MapHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        setupReloadButton()
        fetchPhotos()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        location!.photoCount = Int16(photoFetchedResultsController.sections!.first!.numberOfObjects)
    }
    
    //MAKR: Networking
    
    //Download data from Fliker, If the album is empty = collection of images names
    //Update Data from Fliker, when creating a new Album == collection of image names
    func loadingPhotoCollection(lat:Double, long: Double){
        inCreationState = true
        let flickerAPi = FlickrAPI()
        let url = FlickrAPI.Endpoint.search(lat: "\(lat)", long: "\(long)").url
        flickerAPi.newSearch(url: url){ ( flickrRespose,photos, error) in
            if let error = error{
                DispatchQueue.main.async {
                    self.alerting(with:"The error was \(error) ")
                }
            }else{
                DispatchQueue.main.async {
                    
                    if self.collectionView.subviews.contains(self.noImageLabel){
                        self.noImageLabel.text = "Loading \(flickrRespose!.total) image )"
                    }
                }
                guard let photos = photos else{ return }
                if photos.count == 0{
                    DispatchQueue.main.async {
                        if self.collectionView.subviews.contains(self.noImageLabel){
                            self.noImageLabel.text = "Could not fine images"
                        }
                    }
                }else{
                    self.addingPhotosToCodeData(photos: photos)
                    
                }
                
            }
            
        }
    }
    
    
    func loadImageData(url:URL)->Data?{
        do{
            let imageData = try Data(contentsOf: url)
            return imageData
        }catch{
            self.alerting(with: error.localizedDescription)
            return nil
        }
    }


    
    
    //Loading Status
    func loadingNewCollection(pageNumber: Int){
        guard let location = location else { return }
        noImageLabel.text = "Collecting Photos from Flickr"
        loadingPhotoCollection(lat: location.latitude, long: location.longitude)
        //Start Activity Indecator
        activityIndecator.frame = collectionView.frame
        collectionView.addSubview(activityIndecator)
        activityIndecator.startAnimating()
        //Disable View Actions
        reloadCollectionButton.isEnabled = false
        
    }
    
        
    
    func setupTextInformation(){
        displayingText = true
        collectionView.addSubview(noImageLabel)
        let margin = collectionView.layoutMarginsGuide
        noImageLabel.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        noImageLabel.centerYAnchor.constraint(equalTo: margin.centerYAnchor).isActive = true
    }
    
    
    
    func setupReloadButton(){
        collectionView.addSubview(reloadCollectionButton)
        let margin = collectionView.layoutMarginsGuide
        reloadCollectionButton.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        reloadCollectionButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        reloadCollectionButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
    }
    
    
    @objc func updateCollection(){
                let items = self.photoFetchedResultsController.sections!.first!.objects as? [Photos]
                for item in items!{
                    self.dataController!.viewContext.delete(item)
                }
                self.fetchPhotos()
    }
    
    
    func alerting(with message:String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func removeInformatvieLabel(){
        if self.collectionView.subviews.contains(noImageLabel){
            noImageLabel.removeFromSuperview()
        }
    }
    
    
}


