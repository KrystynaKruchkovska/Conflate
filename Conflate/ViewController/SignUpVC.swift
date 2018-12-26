//
//  SignUpVC.swift
//  Conflate
//
//  Created by Mac on 12/24/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    let signUpViewModel = SignUpViewModel()
    
    @IBOutlet weak var nicknameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.hideSpinner()
    }
    
    
    @IBAction func createUserBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        guard let confirmuserpassword = confirmPasswordTxtField.text else { return}
        
        if userpassword != confirmuserpassword {
            self.confirmPasswordTxtField.makeWarningError()
            showAlertWithErrorMessage("Password should be the same")
            return
        }
        
        showSpinner()
        
        self.signUpViewModel.createUser(email: useremail, password: userpassword) { (error, user) in
            
            if error != nil {
                print("user create failed")
                self.showAlert(error: error)
                self.hideSpinner()
                
            } else {
                guard let user = user else {
                    self.showAlertWithErrorMessage("Internal error :(")
                    return
                }
                
                self.signUpViewModel.sendVerificationEmail(user: user, handler: { (error) in
                    self.hideSpinner()
                    if let error = error {
                        self.showAlert(error: error)
                    }else{
                        self.verifyEmailAlert(message: "Verification email was sent successfully, check your email")
                    }
                })
                
                print("user create succesfully")
                // TODO: dismiss current view controller
            }
        }
        
    }
    
    
    func verifyEmailAlert(message:String){
        let alert = UIAlertController(title: "WELL DONE!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithErrorMessage(_ message:String) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : message])
        showAlert(error: error)
    }
    
    func showAlert(error:Error?){
        guard let errorDescription = error?.localizedDescription  else {
            self.showAlertWithErrorMessage("Internal error :(")
            return
        }
        
        let alert = UIAlertController(title: "Oops", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
}

