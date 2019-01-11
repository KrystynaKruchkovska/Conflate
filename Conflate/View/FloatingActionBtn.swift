//
//  FloatingActionBtn.swift
//  Conflate
//
//  Created by Mac on 1/10/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class FloatingActionBtn: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.height/2.0
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.backgroundColor = btnColor().cgColor
    }
    
    private func btnColor() -> UIColor {
        return UIColor(red: 128/255, green: 105/255, blue: 194/255, alpha: 1.0)
    }
    
}
