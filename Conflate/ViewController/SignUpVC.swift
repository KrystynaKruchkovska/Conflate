//
//  SignUpVC.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

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
        guard let useremail = emailTxtField.text else { return }
        guard let userpassword = passwordTxtField.text else { return }
        guard let confirmuserpassword = confirmPasswordTxtField.text else { return }
        guard let userNickName = nicknameTxtField.text else { return }
        
        if userpassword != confirmuserpassword {
            self.confirmPasswordTxtField.makeWarningError()
            showAlert(Constants.Strings.different_passwords, title: Constants.Alerts.errorAlertTitle, handler:nil)
            return
        }
        showSpinnerAndControlOff(spinner: spinner)
        self.createUser(userNickName: userNickName, email: useremail, password: userpassword)

    }
    
    func createUser(userNickName:String,email: String, password: String){
        self.authViewModel.createUser(userNickName:userNickName,email: email, password: password) { [weak self](error, user) in
            
            if error != nil {
                print("user create failed")
                self?.showAlertWithError(error)
                self?.hideSpinnerAndControlOn(spinner: self?.spinner)
            } else {
                guard let user = user else {
                    self?.showAlert(Constants.Strings.internal_error, title: Constants.Alerts.errorAlertTitle, handler:nil)
                    return
                }
                
                self?.sendVertificationEmail(user: user, userNickName: userNickName)
                print("user create succesfully")
            }
        }
    }
    
    func sendVertificationEmail(user:User,userNickName:String) {
        self.authViewModel.sendVerificationEmail(user: user, handler: { [weak self] (error) in
            if let error = error {
                self?.showAlertWithError(error)
            } else {
                let userData = ["provider": user.providerID, "email": user.email, "username": userNickName]
                self?.addUser(user: user, userData: userData as Dictionary<String, AnyObject>)
            }
            
        })
    }
    
    func addUser(user:User, userData: Dictionary<String, AnyObject>) {
        self.authViewModel.addUser(uid: user.uid, userData: userData as Dictionary<String, AnyObject>,handler: { (error) in
            self.hideSpinnerAndControlOn(spinner: self.spinner)
            if let error = error {
                self.showAlertWithError(error)
            }
            
            self.showAlert(Constants.Strings.verification_sent, title: Constants.Alerts.successAlertTitle, handler: { (alertAction) in
                self.showSignInVC()
            })
            
        })
    }
    
    func showSignInVC() {
        self.dismiss(animated: true, completion:nil)
    }
    
}

