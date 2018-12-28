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
            showAlertWithErrorMessage("Password should be the same")
            return
        }
        
        showSpinnerAndControlOff(spinner: spinner)
        
        self.authViewModel.createUser(email: useremail, password: userpassword) { [weak self](error, user) in
            
            guard let unwrappedSelf = self else {
                print("there is no referance to self")
                return
            }
            
            if error != nil {
                print("user create failed")
                self?.showAlert(error: error)
                self?.hideSpinnerAndControlOn(spinner: self?.spinner)
                
            } else {
                guard let user = user else {
                    self?.showAlertWithErrorMessage("Internal error :(")
                    return
                }
                
                self?.authViewModel.sendVerificationEmail(user: user, handler: { [weak self] (error) in
                    self?.hideSpinnerAndControlOn(spinner: self?.spinner)
                    if let error = error {
                        self?.showAlert(error: error)
                    }else{
                        self?.verifyEmailAlert(message: "Verification email was sent successfully, check your email")
                    }
                })
                
                print("user create succesfully")
                // TODO: go to login view controller
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

}

