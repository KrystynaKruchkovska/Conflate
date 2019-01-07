//
//  UIView+CenterInSuperView.swift
//  Conflate
//
//  Created by Paweł on 07/01/2019.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

extension UIView {
    
    func centerInSuperview() {
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }
}
