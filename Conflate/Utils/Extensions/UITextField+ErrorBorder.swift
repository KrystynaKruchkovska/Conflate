//
//  UITextField+ErrorBorder.swift
//  Conflate
//
//  Created by Paweł on 24/12/2018.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

extension UITextField {
    
    func makeWarningError() {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 3.0
        self.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.layer.masksToBounds = true
    }
    
}
