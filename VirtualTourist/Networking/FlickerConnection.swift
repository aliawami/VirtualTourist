//
//  FlickerConnection.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation


 


class FlickrAPI{
    
    static let apiKey = "b7d8e59404870309a66adf6109d8b98e"
    
    
    enum Endpoint{
        case search(lat:String, long:String)
        
        static let sheme = "https"
        static let host = "www.flickr.com"
        static let path = "/services/rest/"
        static let method = "method"
        static let searchingMethod = "flickr.photos.search"
        static let apikey = "api_key"
        static let lat = "lat"
        static let long = "lon"
        static let format = "format"
        static let jsonFormat = "json"
        static let noJson = "nojsoncallback"
        static let callBack = 1
        
        var urlString:String{
            var urlComponent = URLComponents()
            urlComponent.scheme = Endpoint.sheme
            urlComponent.host = Endpoint.host
            urlComponent.path = Endpoint.path
            
            switch self {
            //case .search(let lat, let long, let pageNumber):
            case .search(let lat, let long):
                var queryCollection = [URLQueryItem]()
                let method = URLQueryItem(name: Endpoint.method, value: Endpoint.searchingMethod)
                let key = URLQueryItem(name: Endpoint.apikey, value: FlickrAPI.apiKey)
                let late = URLQueryItem(name: Endpoint.lat, value: lat)
                let lon = URLQueryItem(name: Endpoint.long, value: long)
                let format = URLQueryItem(name: Endpoint.format, value: Endpoint.jsonFormat)
                let callBack = URLQueryItem(name: Endpoint.noJson, value: "\(Endpoint.callBack)")
                
                queryCollection = [method, key, late, lon ,format, callBack]
                urlComponent.queryItems = queryCollection
            }

            return urlComponent.string!
        }
        
        var url:URL{
            return URL(string: urlString)!
        }
        
    }
    
    
    
    func newSearch(url:URL, completions: @escaping (FlickerResponseDetails?,[FlickerPhoto]?, Error?)->Void){
        let networkConnection = NetworkConnection()
        networkConnection.GETRequestMethod(url: url, respondType: FlickerRepsonse.self) { (photos, error) in
            if let error = error{
                completions(nil,nil, error)
            }else{
                var photosURL = [String]()
                let images = photos!.photos.photo
                for image in images{
                    photosURL.append(image.buildURL())
                }
                completions(photos!.photos,images, nil)
            }
        }
                
    }

    
}
