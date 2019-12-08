//
//  MemeDisplayerViewController.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit

class MemeDisplayerViewController: UIViewController {
    
    var memeImage:UIImage?
    
    lazy var memeImageViewer:UIImageView = {
        let displayImage = UIImageView()
        displayImage.contentMode = UIView.ContentMode.scaleAspectFit
        displayImage.backgroundColor = .black
        
        displayImage.translatesAutoresizingMaskIntoConstraints = false
        return displayImage
    }()
    
    lazy var shareButton:UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(shareMeme))
        barButton.isEnabled = false
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let memeImage = memeImage{
            memeImageViewer.image = memeImage
            setupMemeImageView()
            shareButton.isEnabled = true
        }else{
            navigationController?.popViewController(animated: true)
        }

    }
    
    
    func setupMemeImageView(){
        view.addSubview(memeImageViewer)
        let margins = self.view.safeAreaLayoutGuide
        memeImageViewer.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        memeImageViewer.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        memeImageViewer.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        memeImageViewer.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    }
    
    
    @objc func shareMeme(){
        let image = memeImage!
        let activaity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activaity.excludedActivityTypes = [.postToTwitter,
                                           .postToFlickr,
                                           .postToFacebook,
                                           .postToWeibo,]
        activaity.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed{
                
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        present(activaity, animated: true, completion: nil)
    }
}
