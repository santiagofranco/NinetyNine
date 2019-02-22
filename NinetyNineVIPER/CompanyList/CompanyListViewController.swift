//
//  CompanyListViewController.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

/**
 This class manages interface logic and user inputs.
 
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 */

class CompanyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate: CompanyListViewDelegate?
    var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(with: CompanyTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Companies"
        
        delegate?.viewDidLoad()
    }
    
    fileprivate func showMessage(_ message: String) {
        messageLabel.text = message
        tableView.isHidden = true
    }
}


extension CompanyListViewController: CompanyListView {
    func showLoading() {
        activityIndicator.isHidden = false
        tableView.isHidden = true
    }
    
    func showCompanies(_ companies: [Company]) {
        self.companies = companies
        tableView.reloadData()
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        tableView.isHidden = false
    }
    
    func showLoadingCompaniesError() {
        showMessage("Something went wrong loading companies")
    }
    
    func showAuthenticationError() {
        showMessage("You should be authenticated to load companies")
    }
    
    
}

extension CompanyListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CompanyTableViewCell = tableView.dequeue(at: indexPath, identifier: CompanyTableViewCell.identifier)
        
        cell.bind(company: companies[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTap(company: companies[indexPath.row])
    }
}
