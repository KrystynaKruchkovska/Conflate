//
//  ViewController.swift
//  Conflate
//
//  Created by Mac on 12/22/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    var authViewModel:AuthViewModel!
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.hideSpinnerAndControlOn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUpVC {
            let vc = segue.destination as? SignUpVC
            
           if vc?.authViewModel !== self.authViewModel {
                vc?.authViewModel = self.authViewModel
            }
        
        }
    }
    

    @IBAction func LoginBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        
        showSpinnerAndControlOff()
        
        self.authViewModel.signIn(email: useremail, password: userpassword) { (error, user) in
            self.hideSpinnerAndControlOn()
            
            if let error = error {
                
                print("user login failed")
                self.showAlert(error: error, secondAlertAction: nil)
                return
                
            } else {
                print("user login succesfully")
                
                guard let user = user else {
                    self.showAlertWithMessage("Internal error : (")
                    return
                }
                
                self.checkIfVerified(user:user)
            }
        }
    }
    
    func checkIfVerified(user:User) {
        if user.isEmailVerified {
            // TODO: dismiss this viewcontroller to show main tab bar controller
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Your account is not verified. Click \"Resend\" if you want us to resend activation email"])
            
            let secondAction = UIAlertAction(title: "Resend", style: UIAlertAction.Style.default){ (action)  in
                self.showSpinnerAndControlOff()
                
                self.authViewModel.sendVerificationEmail(user: user, handler: { (error) in
                    self.hideSpinnerAndControlOn()
                    
                    if let error = error {
                        self.showAlert(error: error, secondAlertAction: nil)
                    } else {
                        self.showAlertWithMessage("Verification email was sent!")
                    }
                    
                })
            }
            
            self.showAlert(error: error, secondAlertAction: secondAction)
        }
    }
    
    @IBAction func forgotPasswordWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginWithFBWasPressed(_ sender: UIButton) {
    }
    
    func showAlert(error:Error?, secondAlertAction:UIAlertAction?){
        let oopsTitle = "Oops!"
        let wowTitle = "Wow!"
        var messageTitle = ""
        
        if secondAlertAction != nil{
            messageTitle = oopsTitle
        } else {
            messageTitle = wowTitle
        }
        
        let alert = UIAlertController(title: messageTitle, message: "\(error?.localizedDescription ?? "Login failed")", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        if let secondAction = secondAlertAction {
            alert.addAction(secondAction)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSpinnerAndControlOff() {
        spinner.isHidden = false
        spinner.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideSpinnerAndControlOn() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func showAlertWithMessage(_ message:String) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : message])
        showAlert(error: error, secondAlertAction: nil)
    }
    
}

