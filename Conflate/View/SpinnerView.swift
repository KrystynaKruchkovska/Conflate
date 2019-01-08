//
//  SpinnerView.swift
//  Conflate
//
//  Created by Mac on 1/7/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class SpinnerView: UIView {
    private var spinner = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func showSpinner() {
        self.isHidden = false
        self.spinner.isHidden = false
        self.spinner.startAnimating()
    }
    
    func hideSpinner() {
        self.isHidden = true
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
    private func commonInit() {
        setupSelf()
        setupSpinner()
    }
    
    private func setupSelf() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
    }
    
    private func setupSpinner() {
        self.spinner.style = UIActivityIndicatorView.Style.whiteLarge
        self.spinner.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.addSubview(self.spinner)
        self.spinner.centerInSuperview()
    }

}
