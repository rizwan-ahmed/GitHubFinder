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
    
    // MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Class Variables
    var viewModel = GHSearchUserViewModel()
    
    // MARK: - ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    func setupViewModel() {
        
        viewModel.dataFetch = { [weak self] (user) in
            DispatchQueue.main.async { [weak self] in
                self?.performSegue(withIdentifier: Segues.homeToDetailPage, sender: self)
            }
        }
        
        viewModel.dataFetchFailed = { [weak self] (error) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlertView(title: "Error", message: error)
            }
        }
    }                            
}

// MARK: - SearchBar Delegates
extension GHSearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.userId = searchBar.text ?? ""
        viewModel.fetchUsrer()
    }
}

// MARK: - Show Alerts
extension GHSearchUserViewController {
    func showAlertView(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Navigations
extension GHSearchUserViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Segues.homeToDetailPage {
            if let destinationVC = segue.destination as? GHUserDetailViewController {
                destinationVC.viewModel.userModel = viewModel.userModel
            }
        }
        
    }
}
