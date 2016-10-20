//
//  ProfileViewController.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadProfile()
    }
    
    func loadProfile(){
        DataService.usersRef.child(User.currentUserUid).observeEventType(.Value, withBlock: {(userSnap) in
            if let user = User.init(snapshot: userSnap){
                self.nameLabel.text = user.name
                self.descriptionLabel.text = user.description
                let photoURL = user.photoURL
                self.profileImage.sd_setImageWithURL(NSURL(string: photoURL!))
            }
        })
        }
    
    
    @IBAction func onSignOutbutton(sender: UIBarButtonItem) {
        try! FIRAuth.auth()?.signOut()
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userUID")
        
        
        goBackToLogin()
        
    }
    
    func goBackToLogin(){
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        // load view controller with the storyboardID of HomeTabBarController
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("LoginView")
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
