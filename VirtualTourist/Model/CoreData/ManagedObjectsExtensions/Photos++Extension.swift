//
//  Photos++Externsion.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 11/1/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation
import CoreData


extension Photos{
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.loadingDate = Date()
    }
}
