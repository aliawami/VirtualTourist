//
//  MemeMeViewController++CoreData.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit
import CoreData

extension MemeMeViewController{
    
    
       //MARK: Save Photos
       func addingMemeToCoreData(meme:Meme){
           guard let dataController = dataController else{
               print("Data controller is nil")
               return
           }
           DispatchQueue.global().sync {
               
               
               let newMeme = Memes(context: dataController.viewContext)
               newMeme.topText = meme.topText
               newMeme.bottomText = meme.bottomText
               newMeme.originalImageURL = imageURL
               newMeme.meme = meme.memedImage.jpegData(compressionQuality: 1.0)
               
               self.dataController!.saveData()
               
           }
       }
       
}
