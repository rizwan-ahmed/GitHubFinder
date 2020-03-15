//
//  ViewController.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 14/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Test: \(searchBar.text)")
    }
}
