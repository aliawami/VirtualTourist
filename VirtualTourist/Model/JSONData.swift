//
//  JSONData.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation


struct FlickerPhoto: Codable{
    var id:String
    var owner:String
    var secret:String
    var server:String
    var farm:Int
    var title:String
    
    func buildThumbnailURL()->String{
        let url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_t.jpg"
        return url
    }
    
    func buildURL()->String{
        let url = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
        return url
    }
    
}

struct FlickerRepsonse:Codable{
    var photos:FlickerResponseDetails
}


struct FlickerResponseDetails:Codable{
    var page:Int
    var pages:Int
    var perpage:Int
    var total:String
    var photo:[FlickerPhoto]
}

