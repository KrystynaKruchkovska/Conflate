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

    @IBOutlet weak var spinnerView: SpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTextField()
        self.spinnerView.hideSpinner()
    }
    
    @IBAction func backbuttonWasPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createUserBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return }
        guard let userpassword = passwordTxtField.text else { return }
        guard let confirmuserpassword = confirmPasswordTxtField.text else { return }
        guard let nickname = nicknameTxtField.text else { return }
        
        if userpassword != confirmuserpassword {
            self.confirmPasswordTxtField.makeWarningError()
            self.showAlertWithMessage(Constants.Strings.different_passwords, title: Constants.Alerts.errorAlertTitle, handler:nil)
            return
        }
       self.spinnerView.showSpinner()
        self.createUser(nickname: nickname, email: useremail, password: userpassword)
        
    }
    
    private func setUpTextField(){
        self.nicknameTxtField.delegate = self
        self.emailTxtField.delegate = self
        self.passwordTxtField.delegate = self
        self.confirmPasswordTxtField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    private func createUser(nickname:String,email: String, password: String){
        self.authViewModel.createUser(nickname:nickname,email: email, password: password) { [weak self] (error, user) in
            
            if error != nil {
                print("user create failed")
                self?.showAlertWithError(error)
                self?.spinnerView.hideSpinner()
            } else {
                guard let user = user else {
                    self?.showAlertInternalError()
                    return
                }
                
                self?.sendVertificationEmail(user: user)
                print("user create succesfully")
            }
        }
    }
    
    private func sendVertificationEmail(user:CUser) {

        self.authViewModel.sendVerificationEmail(user: user, handler: { [weak self] (error) in
            if let error = error {
                self?.showAlertWithError(error)
            } else {
                self?.addUser(user: user)
            }
            
        })
    }
    
    private func addUser(user:CUser) {
        self.authViewModel.addUser(user:user, handler: { [weak self] (error) in
            self?.spinnerView.hideSpinner()
            if let error = error {
                self?.showAlertWithError(error)
            }
            
            self?.showAlertWithMessage(Constants.Strings.verification_sent, title: Constants.Alerts.successAlertTitle, handler: { [weak self] (alertAction) in
                self?.showSignInVC()
            })
            
        })
    }
    
    private func showSignInVC() {
        self.dismiss(animated: true, completion:nil)
    }
    
}

extension SignUpVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
