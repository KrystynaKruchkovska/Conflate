//
//  AllPostsVC.swift
//  Conflate
//
//  Created by Mac on 1/3/19.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class AllPostsVC: UIViewController {
    
    var postViewModel:PostViewModel!
    private var postArray = [Post]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //start spinner and table view control off
        
        self.postViewModel.readPosts { (posts) in
            self.postArray = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            // spinner stop and table view control on
        }
    }
    
    func setupTableView() {
        self.tableView.dataSource = self
    }
    
    @IBAction func infobtnWasPressed(_ sender: UIButton) {
        print("info button was pressed")
    }
    
}

extension AllPostsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell") as? PostTableViewCell else {
            fatalError("The dequeued cell is not an instance of TaskTableViewCell.")
        }
      
        let post = postArray[indexPath.row]
        
        cell.configureCell(title: post.title)
        
        return cell
    }
   
    
    
    
}
