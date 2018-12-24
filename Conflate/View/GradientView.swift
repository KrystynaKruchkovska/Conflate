//
//  GradientView.swift
//  Conflate
//
//  Created by Mac on 12/22/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    
    var internalLayer:CAGradientLayer?
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.3411764706, green: 0.2705882353, blue: 0.5294117647, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.8156862745, green: 0.2941176471, blue: 0.8470588235, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let internalLayer = self.internalLayer {
            internalLayer.removeFromSuperlayer()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.removeFromSuperlayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        
        self.internalLayer = gradientLayer
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
