//
//  MapVC.swift
//  Conflate
//
//  Created by Mac on 1/1/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class MapVC: UIViewController {
    var authViewModel:AuthViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PostVC {
            let vc = segue.destination as? PostVC
            
            if vc?.authViewModel !== self.authViewModel {
                vc?.authViewModel = self.authViewModel
            }
            
        }
    }
    
}
