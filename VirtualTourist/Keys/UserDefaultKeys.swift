//
//  UserDefaultKeys.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 10/25/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation


enum UserDefaultKeys:String{
    case HasLaunchedBefore
    case lastLongitude
    case lastLatitude
    case longitudinalMeters
    case latitudinalMeters
    case visitedPhotos
    case visitedMeme
    
}


enum LocationKeys:String{
    case createdDate  // Type Date
    case latitude     // Type Double
    case longitude    // Type Double 
}


enum PhotosKeys:String{
    case loadingDate // Type Date
    case url         // Type URL
}

enum MemesKeys:String{
    case creatingDate, buttomText, meme, originalImageURL, topText
}

