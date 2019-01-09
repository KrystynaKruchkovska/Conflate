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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinnerView: SpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.spinnerView.showSpinner()
        self.readPost()
    }
    
    func readPost() {
        self.postViewModel.readPosts { (posts) in
            self.postArray = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.spinnerView.hideSpinner()
            }
            
        }
    }
   
    
    func setupTableView() {
        self.tableView.dataSource = self
    }
    
    @IBAction func infobtnWasPressed(_ sender: UIButton) {
        print("info button was pressed")
        infoButtonDidSelect(sender)
    }
    
    func infoButtonDidSelect(_ infoBtn: UIButton) {
        let indexPath = tableView.getIndexPath(for: infoBtn)
        if indexPath.indices.count < 1 {
            print("Fatal error")
            return
        }
        
        let presentInfo = PostInfoVC()
        presentInfo.post = self.postArray[indexPath.row]
        presentInfo.modalPresentationStyle = .fullScreen
        present(presentInfo, animated: true, completion: nil)
    }
    
}

extension AllPostsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifire.postTableViewCell) as? PostTableViewCell else {
            fatalError(Constants.Strings.fattalError)
        }
      
        let post = postArray[indexPath.row]
        
        cell.configureCell(title: post.title)
        
        return cell
    }
   
    
    
    
}
