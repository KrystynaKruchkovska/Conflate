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
        
        layer.cornerRadius = self.frame.height/2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }


}
