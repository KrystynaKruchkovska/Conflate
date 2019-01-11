//
//  PopUpVC.swift
//  Conflate
//
//  Created by Mac on 1/8/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {
    
    private var categories: [Category] = []
    private var categoryTypeToPass:String?
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCategoryArray()
        self.setupTableView()
    }
    
    @IBAction func doneBtnWasPressed(_ sender: UIButton) {
            if let presenter = self.presentingViewController as? AddPostVC {
              presenter.categoryType = self.categoryTypeToPass
            }
    
            self.dismiss(animated: true, completion: nil)
    }
    
    private func setCategoryArray(){
        categories = [Category(image: Constants.CategoryImage.lostAndFound, title: Constants.CategoryTitle.lostAndFound),
                      Category(image: Constants.CategoryImage.healthAndFitness, title: Constants.CategoryTitle.healthAndFitness),
                      Category(image: Constants.CategoryImage.party, title: Constants.CategoryTitle.party)]
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func setUpPopView(){
        self.popUpView.layer.cornerRadius = 10
        self.popUpView.layer.masksToBounds = true
    }
    
}

extension PopUpVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.ReusableIdentifier.categoryPopVCViewCell) as? CategoryCell else {
            fatalError(Constants.Strings.fatalError)
        }
        let category = categories[indexPath.row]
        cell.configureCell(category: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError(Constants.Strings.fatalError)
        }
        
        guard let currentCell = tableView.cellForRow(at: indexPath) as? CategoryCell else {
            fatalError(Constants.Strings.fatalError)
        }
        self.categoryTypeToPass = currentCell.categoryTitle.text
    }
    
}
