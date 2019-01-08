//
//  PopUpVC.swift
//  Conflate
//
//  Created by Mac on 1/8/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {
    
    
    var categories: [Category] = []

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryArray()
        self.tableView.dataSource = self

    }
    
    
    func setCategoryArray(){
        categories = [Category(image: Constants.Image.lostAndFound, title: Constants.CategoryTitle.lostAndFound),Category(image: Constants.Image.healthAndFitness, title: Constants.CategoryTitle.healthAndFitness),Category(image: Constants.Image.party, title: Constants.CategoryTitle.party)]
    }
    
    
    func setUpPopView(){
        self.popUpView.layer.cornerRadius = 10
        self.popUpView.layer.masksToBounds = true
    }
    
    @IBAction func DoneBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension PopUpVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell else {
            fatalError(Constants.Strings.fattalError)
        }
        let category = categories[indexPath.row]
        cell.configureCell(category: category)
        return cell
    }
    
    
}
