//
//  MemeMeViewController++Navigation.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import UIKit

extension MemeMeViewController{
    func customNavigation(){

        navigationItem.leftBarButtonItems?.insert(cancelButton, at: navigationItem.leftBarButtonItems!.count-1)
        self.navigationItem.rightBarButtonItem = shareButton
        
    }
    
}
