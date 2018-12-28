//
//  UIViewController + Spinner.swift
//  Conflate
//
//  Created by Mac on 12/28/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showSpinnerAndControlOff(spinner:UIActivityIndicatorView?) {
        spinner?.isHidden = false
        spinner?.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideSpinnerAndControlOn(spinner:UIActivityIndicatorView?) {
        spinner?.isHidden = true
        spinner?.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}
