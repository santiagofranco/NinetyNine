//
//  ViewController.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CompanyListView {
    func showLoading() {
        
    }
    
    func showCompanies(_ companies: [Company]) {
        print(companies)
    }
    
    func hideLoading() {
        
    }
    
    func showLoadingCompaniesError() {
        
    }
    
    func showAuthenticationError() {
        
    }
    

    var delegate: CompanyListViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()
    }


}

