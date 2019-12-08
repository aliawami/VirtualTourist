//
//  Location++Extension.swift
//  VirtualTourist
//
//  Created by Ali Alawami on 11/1/19.
//  Copyright © 2019 alialawami. All rights reserved.
//

import Foundation
import CoreData


extension Location{
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.createdDate = Date()
    }
}
