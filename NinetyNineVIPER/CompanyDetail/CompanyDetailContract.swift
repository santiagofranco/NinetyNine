//
//  CompanyDetailContract.swift
//  NinetyNineVIPER
//
//  Created by Santi on 21/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import Foundation

/**
 
 This file contains all the protocols for the company detail module of the app
 The goal of the contract file is to see in just a glance all of the functionality of the module
 Also, having all protocols in one file let us to change any implementation file/class easily, just creating a new one and deleting the old one
 */

protocol CompanyDetailView: class {
    var delegate: CompanyDetailViewDelegate? { get set }
    
    func showLoading()
    func hideLoading()
    func showCompany(_ company: Company)
    func showErrorLoadCompany()
}

protocol CompanyDetailViewDelegate: class {
    func viewDidLoad()
}

protocol CompanyDetailInteractorProtocol: class {
    var delegate: CompanyDetailInteractorDelegate? { get set }
    
    func loadCompany(with id: Int)
    func runRefreshProcess()
}

protocol CompanyDetailInteractorDelegate: class {
    func didLoadCompany(_ company: Company)
    func didLoadCompanyError(_ error: NNError)
}
