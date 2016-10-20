//
//  User.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class User{
    
    var uid: String?
    var name: String?
    var email: String?
    var age: Int?
    var gender: String?
    var description: String?
    var photoURL: String?
    
    init?(snapshot: FIRDataSnapshot){
        
        self.uid = snapshot.key
        
        guard let dict = snapshot.value as? [String: AnyObject] else { return nil }
        
        if let dictUsername = dict["username"] as? String{
            self.name = dictUsername
        }else{
            self.name = ""
        }
        if let dictEmail = dict["email"] as? String{
            self.email = dictEmail
        }else{
            self.email = ""
        }
        if let dictAge = dict["age"] as? Int{
            self.age = dictAge
        }else{
            self.age = 0
        }
        if let dictGender = dict["gender"] as? String{
            self.gender = dictGender
        }else{
            self.gender = ""
        }
        if let dictDescription = dict["description"] as? String{
            self.description = dictDescription
        }else{
            self.description = ""
        }
        if let dictPhotoURL = dict["profile_photo"] as? String{
            self.photoURL = dictPhotoURL
        }else{
            self.photoURL = ""
        }
        
    }

    
    
    class func signIn (uid: String){
        //storing the uid of the person in the phone's default settings.
        NSUserDefaults.standardUserDefaults().setValue(uid, forKeyPath: "uid")
        
    }
    
    static var currentUserUid:  String {
        if let user = FIRAuth.auth()!.currentUser{
            return user.uid
        }
        
        return "UnableToFind"
    }
}


