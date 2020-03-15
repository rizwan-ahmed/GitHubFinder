//
//  ViewController.swift
//  GitHubUserFinder
//
//  Created by Rizwan Ahmed on 14/03/2020.
//  Copyright © 2020 Rizwan Ahmed. All rights reserved.
//

import UIKit
//import NetworkLayer
class GHSearchUserViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = GHSearchUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    func setupViewModel() {
        
        viewModel.dataFetch = { [weak self] (user) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlertView(title: "User Found", message: user.name ?? "")
            }
        }
        
        viewModel.dataFetchFailed = { [weak self] (error) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlertView(title: "Error", message: error)
            }
        }
    }
}

extension GHSearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.userId = searchBar.text ?? ""
        viewModel.fetchUsrer()
    }
}

extension GHSearchUserViewController {
    func showAlertView(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

