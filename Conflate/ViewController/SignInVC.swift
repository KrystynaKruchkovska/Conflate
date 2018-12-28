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
    var forgotPasswordBtn = UIButton()
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.hideSpinnerAndControlOn(spinner: spinner)
        configureForgotPasswordButton(button: forgotPasswordBtn)
        passwordTxtField.addButton(forgotPasswordBtn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUpVC {
            let vc = segue.destination as? SignUpVC
            
           if vc?.authViewModel !== self.authViewModel {
                vc?.authViewModel = self.authViewModel
            }
        
        }
    }
    
    func configureForgotPasswordButton(button:UIButton){
        button.frame = CGRect(x: 0, y: 0, width: self.passwordTxtField.frame.width/3.0, height: self.passwordTxtField.frame.height)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.5019607843, green: 0.4, blue: 0.768627451, alpha: 1), for: .normal)
        button.setTitle("Forgot?", for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
    }
    
    @objc func forgotPasswordButtonAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: Constants.Storyboard.authSB, bundle: Bundle.main)
        let forgotPasswordVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.forgotPasswordVC)
        if let presentVC = forgotPasswordVC as? ForgotPasswordVC{
            presentVC.authViewModel = self.authViewModel
        }
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    

    @IBAction func LoginBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        
        showSpinnerAndControlOff(spinner: spinner)
        
        self.authViewModel.signIn(email: useremail, password: userpassword) { [weak self](error, user) in
            self?.hideSpinnerAndControlOn(spinner: self?.spinner)
            
            if let error = error {
                
                print("user login failed")
                self?.showAlert(error: error, secondAlertAction: nil)
                return
                
            } else {
                print("user login succesfully")
                
                guard let user = user else {
                    self?.showAlertWithMessage("Internal error : (")
                    return
                }
                
                self?.checkIfVerified(user:user)
            }
        }
    }
    
    func checkIfVerified(user:User) {
        if user.isEmailVerified {
            // TODO: dismiss this viewcontroller to show main tab bar controller
        } else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Your account is not verified. Click \"Resend\" if you want us to resend activation email"])
            
            let secondAction = UIAlertAction(title: "Resend", style: UIAlertAction.Style.default) { [weak self] (action)  in
                self?.showSpinnerAndControlOff(spinner: self?.spinner)
                
                self?.authViewModel.sendVerificationEmail(user: user, handler: { [weak self] (error) in
                    self?.hideSpinnerAndControlOn(spinner: self?.spinner)
                    
                    if let error = error {
                        self?.showAlert(error: error, secondAlertAction: nil)
                    } else {
                        self?.showAlertWithMessage("Verification email was sent!")
                    }
                    
                })
            }
            
            self.showAlert(error: error, secondAlertAction: secondAction)
        }
    }
        
    @IBAction func loginWithFBWasPressed(_ sender: UIButton) {
    }

    
    func showAlert(error:Error?, secondAlertAction:UIAlertAction?){
        let oopsTitle = "Oops!"
        let wowTitle = "Wow!"
        var messageTitle = ""
        
        if secondAlertAction != nil {
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
    
    func showAlertWithMessage(_ message:String) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : message])
        showAlert(error: error, secondAlertAction: nil)
    }
    
}

