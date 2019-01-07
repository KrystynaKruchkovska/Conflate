//
//  TableView+GetIndexPath.swift
//  Conflate
//
//  Created by Mac on 1/7/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

extension UITableView {
    
    func getIndexPath(for action:UIButton) -> IndexPath {
        for cell in self.visibleCells {
            if action.isDescendant(of: cell) {
                guard let indexPath = self.indexPath(for: cell) else {
                    continue
                }
                
                return indexPath
                
            }
        }
        
        return IndexPath()
    }
    
}

