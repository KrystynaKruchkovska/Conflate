//
//  PostInfoVC.swift
//  Conflate
//
//  Created by Mac on 1/3/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class PostInfoVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    var post:Post!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var participantsLbl: UILabel!
    @IBOutlet weak var peopleGoingLbl: UILabel!
    @IBOutlet weak var category: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
   func setupView(){
    dateLbl.text = (dateLbl.text ?? "") + " " + post.date
    titleLbl.text = (titleLbl.text ?? "") + " " + post.title
    locationLbl.text = (locationLbl.text ?? "") + " " + "lat:\(post.location.lat)" + " " + "long:\(post.location.long)"
    descriptionLbl.text = (descriptionLbl.text ?? "") + " " + post.description
    participantsLbl.text = (participantsLbl.text ?? "") + " " + String(post.numberOfParticipants)
    category.text = (category.text ?? "") + " " + String(post.category)
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func askQuryWasPressed(_ sender: Any) {
    }
    
    @IBAction func goBtnWasPressed(_ sender: Any) {
    }
    
    
}
