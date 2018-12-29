//
//  ForgotPasswordVC.swift
//  Conflate
//
//  Created by Mac on 12/28/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    var authViewModel:AuthViewModel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideSpinnerAndControlOn(spinner: spinner)
    }
    
    @IBAction func sendResetPasswordEmailWasPressed(_ sender: UIButton) {
        showSpinnerAndControlOff(spinner: spinner)
        guard let email = emailTextField.text else{
            print("email == nil")
            return
        }
        
        self.authViewModel.resetPassword(email: email) { [weak self](error) in
            self?.hideSpinnerAndControlOn(spinner: self?.spinner)
            if error != nil{
                self?.showAlertWithError(error)
            } else {
                self?.showAlert(Constants.Strings.password_reset, title: Constants.Alerts.successAlertTitle, handler:nil)
            }
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
