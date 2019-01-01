//
//  PosrVC.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class PostVC: UIViewController {
    var authViewModel:AuthViewModel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var participanceTxtField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func locationBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func categoryBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func addBynWasPressed(_ sender: UIButton) {
    }
}
