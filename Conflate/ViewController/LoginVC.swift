//
//  ViewController.swift
//  Conflate
//
//  Created by Mac on 12/22/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signUpWasPressed(_ sender: Any) {
    }
    
    @IBAction func LoginBtnWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func forgotPasswordWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginWithFBWasPressed(_ sender: UIButton) {
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }
}

