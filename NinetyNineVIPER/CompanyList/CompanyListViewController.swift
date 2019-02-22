//
//  CompanyListViewController.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CompanyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var delegate: CompanyListViewDelegate?
    let companiesDataSource = Variable<[Company]>([])
    
    //RX
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Companies"
        
        delegate?.viewDidLoad()
    }
    
    fileprivate func setupTableView() {
        
        tableView.registerCell(with: CompanyTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        setupDataSource()
        setupItemSelected()
        
    }
    
    fileprivate func setupDataSource() {
        companiesDataSource
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CompanyTableViewCell.identifier)){ row,company,cell in
                guard let cell = cell as? CompanyTableViewCell else {
                    return
                }
                cell.bind(company: company)
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupItemSelected() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let company = self?.companiesDataSource.value[safe: indexPath.row] else {
                    return
                }
                self?.delegate?.didTap(company: company)
            }).disposed(by: disposeBag)
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
        self.companiesDataSource.value = companies
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
