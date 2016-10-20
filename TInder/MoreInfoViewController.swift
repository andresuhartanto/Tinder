//
//  MoreInfoViewController.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class MoreInfoViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var continueButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    var profilePhotoURL: String?
    var genderType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imagePicker.delegate = self

        setupTapGesture()
        
        DataService.usersRef.child(User.currentUserUid).child("profile_photo").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            print("photo \(snapshot.key)")
            
            
            if let photoURL = snapshot.value as? String {
                self.profilePhotoURL = photoURL
            }})
        
        if gender.selectedSegmentIndex == 0{
            self.genderType = "Male"
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        DataService.usersRef.child(User.currentUserUid).child("profile_photo").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            print("photo \(snapshot.key)")
            
            
            if let photoURL = snapshot.value as? String {
                self.profilePhotoURL = photoURL
                self.profileImage.sd_setImageWithURL(NSURL(string:photoURL))
                self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width) / 2
            }})
    }
    
    func setupTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        profileImage.userInteractionEnabled = true
        profileImage.addGestureRecognizer(tap)
    }
    
    func tapFunction(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onSegmentedController(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.genderType = "Male"
        }else if sender.selectedSegmentIndex == 1{
            self.genderType = "Female"
        }
    }
    
    
    @IBAction func continueButton(sender: UIButton) {
        guard
            let age = ageTextField.text,
            let description = descriptionTextView.text,
            let gender = self.genderType else { return }
        
        let infoDict = ["age": age,
                        "gender": gender,
                        "description": description]
        
        DataService.usersRef.child(User.currentUserUid).updateChildValues(infoDict as [NSObject : AnyObject])
        
        self.performSegueWithIdentifier("CardSegue", sender: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            uploadProfilePicture(pickedImage)
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func uploadProfilePicture(pickedImage:UIImage){
        
        //store to Firebase Storage
        let imagesStorageRef = StorageService.storageRef.child("images")
        let imageData = UIImageJPEGRepresentation(pickedImage, 0.8)
        let imagePath = FIRAuth.auth()!.currentUser!.uid + ".jpg"
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        imagesStorageRef.child(imagePath)
            .putData(imageData!, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading: \(error)")
                    return
                }
                /**save image to firebase database*/
                let fullurl = metadata!.downloadURL()!.absoluteString
                print("fulurl \(metadata!.downloadURL()!.absoluteString)")
                
                let imageDict = ["profile_photo_url":fullurl]
                //build a new root node called tweets
                let imageRef = DataService.usersRef.child(User.currentUserUid).child("profile_photo")
                //underneath the root, there is text,created_at,userUID
                imageRef.setValue(imageDict)
                
                // Caching the image
                SDImageCache.sharedImageCache().storeImage(pickedImage, forKey: fullurl)
                
                /**/
        }
        
    }

}
