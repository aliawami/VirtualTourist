//
//  NetworkConnection.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 28/10/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation

class NetworkConnection{
    
    //MARK: GET Request
    //In order to retrive data from Server with JSON decoded object, URL must be provided
    func GETRequestMethod<ResponseType:Decodable>(url: URL, respondType: ResponseType.Type, completion: @escaping (ResponseType?, Error?)->()){
        let urlRequest = URLRequest(url: url)
        sessionParsing(urlRequest: urlRequest, responseType: ResponseType.self, completion: { (result, error) in
            if let result = result{
                completion(result, nil)
            }else{
                completion(nil, error!)
            }
        })
    }
    
    
    
    func sessionParsing<ResponseType:Decodable>(urlRequest:URLRequest, responseType: ResponseType.Type, completion:@escaping (ResponseType?, Error?)->()){
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else{ completion(nil, error)
                return
            }

            let decoder = JSONDecoder()
            do{
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            }catch{
                completion(nil, error)
            }
            
        }
        
        task.resume()
        
    }
}
