//
//  ForgotPasswordVC.swift
//  Conflate
//
//  Created by Mac on 12/28/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    var authViewModel:AuthViewModel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideSpinnerAndControlOn(spinner: spinner)
    }
    
    @IBAction func sendResetPasswordEmailWasPressed(_ sender: UIButton) {
        showSpinnerAndControlOff(spinner: spinner)
        guard let email = emailTextField.text else{
            print("email == nil")
            return
        }
        
        self.authViewModel.resetPassword(email: email) { [weak self](error) in
            self?.hideSpinnerAndControlOn(spinner: self?.spinner)
            if error != nil{
                self?.showAlert(error: error, secondAlertAction: nil)
            } else {
                self?.showAlertWithMessage("Now you can reset password, check your mail")
            }
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
