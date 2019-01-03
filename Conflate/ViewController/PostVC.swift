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
    
    var postViewModel:PostViewModel!
    var currentUser = Auth.auth().currentUser
    var location:Location?
    
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
        self.postViewModel.validatePostData(location: self.location, title: self.titleTxtField.text, particiapntNumber: self.participanceTxtField.text, date: self.datePicker?.date, description: descriptionTxtView.text, currentUser: currentUser) { (error, post) in
            
            if let error = error {
                self.showAlertWithError(error)
                return
            }
            
            guard let post = post else {
                self.showAlertInternalError()
                return
            }
            
            self.addPost(post: post)
        }
    }
        
    func addPost(post:Post) {
        self.postViewModel.addPost(post) { (error) in
            self.hideSpinnerAndControlOn(spinner: self.spinner)
            if let error = error {
                self.showAlertWithError(error)
            } else {
                
                self.showAlert("Post added!", title: Constants.Alerts.successAlertTitle, handler: { (alertAction) in
                    self.hideSelfVC()
                })
                
            }
        }
        
    }
    
    @IBAction func backButtonWasPressed(_ sender: Any) {
        self.hideSelfVC()
    }
    
    func hideSelfVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
