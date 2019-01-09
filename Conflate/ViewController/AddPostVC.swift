//
//  PosrVC.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase
import MapKit
class AddPostVC: UIViewController {
    
    var postViewModel:PostViewModel!
    var currentUser = Auth.auth().currentUser
    var location:Location?
    var categoryType:String?
    var date :String?
    
    @IBOutlet weak var spinnerView: SpinnerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var participanceTxtField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinnerView.hideSpinner()
        datePicker.addTarget(self, action: #selector(dataPickerChanged(_:)), for: .valueChanged)
    }
    
    @IBAction func locationBtnWasPressed(_ sender: Any) {
    }
    
    @objc func dataPickerChanged(_ sender: UIDatePicker) {
    
            print("print \(sender.date)")
            
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = " YYYY-MM-dd HH:mm"
   
        let dateString = dateFormatter.string(from: sender.date)
        self.date = dateString
            print(dateString)  // "somedateString" is your string date
        
    }
    
    @IBAction func addBtnWasPressed(_ sender: UIButton) {
        self.spinnerView.showSpinner()
        self.postViewModel.validatePostData(location: self.location, title: self.titleTxtField.text, particiapntNumber: self.participanceTxtField.text, date: self.date, description: descriptionTxtView.text, currentUser: currentUser, category: categoryType) { [weak self] (error, post) in
            
            if let error = error {
                self?.showAlertWithError(error)
                self?.spinnerView.hideSpinner()
                return
            }
            
            guard let post = post else {
                self?.showAlertInternalError()
                return
            }
            
            self?.addPost(post: post)
        }
    }
        
    func addPost(post:Post) {
        self.postViewModel.addPost(post) { [weak self] (error) in
            
            self?.spinnerView.hideSpinner()
            
            if let error = error {
                self?.showAlertWithError(error)
            } else {
                
                self?.showAlert("Post added!", title: Constants.Alerts.successAlertTitle, handler: { (alertAction) in
                    self?.hideSelfVC()
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
