//
//  CardsViewController.swift
//  TInder
//
//  Created by Andre Suhartanto on 10/20/16.
//  Copyright © 2016 EndeJeje. All rights reserved.
//

import UIKit
import Koloda

class CardsViewController: UIViewController {
    
    var cards = [User]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()

    }
    
    func loadUsers(){
        DataService.usersRef.observeEventType(.ChildAdded, withBlock: {(usersSnap) in
            DataService.usersRef.child(usersSnap.key).observeEventType(.Value, withBlock: {(aUserSnap) in
                if let user = User.init(snapshot: aUserSnap){
                    self.cards.append(user)
                    self.populateCard()
                }
            })
        })
    }
    
    func populateCard(){
        
        for card in cards{
        let photoURL = card.photoURL
        self.imageView.sd_setImageWithURL(NSURL(string: photoURL!))
        self.nameLabel.text = card.name
        self.ageLabel.text = String(card.age)
        self.descriptionLabel.text = card.description
        }
    }
    
    @IBAction func onNopeButtonPressed(sender: UIButton) {
    }
    
    @IBAction func onYasButtonPressed(sender: UIButton) {
    }

}
