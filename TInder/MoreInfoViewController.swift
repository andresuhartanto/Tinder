//
//  MoreInfoViewController.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var continueButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        setupTapGesture()
        
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
    
    @IBAction func continueButton(sender: UIButton) {
        self.performSegueWithIdentifier("CardSegue", sender: nil)
    }

}
