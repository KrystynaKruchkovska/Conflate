//
//  AllPostsVC.swift
//  Conflate
//
//  Created by Mac on 1/3/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class AllPostsVC: UIViewController{
    
    var postViewModel:PostViewModel!
    private var postArray = [Post]()
    private var userLocation:Location?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinnerView: SpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.spinnerView.showSpinner()
        self.readPosts()
    }
    
    func updateUserLocation(_ location:Location) {
        self.userLocation = location
        self.reloadTableView()
    }
    
    private func readPosts() {
        self.postViewModel.readPosts { (posts) in
            self.postArray = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinnerView.hideSpinner()
            }
        }
    }
   
    private func reloadTableView() {
        self.spinnerView.showSpinner()
        self.tableView.reloadData()
        self.spinnerView.hideSpinner()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
    }
    
    @IBAction func infobtnWasPressed(_ sender: UIButton) {
        let indexPath = self.tableView.getIndexPath(for: sender)
        
        if indexPath.indices.count < 1 {
            self.showAlertInternalError()
            return
        }
        
       self.presentPostInfoVCForRow(indexPath.row)
    }
    
    private func presentPostInfoVCForRow(_ row:Int) {
        let presentInfo = PostInfoVC()
        presentInfo.post = self.postArray[row]
        presentInfo.modalPresentationStyle = .fullScreen
        present(presentInfo, animated: true, completion: nil)
    }
    
}

extension AllPostsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.ReusableIdentifier.postTableViewCell) as? PostTableViewCell else {
            fatalError(Constants.Strings.fatalError)
        }
      
        let post = self.postArray[indexPath.row]
        
        
        cell.configureCell(title: post.title, distanceFrom:self.getDistanceToPost(post))
        
        return cell
    }
    
    func getDistanceToPost(_ post:Post) -> String {
        guard let location = self.userLocation else {
            return ""
        }
        
        let mInKm = 1000.0
        let distance = (post.location.distanceFrom(location: location))/mInKm
        let rounded = distance.roundToDecimal(1)
        
        return "\(rounded) km"
    }
   
    
}
