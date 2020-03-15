//
//  GHUserDetailViewController.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 15/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import UIKit

class GHUserDetailViewController: UIViewController {
    
    var viewModel = GHUserDetailViewModel()
    
    @IBOutlet weak var userImageView    : UIImageView!
    @IBOutlet weak var userNameLabel    : UILabel!
    @IBOutlet weak var userEmailLabel   : UILabel!
    @IBOutlet weak var repoCountLabel   : UILabel!
    @IBOutlet weak var tableView        : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
        setupViewModel()
        setupView()
    }
    
    func setupViewModel() {
        viewModel.setUpUser()
        viewModel.imageFetch = { [weak self] (image) in
            if let userImage = image {
                DispatchQueue.main.async {
                    self?.userImageView.image = userImage
                }
            }
        }
        
        viewModel.followersFetch = { [weak self] (followers) in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
        }
    }
    
    func setupView(){
        userNameLabel.text = viewModel.userName
        userEmailLabel.text = viewModel.userEmail
        repoCountLabel.text = viewModel.publicRepos
    }
}

extension GHUserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.followerCellIdentifier, for: indexPath) as? GHFollowerTableViewCell else { return UITableViewCell() }
        if let followerModel = viewModel.getFollower(atIndex: indexPath.row) {
            cell.setupCell(index: indexPath.row, follower: followerModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
}
