//
//  MemeMeViewController++Actions.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit

extension MemeMeViewController{
    //Return all the views to their orgiginal state
    @objc func clearMeme(){
        //reset Everythink to original
        self.bottomTextField.text = "bottom".uppercased()
        self.topTextField.text = "top".uppercased()
        self.imageDisplayer.image = nil
        self.shareButton.isEnabled = false
        
        
    }
    
    @objc func cancelMeme(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    @objc func shareMeme(){
        let meme = saveMeme()
        let image = meme
        let activaity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activaity.excludedActivityTypes = [.postToTwitter,
                                           .postToFlickr,
                                           .postToFacebook,
                                           .postToWeibo,]
        activaity.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed{
                self.cancelMeme()
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        present(activaity, animated: true, completion: nil)
        
    }
    
    
    func saveMeme()->UIImage{
        var topText = ""
        var bottomText = ""
        let originalImage = imageDisplayer.image!
        
        if topTextField.text != "TOP"{
            topText = topTextField.text ?? ""
        }
        
        if bottomTextField.text != "BOTTOM"{
            bottomText = bottomTextField.text ?? ""
        }
        
        let memeImage = generateMemedImage()
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memeImage)
        
        addingMemeToCoreData(meme: meme)
        dataController!.saveData()
        
        return memeImage
        
    }
    
    
    
    func generateMemedImage() -> UIImage {
        
        if topTextField.text == "TOP"{
            topTextField.text = ""
        }
        
        if bottomTextField.text == "BOTTOM"{
            bottomTextField.text = ""
        }
        
        imageDisplayerTopAncher.isActive = false
        imageDisplayerTopAncher = imageDisplayer.topAnchor.constraint(equalTo: view.topAnchor)
        imageDisplayerTopAncher.isActive = true
        navigationController?.navigationBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        navigationController?.navigationBar.isHidden = false
        imageDisplayerTopAncher.isActive = false
        imageDisplayerTopAncher = imageDisplayer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        imageDisplayerTopAncher.isActive = true
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        return memedImage
    }
    
    
    func loadImageData(url:URL)->Data?{
        do{
            let imageData = try Data(contentsOf: url)
            return imageData
        }catch{
            // self.alerting(with: error.localizedDescription)
            return nil
        }
    }
    
}
