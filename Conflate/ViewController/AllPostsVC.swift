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
    var spinner = UIActivityIndicatorView()
    private var postArray = [Post]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showSpinnerAndControlOff(spinner: spinner)
        
        self.postViewModel.readPosts { (posts) in
            self.postArray = posts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideSpinnerAndControlOn(spinner: self.spinner)
            }
           
        }
    }
    
    
    func setupSpinner() {
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        spinner.style = UIActivityIndicatorView.Style.gray
        spinner.center = self.view.center
        spinner.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.view.addSubview(spinner)
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
