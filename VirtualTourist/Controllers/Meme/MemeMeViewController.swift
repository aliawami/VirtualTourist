//
//  MemeMeViewController.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import CoreData

class MemeMeViewController: UIViewController {
    
    
    var dataController:DataController?
    
    
    
    //MARK: Properties
    var imageURL:URL!
    
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -1
    ]
    

    
    //MARK: Lables
    lazy var topTextField: UITextField = {
        let text = UITextField()
        text.text = "Top".uppercased()
        text.tag = 500
        text.textAlignment = .center
        text.defaultTextAttributes = self.memeTextAttributes
        text.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        
        text.delegate = self
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    lazy var bottomTextField: UITextField = {
        let text = UITextField()
        text.text = "Bottom".uppercased()
        text.tag = 501
        text.textAlignment = .center
        text.defaultTextAttributes = self.memeTextAttributes
        text.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        
        text.delegate = self
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()


    //MARK: Barbuttons
    lazy var cancelButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelMeme))
        barButton.tag = 200
        return barButton
    }()
    
    lazy var shareButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareMeme))
        barButton.tag = 201
        barButton.isEnabled = false
        return barButton
    }()
    
    
    lazy var imageDisplayer:UIImageView = {
        let displayImage = UIImageView()
        displayImage.contentMode = UIView.ContentMode.scaleAspectFit
        displayImage.backgroundColor = .black
        
        displayImage.translatesAutoresizingMaskIntoConstraints = false
        return displayImage
    }()
    
    
    
    
    

    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("URL is \(imageURL)")
        
        if let imageData = loadImageData(url: imageURL){
            imageDisplayer.image = UIImage(data: imageData)
        }
        
        
        customNavigation()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.keyboardNotification()
        
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.keyboardNoificationDismiss()
    }
    
    
    
    //MARK: ViewSetup
    func setupSubviews(){
       
        self.setupImageDisplayer()
        self.setupTextFields()
        
    }
    
    
 
    
    
    var imageDisplayerTopAncher:NSLayoutConstraint!
    func setupImageDisplayer() {
        self.view.addSubview(imageDisplayer)
        
        let margins = view!
        imageDisplayerTopAncher =  imageDisplayer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
            
            imageDisplayerTopAncher.isActive = true
        self.imageDisplayer.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        self.imageDisplayer.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        self.imageDisplayer.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        
        
    }
    
    func setupTextFields(){
        self.view.addSubview(topTextField)
        self.view.addSubview(bottomTextField)
        
        let margins = self.imageDisplayer
        self.topTextField.topAnchor.constraint(equalToSystemSpacingBelow: margins.topAnchor, multiplier: 4).isActive = true
        self.topTextField.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        
        
        margins.bottomAnchor.constraint(equalToSystemSpacingBelow: self.bottomTextField.bottomAnchor, multiplier: 4).isActive = true
        self.bottomTextField.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        
    }
    




}





