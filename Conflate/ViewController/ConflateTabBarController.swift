//
//  ConflateTabBarController.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class ConflateTabBarController: UITabBarController {

    var authViewModel:AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mapVC:MapVC = self.getTabVC() {
            mapVC.authViewModel = self.authViewModel
            
        }
    }
    

    private func getTabVC<T:UIViewController>() -> T? {
        
        for controller in self.viewControllers! {
            if let vc = controller as? T {
                return vc
            }
        }
        
        return nil
    }
    
}
