//
//  User.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import Foundation

class User{
    
    var uid: String?
    var name: String?
    var email: String?
    
    class func signIn (uid: String){
        //storing the uid of the person in the phone's default settings.
        NSUserDefaults.standardUserDefaults().setValue(uid, forKeyPath: "uid")
        
    }
}


