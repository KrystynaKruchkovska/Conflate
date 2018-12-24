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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func createUserBtnWasPressed(_ sender: UIButton) {
        guard let useremail = emailTxtField.text else { return}
        guard let userpassword = passwordTxtField.text else { return}
        guard let confirmuserpassword = confirmPasswordTxtField.text else { return}
       
        if userpassword != confirmuserpassword{
            self.confirmPasswordTxtField.makeWarningError()
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Password should be the same"])

            showAlert(error: error)
            
            //show alert
            return
        }
        
        self.signUpViewModel.createUser(email: useremail, password: userpassword) { (error) in
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
        
        // create the alert
        let alert = UIAlertController(title: "OOPS", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UITextField {

func makeWarningError() {
    self.layer.cornerRadius = 3.0
    self.layer.borderWidth = 3.0
    self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    self.layer.masksToBounds = true
}
    
}
    

