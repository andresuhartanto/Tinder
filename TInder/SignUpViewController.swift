//
//  SignUpViewController.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUpButtonPressed(sender: UIButton) {
        guard
            let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: {(user, error) in
            if let user = user{
                
                // stores into user defaults under key userUID, the user's
                NSUserDefaults.standardUserDefaults().setObject((user.uid), forKey: "userUID")
                User.signIn(user.uid)
                
                
                
                let currentUserRef = DataService.usersRef.child(user.uid)
                let userDict = ["email": email, "username": name]
                currentUserRef.setValue(userDict)
                
                
                
                
            }else{
                let alert = UIAlertController(title: "Sign Up Failed", message: error?.localizedDescription, preferredStyle: .Alert)
                
                let dismissAction = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                
                alert.addAction(dismissAction)
                
                self.presentViewController(alert, animated:true, completion: nil)
                
            }
        })
        
        FIRAuth.auth()?.currentUser?.sendEmailVerificationWithCompletion({ (error) in
            print("verification email sent")
            let alert = UIAlertController(title: "Account Created", message: "Please verify your email by confirming the sent link.", preferredStyle: UIAlertControllerStyle.Alert)
            let actionButton = UIAlertAction(title: "Ok", style: .Default, handler: { (actionButton) in
                self.performSegueWithIdentifier("MoreInfoSegue", sender: nil)
            })
            alert.addAction(actionButton)
            self.presentViewController(alert, animated: true, completion: nil)
        })
        
        
        
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
