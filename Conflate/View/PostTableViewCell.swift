//
//  PostTableViewCell.swift
//  Conflate
//
//  Created by Mac on 1/3/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
  
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var infoButton: UIButton!
    
    func configureCell(title:String) {
        self.titleLbl.text = title
    }
    
}
