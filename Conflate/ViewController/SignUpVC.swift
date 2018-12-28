//
//  SignUpVC.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    var authViewModel:AuthViewModel!
    
    @IBOutlet weak var nicknameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.hideSpinnerAndControlOn(spinner: spinner)
    }
    
    @IBAction func backbuttonWasPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createUserBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        guard let confirmuserpassword = confirmPasswordTxtField.text else { return}
        
        if userpassword != confirmuserpassword {
            self.confirmPasswordTxtField.makeWarningError()
            showAlert("Password should be the same", title: Constants.Alerts.errorAlertTitle)
            return
        }
        
        showSpinnerAndControlOff(spinner: spinner)
        
        self.authViewModel.createUser(email: useremail, password: userpassword) { [weak self](error, user) in
            
            if error != nil {
                print("user create failed")
                self?.showAlertWithError(error)
                self?.hideSpinnerAndControlOn(spinner: self?.spinner)
                
            } else {
                guard let user = user else {
                    self?.showAlert("Internal error :(", title: Constants.Alerts.errorAlertTitle)
                    return
                }
                
                self?.authViewModel.sendVerificationEmail(user: user, handler: { [weak self] (error) in
                    self?.hideSpinnerAndControlOn(spinner: self?.spinner)
                    if let error = error {
                        self?.showAlertWithError(error)
                    }else{
                        self?.showAlert("Verification email was sent successfully, check your email", title: Constants.Alerts.successAlertTitle)
                    }
                })
                
                print("user create succesfully")
                // TODO: go to login view controller
            }
        }
        
    }
    
}

