//
//  PosrVC.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class PostVC: UIViewController {
    var authViewModel:AuthViewModel!
    var currentUser = Auth.auth().currentUser
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var participanceTxtField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideSpinnerAndControlOn(spinner: self.spinner)
    }
    
    @IBAction func locationBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func categoryBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func addBtnWasPressed(_ sender: UIButton) {
        addPost()
    }
    
    func addPost() {
        let date = self.datePicker?.date.timeIntervalSince1970
        
        self.authViewModel.addPost(lat: "49.29899", long: "19.94885", participants: participanceTxtField.text, title: titleTxtField.text!, user: currentUser!, category: "Party", date:date!, description: descriptionTxtView.text) { (error) in
            self.hideSpinnerAndControlOn(spinner: self.spinner)
            if let error = error {
                self.showAlertWithError(error)
            }
        }
        
    }
    
}
