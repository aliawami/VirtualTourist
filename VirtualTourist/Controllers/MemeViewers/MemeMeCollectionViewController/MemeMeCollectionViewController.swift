//
//  MemeMeCollectionViewController.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//


import UIKit
import CoreData


class MemeMeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //Cell IDs
    internal let gridCell = "GridCell"
    internal let tableCell = "TableCell"
    
    //Sizing cells
    let space:CGFloat = 3.0
    var grideCellDimension:CGSize{
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        return CGSize(width: dimension, height: dimension)
    }
    
    var tableCellDimension:CGSize{
        let marginFrame = view.layoutMarginsGuide.layoutFrame
        return CGSize(width: marginFrame.width, height: marginFrame.width/3.0)
    }
    
    
    //Data collection
    var dataController:DataController!
    var memeFetchedResultsController:NSFetchedResultsController<Memes>!
    var isGrid = false
    var displayingText = false
    
    
    //MARK: SubViews
    lazy var noImageLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "No Images"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    lazy var segment:UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(with: UIImage(named: "table"), at: 0, animated: true)
        segmented.insertSegment(with: UIImage(named: "collection"), at: 1, animated: true)
        segmented.isMomentary = true
        segmented.addTarget(self, action: #selector(switchCollectionView(sender:)), for: UIControl.Event.valueChanged)
        if #available(iOS 13.0, *) {
            segmented.selectedSegmentTintColor = .lightGray
        }
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        collectionView!.register(MemeTableLikeCollectionViewCell.self, forCellWithReuseIdentifier: tableCell)
        collectionView!.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: gridCell)
        collectionView!.delegate = self
        fetchPhotos()
        setupSegmentView()
        navigationItem.title = "Memes"
        
        let isFirstTime = UserDefaults.standard.bool(forKey: UserDefaultKeys.HasLaunchedBefore.rawValue)
        let firstVisit = UserDefaults.standard.bool(forKey: UserDefaultKeys.visitedMeme.rawValue)
        if isFirstTime == true && firstVisit == false{
            alerting(with: "To delete Meme, \n Use Long Press")
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.visitedMeme.rawValue)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeInformatvieLabel()
    }
    
    
  
    //MARK: Actions
    func alerting(with message:String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                alertController.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    
    
    func setupTextInformation(){
        displayingText = true
        collectionView.addSubview(noImageLabel)
        let margin = collectionView.layoutMarginsGuide
        noImageLabel.centerXAnchor.constraint(equalTo: margin.centerXAnchor).isActive = true
        noImageLabel.centerYAnchor.constraint(equalTo: margin.centerYAnchor).isActive = true
    }
    
    func removeInformatvieLabel(){
        if self.collectionView.subviews.contains(noImageLabel){
            noImageLabel.removeFromSuperview()
        }
    }
    
    
    func setupSegmentView(){
        let margin = collectionView.layoutMarginsGuide
        collectionView.addSubview(segment)
        
        segment.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        segment.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        segment.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        segment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        
        
    }
    
    
    
    @objc func switchCollectionView(sender: UISegmentedControl){
        print("The selected semented Inext is \(sender.selectedSegmentIndex)")
           if sender.selectedSegmentIndex == 0{
               if isGrid{
                   isGrid = false
                   collectionView.reloadData()
               }
           }else if sender.selectedSegmentIndex == 1{
               if isGrid == false{
                   isGrid = true
                   collectionView.reloadData()
               }
           }
           
       }
    
    
    
       
    
    
   
    
    
    
}






