//
//  AppDelegate.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 10/25/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    

    var window: UIWindow?


    let dataController = DataController(modelName: "VirualTourcist")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        dataController.load()
        let vc = TravelLocationMapViewController()
        vc.dataController = dataController
        
        let nav = UINavigationController(rootViewController: vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = nav
        
        
        return true
    }
    
    
    func checkIfFirestLaunch(){
        if UserDefaults.standard.bool(forKey: UserDefaultKeys.HasLaunchedBefore.rawValue){
            print("Not the first time")
        }else{
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.HasLaunchedBefore.rawValue)
            UserDefaults.standard.set(0.0, forKey: UserDefaultKeys.lastLatitude.rawValue)
            UserDefaults.standard.set(0.0, forKey: UserDefaultKeys.lastLongitude.rawValue)
            UserDefaults.standard.set(0.0, forKey: UserDefaultKeys.longitudinalMeters.rawValue)
            UserDefaults.standard.set(0.0, forKey: UserDefaultKeys.latitudinalMeters.rawValue)
            UserDefaults.standard.set(false, forKey: UserDefaultKeys.visitedPhotos.rawValue)
            UserDefaults.standard.set(false, forKey: UserDefaultKeys.visitedMeme.rawValue)
            
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        dataController.saveData()
        
    }
  
    func applicationWillTerminate(_ application: UIApplication) {
        dataController.saveData()
    }
    



}

