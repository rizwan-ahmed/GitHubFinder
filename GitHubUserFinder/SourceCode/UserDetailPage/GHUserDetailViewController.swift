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
    @IBOutlet weak var followersLabel   : UILabel!
    @IBOutlet weak var tableView        : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.setUpUser()
        setupView()
    }
    
    func setupView(){
        userNameLabel.text = viewModel.userName
        userEmailLabel.text = viewModel.userEmail
        followersLabel.text = viewModel.userFollowers
    }
}
