//
//  ConflateTabBarController.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class ConflateTabBarController: UITabBarController {

    var postViewModel:PostViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mapVC:MapVC = self.getTabVC() {
            mapVC.postViewModel = self.postViewModel
            
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
