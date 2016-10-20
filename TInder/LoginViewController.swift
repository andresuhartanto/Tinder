//
//  ViewController.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("userUID") as? String{
            if let user = FIRAuth.auth()?.currentUser{
                if !user.emailVerified{
                    let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Please Verifiec your email address first", preferredStyle: .Alert)
                    let alertActionOkay = UIAlertAction(title: "Okay", style: .Default) {
                        (_) in
                        user.sendEmailVerificationWithCompletion(nil)
                    }
                    alertVC.addAction(alertActionOkay)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                }
                
                // load storyboard
                let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                // load view controller with the storyboardID of HomeTabBarController
                let viewController = storyBoard.instantiateViewControllerWithIdentifier("CardView")
                
                self.presentViewController(viewController, animated: true, completion: nil)
                
            }}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        
        
    }

    @IBAction func onSignInButtonPressed(sender: AnyObject) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            if let person = user {
                if !person.emailVerified{
                    let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(self.emailTextField.text!).", preferredStyle: .Alert)
                    let alertActionOkay = UIAlertAction(title: "Okay", style: .Default) {
                        (_) in
                        person.sendEmailVerificationWithCompletion(nil)
                }
                    alertVC.addAction(alertActionOkay)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                }
                
                NSUserDefaults.standardUserDefaults().setObject((user!.uid), forKey: "userUID")
                User.signIn(person.uid)
                self.performSegueWithIdentifier("CardSegue", sender: nil)
                
            }else {
                let controller = UIAlertController(title: "Registration Failed", message: error?.localizedDescription, preferredStyle: .Alert)
                let dismissButton = UIAlertAction(title: "Try Again", style: .Default, handler: nil)
                
                controller.addAction(dismissButton)
                
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }

        
    }

}

