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
    
    @IBOutlet weak var spinnerView: SpinnerView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinnerView.hideSpinner()
        self.setUpTextField()
    }
    
    @IBAction func sendResetPasswordEmailWasPressed(_ sender: UIButton) {
        self.spinnerView.showSpinner()
        guard let email = emailTextField.text else{
            print("email == nil")
            return
        }
        
        self.resetPassword(email: email)
    }
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpTextField(){
        self.emailTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    private func resetPassword(email:String){
        self.authViewModel.resetPassword(email: email) { [weak self](error) in
            self?.spinnerView.hideSpinner()
            if error != nil{
                self?.showAlertWithError(error)
            } else {
                self?.showAlertWithMessage(Constants.Strings.password_reset, title: Constants.Alerts.successAlertTitle, handler: { [weak self] (alertAction) in
                    self?.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
}

extension ForgotPasswordVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
