//
//  CategoryCell.swift
//  Conflate
//
//  Created by Mac on 1/8/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    func configureCell (category:Category){
        self.categoryImg.image = UIImage(named: category.image)
        self.categoryTitle.text = category.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
