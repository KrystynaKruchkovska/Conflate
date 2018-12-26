//
//  ViewController.swift
//  Conflate
//
//  Created by Mac on 12/22/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    private let loginViewModel = LoginViewModel()

    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.hideSpinner()
    }
    
    @IBAction func signUpWasPressed(_ sender: Any) {
    }
    
    @IBAction func LoginBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        
        showSpinner()
        
        self.loginViewModel.signIn(email: useremail, password: userpassword) { (error) in
            self.hideSpinner()
            
            if let error = error {
                // it didn't work
                print("user login failed")
                self.showAlert(error: error)
                return
            } else {
               
                print("user login succesfully")
                // move to logged in viewcontroller
            }
        }
    }
    
    @IBAction func forgotPasswordWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginWithFBWasPressed(_ sender: UIButton) {
    }
    
    func showAlert(error:Error?){
        // create the alert
        let alert = UIAlertController(title: "Oops", message: "\(error?.localizedDescription ?? "Login failed")", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
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

