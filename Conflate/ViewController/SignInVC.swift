//
//  ViewController.swift
//  Conflate
//
//  Created by Mac on 12/22/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class SignInVC: UIViewController, FBSDKLoginButtonDelegate {
    
    var authViewModel:AuthViewModel!
    private var forgotPasswordBtn = UIButton()
    private let fbLoginButton = FBSDKLoginButton()
    
    @IBOutlet weak var spinnerView: SpinnerView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTextField()
        self.spinnerView.hideSpinner()
        self.configureForgotPasswordButton(button: forgotPasswordBtn)
        self.configureFBLogin()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUpVC {
            let vc = segue.destination as? SignUpVC
            
            if vc?.authViewModel !== self.authViewModel {
                vc?.authViewModel = self.authViewModel
            }
            
        }
    }
    private func setUpTextField(){
        self.emailTxtField.delegate = self
        self.passwordTxtField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    private func configureFBLogin() {
        self.fbLoginButton.delegate = self
        self.fbLoginButton.readPermissions = ["email", "public_profile"]
    }
    
    private func configureForgotPasswordButton(button:UIButton){
        button.frame = CGRect(x: 0, y: 0, width: self.passwordTxtField.frame.width/3.0, height: self.passwordTxtField.frame.height/2)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.5019607843, green: 0.4, blue: 0.768627451, alpha: 1), for: .normal)
        button.setTitle(Constants.Strings.forgot, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonAction), for: .touchUpInside)
        
        self.passwordTxtField.addButton(forgotPasswordBtn)
    }
    
    @objc func forgotPasswordButtonAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: Constants.Storyboard.authSB, bundle: Bundle.main)
        let forgotPasswordVC = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.forgotPasswordVC)
        if let presentVC = forgotPasswordVC as? ForgotPasswordVC{
            presentVC.authViewModel = self.authViewModel
        }
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    @IBAction func loginWithFBWasPressed(_ sender: UIButton) {
        self.spinnerView.showSpinner()
        self.fbLoginButton.sendActions(for:.touchUpInside)
    }
    
    @IBAction func loginBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        self.spinnerView.showSpinner()
        self.signInWithEmail(useremail: useremail, userpassword: userpassword)
    }
    
    private func signInWithEmail(useremail:String, userpassword:String) {
        self.authViewModel.signIn(email: useremail, password: userpassword) { [weak self](error, user) in
            self?.spinnerView.hideSpinner()
            
            if let error = error {
                print("user sign in failed")
                self?.showAlertWithError(error, secondAlertAction: nil)
                return
            }
            
            guard let user = user else {
                self?.showAlertInternalError()
                return
            }
            
            print("user signed in succesfully")
            
            if user.isEmailVerified {
                self?.hideLoginVC()
            } else {
                self?.showResendVerificationAlert(user:user)
            }
            
        }
    }
    
    private func showResendVerificationAlert(user:CUser) {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.Strings.verification_invalid])
        
        let secondAction = UIAlertAction(title: Constants.Alerts.resend, style: UIAlertAction.Style.default) { [weak self] (action)  in
            self?.spinnerView.showSpinner()
            self?.sendVarificationEmail(user: user)
        }
        
        self.showAlertWithError(error, secondAlertAction: secondAction)
    }
    
    private func sendVarificationEmail(user:CUser){
        self.authViewModel.sendVerificationEmail(user: user, handler: { [weak self] (error) in
            self?.spinnerView.hideSpinner()
            
            if let error = error {
                self?.showAlertWithError(error)
            } else {
                self?.showAlertWithMessage(Constants.Strings.verification_sent, title: Constants.Alerts.successAlertTitle, handler:nil)
            }
        })
    }
    
    private func hideLoginVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let error = error {
            self.showAlertWithError(error, secondAlertAction: nil)
            self.spinnerView.hideSpinner()
            return
        }
        
        print("login button with facebook did complete with no error")
        
        if (FBSDKAccessToken.current() == nil) {
            self.showAlertWithMessage(Constants.Strings.facebook_login_fail, title: Constants.Alerts.errorAlertTitle, handler:nil)
            self.spinnerView.hideSpinner()
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        self.authViewModel.loginWithFacebook(credential) { [weak self] (error, user) in
            if let error = error {
                print("login button with facebook fir complete with error:\(error)")
                self?.showAlertWithError(error, secondAlertAction: nil)
                self?.spinnerView.hideSpinner()
                return
            }
            
            print("logged in succesfully with facebook")
            
            guard let user = user else {
                self?.showAlertInternalError()
                return
            }
            
            self?.addUser(user:user)
        }
        
    }
    
    private func addUser(user:CUser) {
        self.authViewModel.addUser(user:user, handler: { [weak self] (error) in
            self?.spinnerView.hideSpinner()
            if let error = error {
                self?.showAlertWithError(error)
            }
        
            self?.hideLoginVC()
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.spinnerView.hideSpinner()
    }
}
extension SignInVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

