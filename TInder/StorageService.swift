//
//  StorageService.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import Foundation
import FirebaseStorage

struct StorageService {
    static let storageRefName="gs://tinderclone-b880c.appspot.com"
    static let storage = FIRStorage.storage()
    static let storageRef = storage.referenceForURL(storageRefName)
    
    
}
