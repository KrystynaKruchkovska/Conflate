//
//  UITextField+Button.swift
//  Conflate
//
//  Created by Mac on 12/28/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func addButton(_ button: UIButton) {
        self.rightView = button
        self.rightViewMode = .always
    }

}
