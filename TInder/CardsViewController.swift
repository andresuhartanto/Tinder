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
        
        

    }
    
    func loadUsers(){
        DataService.
    }
    
    @IBAction func onNopeButtonPressed(sender: UIButton) {
    }
    
    @IBAction func onYasButtonPressed(sender: UIButton) {
    }

}
