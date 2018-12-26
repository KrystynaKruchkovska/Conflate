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
        showSpinner()
       
        if userpassword != confirmuserpassword{
            hideSpinner()
            self.confirmPasswordTxtField.makeWarningError()
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Password should be the same"])

            showAlert(error: error)

            return
        }
        
        self.signUpViewModel.createUser(email: useremail, password: userpassword) { (error) in
            self.hideSpinner()
            if error != nil {
                print("user create failed")
                self.showAlert(error: error)
                
            } else {
                print("user create succesfully")
                
            }
        }
    }
    
    
    func showAlert(error:Error?){
        guard let errorDescription = error?.localizedDescription  else {
            print("not showing error without description")
            return
        }
        let alert = UIAlertController(title: "OOPS", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
        
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

