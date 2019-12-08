//
//  Memes++Extension.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 06/12/2019.
//  Copyright © 2019 alialawami. All rights reserved.
//

import CoreData

extension Memes{
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.creatingDate = Date()
    }
}

