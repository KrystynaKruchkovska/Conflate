//
//  Double+Round.swift
//  Conflate
//
//  Created by Paweł on 13/01/2019.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//


import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
