//
//  ViewController.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 14/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import UIKit

class GHSearchUserViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = GHSearchUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
                    
}

extension GHSearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.userId = searchBar.text ?? ""
        viewModel.fetchUsrer()
    }
}
